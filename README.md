# 🧪 Lab Exercises – Flutter  
Dự án tổng hợp các bài thực hành Flutter cho môn học.  
Bao gồm: ListView, GridView, Shared Preferences, Async, Isolate.

---

## 📌 1. Giới thiệu
Ứng dụng demo các kiến thức Flutter cơ bản – mỗi tab tương ứng một tính năng quan trọng trong Flutter:

- Hiển thị danh sách (ListView)
- Hiển thị lưới (GridView)
- Lưu trữ dữ liệu cục bộ (SharedPreferences)
- Lập trình bất đồng bộ (Async / Future / async-await)
- Xử lý song song bằng Isolate

2. Tính năng chi tiết
2.1. ListView Contacts
   <img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/a4da9e74-2f1a-466e-8275-928726ec7274" />


Hiển thị danh sách 30 contact mẫu

Khi bấm vào từng item → hiện thông báo phía dưới “Tapped Contact X”

Sử dụng ListView.builder, ListTile

2.2. GridView Demo
<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/a75e8f94-ba0f-49ea-865e-2e8e9fe8837e" />


Hiển thị 20 item dạng lưới (grid)

Mỗi ô có màu riêng và số thứ tự

Sử dụng GridView.count

2.3. Shared Preferences
<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/a32b947b-59ef-4860-ae6b-45fb899c641e" />


Nhập tên → lưu vào bộ nhớ

Bấm Show Name → lấy lại dữ liệu đã lưu

Không crash khi chưa có dữ liệu

Demo: Save, Load (và có thể thêm Clear nếu cần)

2.4. Async Demo
<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/e77acf2a-53fb-4d96-86ca-e077b090e586" />


Khi bấm “Start Countdown” → đếm 5 → 1

Mô phỏng xử lý chờ bằng Future.delayed

Hiện trạng thái chạy

2.5. Isolate Demo
<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/155dbc83-f8ef-44a5-8045-7e3e6a858cf2" />


Tạo một isolate riêng tính toán số ngẫu nhiên

Gửi kết quả qua SendPort

Không làm lag UI

Minh họa cách xử lý tác vụ nặng trong Flutter

Sinh viên thực hiện

Nguyễn Châu Thiên

Flutter Lab Exercises – 2025
