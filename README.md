<h1 align="center"><project-name>INT2211_24 Barbershop</h1>

## Author
- [Phạm Đàm Quân](https://github.com/ZeroGxMax)

## ER diagram:
![alt text](ER/ER_diagram.png)

ER diagram link: https://erdplus.com/edit-diagram/76057dab-0b49-4cff-a99a-d74ca009f300


## Schema diagram:

![alt text](Schema/Schema_diagram.png)
  
  Bảng services nối với bảng <b>service_categories</b> chứ không phải appointments

## Demo:
- Cách 1: Vào link demo: https://barbershop-2211-24.000webhostapp.com/
- Cách 2: 
  +, Tải xuống repo, vào xampp, tạo database đặt tên là barbershop rồi import file barbershop_db.sql.
  +, Đặt folder Barbershop vào C:\xampp\htdocs, rồi sử dụng link localhost/Barbershop trong trình duyệt để xem demo của trang web.

## Lưu ý:
- Click vào biểu tượng phía trên cùng bên trái để vào Admin Panel
- Tài khoản: admin
- Mật khẩu: 123456789
- Nếu đăng nhập mà thấy lỗi: Warning: Cannot modify header information - headers already sent by (output started at /storage/ssd4/723/19933723/public_html/Admin/Includes/functions/functions.php:1) in /storage/ssd4/723/19933723/public_html/Admin/login.php on line 67,
chỉ cần load lại trang là được.

