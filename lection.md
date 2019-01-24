# Онлайн проект <a href="https://github.com/JavaWebinar/topjava">Topjava</a>

## <a href="https://drive.google.com/drive/folders/0B9Ye2auQ_NsFfkpsWE1uX19zV19IVHd0bTlDclc5QmhMMm4xa0Npek9DT18tdkwyLTBZdXM">Материалы занятия</a> (скачать все патчи можно через Download папки patch)

## ![hw](https://cloud.githubusercontent.com/assets/13649199/13672719/09593080-e6e7-11e5-81d1-5cb629c438ca.png) Разбор домашнего задания HW1:

- **Перед сборкой проекта (или запуском Tomcat) откройте вкладку Maven Projects и сделайте `clean`**
- **Если страничка в браузере работает неверно, очистите кэш (`Ctrl+F5` в хроме)**

### ![video](https://cloud.githubusercontent.com/assets/13649199/13672715/06dbc6ce-e6e7-11e5-81a9-04fbddb9e488.png) 1. <a href="https://drive.google.com/open?id=0B9Ye2auQ_NsFXzByNVF3VV9zM1k">Отображения списка еды в JSP</a>
#### Apply 2_1_HW1.patch

> - Изменения в `MealsUtil`:
>    - Сделал константу `List<Meal> MEALS`
>    - Сделал вспомогательный метод `getWithExceeded`. Для фильтрации передаю реализацию `Predicate` (см. паттерн [Стратегия](https://refactoring.guru/ru/design-patterns/strategy))
> - Форматирование даты сделал на основе <a href="http://stackoverflow.com/questions/35606551/jstl-localdatetime-format#35607225">JSTL LocalDateTime format</a>
> - Переименовал `TimeUtil` в `DateTimeUtil`
> - Переименовал `mealList.jsp` в `meals.jsp`
> - Добавил еще один способ вывести `dateTime` через стандартную JSTL функцию `replace`  (префикс `fn` в шапке также надо поменять)

- [jsp:useBean](http://www.labir.ru/j2ee/jspUseBean.html)
- [MVC - Model View Controller](http://design-pattern.ru/patterns/mvc.html)

### ![video](https://cloud.githubusercontent.com/assets/13649199/13672715/06dbc6ce-e6e7-11e5-81a9-04fbddb9e488.png) 2. <a href="https://drive.google.com/open?id=0B9Ye2auQ_NsFQndBeWFOa3phRTg">Optional: реализация CRUD</a>
#### Apply 2_2_HW1_optional.patch
Про использование паттерна Repository будет подробно рассказано в видео "Слои приложения"

> - Поправил `InMemoryMealRepositoryImpl.save()`. Если обновляется еда, которой нет в хранилище (c несуществующим id), вставка не происходит.
> - В `MealServlet.doGet()` сделал выбор через `switch`
> - В местах, где требуется `int`, заменил `Integer.valueOf()` на `Integer.parseInt()`
> - В `meal.jsp` используется <a href="http://stackoverflow.com/questions/1890438/how-to-get-parameters-from-the-url-with-jsp#1890462">параметр запроса `param.action`</a>, который не кладется в атрибуты.
> - Переименовал `mealEdit.jsp` в `mealForm.jsp`. Поля ввода формы добавил `required`
> - Пофиксил багу c `history.back()` в `mealForm.jsp` для **FireFox** (коммит формы при Cancel, сделал `type="button"`).

Дополнительно:
  - <a href="http://stackoverflow.com/questions/246859/http-1-0-vs-1-1">HTTP 1.0 vs 1.1</a>

### ![question](https://cloud.githubusercontent.com/assets/13649199/13672858/9cd58692-e6e7-11e5-905d-c295d2a456f1.png) Вопросы по HW1

> Зачем в `InMemoryMealRepositoryImpl` наполнять map с помощью нестатического блока инициализации, а не в конструкторе?

Разницы нет. Сделал чтобы напомнить вам про эту конструкцию. [Малоизвестные особенности Java](https://habrahabr.ru/post/133237/)

> Почему `InMemoryMealRepositoryImpl` не singleton?

Начиная с Servlet API 2.3 пул сервлетов не создается, [создается только один инстанс сервлетов](https://stackoverflow.com/questions/6298309). Те. `InMemoryMealRepositoryImpl` в нашем случае создается тоже только один раз. Далее все наши классы слоев приложения будут создаваться через Spring, бины которого по умолчанию являются синглтонами (в его контексте).  

> `Objects.requireNonNull` в `MealServlet.getId(request)` если у нас нет `id` в запросе бросает NPE (`NullPointerException`). Но оно вылетит и без этого метода. Зачем он нужен и почему мы его не обрабатываем?

`Objects.requireNonNull` - это проверка предусловия (будет подробно на 4-м занятии). Означает что в метод пришел неверный аргумент (должен быть не null) и приложение сообщает об ошибке сразу на входе (а не "может быть где-то потом"). См. [What is the purpose of Objects#requireNonNull](https://stackoverflow.com/a/27511204/548473). Если ее проглатывать или замазывать, то приложение возможно где-то работает неверно (приходят неверные аргументы), а мы об этом не узнаем. Красиво обрабатывать ошибки будем на последних занятиях (Spring Exception Handling).

## Занятие 2:
### ![video](https://cloud.githubusercontent.com/assets/13649199/13672715/06dbc6ce-e6e7-11e5-81a9-04fbddb9e488.png) 3. <a href="https://drive.google.com/open?id=0B9Ye2auQ_NsFVDJZVTktQzRYTWc">Библиотека vs Фреймворк. Стандартные библиотеки Apache Commons, Guava</a>
- <a href="http://commons.apache.org/">Apache Commons</a>, <a href="https://github.com/google/guava/wiki">Guava</a>
  - Guava используется на проекте [Многомодульный maven. Многопоточность. XML (JAXB/StAX). Веб сервисы (JAX-RS/SOAP). Удаленное взаимодействие (JMS/AKKA)](http://javaops.ru/reg/masterjava)  
   
### ![video](https://cloud.githubusercontent.com/assets/13649199/13672715/06dbc6ce-e6e7-11e5-81a9-04fbddb9e488.png) 4. <a href="https://drive.google.com/open?id=0B9Ye2auQ_NsFeWZ1d1cxaUZiUmc">Слои приложения. Создание каркаса приложения.</a>
#### Apply 2_3_app_layers.patch
> - Переименовал `ExceptionUtil` в `ValidationUtil`
> - Поменял `LoggedUser` на `SecurityUtil`. Это класс, из которого приложение будет получать данные авторизированного пользователя (пока авторизации нет, он реализован как заглушка). Находится в пакете `web`, т.к. авторизация происходит на слое контроллеров и остальные слои приложения про нее знать не должны.
> - Добавил проверку id пользователя, пришедшего в контроллер ([treat IDs in REST body](https://stackoverflow.com/a/32728226/548473), "If it is a public API you should be conservative when you reply, but accept liberally")

![Слои приложения](http://4.bp.blogspot.com/-B4BdrPHfILA/Tu6dC5uK4dI/AAAAAAAAAeQ/iPEM0WctR7Y/s1600/Roo+Technical+Architecture+Diagram.png)

-  <a href="http://en.wikipedia.org/wiki/Multilayered_architecture">Паттерн "Слои приложения"</a>
-  <a href="https://ru.wikipedia.org/wiki/Data_Access_Object">Data Access Object</a>
-  <a href="http://martinfowler.com/eaaCatalog/dataTransferObject.html">Паттерн DTO</a>
-  <a href="http://stackoverflow.com/questions/1612334/difference-between-dto-vo-pojo-javabeans">Value Object и Data Transfer Object</a>
-  <a href="http://stackoverflow.com/questions/21554977/should-services-always-return-dtos-or-can-they-also-return-domain-models">Should services always return DTOs, or can they also return domain models?</a>
-  Дополнительно:
   -  <a href="http://codehelper.ru/questions/205/new/repository-и-dao-отличия-преимущества-недостатки">Паттерны Repository и DAO</a>
   - <a href="http://habrahabr.ru/post/263033/">Забудьте о DAO, используйте Repository</a>
   - <a href="http://stackoverflow.com/questions/6640784/difference-between-active-record-and-dao">Difference between Active Record and DAO</a>

## ![question](https://cloud.githubusercontent.com/assets/13649199/13672858/9cd58692-e6e7-11e5-905d-c295d2a456f1.png) Ваши вопросы
>  Какова цель деления приложения на слои?

Управляемость проекта (особенно большого) повышается на порядок:
- Обеспечивается меньшая связываемость. Допустим если мы меняем что-то в контроллере, то сервис эти изменения не задевают.
- Облегчается тестирование (мы будем тестировать слои сервисов и контроллеров отдельно)

> DTO используются когда есть избыточность запросов, которую мы уменьшаем, собрав данные из разных бинов в один? Когда DTO необходимо использовать?

(D)TO может быть как частью одного entity  (набор полей) так и набором нескольких entities.
В нашем проекте для данных, которые надо отдавать наружу и отличающихся от Entiy (хранимый бин), мы будем делать (Data) Transfer Object и класть в отдельный пакет to. Например `MealsWithExceeded` мы отдаем наружу и он является Transfer Object, его надо перенести в пакет `to`.
На многих проектах (и собеседованиях) практикуют разделение на уровне maven модулей entity слоя от логики и соответствующей конвертацией ВСЕХ Entity в TO, даже если у них те же самые поля.
Хороший ответ когда TO обязательны есть на <a href="http://stackoverflow.com/questions/21554977/should-services-always-return-dtos-or-can-they-also-return-domain-models#21569720">stackoverflow: When to Use</a>.

> Почему контроллеры положили в папку web, а не в conrollers?

То же самое что `domain/model` - просто разные названия.

> Зачем мы наследуем `NotFoundException` от `RuntimeException`?

Так с ним удобнее работать. И у нас нет никаких действий по восстановлению состояния приложения (no recoverable conditions): <a href="http://stackoverflow.com/questions/6115896/java-checked-vs-unchecked-exception-explanation">checked vs unchecked exception</a>. По последним данным checked exception вообще depricated: <a href="http://blog.takipi.com/ignore-checked-exceptions-all-the-cool-devs-are-doing-it-based-on-600000-java-projects">Ignore Checked Exceptions</a>

> Зачем в API пишем `NotFoundException`, если они `RuntimeException`?

Обычно не пишут. Я написал для информации разработчикам - здесь делаем проверку и может быть брошено.

> Зачем в `AdminRestController` переопределяются методы родителя с вызовом тех же родительских?

Сделано на будущее, мы будем работать с `AdminRestController`.

> И что такое `ProfileRestController`?

Контроллер, где авторизованный пользователь будет работать со своими данными

> Что лучше возвращать из API: `Collection` или `List`

Вообще, как правило, возвращают `List`, если не просится по коду более общий случай (например возможный `Set` или `Collection`, возвращаемый `Map.values()`). Если возвращается отсортированный список, то `List` будет адекватнее.

###  ![video](https://cloud.githubusercontent.com/assets/13649199/13672715/06dbc6ce-e6e7-11e5-81a9-04fbddb9e488.png) 5. <a href="https://drive.google.com/open?id=14XPypWzxYdjxir6dGTjqTOCBZUu_Jy3C">Обзор  Spring Framework. Spring Context.</a>
#### Apply 2_4_add_spring_context.patch
-  <a href="http://en.wikipedia.org/wiki/Spring_Framework">Spring Framework</a>
-  <a href="http://spring.io/projects">Проекты Spring</a>.
-  <a href=https://docs.spring.io/spring/docs/current/spring-framework-reference/html/overview.html>Обзор Spring Framework</a>

#### Apply 2_5_add_dependency_injection.patch
-  <a href="https://ru.wikipedia.org/wiki/Инверсия_управления">Инверсия управления.</a>
-  <a href="http://habrahabr.ru/post/131993/">IoC, DI, IoC-контейнер — Просто о простом</a>

#### Apply 2_6_add_annotation_processing.patch
> - Закомментировал ненужный `context:annotation-config`: сканирование аннотаций подключаются при `context:component-scan`

-  <a href="http://stackoverflow.com/questions/6827752/whats-the-difference-between-component-repository-service-annotations-in">Difference
   between @Component, @Repository & @Service annotations in Spring</a>
-  <a href="http://www.mkyong.com/spring/spring-auto-scanning-components/">Spring Auto Scanning Components</a>
-  <a href="http://www.seostella.com/ru/article/2012/02/12/ispolzovanie-annotacii-autowired-v-spring-3.html">Использование аннотации @Autowired</a>
-  Дополнительное:
   -  <a href="https://docs.spring.io/spring/docs/current/spring-framework-reference/html/beans.html">Introduction to the Spring IoC container
       and beans</a>
   -  <a href="http://it.vaclav.kiev.ua/2010/12/25/spring-framework-for-begginers-part-7/">Constructor против Setter Injection </a>
   -  <a href="https://spring.io/guides">Getting Started</a>
   -  <a href="https://docs.spring.io/spring/docs/current/spring-framework-reference/">Spring Framework Reference Documentation</a>
   -  <a href="https://github.com/spring-projects">Spring на GitHub</a>
   -  <a href="https://dzone.com/refcardz/spring-annotations">Spring Annotations</a>

#### Apply 2_7_constructor_injection.patch
- [Inject 2 beans of same type](https://stackoverflow.com/a/2153680/548473)
- [Перевод "Field Dependency Injection Considered Harmful"](https://habrahabr.ru/post/334636/)
- [Tutorial: testing with AssertJ](http://www.vogella.com/tutorials/AssertJ/article.html)
- [Field vs Constructor vs Setter DI](http://stackoverflow.com/questions/39890849/what-exactly-is-field-injection-and-how-to-avoid-it)
- [Implicit constructor injection for single-constructor scenarios](https://spring.io/blog/2016/03/04/core-container-refinements-in-spring-framework-4-3#implicit-constructor-injection-for-single-constructor-scenarios)

В контроллерах *Constructor Injection* делать не стал, добавляется лишний код (попробуйте сделать сами). На каждом проекте свои правила, универсальных нет.

#### Дополнительно видео по Spring
   - [Юрий Ткач: Spring Framework - The Basics](https://www.youtube.com/playlist?list=PL6jg6AGdCNaWF-sUH2QDudBRXo54zuN1t)
   - [Java Brains: Spring Framework](https://www.youtube.com/playlist?list=PLC97BDEFDCDD169D7)
   - [Тимур Батыршинов: Spring](https://www.youtube.com/playlist?list=PLwwk4BHih4fho6gmaAwdHYZ6QQq0aE7Zi)

### ![video](https://cloud.githubusercontent.com/assets/13649199/13672715/06dbc6ce-e6e7-11e5-81a9-04fbddb9e488.png) 6. <a href="https://drive.google.com/open?id=0B9Ye2auQ_NsFN2N6LS1PVE96SW8">Пояснения к HW2. Обработка Autowired</a>
  
`<context:annotation-config/>` говорит спрингу при поднятии контекста обрабатывать `@Autowired` (добавляется в контекст спринга `AutowiredAnnotationBeanPostProcessor`). После того, как все бины уже в контексте постпроцессор через отражение инжектит все `@Autowired` зависимости. Будет подробнее в видео "Жизненный цикл Spring контекста" на следующем уроке.
 
## ![question](https://cloud.githubusercontent.com/assets/13649199/13672858/9cd58692-e6e7-11e5-905d-c295d2a456f1.png) Ваши вопросы
> Что такое схема в spring-app.xml xsi:schemaLocation и зачем она нужна

<a href="https://ru.wikipedia.org/wiki/XML_Schema">XML схема</a> нужна для валидации xml, IDEA делает по ней автозаполнение.

> Что означает для Spring

     <bean class="ru.javawebinar.topjava.service.UserServiceImpl">
         <property name="repository" ref="mockUserRepository"/>
     </bean> ?

Можно сказать так: создай и занеси в свой контекст экземпляр класса (бин) `UserServiceImpl` и заинжекть в его проперти из своего контекста бин `mockUserRepository`.

> Как биндинг происходит для `@Autowired`? Как поступать, если у нас больше одной реализации `UserRepository`?

`@Autowired`  инжектит по типу (т.е. ижектит класс который реализует `UserRepository`). Обычно он один. Если у нас несколько реализаций, Spring не поднимится и поругается - `No unique bean`.
 В этом случае <a href="http://www.mkyong.com/spring/spring-autowiring-qualifier-example/">можно уточнить имя бина через @Qualifier</a>. `@Qualifier` обычно добавляют только в случае нескольких реализаций.

> Почему нельзя сервлет помещать в Spring контекст?

Сервлеты- это исключительно классы `servlet-api` (веб контейнера) и должны инстанциироваться и работать в нем. Те технически можно ( без `init/destroy`), но идеологически - неверно. Также НЕ надо работать с cервлетом из `SpringMain`.

--------------------
- **Еще раз смотрим на [демо приложение](http://topjava.herokuapp.com) и вникаем, что такое пользователь и его еда и что он может с ней сделать. Когда пользователь авторизуется в приложении, его id и норма калорий "чудесным образом" попадают в  `SecurityUtil.authUserId()/authUserCaloriesPerDay()` и в приложении мы может обращаемся к ним. Как они реально туда попадут будет в уроке  9 (Spring Security, сессия и куки)**
- **Перед началом выполнения ДЗ (ели есть хоть какие-то сомнения) прочитайте ВСЕ ДЗ. Если вопросы остаются- то ВСЕ подсказки**. Особенно этот пункт важный, когда будете делать реальное рабочее ТЗ.

## ![hw](https://cloud.githubusercontent.com/assets/13649199/13672719/09593080-e6e7-11e5-81d1-5cb629c438ca.png) Домашнее задание HW02
- 1: переименовать `MockUserRepositoryImpl` в `InMemoryUserRepositoryImpl` и имплементировать по аналогии с `InMemoryMealRepositoryImpl` (список пользователей возвращать отсортированным по имени)
- 2: сделать `Meal extends AbstractBaseEntity`, `MealWithExceed` перенести в пакет `ru.javawebinar.topjava.to` (transfer objects)
- 3: Изменить `MealRepository` и `InMemoryMealRepositoryImpl` таким образом, чтобы вся еда всех пользователей находилась в одном общем хранилище, но при этом каждый конкретный авторизованный пользователь мог видеть и редактировать только свою еду.
  - 3.1: реализовать хранение еды для каждого пользователя можно с добавлением поля `userId` в `Meal` ИЛИ без него (как нравится). Напомню, что репозиторий один и приложение может работать одновременно с многими пользователями.
  - 3.2: если по запрошенному id еда отсутствует или чужая, возвращать `null/false` (см. комментарии в `UserRepository`)
  - 3.3: список еды возвращать отсортированный в обратном порядке по датам
  - 3.4: атомарность операций не требуется  (коллизии при одновременном изменении одного пользователя можно не учитывать)
- 4: Реализовать слои приложения для функциональности "еда". API контроллера должна удовлетворять все потребности демо приложения и ничего лишнего (см. [демо](http://topjava.herokuapp.com)). 
  - **Смотрите на реализацию слоя для user и делаете по аналогии! Если там что-то непонятно, не надо исправлять или делать по своему. Задавайте вопросы. Если действительно нужна правка- я сделаю и напишу всем.**
  - 4.1: после авторизации (сделаем позднее), id авторизованного юзера можно получить из `SecurityUtil.authUserId()`. Запрос попадает в контроллер, методы которого будут доступны снаружи по http, т.е. запрос можно будет сделать с ЛЮБЫМ id для еды
# Онлайн проект <a href="https://github.com/JavaWebinar/topjava">Topjava</a>
 
## [Материалы занятия](https://drive.google.com/drive/u/0/folders/0B9Ye2auQ_NsFT1NxdTFOQ1dvVnM)  (скачать все патчи можно через Download папки patch)

### ![correction](https://cloud.githubusercontent.com/assets/13649199/13672935/ef09ec1e-e6e7-11e5-9f79-d1641c05cbe6.png) Рефакторинг

#### Apply 3_0_1_switch_servlet_4.patch
- Обновил зависимость до Servlet 4.0. Приложение нормально работает в [Tomcat 9.x](https://tomcat.apache.org/download-90.cgi)

#### Apply 3_0_2_correct_meal_exceed.patch
- Поправил грамматику: `exceed` (глагол) на `excess`.
- Преименовал класс `MealWithExceed`, принимаю предложения [по лучшему названию класса](https://stackoverflow.com/questions/1724774/java-data-transfer-object-naming-convention)

## ![hw](https://cloud.githubusercontent.com/assets/13649199/13672719/09593080-e6e7-11e5-81d1-5cb629c438ca.png) Разбор домашнего задания HW02
### ![video](https://cloud.githubusercontent.com/assets/13649199/13672715/06dbc6ce-e6e7-11e5-81a9-04fbddb9e488.png) 1. <a href="https://drive.google.com/open?id=0B9Ye2auQ_NsFdDhnNHFMU2dKQzQ">HW2</a>
> **ВНИМАНИЕ! При удалении класса из исходников, его скомпилированная версия все еще будет находиться в target (и classpath). В этом случае (или в любом другом, когда проект начинает глючить) сделайте `mvn clean`.**

#### Apply 3_01_HW2_repository.patch
> - В репозиториях по другому инстанциировал компараторы. [Оптимизация анонимных классов](http://stackoverflow.com/questions/19718353) не требуется! Почитайте комменты от Holger: *Java 8 relieves us from the need to think about such things at all*.
> - Зарефакторил `<T extends Comparable<? super T>> DateTimeUtil.isBetween(T value, T start, T end)`. Метод теперь не зависит от date/time, перенес его в общий `Util` класс. Дженерики означают, что мы принимаем экземпляры класса, реализующего компаратор, который умеет сравнивать T или суперклассы от T.
> - Для фильтрации в `InMemoryMealRepositoryImpl` передаю `Predicate` анологично решению в `MealsUtil`
> - В `InMemoryMealRepositoryImpl.save()` вместо 2-х разнесенных по времени операций
>   - `get(meal.getId(), userId)`
>   - `meals.put(meal.getId(), meal)`,
между которыми может вклинится операция удаления этой еды из другого потока, сделал обновление атомарным, используя `ConcurrentHashMap.computeIfPresent()` (см. псевдокод в `Map.computeIfPresent`. `ConcurrentHashMap` в отличие от `HashMap` делает операции атомарно).

#### Apply 3_02_HW2_meal_layers.patch
> - перенес обработку null-дат  в `MealRestController.getBetween()`
> - по аналогии с `AbstractUserController` добавил проверку id пользователя, пришедшего в `MealRestController (assureIdConsistent, checkNew)`
> - поправил интерфейс `MealService.update`: контроллер и сервис при `update` ничего не возвращает


#### Apply 3_03_HW2_optional_MealServlet.patch
> - Убрал логирование (уже есть в контроллере)
> - `assureIdConsistent` позволяет в контроллере обновлять еду с `id=null`

#### Apply 3_04_HW2_optional_filter.patch
> - Вместо `MealServlet.resetParam` (перемещение параметров фильтрации в атрибуты запроса для отображения в `meals.jsp`), достаю их в jsp напрямую из запроса через [`${param.xxx}`](https://stackoverflow.com/a/1890462/548473)
> - В демо фильтр не хранится в сессии (скидывается по F5). Что такое сессия будем разбирать, когда будем делать реальную авторизацию
> - Цвет строк сделал через аттрибут `data-mealExcess` и css `tr[data-mealExcess=...]`
>   - [Использование data-* атрибутов](https://developer.mozilla.org/ru/docs/Web/Guide/HTML/Using_data_attributes) 

#### Apply 3_05_HW2_optional_select_user.patch

### ![video](https://cloud.githubusercontent.com/assets/13649199/13672715/06dbc6ce-e6e7-11e5-81a9-04fbddb9e488.png) 2. <a href="https://drive.google.com/open?id=0B9Ye2auQ_NsFMGRVM0QyblJtNGc">Вопросы по API и слоям приложения</a>
- <a href="http://stackoverflow.com/questions/21554977/should-services-always-return-dtos-or-can-they-also-return-domain-models">Should services always return DTOs, or can they also return domain models?</a>
- <a href="http://stackoverflow.com/questions/31644131/spring-dto-dao-resource-entity-mapping-goes-in-which-application-layer-cont/35798539#35798539">Mapping Entity->DTO goes in which application layer: Controller or Service?</a>

### ![question](https://cloud.githubusercontent.com/assets/13649199/13672858/9cd58692-e6e7-11e5-905d-c295d2a456f1.png) Вопросы по HW2

> Что делает `repository.computeIfAbsent / computeIfPresent` ?

Всегда пробуйте ответить на вопрос сами. Дастоточно просто зайти по Ctrl+мышка в реализацию и посмотреть javadoc и **их дефолтную реализацию**

> Почему выбрана реализация `Map<userId, Map<mealId,Meal>>` а не `Meal.userId + Map<mealId,Meal>` ?

В данном случае двойная мапа - самый эффективный способ хранения, который не требует итерирования (перебора всех значений).

## Занятие 3:
### ![video](https://cloud.githubusercontent.com/assets/13649199/13672715/06dbc6ce-e6e7-11e5-81a9-04fbddb9e488.png) 3. <a href="https://drive.google.com/open?id=0B9Ye2auQ_NsFOU8wWlpPVE05STA">Коротко о жизненном цикле Spring контекста.</a>
#### Apply 3_06_bean_life_cycle.patch
-  <a href="http://habrahabr.ru/post/222579/">Spring изнутри. Этапы инициализации контекста.</a>
-  Ресурсы:
   -  <a href="https://www.youtube.com/watch?v=BmBr5diz8WA">Евгений Борисов. Spring, часть 1</a>
   -  <a href="https://www.youtube.com/watch?v=cou_qomYLNU">Евгений Борисов. Spring, часть 2</a>

### ![video](https://cloud.githubusercontent.com/assets/13649199/13672715/06dbc6ce-e6e7-11e5-81a9-04fbddb9e488.png)  4. <a href="https://drive.google.com/open?id=0B9Ye2auQ_NsFODlkU1B0QnNnSGs">Тестирование через JUnit.</a>
### ВНИМАНИЕ!! Перед накаткой патча создайте каталог test (из корня проекта путь `\src\test`), иначе часть файлов попадет в `src\main`.

> - в `maven-surefire-plugin` (JUnit) <a href="http://stackoverflow.com/questions/17656475/maven-source-encoding-in-utf-8-not-working/17671104#17671104">поменял кодировку на UTF-8</a>
> - добавил метод `InMemoryUserRepositoryImpl.init()` для инициализации.
>   - `save()` больше не работает для  отсутствующих `id`
>   - автогенерацию id начал со 100
> - пакет `mock` переименовал в `inmemory`
> - переименовал тестовые классы 

#### Apply 3_07_add_junit.patch
### После патча сделайте `clean` и [обновите зависимости Maven](https://github.com/JavaOPs/topjava/wiki/IDEA#%D0%9E%D0%B1%D0%BD%D0%BE%D0%B2%D0%B8%D1%82%D1%8C-%D0%B7%D0%B0%D0%B2%D0%B8%D1%81%D0%B8%D0%BC%D0%BE%D1%81%D1%82%D0%B8-%D0%B2-maven-%D0%BF%D1%80%D0%BE%D0%B5%D0%BA%D1%82%D0%B5), чтобы IDEA определила сорсы тестов
#### ![question](https://cloud.githubusercontent.com/assets/13649199/13672858/9cd58692-e6e7-11e5-905d-c295d2a456f1.png) Вопрос: почему проект упадет при попытке открыть страничку еды (в логе смотреть самый верх самого нижнего исключения)?
-  <a href="http://junit.org/junit4/">JUnit 4</a>
-  <a href="http://habrahabr.ru/post/120101/">Тестирование в Java. JUnit</a>

### ![video](https://cloud.githubusercontent.com/assets/13649199/13672715/06dbc6ce-e6e7-11e5-81a9-04fbddb9e488.png) 5. <a href="https://drive.google.com/open?id=0B9Ye2auQ_NsFai1veG9qaFZlZ2s">Spring Test</a>
> - поменял `@RunWith`: `SpringRunner` is an alias for the `SpringJUnit4ClassRunner`
#### Apply 3_08_add_spring_test.patch
-  <a href="https://docs.spring.io/spring/docs/4.3.x/spring-framework-reference/htmlsingle/#testing">Spring Testing</a>

### ![video](https://cloud.githubusercontent.com/assets/13649199/13672715/06dbc6ce-e6e7-11e5-81a9-04fbddb9e488.png) 6. <a href="https://drive.google.com/open?id=0B9Ye2auQ_NsFVlNYczhnSU9JdXc">Базы данных. Обзор NoSQL и Java persistence solution без ORM.</a>
-  <a href="https://ru.wikipedia.org/wiki/PostgreSQL">PostgreSQL</a>.
-  [PostgreSQL JDBC Driver](https://github.com/pgjdbc/pgjdbc)
-  <a href="http://java-course.ru/begin/postgresql/">Установка PostgreSQL</a>. **ВНИМАНИЕ! с Postgres 11 есть проблемы.** 
-  Чтобы избежать проблем с правами и именами каталогов, [**рекомендуют установить postgres в простой каталог, например `C:\Postgresql`**. И при проблемах создать каталог data на другом диске](https://stackoverflow.com/questions/43432713/postgresql-installation-on-windows-8-1-database-cluster-initialisation-failed). Если Unix, [проверить права доступа к папке (0700)](http://www.sql.ru/forum/765555/permissions-should-be-u-rwx-0700).
    
> Создать в pgAdmin новую базу `topjava` и новую роль `user`, пароль `password`

![image](https://cloud.githubusercontent.com/assets/13649199/18809406/118f9c48-8283-11e6-8f10-d8291517a497.png)

>  Проверьте, что у user в Privileges есть возможность авторизации (особенно для pgAdmin4)

или в UNIX командной строке:
```
sudo -u postgres psql
CREATE DATABASE topjava;
CREATE USER "user" WITH password 'password';
GRANT ALL PRIVILEGES ON DATABASE topjava TO "user";
```
-  <a href="http://alexander.holbreich.org/2013/03/nosql-or-rdbms/">NoSQL or RDBMS.</a> <a href="http://habrahabr.ru/post/77909/">Обзор NoSQL систем</a>. <a href="http://blog.nahurst.com/visual-guide-to-nosql-systems">CAP</a>
-  <a href="http://db-engines.com/en/ranking">DB-Engines Ranking</a>
-  <a href="http://ru.wikipedia.org/wiki/Java_Database_Connectivity">JDBC</a>
-  Обзор Java persistence solution без ORM: <a href="http://commons.apache.org/proper/commons-dbutils/">commons-dbutils</a>,
            <a href="https://docs.spring.io/spring/docs/current/spring-framework-reference/data-access.html#jdbc">Spring JdbcTemplate</a>,
            <a href="http://en.wikipedia.org/wiki/MyBatis">MyBatis</a>, <a href="http://www.jdbi.org/">JDBI</a>, <a href="http://www.jooq.org/">jOOQ</a>
- Основы:
  - <a href="https://ru.wikipedia.org/wiki/Реляционная_СУБД">Реляционная СУБД</a>
  - <a href="http://habrahabr.ru/post/103021/">Реляционные базы</a>
  - <a href="https://www.youtube.com/playlist?list=PLIU76b8Cjem5qdMQLXiIwGLTLyUHkTqi2">Уроки по JDBC</a>
  - <a href="http://postgresguide.com/">Postgres Guide</a>
  - <a href="http://www.postgresqltutorial.com">PostgreSQL Tutorial</a>
  - <a href="http://campus.codeschool.com/courses/try-sql">Try SQL</a>
  - <a href="http://java-course.ru/begin/database01/">Базы данных на Java</a>
  - <a href="http://java-course.ru/begin/database02/">Возможности JDBC — второй этап</a>
- Дополнительно:
  - [Документация к PostgreSQL 9.6](https://postgrespro.ru/docs/postgresql/9.6/index.html)
  - [Книги по PostgreSQL](https://postgrespro.ru/education/books)

### ![video](https://cloud.githubusercontent.com/assets/13649199/13672715/06dbc6ce-e6e7-11e5-81a9-04fbddb9e488.png) 7. <a href="https://drive.google.com/open?id=0B9Ye2auQ_NsFQWtHYU1qTDlMWVE">Настройка Database в IDEA.</a>
#### Apply 3_09_add_postgresql.patch
-  <a href="http://habrahabr.ru/company/JetBrains/blog/204064/">Настройка Database в IDEA</a> и запуск SQL.

### ![video](https://cloud.githubusercontent.com/assets/13649199/13672715/06dbc6ce-e6e7-11e5-81a9-04fbddb9e488.png) 8. <a href="https://drive.google.com/open?id=0B9Ye2auQ_NsFMGNWUXhaVzdlU0k">Скрипты инициализации базы. Spring Jdbc Template.</a>
> в `JdbcUserRepositoryImpl.getByEmail()` заменил `queryForObject()` на `query()`. Загляните в код: `queryForObject` бросает `EmptyResultDataAccessException` вместо нужного нам `null`.

#### Apply 3_10_db_implementation.patch
> - в `JdbcUserRepositoryImpl.save()` добавил проверку на несуществующей в базе `User.id`
> - в классе `JdbcTemplate` есть настройки (`queryTimeout/ skipResultsProcessing/ skipUndeclaredResults`) уровня приложения (если они будут менятся, то, скорее всего, везде в приложении).
  Мы можем дополнительно сконфигурировать его в `spring-db.xml` и использовать в конструкторах `NamedParameterJdbcTemplate` и в `SimpleJdbcInsert` вместо `dataSource`.

-  Подключение <a href="https://docs.spring.io/spring/docs/current/spring-framework-reference/data-access.html#jdbc">Spring Jdbc</a>.
-  Конфигурирование DataSource. <a href="http://www.mkyong.com/spring/spring-propertyplaceholderconfigurer-example/">Property Placeholder</a>

>  Проверьте, что в контекст Spring проекта включены оба файла конфигурации

![image](https://cloud.githubusercontent.com/assets/13649199/24730713/eb21456a-1a6d-11e7-997c-fb4ad728ba45.png)

### ![video](https://cloud.githubusercontent.com/assets/13649199/13672715/06dbc6ce-e6e7-11e5-81a9-04fbddb9e488.png) 9. <a href="https://drive.google.com/open?id=1SPMkWMYPvpk9i0TA7ioa-9Sn1EGBtClD">Тестирование UserService через AssertJ.</a>
#### Apply 3_11_test_UserService.patch
> - В конструктор `User` внес `registered` и делаю копию `roles`, чтобы роли нельзя было изменить после инициализации.

- [Spring Testing Annotations](https://docs.spring.io/spring/docs/4.3.x/spring-framework-reference/htmlsingle/#integration-testing-annotations-spring)
- [The JPA hashCode() / equals() dilemma](https://stackoverflow.com/questions/5031614/the-jpa-hashcode-equals-dilemma)
- [Hibernate: implementing equals() and hashCode()](https://docs.jboss.org/hibernate/orm/current/userguide/html_single/Hibernate_User_Guide.html#mapping-model-pojo-equalshashcode)
- [Junit Matcher for comparators](https://stackoverflow.com/questions/17949752)
- [AssertJ custom comparison strategy](http://joel-costigliola.github.io/assertj/assertj-core-features-highlight.html#custom-comparison-strategy). [AssertJ field by field comparisons](http://joel-costigliola.github.io/assertj/assertj-core-features-highlight.html#field-by-field-comparison)

### ![video](https://cloud.githubusercontent.com/assets/13649199/13672715/06dbc6ce-e6e7-11e5-81a9-04fbddb9e488.png) 10. <a href="https://drive.google.com/open?id=0B9Ye2auQ_NsFVmZaSm9UMktXUnc">Логирование тестов.</a>
#### Apply 3_12_test_logging.patch
> - Новый PostgreSQL JDBC Driver [логирует через java.util.logging](https://github.com/pgjdbc/pgjdbc#changelog).  [Направил логирование в SLF4J](http://stackoverflow.com/a/43242620/548473)
> - Поменял формат вывода. См. [Logback Layouts](https://logback.qos.ch/manual/layouts.html)

- Ресурсы, которые кладутся в classpath, maven при сборке берет из определенных каталогов `resources` ([Introduction to the Standard Directory Layout](https://maven.apache.org/guides/introduction/introduction-to-the-standard-directory-layout.html)). Их можно настраивать через [maven-resources-plugin](https://maven.apache.org/plugins/maven-resources-plugin/examples/resource-directory.html), меняем в проекте Masterjava.

#### Apply 3_13_fix_servlet.patch
**Приложение перестало работать, тк. для репозитория мы используем заглушку `JdbcMealRepositoryImpl`**
 
### ![video](https://cloud.githubusercontent.com/assets/13649199/13672715/06dbc6ce-e6e7-11e5-81a9-04fbddb9e488.png) 11. <a href="https://drive.google.com/open?id=0B9Ye2auQ_NsFNDlOQVpOWF82OTA">Ответы на Ваши вопросы</a>
-  Что такое REST? <a href="http://blog.mwaysolutions.com/2014/06/05/10-best-practices-for-better-restful-api/">10 Best Practices for Better RESTful API</a>
-  Зачем нужна сортировка еды?
-  Можно ли обойтись без `MapSqlParameterSource`?
-  Как происходит работа с DB в тестах?
-  Как реализовывать RowMapper?
-  Мои комментарии: решения проблем разработчиком.
-  Нужен ли разработчику JavaScript?

## ![question](https://cloud.githubusercontent.com/assets/13649199/13672858/9cd58692-e6e7-11e5-905d-c295d2a456f1.png) Ваши вопросы
> Какая разница между @BeforeClass and @Before? 

`@BeforeClass` выполняется один раз после загрузки класса (поэтому метод может быть только статический), `@Before` перед каждым тестом.
Также: для чистоты тестов экземпляр тестового класса пересоздается перед каждым тестом: http://stackoverflow.com/questions/6094081/junit-using-constructor-instead-of-before

> Тесты в классе в каком-то определенном порядке выполняются ("сверху вниз" например)?

Порядок по умолчанию неопределен, каждый тест должен быть автономен и не зависеть от других. См. также http://stackoverflow.com/questions/3693626/how-to-run-test-methods-in-specific-order-in-junit4 

> Обязательно ли разворачивать postgreSQL?

Желательно: хорошая и надежная ДБ:) Если совсем не хочется - можно работать со своей любимой RDBMS (поправить `initDB.sql`) или работать c postgresql в heroku (креденшелы к нему есть сверху в `postgres.properties`). На следующем уроке добавим HSQLDB, она не требует установки.

> Зачем начали индексацию с 100000?

Тут нет "как принято". Так удобно вставлять в базу (если будет потребность) записи вручную не мешая счетчику.

> Из 5-го видео - "Логика в базе - большое зло". Можно чуть поподробней об этом?

- Есть успешные проекты с логикой в базе. Те все относительно.
- Логика в базе - это процедуры и триггеры. Нет никакого ООП, переиспользовать код достаточно сложно, никагого рефакторинга, поиска по коду и других плюшек IDE. Нельзя делать всякие вещи типа кэширования, хранения в сесии - это все для логики на стороне java. Например json можно напрямую отдать в процедуру и там парсить и вставлять в таблицы или наоборот - собирать из таблиц и возвращать.
А затем потребуется некоторая логика на стороне приложения и все равно придется этот json дополнительно разпарсивать в java.
Я на таком проекте делал специальную миграцию, чтобы процедуры мигрировать не как sql скрипты, а каждую процедуру хранить как класс с историей изменений. Если логика: триггеры и простые процедуры записи-чтения, которые не требуют переиспользования кода или
проект небольшой это допустимо, иначе проект становится трудно поддерживать. Также иногда используют [View](http://postgresql.ru.net/gruber/ch20.html) для разграничения доступа. Например, для финансовых систем, таблицы проводок доступны только  для админ учеток, а View просто не дадут увидеть (тем более изменить) данны обычному оператору на уровне СУБД.

> У JUnit есть ассерты и у спринга тоже. Можно ли обойтись без JUnit?

Предусловия и JUnit-тесты совершенно разные вещи. Один другого не заменит, у нас будут предусловия в следующем уроке.

> Я так понял VARCHAR быстрее, чем TEXT, когда мы работаем с небольшими записями. Наши записи будут небольшими (255). Почему вы приняли решение перейти на TEXT?

В отличие от MySql в Postgres  VARCHAR и TEXT - тоже самое: http://stackoverflow.com/questions/4848964/postgresql-difference-between-text-and-varchar-character-varying

> Зачем при создании таблицы мы создаем `CREATE UNIQUE INDEX` и `CREATE INDEX`. При каких запросах он будет использоваться?

UNIQUE индекс нужен для обеcпечения уникальности, DB не даст сделать одинаковый индекс. Индексы используется для скорости выполнения запросов. Обычно они задействуются, когда в запросе есть условия, на которые сделан индекс. Узнать по конкретному запросу можно  запросив план запроса: см. <a href="https://habrahabr.ru/post/203320">Оптимизация запросов. Основы EXPLAIN в PostgreSQL</a>. На измерение производительности с индексами посмотрим в следующем уроке.

> А это нормально, что у нас в базе у meals есть userId, а в классе - нет?

Ненормально, когда в приложении есть "лишний" код, который не используется. Для ORM он нам понадобится- мы `Meal.user` добавим.

> Почему мы использует один sequence на разные таблицы?

Мы будем использовать Hibernate, по умолчанию он делает глобальный sequence на все таблицы. В этом подходе есть <a href="http://stackoverflow.com/questions/1536479/asking-for-opinions-one-sequence-for-all-tables">как плюсы, так и минусы</a>, из плюсов - удобно делать ссылки в коде и в таблицах на при наследовании и мапы в коде. В дополнение: <a href="http://stackoverflow.com/questions/6633384/can-i-configure-hibernate-to-create-separate-sequence-for-each-table-by-default">Configure Hibernate to create separate sequence for each table by default</a>.

## ![hw](https://cloud.githubusercontent.com/assets/13649199/13672719/09593080-e6e7-11e5-81d1-5cb629c438ca.png) Домашнее задание HW03
- 1 Понять, почему перестали работать `SpringMain, InMemoryAdminRestControllerTest, InMemoryAdminRestControllerSpringTest`
- 2 Дополнить скрипты создания и инициализации базы таблицой MEALS. Запустить скрипты на вашу базу (через Run). Порядок таблиц при DROP и DELETE важен, если они связаны внешними ключами (foreign key, fk). Проверьте, что ваши скрипты работают
- 3 Реализовать через Spring JDBC Template `JdbcMealRepositoryImpl`
  - 3.1. сделать каждый метод за один SQL запрос
  - 3.2. `userId` в класс `Meal` вставлять НЕ надо (для UI и REST это лишние данные, userId это id залогиненного пользователя)
  - 3.3. `JbdcTemplate` работает через сеттеры. Вместе с конструктором по умолчанию их нужно добавить в `Meal` 
  - 3.4. Cписок еды должен быть отсортирован (тогда мы его сможем сравнивать с тестовыми данными). Кроме того это требуется для UI и API: последняя еда наверху.
- 4 Проверить работу MealServlet, запустив приложение

#### Optional
- 5 Сделать `MealServiceTest` из `MealService` и реализовать тесты для `JdbcMealRepositoryImpl`.
> По `Ctrl+Shift+T` (выбрать JUnit4) можно создать тест для конкретного класса, выбрав для него нужные методы. Тестовый класс создастся в папке `test` в том же пакете, что и тестируемый. 
  - 5.1 Сделать тестовые данные `MealTestData` (точно такие же, как вставляем в `populateDB.sql`).
  - 5.2 Сделать тесты на чужую еду (delete, get, update) с тем чтобы получить `NotFoundException`.
- 6 Почнинить `SpringMain, InMemory*Test`. `InMemory*Test` **должны использовать реализацию в памяти**
- 7 Сделать индексы к таблице `Meals`: запретить создавать у одного и того-же юзера еду с одинаковой dateTime.
Индекс на pk (id) postgres создает автоматически: <a href="http://stackoverflow.com/questions/970562/postgres-and-indexes-on-foreign-keys-and-primary-keys">Postgres and Indexes on Foreign Keys and Primary Keys</a>
  - [PostgreSQL: индексы](https://postgrespro.ru/docs/postgresql/10/indexes-intro)
  - <a href="http://postgresguide.com/performance/indexes.html">Postgres Guide: Indexes</a>
  - [Оптимизация запросов. Основы EXPLAIN в PostgreSQL](https://habrahabr.ru/post/203320/)
  - [Оптимизация запросов. Часть 2](https://habrahabr.ru/post/203386/)
  - [Оптимизация запросов. Часть 3](https://habrahabr.ru/post/203484/)

> ![question](https://cloud.githubusercontent.com/assets/13649199/13672858/9cd58692-e6e7-11e5-905d-c295d2a456f1.png) Как правильно придумать индекс для базы? Указать в нем все поля, комбинация которых создает по смыслу уникальную запись, или какие-то еще есть условия?

Индекс нужно делать по тем полям, по которым будут искаться записи (участвуют в WHERE, ORDER BY). Уникальность - совсем не обязательное условие. Индексы ускоряют поиск по определенным полям таблицы. Они не бесплатные (хранятся в памяти, замедляется вставка), поэтому на всякий случай их делать не надо. Также не строят индексы на колонки с малым процентом уникальности (например поле "М/Ж"). Поля индекса НЕ КОММУТАТИВНЫ и порядок полей в описании индекса НЕОБХОДИМО соблюдать (в силу использования B-деревьев и их производных как поисковый механизм индекса). При построении плана запроса EXPLAIN учитывается количество записей в базе, поэтому вместо индексного поиска (Index Scan) база может выбрать последовательный (Seq Scan). Проверить, работают ли индексы можно <a href="http://stackoverflow.com/questions/14554302/postgres-query-optimization-forcing-an-index-scan">отключив Seq Scan</a>. Также см. <a href="https://dba.stackexchange.com/a/27493/3684">Queries on the first field of composite index</a>

### ![error](https://cloud.githubusercontent.com/assets/13649199/13672935/ef09ec1e-e6e7-11e5-9f79-d1641c05cbe6.png) Решение проблем

> Из каталога `main` не видятся классы/ресурсы в `test`

Все что находится в `test` используется только для тестов и недоступно в основном коде.  

> Из `IDEA` не видятся ресурсы в каталоге `test`

- Сделайте Reimport All в Maven окне

![image](https://cloud.githubusercontent.com/assets/13649199/18831806/7e43bedc-83f0-11e6-97db-67d4e1a7599f.png)

> В UserServiceImpl и MealServiceImpl подчеркнуты красным repository, ошибка: Could not autowire. There is more than one bean of 'MealRepository' type.

- Spring test контекст не надо включать в Spring Facets проекта, там должны быть только `spring-app.xml` и `spring-db.xml`. Для тестовых контекстов поставьте чекбокс `Check test files` в Inspections. 

![image](https://cloud.githubusercontent.com/assets/13649199/18831817/8a858f22-83f0-11e6-837e-bf5317b33b3a.png)

### ![error](https://cloud.githubusercontent.com/assets/13649199/13672935/ef09ec1e-e6e7-11e5-9f79-d1641c05cbe6.png) Проверка по HW03 (сначала сделайте самостоятельно!)

- 1: В `MealTestData` еду делайте константами. Не надо `Map` конструкций!
- 2: SQL  case-insensitive, не надо писать в стиле Camel. В POSTGRES возможны case-sensitive значения, их надо в кавычки заключать (обычно не делают).
- 3: ЕЩЕ РАЗ: `InMemory` тесты должны идти на `InMemory` репозитории
- 4: **Проверьте, что возвращает `JdbcMealRepositoryImpl` при обновлении чужой еды**
- 5: В реализации `JdbcMealRepositoryImpl` одним SQL запросом используйте возвращаемое `update` значение `the number of rows affected`
- 6: При тестировании не портите констант из `MealTestData`
- 7: Проверьте, что все, что относится к тестам, ноходится в каталоге `test` (не попадает в сборку проекта)
- 8: **Еще раз: в тестах проверять через `JUnit Assert` или использовать `assertThat().isEqualTo` нельзя: сравнение будет происходить через `equals`, который сравнивает объекты только по `id`. Мы не можем переопределять `equals` для объектов модели, тк будем использовать JPA (см. [The JPA hashCode() / equals() dilemma](https://stackoverflow.com/questions/5031614/the-jpa-hashcode-equals-dilemma))**
- 9: НЕ делайте склейку SQL запросов вручную из параметров, только через `jdbcTemplate` параметры! См. [Внедрение_SQL-кода](https://ru.wikipedia.org/wiki/Внедрение_SQL-кода)
- 10: Напомню: `BeanPropertyRowMapper` работает через отражение. Ему нужны геттеры/сеттеры и имена полей должны "совпадать" с колонками `ResultSet` (Column values are mapped based on matching the column name as obtained from result set metadata to public setters for the corresponding properties. The names are matched either directly or by transforming a name separating the parts with underscores to the same name using "camel" case).
