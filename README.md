# RadioApp

![RadioApp](RadioApp/Assets.xcassets/mockup.imageset/mockup.png)
<p align="left"> 
<a href="https://swift.org">
<img src="https://img.shields.io/badge/Swift-5.10-mediumslateblue" alt="Swift Version 5.10" /></a>
<a href="https://developer.apple.com/ios/">
<img src="https://img.shields.io/badge/iOS-15.0%2B-indianred" alt="iOS Version 15.0"/></a>
<img src="https://img.shields.io/badge/MVP+Router-goldenrod" alt="MVP+Router" />
<img src="https://img.shields.io/badge/CoreData-mediumslateblue" alt="CoreData" /></a>
</p>

### В разработке участвовали:
<p align="left"> 
<a href="https://github.com/realeti">
<img src="https://img.shields.io/badge/realeti-mediumslateblue"/></a>
<a href="https://github.com/DmitriyLubov">
<img src="https://img.shields.io/badge/DmitriyLubov-indianred"/></a>
<a href="https://github.com/dr4gons1ayer01">
<img src="https://img.shields.io/badge/dr4gons1ayer01-goldenrod"/></a>
<a href="https://github.com/AML1708">
<img src="https://img.shields.io/badge/AML1708-mediumslateblue"/></a>
<a href="https://github.com/ShapovalovIlya">
<img src="https://img.shields.io/badge/ShapovalovIlya-indianred"/></a>
</p>

### О приложении:

#### RadioApp - приложение, которое позволяет прослушивать множество радиостанций мира.

### Функционал:
  * Авторизация - возможность регистрации и входа зарегистрированного пользователя через почту и пароль или через Google. Функция "забыл пароль" отправляет письмо для сброса пароля на почту пользователя, с возможностью перехода в браузер и изменения пароля через почтовый клиент.
  * Popular - отображение коллекции популярных радиостанций с возможностью их прослушивания, голосования за станцию и добавления ее в избранное.
  * Плеер - проигрыватель с возможностью переключения между радиостанциями и изменения громкомти воспроизведения.
  * Favorites - отображение избранных станций с возможностью удаления из избранного и просмотра детального описания станции, хранение реализовано через Core Data.
  * All stations - отображение всех радиостанций с возможностью просмотра детального описания станции, голосования за станцию и добавления ее в избранное. Реализована возможность поиска станций по названию.
  * Настройки - отображение данных пользователя: персональное фото, имя и почта с возможностью их изменения и выхода из личного кабинета. Реализована смена языка. Вкладки: Положения и условия, About us.

### Swift / UIKit / CoreData
  
### Архитектура: 
MVP+Router
  
### Фреймворки: 
  * SnapKit
  * Firebase
  * Google SignIn
  * RadioBrowser (*by [ShapovalovIlya](https://github.com/ShapovalovIlya)*)
  * Kingfisher
  * Lottie
