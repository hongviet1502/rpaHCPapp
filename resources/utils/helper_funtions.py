from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn
from appium import webdriver
from appium.webdriver.common.appiumby import AppiumBy
from PIL import Image
import io, time

@keyword("Check Color Changed")
def check_color_changed(locator, timeout=2.0):
    """
    Kiểm tra màu trung tâm của element thay đổi trong `timeout` giây.
    Chỉ lấy 1 pixel trung tâm để giảm tải (nhẹ hơn nhiều so với so sánh ảnh).
    """
    # ✅ Sửa dòng này:
    appium_lib = BuiltIn().get_library_instance("AppiumLibrary")
    driver: webdriver.Remote = appium_lib._current_application()

    # Hàm phụ: lấy màu trung tâm của element
    def get_center_color():
        element = driver.find_element(AppiumBy.XPATH, locator)
        img = Image.open(io.BytesIO(element.screenshot_as_png)).convert("RGB")
        w, h = img.size
        return img.getpixel((w // 2, h // 2))

    try:
        color_before = get_center_color()
    except Exception as e:
        raise AssertionError(f"Không thể lấy màu ban đầu: {e}")

    start = time.time()
    while (time.time() - start) < float(timeout):
        try:
            color_after = get_center_color()
            if color_after != color_before:
                return True
        except Exception:
            pass
        time.sleep(0.1)  # polling nhanh, không block

    return False
