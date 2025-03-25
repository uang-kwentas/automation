from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys

# Initialize the driver (make sure you have the right path to your WebDriver)
driver = webdriver.Chrome(executable_path='C:\Users\DEVOJT\Downloads\REMOROZA_JOURNAL\webdriver\chromedriver-win64')

# Open the page where the course search is located
driver.get("http://localhost:4200/courselist")

# Locate the course name input field and enter the course name
course_name_input = driver.find_element(By.XPATH, "//input[@placeholder='Course Name']")  # Change XPath accordingly
course_name_input.clear()  # Clear the input field
course_name_input.send_keys("Course Name")  # Replace "Course Name" with the actual name

# Locate the search button and click it to trigger the search
search_button = driver.find_element(By.XPATH, "//button[contains(text(),'🔎 Search')]")
search_button.click()

# Wait for the results to appear or perform further actions as needed
