-- Создание теста по JVM
INSERT INTO tests (id, title, description) VALUES
    (2, 'Java Virtual Machine (JVM)', 'Тест по архитектуре и работе виртуальной машины Java');

-- Вопрос 1: За что отвечает JVM
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (18, 2, 'За что отвечает JVM в экосистеме Java?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (87, 18, 'Выполнение байт-кода', true),
                                                            (88, 18, 'Управление памятью (heap, stack)', true),
                                                            (89, 18, 'Обеспечение платформо-независимости', true),
                                                            (90, 18, 'Компиляция исходного кода в машинный код', false),
                                                            (91, 18, 'Оптимизация SQL-запросов', false),
                                                            (92, 18, 'Генерация документации', false);

-- Вопрос 2: ClassLoader
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (19, 2, 'Какие из утверждений о ClassLoader верны?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (93, 19, 'Иерархия: Bootstrap → Platform → System class loaders', true),
                                                            (94, 19, 'Реализует принцип делегирования загрузки классов', true),
                                                            (95, 19, 'Bootstrap class loader написан на Java', false),
                                                            (96, 19, 'Класс загружается только один раз за время работы JVM', false),
                                                            (97, 19, 'ClassLoader может выгружать классы из памяти', true),
                                                            (98, 19, 'Все ClassLoader-ы являются экземплярами одного класса', false);

-- Вопрос 3: Области данных времени выполнения
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (20, 2, 'Какие области данных существуют в JVM во время выполнения?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (99, 20, 'Heap (куча)', true),
                                                            (100, 20, 'Stack (стек)', true),
                                                            (101, 20, 'Metaspace (метаданные классов)', true),
                                                            (102, 20, 'Program Counter Register', true),
                                                            (103, 20, 'Native Method Stack', true),
                                                            (104, 20, 'CPU Cache', false),
                                                            (105, 20, 'SSD-хранилище', false);

-- Вопрос 4: Frames (стековые фреймы)
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (21, 2, 'Что содержится в стековом фрейме (frame) JVM?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (106, 21, 'Локальные переменные', true),
                                                            (107, 21, 'Операндный стек', true),
                                                            (108, 21, 'Ссылка на пул констант класса', true),
                                                            (109, 21, 'Байт-код текущего метода', false),
                                                            (110, 21, 'Статические переменные класса', false),
                                                            (111, 21, 'Ссылки на другие потоки', false);

-- Вопрос 5: Execution Engine
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (22, 2, 'Как Execution Engine выполняет байт-код?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (112, 22, 'Интерпретация байт-кода', true),
                                                            (113, 22, 'JIT-компиляция (Just-In-Time)', true),
                                                            (114, 22, 'Использование HotSpot-оптимизаций', true),
                                                            (115, 22, 'Прекомпиляция всего кода при запуске', false),
                                                            (116, 22, 'Преобразование в JavaScript', false),
                                                            (117, 22, 'Через внешний C++ компилятор', false);

-- Вопрос 6: Heap vs Stack
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (23, 2, 'Чем Heap отличается от Stack в JVM?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (118, 23, 'Heap: хранит объекты, Stack: хранит примитивы и ссылки', true),
                                                            (119, 23, 'Heap: общий для всех потоков, Stack: свой у каждого потока', true),
                                                            (120, 23, 'Heap: автоматическое управление памятью (GC), Stack: автоматическое освобождение', true),
                                                            (121, 23, 'Heap: быстрее по доступу', false),
                                                            (122, 23, 'Stack: хранит статические переменные', false),
                                                            (123, 23, 'Heap: ограничен по размеру, Stack: неограничен', false);

-- Вопрос 7: Garbage Collection
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (24, 2, 'Какие утверждения о Garbage Collection верны?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (124, 24, 'Удаляет объекты без ссылок', true),
                                                            (125, 24, 'Использует поколенческую модель (Generational GC)', true),
                                                            (126, 24, 'Может вызывать stop-the-world паузы', true),
                                                            (127, 24, 'Работает в отдельном системном процессе', false),
                                                            (128, 24, 'Очищает стек автоматически', false),
                                                            (129, 24, 'Удаляет все объекты при завершении потока', false);

-- Вопрос 8: JIT-компиляция
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (25, 2, 'Как работает JIT-компиляция в JVM?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (130, 25, 'Компилирует "горячий" код в нативный', true),
                                                            (131, 25, 'Использует профилирование выполнения', true),
                                                            (132, 25, 'Уменьшает накладные расходы интерпретатора', true),
                                                            (133, 25, 'Заменяет javac компилятор', false),
                                                            (134, 25, 'Работает только при запуске программы', false),
                                                            (135, 25, 'Всегда компилирует весь код сразу', false);

-- Вопрос 9: Метасфера (Metaspace)
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (26, 2, 'Что хранится в Metaspace?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (136, 26, 'Метаданные загруженных классов', true),
                                                            (137, 26, 'Структуры данных JVM для работы с классами', true),
                                                            (138, 26, 'Константы времени компиляции', false),
                                                            (139, 26, 'Скомпилированный нативный код', false),
                                                            (140, 26, 'Статические переменные классов', false),
                                                            (141, 26, 'Кэш результатов JIT-компиляции', false);

-- Вопрос 10: Bytecode
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (27, 2, 'Какие утверждения о байт-коде Java верны?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (142, 27, 'Это промежуточное представление кода', true),
                                                            (143, 27, 'Исполняется виртуальной машиной', true),
                                                            (144, 27, 'Один и тот же для всех платформ', true),
                                                            (145, 27, 'Зависит от операционной системы', false),
                                                            (146, 27, 'Требует компиляции перед каждым запуском', false),
                                                            (147, 27, 'Идентичен машинному коду процессора', false);

-- Вопрос 11: Модель памяти JVM
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (28, 2, 'Какие компоненты входят в модель памяти JVM?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (148, 28, 'Heap', true),
                                                            (149, 28, 'Stack', true),
                                                            (150, 28, 'Metaspace', true),
                                                            (151, 28, 'Program Counter Register', true),
                                                            (152, 28, 'Native Memory', false),
                                                            (153, 28, 'CPU Cache', false),
                                                            (154, 28, 'GPU Memory', false);

-- Вопрос 12: Управление памятью
INSERT INTO questions (id, test_id, text, question_type) VALUES
    (29, 2, 'Как JVM управляет памятью?', 1);

INSERT INTO options (id, question_id, text, is_correct) VALUES
                                                            (155, 29, 'Автоматическое выделение/освобождение (GC)', true),
                                                            (156, 29, 'Разделение на поколения (Young, Old)', true),
                                                            (157, 29, 'Использование разных алгоритмов сборки мусора', true),
                                                            (158, 29, 'Ручное управление через malloc/free', false),
                                                            (159, 29, 'Полная очистка при нехватке памяти', false),
                                                            (160, 29, 'Использование только физической памяти', false);

-- Обновляем последовательности для автоинкремента
SELECT setval('tests_id_seq', (SELECT MAX(id) FROM tests));
SELECT setval('questions_id_seq', (SELECT MAX(id) FROM questions));
SELECT setval('options_id_seq', (SELECT MAX(id) FROM options));