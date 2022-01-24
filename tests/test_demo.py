import os
from appium import webdriver as appium_webdriver

import pytest
import time

PACKAGE = "com.tcarpentier.demoapplication"
ACTIVITY = ".MainActivity"


def get_absolute_path(test_path, file_path):
    """Take a path file and a test path and build a correct absolute path
    :param test_path: the relative path to your current test
    :param file_path: the relative path to your file"""
    return os.path.abspath(os.path.join(test_path, file_path))


class TestDemoApp:

    @pytest.fixture(scope="session")
    def appium(self):
        capabilities = {
            "platformName": "Android",
            "app": get_absolute_path(os.path.dirname(__file__), "../app/DemoApplication.apk"),
            "udid": os.environ['ADB_SERIAL'],
            "systemPort": os.environ['systemPort'],
            "automationName": "UIAutomator2",
            "noReset": True,
            "newCommandTimeout": 0,
            "uiautomator2ServerInstallTimeout": 40000,
            "adbExecTimeout": 9000,

        }
        url = "http://localhost:4723/wd/hub"
        appium = appium_webdriver.Remote(url, capabilities)

        yield appium

        # teardown appium
        appium.quit()

    def test_action1(self, appium):
        appium.start_activity(PACKAGE, ACTIVITY)
        self.click_button(
            appium,
            'new UiSelector().resourceId("com.tcarpentier.demoapplication:id/button1")',
        )

    def test_action2(self, appium):
        appium.start_activity(PACKAGE, ACTIVITY)
        self.click_button(
            appium,
            'new UiSelector().resourceId("com.tcarpentier.demoapplication:id/button2")',
        )

    def test_action3(self, appium):
        appium.start_activity(PACKAGE, ACTIVITY)
        self.click_button(
            appium,
            'new UiSelector().resourceId("com.tcarpentier.demoapplication:id/button3")',
        )

    def test_action4(self, appium):
        appium.start_activity(PACKAGE, ACTIVITY)
        self.click_button(
            appium,
            'new UiSelector().resourceId("com.tcarpentier.demoapplication:id/button4")',
        )

    def test_action5(self, appium):
        appium.start_activity(PACKAGE, ACTIVITY)
        self.click_button(
            appium,
            'new UiSelector().resourceId("com.tcarpentier.demoapplication:id/button5")',
        )

    def click_button(self, appium, arg1):
        button_action1 = appium.find_element_by_android_uiautomator(arg1)
        button_action1.click()
        time.sleep(3)
