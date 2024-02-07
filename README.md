# Оглавление

* [**Общие вопросы**](#общие-вопросы)
    * [Как в командной работе была устроена работа с git? Был ли CI, настраивал ли самостоятельно?](#как-в-командной-работе-была-устроена-работа-с-git-был-ли-ci-настраивал-ли-самостоятельно)
    * [Какие менеджеры зависимостей используешь и почему? Положительно или негативно относишься к использованию third-party libraries?](#какие-менеджеры-зависимостей-используешь-и-почему-положительно-или-негативно-относишься-к-использованию-third-party-libraries)
    * [Писал ли фреймворки самостоятельно? Чем статик фреймворк от динамик отличается?](#писал-ли-фреймворки-самостоятельно-чем-статик-фреймворк-от-динамик-отличается)
* [**Swift**](#swift)
    * [В чем преимущества Swift?](#в-чем-преимущества-swift)
    * [Чем является Optional под капотом?](#чем-является-optinal-под-капотом)
    * [К какой семантике относится enum?](#к-какой-симантике-относится-enum)
    * [Какие ещё бывают семантики? Какие между ними отличия? Какие типы данных относятся к каждой из них?](#какие-ещё-бывают-семантики-какие-между-ними-отличия-какие-типы-даных-относятся-к-каждой-из-них)
    * [Будет ли скомпилирован этот код? Почему? Как исправить, чтобы компилировалось](#будет-ли-скомпилирован-этот-код-почему-как-исправить-чтобы-компилировалось)
    * [Задача на многопоточность](#задача-на-многопоточность-у-нас-есть-какое-то-количество-тяжеловесных-операций-по-памяти-мы-хотим-их-распаралелить-для-быстроты-работы-но-из-за-того-что-они-тяжеловесные-эмпирическим-путям-выяснили-что-максимум-можно-распаралелить-на-4-потока-как-н)
    * [Как реализовать thread-safe массив?](#как-реализовать-thread-safe-массив)
    * [Ещё одна задача, не на многопоточность](#ещё-одна-задача-не-на-многопоточность-у-нас-всё-так-же-есть-какое-то-кол-во-операций-они-жрут-оперативку-но-нам-их-нужно-в-цикле-выполнить-например-хотим-просто-скачать-1000-картинок-и-отобразить-их-на-viewcontroller-всё-ли-будет-ок-почему-как-по)
    * [Как работает ARC?](#как-работает-arc)
    * [Какие хранилища данных использовал? Писал ли AppExtensions? Как делать шареные хранилища (дефолты, кейчейн)?](#какие-хранилища-данных-использовал-писал-ли-appextensions-как-делать-шареные-хранилища-дефолты-кейчейн)
    * [Какие шаблоны проектирования используешь?](#какие-шаблоны-проектирования-используешь)
    * [+ и - синглтона?](#-и-синглтона)
    * [Как можно реализовать шаблон обзервер?](#как-можно-реализовать-шаблон-обзервер)
    * [Как создать хранилище слабых ссылок?](#как-создать-хранилище-слабых-ссылок)
* [**UIKit**](#uikit)
    * [Разница между points и pixels?](#разница-между-points-и-pixels)
    * [Чем отличаются bounds и frame?](#чем-отличаются-bounds-и-frame)
    * [Когда bounds будет отлично от нуля?](#когда-bounds-будет-отлично-от-нуля)
    * [Как работает Auto Layout?](#как-работает-autolayout)
    * [За счёт чего View отрисовывается на экране?](#за-счёт-чего-view-отрисовывается-на-экране)
    * [Можно ли построить полноценный UI з кнопками, toggler-ами и т.д., используя чисто CALayers?](#можно-ли-построить-полноценный-ui-з-кнопкками-toggler-ами-итд-используя-чисто-calayers)
    * [Как работает Responder Chain?](#как-работает-responderchain)
    * [Как определяется, какой UIResponder должен обрабатывать события касания?](#как-определяется-какой-uiresponder-должен-обрабатывать-события-касания-touch-event)
    * [Какое есть важное правило при работе с UI в многопоточном приложении?](#какое-есть-важное-правило-при-работе-с-ui-в-многопоточном-приложении)
    * [Где берёт ресурсы CoreGraphics, а где CoreAnimation?](#где-берёт-ресурсы-coregraphics-а-где-coreanimation)

# Общие вопросы

### Как в командной работе была устроена работа с git? Был ли CI, настраивал ли самостоятельно?

<details>
<summary>Answer</summary>

Просто слушаем про опыт. С git интересует работа с бренчами, процессы код ревью 

</details>

### Какие менеджеры зависимостей используешь и почему? Положительно или негативно относишься к использованию third-party libraries?

<details>
<summary>Answer</summary>

Приемлемый ответ - пытаюсь делать сам. Использую third-party, когда без них не обойтись (аналитика и т.д.), если не выделяют достаточно времени на проекте, какие-то специфические сценарии, где нецелесообразно изобретать велосипед

</details>

### Писал ли фреймворки самостоятельно? Чем статик фреймворк от динамик отличается?

<details>
<summary>Answer</summary>

Статик "вшивается" в исполнительный файл, в то время как динамик лежит отдельно, а исполнительный файл на него только ссылается

</details>

# Swift

### В чем преимущества Swift?
<details>
<summary>Answer</summary>

- Быстрый. [Apple пишет про 2.6x скорость в сравнении с obj-c](https://www.apple.com/swift/)
- Построен с концепцией безопасности
- Совместимость с Objective-C
- Присутсвует концепция Optional

Самое главное вывести на Optional, чтобы потом раскручивать эту тему

</details>

### Чем является Optional под капотом?

<details>
<summary>Answer</summary>

```swift
enum Optional<T> {
    case some(T)
    case none
}
```

</details>
  
### К какой семантике относится `enum`?

<details>
<summary>Answer</summary>

Value семантика

</details>

### Какие ещё бывают семантики? Какие между ними отличия? Какие типы даных относятся к каждой из них?

<details>
<summary>Answer</summary>

`value` и `reference`  
К reference относятся `class`, `closure`, `actor`, к `value` - всё остальное.  
При передаче параметров `value` семантики, они копируются (хотя есть оптимизации по типу copy-on-write), у `reference` копируется только указатель, а данные шерятся. Также `reference` всегда хранится на куче, `value` - в основном на стэке, хотя бывают и случаи, когда тоже хранится на куче (например, когда value тип является частью reference типа, или value тип имеет ооочень много полей => большой вес, другое)

</details>

### Будет ли скомпилирован этот код? Почему? Как исправить, чтобы компилировалось

```swift
struct Parent {
    var child: Child
}

struct Child {
    var parent: Parent
}
```

<details>
<summary>Answer</summary>

Нет, компилятор не может определить сколько памяти нужно выделить. Варианты решения:  

- Через протокол

```swift
protocol Human { }

struct Parent: Human {
    var child: Human
}

struct Child: Human {
    var parent: Human
}
```

- Через массив

```swift
struct Parent {
    var child: [Child]
}

struct Child {
    var parent: [Parent]
}
```

- Через классы

```swift
class Parent {
    var child: Child
}

class Child {
    var parent: Parent
}
```

</details>

### Static dispatch. Что выведется?

```swift
protocol Drawing {
    func render()
}

extension Drawing {
    func circle() { print("protocol") }
    func render() { circle() }
}

class SVG: Drawing {
    func circle() { print("class") }
}

SVG().render()
```

<details>
<summary>Answer</summary>

Выведется "protocol". func circle() не задекларирована в protocol и реализована в extension, поэтому будет static dispatch реализации из extension.

</details>

### Function performance. Какой синтаксис лучше перформит?

```swift
protocol Networking {}

// A
func load(_ networking: Networking) {}

// B
func load<N: Networking>(networking: N) {}
```

<details>
<summary>Answer</summary>

- A - existential type.
    Динамическая диспетчеризация и компилятор должен в рантайме лезть в лукап таблицу
- B - generic constraint.
    Статическая диспетчеризация и подставляемый тип известен на момент компиляции

</details>

### Задача на многопоточность. У нас есть какое-то количество тяжеловесных операций по памяти. Мы хотим их распараллелить для быстроты работы, но из-за того, что они тяжеловесные, эмпирическим путям выяснили, что максимум можно распараллелить на 4 потока. Как нам это реализовать средствами GCD?

<details>
<summary>Answer</summary>

С использованием DispatchSemaphore и DispatchQueue

```swift
let queue = DispatchQueue(label: "label", attributes: .concurrent)
let semaphore = DispatchSemaphore(value: 4)
   
semaphore.wait()
   
queue.async {
    someOperation()
    semaphore.signal()
}
```

</details>

### Как реализовать thread-safe массив?

<details>
<summary>Answer</summary>

- Через barrier [nice examples](https://gist.github.com/basememara/afaae5310a6a6b97bdcdbe4c2fdcd0c6)

```swift
var array = []
let queue = DispatchQueue(label: "thread-safe-obj", attributes: .concurrent)

// write
queue.async(flags: .barrier) {
    // perform writes on data
}

// read
queue.sync {
    // perform read and assign value
}
```

- Через NSLock

```swift
var lock = NSLock()
var array = [1, 2, 3]

lock.lock()
array.append(4)
lock.unlock()

===============

extension NSLock {
    @discardableResult
    func with<T>(_ block: () throws -> T) rethrows -> T {
        lock()
        defer { unlock() }
        return try block()
    }
}

let lock = NSLock()
var array = [1, 2, 3]

lock.with { array.append(4) }

===============

@propertyWrapper
struct Atomic<Value> {

    private let lock = NSLock()
    private var value: Value

    init(default: Value) {
        self.value = `default`
    }

    var wrappedValue: Value {
        get {
            lock.lock()
            defer { lock.unlock() }
            return value
        }
        set {
            lock.lock()
            value = newValue
            lock.unlock()
        }
    }
}
```

- Через actors

```swift
actor SyncArray<T> {
    private var buffer: [T]
    
    init<S: Sequence>(_ elements: S) where S.Element == T {
        buffer = Array(elements)
    }
    
    var count: Int {
        buffer.count
    }
    
    func append(_ element: T) {
        buffer.append(element)
    }
    
    @discardableResult
    func remove(at index: Int) -> T {
        buffer.remove(at: index)
    }
}

Task {
    let array = SyncArray([1])

    if await array.count == 1 { 
        await array.remove(at: 0)
    }
}
```

</details>

### Ещё одна задача, не на многопоточность. У нас всё так же есть какое-то кол-во операций, они жрут оперативку, но нам их нужно в цикле выполнить. Например, хотим просто скачать 1000 картинок и отобразить их на ViewController. Всё ли будет ок? Почему? Как починить?

```swift
func loadImages() {
    let url = URL(string: "https://picsum.photos/200")!

    for _ in 0...1000 {
            
        let data = try! Data(contentsOf: url)
        let image = UIImage(data: data)!
        self.someOperation(image)
    }
}
```

<details>
<summary>Answer</summary>

Мы упадём по памяти. Нужно использовать autoreleasepool

```swift
func loadImages() {
    let url = URL(string: "https://picsum.photos/200")!

    for _ in 0...1000 {
        autoreleasepool {
            let data = try! Data(contentsOf: url)
            let image = UIImage(data: data)!
            self.someOperation(image)
        }
    }
}
```

</details>

### Как работает ARC?

<details>
<summary>Answer</summary>

Перед ARC был MRC, в котором нужно было самостоятельно расставлять вызовы release и retain. ARC делает это самостоятельно на этапе компиляции и таким образом, когда счётчик сильных ссылок достигает нуля, объект освобождается из памяти. С такой реализацией бывает проблема retain cycle, когда два объекта ссылаются друг на друга, или объект захватывается в кложуре. Таким образом, память никогда не сможет быть освобождена, поэтому для решения используют слабые ссылки. В итоге всего есть три типа ссылок: strong, weak, unowned. weak отличается от unowned тем, что при weak мы допускам, что объект может быть nil, а при unowned мы гарантируем наличие объекта. Если он всё же будет nil, произойдёт креш в рантайме. Также unowned работает немного быстрее, чем weak из-за особенностей реализации. strong и unowned ссылки указывают на объект. Когда мы доступаемся по weak, то сначала идёт обращение с side table, в которой есть указатель на сам объект. side table создаётся не сразу, а только при создании первой слабой (weak) ссылки.  

_До создания Side Table:_  
![До создания Side Table](https://habrastorage.org/r/w1560/getpro/habr/upload_files/81d/01b/692/81d01b6920f5d497ad2f35f29775540f.png) 
_После создания Side Table:_
![После создания Side Table](https://habrastorage.org/r/w1560/getpro/habr/upload_files/b48/2e8/f80/b482e8f80cd29ff43950e33b832d58e6.png)
[nice article](https://habr.com/ru/company/hh/blog/546856/)

</details>

### Какие хранилища данных использовал? Писал ли AppExtensions? Как делать шареные хранилища (дефолты, кейчейн)?

<details>
<summary>Answer</summary>

```swift
init?(suiteName suitename: String?)
```
[docs](https://developer.apple.com/documentation/foundation/userdefaults/1409957-init)

</details>

### Какие шаблоны проектирования используешь?

<details>
<summary>Answer</summary>

Facade, Decorator, Adapter, Observer, Factory, Singleton, etc.

</details>

### + и - синглтона?

<details>
<summary>Answer</summary>

Минусы:
 - Наружает single responsibility (создаёт + что-то далеает)
 - Скрывает зависимости
 - Может создавать проблемы при тестировании  

Плюсы:
 - Можно достучаться из любого места в коде
 - Имеет только один экземпляр 

</details>

### Есть опыт с реактивными библиотеками? Combine/RxSwift. На каких 2-х Паттернах построена реактивная концепция?

<details>
<summary>Answer</summary>

- «наблюдатель» (Observer) и «итератор» (Iterator)
- Вывести на вопрос об обзервере и его реализации
</details>

### Как можно реализовать шаблон обзервер?

<details>
<summary>Answer</summary>

![Observer](https://refactoring.guru/images/patterns/diagrams/observer/structure-2x.png?id=228af9bded4d6ee6daf43a0e23cca9ff)  

</details>

### Как создать хранилище слабых ссылок?

<details>
<summary>Answer</summary>

- Через Wrapper
```swift
class Weak<T: AnyObject> {
    weak var value : T?

    init (value: T) {
        self.value = value
    }
}
```
- Через функциональный подход
```swift
let foo = Foo()

var foos = [() -> Foo?]()
foos.append({ [weak foo] in return foo })

foos.forEach { $0()?.doSomething() }
```
- Через NSHashTable
```swift
NSHashTable<ObjectType>.weakObjects()
```

</details>

# UIKit

### Разница между points и pixels?

<details>
<summary>Answer</summary>

- `Pixels` (px) - точки на экране.
- `Points` (pt) - плотность точек на экране.

</details>

### Чем отличаются bounds и frame?

<details>
<summary>Answer</summary>

- `frame` – это прямоугольник, описываемый положением location(x, y) и размерами size (width, height) вьюхи, относительно ее superview (вью, в которой она содержится).
- `bounds` – это прямоугольник, описываемый положением location(x, y) и размерами size (width, height) вьюхи, относительно ее собственной системы координат (0, 0)

</details>

### Когда bounds будет отлично от нуля?

<details>
<summary>Answer</summary>

Рассмотрим на примере UIScrollView:
Bounds будет отлично от нуля, когда contentOffset у скролла не равен (0;0)

</details>

### Как работает Auto Layout?

<details>
<summary>Answer</summary>

`Auto Layout` занимается динамическим вычислением позиции и размера всех view на основе constraints — правил заданных для того или иного view. Самый большой и очевидный плюс для разработчика в использовании `Auto Layout` в том, что исчезает необходимость в подгонке размеров приложения под определенные устройства. `Auto Layout`  изменяет интерфейс в зависимости от внешних или внутренних изменений. Минус `Auto Layout` состоит в том, что вычисление конкретных значений сводится к задаче решения системы линейных уравнений, поэтому добавление каждого нового констрейнта ощутимо увеличивает сложность расчета конкретных значений. 

</details>

### За счёт чего View отрисовывается на экране?

<details>
<summary>Answer</summary>

CALayer

</details>

### Можно ли построить полноценный UI з кнопками, toggler-ами и т.д., используя чисто CALayers?

<details>
<summary>Answer</summary>

Нет, CALayer не UIResponder

</details>

### Как работает Responder Chain?

<details>
<summary>Answer</summary>

Приложения получают и обрабатывают события, используя responder objects. Responder object — это любой экземпляр класса UIResponder, а общие подклассы включают UIView, UIViewController и UIApplication. Responder objects получают необработанные данные о событии и должны либо обработать событие, либо перенаправить его другому responder object. Когда ваше приложение получает событие, UIKit автоматически направляет это событие наиболее подходящему объекту, известному как first responder.

Необработанные события передаются от responder к responder в активной responder chain. На рисунке показаны responders в приложении, интерфейс которого содержит label, text field, button и два view. На диаграмме также показано, как события перемещаются от одного responder к другому.

![ResponserChain](https://docs-assets.developer.apple.com/published/7c21d852b9/f17df5bc-d80b-4e17-81cf-4277b1e0f6e4.png) 

</details>

### Как определяется, какой UIResponder должен обрабатывать события касания? (touch event)

<details>
<summary>Answer</summary>

UIKit использует hit-testing, чтобы определить, где происходят события касания. В частности, UIKit сравнивает местоположение касания с bounds view в иерархии views. Метод `hitTest(_:with:)` UIView просматривает иерархию views, ища самое глубокое view, содержащее указанное касание, которое становится first responder на событие касания.

</details>

### Какое есть важное правило при работе с UI в многопоточном приложении?

<details>
<summary>Answer</summary>

Обновлять UI на главном потоке

</details>

### Где берёт ресурсы CoreGraphics, а где CoreAnimation?*

<details>
<summary>Answer</summary>

- CoreGraphics - CPU
- CoreAnimation - GPU

</details>
