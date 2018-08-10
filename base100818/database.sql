-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Авг 10 2018 г., 17:39
-- Версия сервера: 5.6.38
-- Версия PHP: 5.5.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `database`
--

-- --------------------------------------------------------

--
-- Структура таблицы `courses`
--

CREATE TABLE `courses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` char(40) NOT NULL,
  `logo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

--
-- Дамп данных таблицы `courses`
--

INSERT INTO `courses` (`id`, `name`, `logo`) VALUES
(8, 'Новый курс', 0);

--
-- Триггеры `courses`
--
DELIMITER $$
CREATE TRIGGER `createCourseDescription` AFTER INSERT ON `courses` FOR EACH ROW INSERT INTO course_description(id_course) VALUES(NEW.id)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `deleteCoursesDescriptionAndLessonsAfterDeleteCourse` AFTER DELETE ON `courses` FOR EACH ROW BEGIN
	DELETE FROM course_description WHERE id_course=OLD.id;
    DELETE FROM lessons WHERE id_course=OLD.id;
    DELETE FROM curator_course WHERE id_course=OLD.id;
    DELETE FROM user_result WHERE id_course=OLD.id;
    DELETE FROM teacher_course WHERE id_course=OLD.id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `course_description`
--

CREATE TABLE `course_description` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_course` bigint(20) UNSIGNED NOT NULL,
  `id_text` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

--
-- Дамп данных таблицы `course_description`
--

INSERT INTO `course_description` (`id`, `id_course`, `id_text`) VALUES
(12, 8, 47);

--
-- Триггеры `course_description`
--
DELIMITER $$
CREATE TRIGGER `createTexts` BEFORE INSERT ON `course_description` FOR EACH ROW BEGIN
	INSERT INTO text(text) VALUES('Введите описание курса');
    SET NEW.id_text=(SELECT LAST_INSERT_ID());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `deleteTextAfterDeleteCourseDescription` AFTER DELETE ON `course_description` FOR EACH ROW BEGIN
DELETE FROM text WHERE id_text=OLD.id_text;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `curator_course`
--

CREATE TABLE `curator_course` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_curator` bigint(20) UNSIGNED NOT NULL,
  `id_course` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Дамп данных таблицы `curator_course`
--

INSERT INTO `curator_course` (`id`, `id_curator`, `id_course`) VALUES
(5, 19, 8);

-- --------------------------------------------------------

--
-- Структура таблицы `curator_student`
--

CREATE TABLE `curator_student` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_curator` bigint(20) UNSIGNED NOT NULL,
  `id_student` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Дамп данных таблицы `curator_student`
--

INSERT INTO `curator_student` (`id`, `id_curator`, `id_student`) VALUES
(7, 19, 23),
(8, 19, 24);

-- --------------------------------------------------------

--
-- Структура таблицы `curator_teacher`
--

CREATE TABLE `curator_teacher` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_curator` bigint(20) UNSIGNED NOT NULL,
  `id_teacher` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Дамп данных таблицы `curator_teacher`
--

INSERT INTO `curator_teacher` (`id`, `id_curator`, `id_teacher`) VALUES
(3, 19, 21),
(4, 19, 22);

-- --------------------------------------------------------

--
-- Структура таблицы `curator_test`
--

CREATE TABLE `curator_test` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_curator` bigint(20) UNSIGNED NOT NULL,
  `id_test` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `curator_test`
--

INSERT INTO `curator_test` (`id`, `id_curator`, `id_test`) VALUES
(8, 19, 13);

-- --------------------------------------------------------

--
-- Структура таблицы `gen_questions_ansver_temp`
--

CREATE TABLE `gen_questions_ansver_temp` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_gen_question` bigint(20) UNSIGNED NOT NULL,
  `ansver` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `gen_questions_temp`
--

CREATE TABLE `gen_questions_temp` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_gen_session` bigint(20) UNSIGNED NOT NULL,
  `id_question` bigint(20) UNSIGNED NOT NULL,
  `number` int(11) NOT NULL,
  `ansver` tinyint(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

-- --------------------------------------------------------

--
-- Структура таблицы `gen_variants_temp`
--

CREATE TABLE `gen_variants_temp` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_gen_question` bigint(20) UNSIGNED NOT NULL,
  `id_variant` bigint(20) UNSIGNED NOT NULL,
  `number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

-- --------------------------------------------------------

--
-- Структура таблицы `images`
--

CREATE TABLE `images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `src` tinytext NOT NULL,
  `type` tinytext NOT NULL,
  `formatting` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

-- --------------------------------------------------------

--
-- Структура таблицы `lessons`
--

CREATE TABLE `lessons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_course` bigint(20) UNSIGNED NOT NULL,
  `number` int(11) NOT NULL,
  `id_text` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `name` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

--
-- Дамп данных таблицы `lessons`
--

INSERT INTO `lessons` (`id`, `id_course`, `number`, `id_text`, `name`) VALUES
(14, 8, 0, 48, 'Новый урок'),
(15, 8, 1, 49, 'Новый урок'),
(16, 8, 2, 50, 'Новый урок');

--
-- Триггеры `lessons`
--
DELIMITER $$
CREATE TRIGGER `createTextL` BEFORE INSERT ON `lessons` FOR EACH ROW BEGIN
	INSERT INTO text(text) VALUES('Новый урок');
    SET NEW.id_text=(SELECT LAST_INSERT_ID());
    SET NEW.name='Новый урок';
    
    SET @count=(SELECT COUNT(*) FROM lessons WHERE 		 				id_course=NEW.id_course);
    
    IF @count=0 THEN
    	SET NEW.number=0;
    ELSE
    	SET @last=(SELECT MAX(number) FROM lessons WHERE 					id_course=NEW.id_course);
        SET NEW.number=@last+1;
    END IF;
    
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `deleteTextAfterDeleteLesson` AFTER DELETE ON `lessons` FOR EACH ROW DELETE FROM text WHERE id_text=OLD.id_text
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `questions`
--

CREATE TABLE `questions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_test` bigint(20) UNSIGNED NOT NULL,
  `number` tinyint(4) NOT NULL,
  `name` tinytext NOT NULL,
  `id_text` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

--
-- Дамп данных таблицы `questions`
--

INSERT INTO `questions` (`id`, `id_test`, `number`, `name`, `id_text`) VALUES
(26, 13, 1, 'Новый вопрос', 98),
(27, 13, 2, 'Новый вопрос', 99),
(28, 13, 3, 'Новый вопрос', 100),
(29, 13, 4, 'Новый вопрос', 101);

--
-- Триггеры `questions`
--
DELIMITER $$
CREATE TRIGGER `createQuestion` BEFORE INSERT ON `questions` FOR EACH ROW BEGIN
	INSERT INTO text(text) VALUES('Введите текст вопроса');
    SET NEW.id_text=(SELECT LAST_INSERT_ID());
    SET NEW.name='Новый вопрос';
    
    SET @count=(SELECT COUNT(*) FROM questions WHERE 						id_test=NEW.id_test);
    IF @count>0 THEN
    	SET @max=(SELECT MAX(number) FROM questions WHERE 							id_test=NEW.id_test);
        SET NEW.number=@max+1;
    ELSE
        SET NEW.number=1;
    END IF;       
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `deleteTextQ` AFTER DELETE ON `questions` FOR EACH ROW BEGIN
	DELETE FROM text WHERE id_text=OLD.id_text;
    DELETE FROM variants WHERE id_question=OLD.id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `result_type`
--

CREATE TABLE `result_type` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

-- --------------------------------------------------------

--
-- Структура таблицы `teacher_course`
--

CREATE TABLE `teacher_course` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_teacher` bigint(20) UNSIGNED NOT NULL,
  `id_course` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Дамп данных таблицы `teacher_course`
--

INSERT INTO `teacher_course` (`id`, `id_teacher`, `id_course`) VALUES
(3, 21, 8);

-- --------------------------------------------------------

--
-- Структура таблицы `tests`
--

CREATE TABLE `tests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` tinytext NOT NULL,
  `id_text` bigint(20) UNSIGNED NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `mix_q` tinyint(1) NOT NULL DEFAULT '0',
  `mix_var` tinyint(1) NOT NULL DEFAULT '0',
  `for_course_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reload` tinyint(1) NOT NULL DEFAULT '0',
  `reload_try` int(11) NOT NULL DEFAULT '0',
  `can_pass` tinyint(1) NOT NULL DEFAULT '1',
  `display_q` int(11) DEFAULT '1',
  `threshold` int(11) NOT NULL DEFAULT '1',
  `minute_on_pass` int(11) NOT NULL DEFAULT '10'
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

--
-- Дамп данных таблицы `tests`
--

INSERT INTO `tests` (`id`, `name`, `id_text`, `active`, `mix_q`, `mix_var`, `for_course_id`, `reload`, `reload_try`, `can_pass`, `display_q`, `threshold`, `minute_on_pass`) VALUES
(13, 'Новый тест', 0, 0, 0, 0, 8, 0, 0, 1, 1, 1, 10);

--
-- Триггеры `tests`
--
DELIMITER $$
CREATE TRIGGER `deleteCuratorTest` AFTER DELETE ON `tests` FOR EACH ROW BEGIN
	DELETE FROM curator_test WHERE id_test=OLD.id;
    DELETE FROM questions WHERE id_test=OLD.id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `test_history`
--

CREATE TABLE `test_history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `data` datetime NOT NULL,
  `time_wasted` int(11) NOT NULL,
  `time_limit` int(11) NOT NULL,
  `question_count` int(11) NOT NULL,
  `try_count` int(11) NOT NULL,
  `threshold` int(11) NOT NULL,
  `result` int(11) NOT NULL,
  `result_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `test_history_questions`
--

CREATE TABLE `test_history_questions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_history` bigint(20) UNSIGNED NOT NULL,
  `number` int(11) NOT NULL,
  `result` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `test_session_temp`
--

CREATE TABLE `test_session_temp` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date_start` datetime NOT NULL,
  `date_end` datetime NOT NULL,
  `try_counter` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

-- --------------------------------------------------------

--
-- Структура таблицы `text`
--

CREATE TABLE `text` (
  `id_text` bigint(20) UNSIGNED NOT NULL,
  `text` text,
  `formatting` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

--
-- Дамп данных таблицы `text`
--

INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES
(47, 'Введите описание курса', ''),
(98, 'Введите текст вопроса', ''),
(99, 'Введите текст вопроса', ''),
(100, 'Введите текст вопроса', ''),
(101, 'Введите текст вопроса', ''),
(104, 'Введите текст варианта', ''),
(105, 'Введите текст варианта', ''),
(106, 'Введите текст варианта', ''),
(107, 'Введите текст варианта', '');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `login` char(20) NOT NULL,
  `password` char(255) NOT NULL,
  `email` tinytext NOT NULL,
  `administrator` tinyint(1) NOT NULL DEFAULT '0',
  `curator` tinyint(1) NOT NULL DEFAULT '0',
  `teacher` tinyint(1) NOT NULL DEFAULT '0',
  `student` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `password`, `email`, `administrator`, `curator`, `teacher`, `student`) VALUES
(3, 'admin', '$2y$10$LgoYtUeoZBPDDQv4MBcu.e01Rh0NBXvE9gJ5ziKYFG4KmhQeUGK7O', 'admin@admin.com', 1, 0, 0, 0),
(19, 'curator', '$2y$10$rO/PIqm8jLNixtxC2Fw9pesz3hRvAAApIDnOs/m.I.Hh7lRj4Qm9S', 'c', 0, 1, 0, 0),
(20, 'curator2', '$2y$10$/4ufycEzNUP4FNCT9UJKS.LAhiWpobjwW0HIB26BFdvy5IBQf7ySi', 'c2', 0, 1, 0, 0),
(21, 'teacher1', '$2y$10$hXf4LuJ5aC2TlrCZSYmKKubbEr27wh6pu.QGYqYCipFquglss634C', 'teacher1', 0, 0, 1, 0),
(22, 'teacher2', '$2y$10$kQOgHx88mftnZDRKO4vbD.OcMY0B26UM3ZtX.viUt2xiIs86LjPKq', 'teacher2', 0, 0, 1, 0),
(23, 'student1', '$2y$10$G5mhalaWcaNd7qHQvD7p9OQJl9krryLEK5aCECRYK6XwC10vj9Rw.', 'st1', 0, 0, 0, 1),
(24, 'student2', '$2y$10$ztBDpVs8GAiqA2eSPJfXAuiY98kC4jTJAb/7kQJZh/CtXQtbp0lju', 'st2', 0, 0, 0, 1);

--
-- Триггеры `users`
--
DELIMITER $$
CREATE TRIGGER `createUserResult` AFTER INSERT ON `users` FOR EACH ROW BEGIN
	IF NEW.student=1 THEN
		INSERT INTO user_result(user_id)
        VALUES(NEW.id);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `deleteUser` AFTER DELETE ON `users` FOR EACH ROW DELETE FROM user_access WHERE user_id=OLD.id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `user_access`
--

CREATE TABLE `user_access` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `table` varchar(40) NOT NULL,
  `g_select` tinyint(1) NOT NULL,
  `g_insert` tinyint(1) NOT NULL,
  `g_update` tinyint(1) NOT NULL,
  `g_delete` tinyint(1) NOT NULL,
  `rls` tinyint(1) NOT NULL,
  `target_id` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `user_result`
--

CREATE TABLE `user_result` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `id_course` bigint(20) UNSIGNED NOT NULL,
  `lessons_learned` smallint(6) NOT NULL DEFAULT '0',
  `test_result` tinyint(4) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `test_id` bigint(20) UNSIGNED DEFAULT NULL,
  `test_active` tinyint(1) DEFAULT NULL,
  `session_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

--
-- Дамп данных таблицы `user_result`
--

INSERT INTO `user_result` (`id`, `user_id`, `id_course`, `lessons_learned`, `test_result`, `active`, `test_id`, `test_active`, `session_id`) VALUES
(6, 23, 0, 0, NULL, 1, NULL, NULL, NULL),
(7, 24, 0, 0, NULL, 1, NULL, NULL, NULL),
(9, 23, 8, 0, NULL, 1, NULL, NULL, NULL),
(10, 24, 8, 0, NULL, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `variants`
--

CREATE TABLE `variants` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_question` bigint(20) UNSIGNED NOT NULL,
  `number` tinyint(4) NOT NULL,
  `id_text` bigint(20) UNSIGNED NOT NULL,
  `isright` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

--
-- Дамп данных таблицы `variants`
--

INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES
(29, 26, 1, 104, 0),
(30, 26, 2, 105, 0),
(31, 26, 3, 106, 0),
(32, 26, 4, 107, 0);

--
-- Триггеры `variants`
--
DELIMITER $$
CREATE TRIGGER `createVariant` BEFORE INSERT ON `variants` FOR EACH ROW BEGIN
	INSERT INTO text(text) VALUES('Введите текст варианта');
    SET NEW.id_text=(SELECT LAST_INSERT_ID());
    
    SET @count=(SELECT COUNT(*) FROM variants WHERE 						id_question=NEW.id_question);
    IF @count>0 THEN
    	SET @max=(SELECT MAX(number) FROM variants WHERE 							id_question=NEW.id_question);
        SET NEW.number=@max+1;
    ELSE
        SET NEW.number=1;
    END IF;       
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `deleteTextV` AFTER DELETE ON `variants` FOR EACH ROW DELETE FROM text WHERE id_text=OLD.id_text
$$
DELIMITER ;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Индексы таблицы `course_description`
--
ALTER TABLE `course_description`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `fkey_courses_d` (`id_course`),
  ADD KEY `fkey_text_d` (`id_text`);

--
-- Индексы таблицы `curator_course`
--
ALTER TABLE `curator_course`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_course` (`id_course`),
  ADD KEY `fkey_curators_cc` (`id_curator`);

--
-- Индексы таблицы `curator_student`
--
ALTER TABLE `curator_student`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_student` (`id_student`),
  ADD KEY `fkey_curators_cs` (`id_curator`);

--
-- Индексы таблицы `curator_teacher`
--
ALTER TABLE `curator_teacher`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_teacher` (`id_teacher`),
  ADD KEY `fkey_curators_ct` (`id_curator`);

--
-- Индексы таблицы `curator_test`
--
ALTER TABLE `curator_test`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fkey_curators_ct2` (`id_curator`),
  ADD KEY `fkey_tests_ct2` (`id_test`);

--
-- Индексы таблицы `gen_questions_ansver_temp`
--
ALTER TABLE `gen_questions_ansver_temp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fkey_question_gqat` (`id_gen_question`);

--
-- Индексы таблицы `gen_questions_temp`
--
ALTER TABLE `gen_questions_temp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fkey_session_gqt` (`id_gen_session`),
  ADD KEY `fkey_question_gqt` (`id_question`);

--
-- Индексы таблицы `gen_variants_temp`
--
ALTER TABLE `gen_variants_temp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fkey_question_gvt` (`id_gen_question`),
  ADD KEY `fkey_variants_gvt` (`id_variant`);

--
-- Индексы таблицы `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Индексы таблицы `lessons`
--
ALTER TABLE `lessons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `fkey_courses_l` (`id_course`),
  ADD KEY `fkey_texts_l` (`id_text`);

--
-- Индексы таблицы `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fkey_tests_q` (`id_test`),
  ADD KEY `fkey_texts_q` (`id_text`);

--
-- Индексы таблицы `result_type`
--
ALTER TABLE `result_type`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `teacher_course`
--
ALTER TABLE `teacher_course`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fkey_courses_tc` (`id_course`),
  ADD KEY `fkey_teachers_tc` (`id_teacher`);

--
-- Индексы таблицы `tests`
--
ALTER TABLE `tests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fkey_courses_t` (`for_course_id`),
  ADD KEY `fkey_texts_t` (`id_text`);

--
-- Индексы таблицы `test_history`
--
ALTER TABLE `test_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fkey_users_th` (`user_id`);

--
-- Индексы таблицы `test_history_questions`
--
ALTER TABLE `test_history_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fkey_history_t` (`id_history`);

--
-- Индексы таблицы `test_session_temp`
--
ALTER TABLE `test_session_temp`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `text`
--
ALTER TABLE `text`
  ADD PRIMARY KEY (`id_text`),
  ADD UNIQUE KEY `id_text` (`id_text`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `login` (`login`);

--
-- Индексы таблицы `user_access`
--
ALTER TABLE `user_access`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `user_result`
--
ALTER TABLE `user_result`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `fkey_courses` (`id_course`),
  ADD KEY `fkey_tests_ur` (`test_id`),
  ADD KEY `fkey_session_ur` (`session_id`);

--
-- Индексы таблицы `variants`
--
ALTER TABLE `variants`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `courses`
--
ALTER TABLE `courses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `course_description`
--
ALTER TABLE `course_description`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT для таблицы `curator_course`
--
ALTER TABLE `curator_course`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `curator_student`
--
ALTER TABLE `curator_student`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `curator_teacher`
--
ALTER TABLE `curator_teacher`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `curator_test`
--
ALTER TABLE `curator_test`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `gen_questions_ansver_temp`
--
ALTER TABLE `gen_questions_ansver_temp`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `gen_questions_temp`
--
ALTER TABLE `gen_questions_temp`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `gen_variants_temp`
--
ALTER TABLE `gen_variants_temp`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `images`
--
ALTER TABLE `images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `lessons`
--
ALTER TABLE `lessons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `questions`
--
ALTER TABLE `questions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT для таблицы `result_type`
--
ALTER TABLE `result_type`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `teacher_course`
--
ALTER TABLE `teacher_course`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `tests`
--
ALTER TABLE `tests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT для таблицы `test_history`
--
ALTER TABLE `test_history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `test_history_questions`
--
ALTER TABLE `test_history_questions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `test_session_temp`
--
ALTER TABLE `test_session_temp`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `text`
--
ALTER TABLE `text`
  MODIFY `id_text` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT для таблицы `user_access`
--
ALTER TABLE `user_access`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `user_result`
--
ALTER TABLE `user_result`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `variants`
--
ALTER TABLE `variants`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `curator_course`
--
ALTER TABLE `curator_course`
  ADD CONSTRAINT `fkey_courses_cc` FOREIGN KEY (`id_course`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fkey_curators_cc` FOREIGN KEY (`id_curator`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `curator_student`
--
ALTER TABLE `curator_student`
  ADD CONSTRAINT `fkey_curators_cs` FOREIGN KEY (`id_curator`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fkey_students_cs` FOREIGN KEY (`id_student`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `curator_teacher`
--
ALTER TABLE `curator_teacher`
  ADD CONSTRAINT `fkey_curators_ct` FOREIGN KEY (`id_curator`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fkey_teachers_ct` FOREIGN KEY (`id_teacher`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `gen_questions_ansver_temp`
--
ALTER TABLE `gen_questions_ansver_temp`
  ADD CONSTRAINT `fkey_question_gqat` FOREIGN KEY (`id_gen_question`) REFERENCES `questions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `gen_questions_temp`
--
ALTER TABLE `gen_questions_temp`
  ADD CONSTRAINT `fkey_question_gqt` FOREIGN KEY (`id_question`) REFERENCES `questions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fkey_session_gqt` FOREIGN KEY (`id_gen_session`) REFERENCES `test_session_temp` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `gen_variants_temp`
--
ALTER TABLE `gen_variants_temp`
  ADD CONSTRAINT `fkey_question_gvt` FOREIGN KEY (`id_gen_question`) REFERENCES `questions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fkey_variants_gvt` FOREIGN KEY (`id_variant`) REFERENCES `variants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `teacher_course`
--
ALTER TABLE `teacher_course`
  ADD CONSTRAINT `fkey_courses_tc` FOREIGN KEY (`id_course`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fkey_teachers_tc` FOREIGN KEY (`id_teacher`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `test_history`
--
ALTER TABLE `test_history`
  ADD CONSTRAINT `fkey_users_th` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `test_history_questions`
--
ALTER TABLE `test_history_questions`
  ADD CONSTRAINT `fkey_history_t` FOREIGN KEY (`id_history`) REFERENCES `test_history` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `user_result`
--
ALTER TABLE `user_result`
  ADD CONSTRAINT `fkey_session_ur` FOREIGN KEY (`session_id`) REFERENCES `test_session_temp` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkey_tests_ur` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkey_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
