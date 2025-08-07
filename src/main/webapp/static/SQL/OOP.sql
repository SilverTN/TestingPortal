-- Создание теста по ООП
INSERT INTO tests (id, title, description) VALUES
    (1, 'Java OOP', 'Тест по основам объектно-ориентированного программирования в Java');

-- Вопрос 1: Что такое ООП?
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (1, 1, 'Что такое ООП?', 1);

-- Варианты ответов для вопроса 1
INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (1, 1, 'Парадигма программирования, основанная на объектах', true),
                                                            (2, 1, 'Язык программирования', false),
                                                            (3, 1, 'Библиотека для работы с объектами', false),
                                                            (4, 1, 'Способ оптимизации кода', false);

-- Вопрос 2: Основные принципы ООП
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (2, 1, 'Назовите основные принципы ООП:', 1);

-- Варианты ответов для вопроса 2
INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (5, 2, 'Инкапсуляция', true),
                                                            (6, 2, 'Наследование', true),
                                                            (7, 2, 'Полиморфизм', true),
                                                            (8, 2, 'Абстракция', true),
                                                            (9, 2, 'Итерация', false),
                                                            (10, 2, 'Компиляция', false);

-- Вопрос 3: Инкапсуляция
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (3, 1, 'Что такое "инкапсуляция"?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (11, 3, 'Сокрытие реализации и объединение данных с методами', true),
                                                            (12, 3, 'Создание множества копий объекта', false),
                                                            (13, 3, 'Наследование свойств родительского класса', false),
                                                            (14, 3, 'Автоматическое управление памятью', false);

-- Вопрос 4: Композиция и агрегация
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (4, 1, 'В чем разница между композицией и агрегацией?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (15, 4, 'Композиция: объект-часть не может существовать без объекта-целого', true),
                                                            (16, 4, 'Агрегация: объект-часть может существовать независимо', true),
                                                            (17, 4, 'Это синонимы', false),
                                                            (18, 4, 'Композиция используется только в интерфейсах', false);

-- Вопрос 5: Статическое и динамическое связывание
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (5, 1, 'Что такое статическое и динамическое связывание?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (19, 5, 'Статическое: во время компиляции', true),
                                                            (20, 5, 'Динамическое: во время выполнения', true),
                                                            (21, 5, 'Статическое: для final методов', true),
                                                            (22, 5, 'Динамическое: только для private методов', false),
                                                            (23, 5, 'Статическое: только для статических переменных', false);

-- Вопрос 6: Преимущества и недостатки ООП
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (6, 1, 'В чем заключаются преимущества и недостатки ООП?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (24, 6, 'Преимущество: повторное использование кода', true),
                                                            (25, 6, 'Недостаток: больший расход памяти', true),
                                                            (26, 6, 'Преимущество: более простая поддержка', true),
                                                            (27, 6, 'Недостаток: более медленная скорость выполнения', false),
                                                            (28, 6, 'Преимущество: не требует сборки мусора', false);

-- Вопрос 7: Класс, объект, интерфейс
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (7, 1, 'Что представляют собой "класс", "объект", "интерфейс"?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (29, 7, 'Класс: шаблон для создания объектов', true),
                                                            (30, 7, 'Объект: экземпляр класса', true),
                                                            (31, 7, 'Интерфейс: контракт для классов', true),
                                                            (32, 7, 'Класс: коллекция статических методов', false),
                                                            (33, 7, 'Объект: синоним переменной', false);

-- Вопрос 8: "Является" vs "Имеет"
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (8, 1, 'Что подразумевают выражения «является» и «имеет» в ООП?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (34, 8, '«Является» — наследование (is-a)', true),
                                                            (35, 8, '«Имеет» — композиция/агрегация (has-a)', true),
                                                            (36, 8, '«Является» — реализация интерфейса', true),
                                                            (37, 8, '«Имеет» — множественное наследование', false),
                                                            (38, 8, '«Является» — отношение между пакетами', false);

-- Вопрос 9: Абстрактные классы vs интерфейсы
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (9, 1, 'Чем абстрактный класс отличается от интерфейса (Java 8+)?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (39, 9, 'Абстрактный класс может иметь состояние (поля)', true),
                                                            (40, 9, 'Интерфейс может содержать default-методы', true),
                                                            (41, 9, 'Абстрактный класс поддерживает конструкторы', true),
                                                            (42, 9, 'Интерфейс может наследовать несколько интерфейсов', true),
                                                            (43, 9, 'Абстрактный класс быстрее выполняется', false),
                                                            (44, 9, 'Интерфейс может иметь final-методы', false);

-- Вопрос 10: Перегрузка vs переопределение
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (10, 1, 'В чем разница между перегрузкой (overload) и переопределением (override)?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (45, 10, 'Перегрузка: один класс, разные параметры', true),
                                                            (46, 10, 'Переопределение: подкласс изменяет метод родителя', true),
                                                            (47, 10, 'Перегрузка требует одинакового возвращаемого типа', false),
                                                            (48, 10, 'Переопределение возможно только для static методов', false),
                                                            (49, 10, 'Перегрузка: только для private методов', false);

-- Вопрос 11: Иммутабельные объекты
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (11, 1, 'Что такое иммутабельный объект?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (50, 11, 'Объект, состояние которого нельзя изменить после создания', true),
                                                            (51, 11, 'Класс, все поля которого объявлены как final', true),
                                                            (52, 11, 'Объект, который можно изменять через геттеры', false),
                                                            (53, 11, 'Объект без методов', false),
                                                            (54, 11, 'Объект, который автоматически клонируется при изменении', false);

-- Вопрос 12: Ковариантность возвращаемого типа
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (12, 1, 'Что такое ковариантность возвращаемого типа?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (55, 12, 'Возможность сужать тип возвращаемого значения при переопределении метода', true),
                                                            (56, 12, 'Пример: метод в подклассе возвращает подтип', true),
                                                            (57, 12, 'Это изменение имени метода в подклассе', false),
                                                            (58, 12, 'То же самое, что перегрузка метода', false),
                                                            (59, 12, 'Возможность возвращать void вместо конкретного типа', false);

-- Вопрос 13: Паттерн Singleton
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (13, 1, 'Для чего нужен паттерн Singleton?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (60, 13, 'Для создания единственного экземпляра класса', true),
                                                            (61, 13, 'Для глобального доступа к экземпляру', true),
                                                            (62, 13, 'Для замены статических методов', false),
                                                            (63, 13, 'Для ускорения работы программы', false),
                                                            (64, 13, 'Для автоматического удаления неиспользуемых объектов', false);

-- Вопрос 14: SOLID-принципы
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (14, 1, 'Какие принципы входят в SOLID?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (65, 14, 'Принцип единственной ответственности', true),
                                                            (66, 14, 'Принцип открытости/закрытости', true),
                                                            (67, 14, 'Принцип подстановки Барбары Лисков', true),
                                                            (68, 14, 'Принцип максимальной эффективности', false),
                                                            (69, 14, 'Принцип единственной переменной', false),
                                                            (70, 14, 'Принцип жесткого кодирования', false);

-- Вопрос 15: final-классы и методы
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (15, 1, 'Для чего используется модификатор final?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (71, 15, 'Запрет наследования (для классов)', true),
                                                            (72, 15, 'Запрет переопределения (для методов)', true),
                                                            (73, 15, 'Запрет изменения ссылки (для переменных)', true),
                                                            (74, 15, 'Для оптимизации скорости работы', false),
                                                            (75, 15, 'Для автоматического удаления объекта', false),
                                                            (76, 15, 'Для создания неизменяемых коллекций', false);

-- Вопрос 16: Пример с кодом (полиморфизм)
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (16, 1, 'Что выведет код?
Что выведет код?
class A { void print() { System.out.println("A"); } }
class B extends A { void print() { System.out.println("B"); } }
A obj = new B();
obj.print();', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (77, 16, 'B', true),
                                                            (78, 16, 'A', false),
                                                            (79, 16, 'Ошибка компиляции', false),
                                                            (80, 16, 'Ничего не выведет', false),
                                                            (81, 16, 'AB', false);

-- Вопрос 17: Интерфейсы с default-методами
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (17, 1, 'Какие утверждения о default-методах в интерфейсах верны?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (82, 17, 'Могут иметь реализацию', true),
                                                            (83, 17, 'Появились в Java 8', true),
                                                            (84, 17, 'Могут быть final', false),
                                                            (85, 17, 'Могут обращаться к полям интерфейса', false),
                                                            (86, 17, 'Заменяют абстрактные классы', false);

-- Обновляем последовательности для автоинкремента
SELECT setval('tests_id_seq', (SELECT MAX(id) FROM tests));
SELECT setval('questions_id_seq', (SELECT MAX(id) FROM questions));
SELECT setval('options_id_seq', (SELECT MAX(id) FROM options));