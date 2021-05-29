-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 02, 2020 at 04:48 PM
-- Server version: 10.3.16-MariaDB
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `technify`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `id` int(25) NOT NULL,
  `name` varchar(25) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `message` varchar(255) NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`id`, `name`, `email`, `phone`, `message`, `date`) VALUES
(1, 'me', 'a@b.com', '0894202511', 'Testing contact form', NULL),
(2, 'me', 'a@b.com', '0894202511', 'Testing contact form again', '2020-04-29 18:13:41'),
(3, 'Abhik', 'test1234@gmail.com', '8942025225', 'Mast kam kar raha ha :)', '2020-04-29 18:15:21'),
(4, 'abhik', 'test1234@gmail.com', '1234567890', 'Test email', '2020-04-29 20:17:57'),
(5, 'flaskLearner', 'test1234@gmail.com', '1234567890', 'This email is coming from contact form in Technify blog in localhost.', '2020-04-29 20:24:42'),
(6, 'Avi', 'newcoder@gmail.com', '08942025161', 'checking', '2020-04-30 11:51:31');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `post_id` int(10) NOT NULL,
  `title` varchar(50) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `content` varchar(10000) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`post_id`, `title`, `slug`, `content`, `image_url`, `date`) VALUES
(1, 'The most popular name in programming world Python', 'the-most-popular-name-in-programming-world-python', 'Python is one of the most popular programming languages. Its a multipurpose language and using it we can do plenty of tasks. It is highly used in the machine learning and data science field. A lot of giant tech companies use python under the hood for thei', 'post-bg.jpg', '2020-05-02 12:22:08'),
(2, 'What is machine learning', 'what-is-machine-learning', 'Machine learning (ML) is the study of computer algorithms that improve automatically through experience.[1] It is seen as a subset of artificial intelligence. Machine learning algorithms build a mathematical model based on sample data, known as \"training data\", in order to make predictions or decisions without being explicitly programmed to do so.[2][3]:2 Machine learning algorithms are used in a wide variety of applications, such as email filtering and computer vision, where it is difficult or infeasible to develop conventional algorithms to perform the needed tasks.\r\n\r\nMachine learning is closely related to computational statistics, which focuses on making predictions using computers. The study of mathematical optimization delivers methods, theory and application domains to the field of machine learning. Data mining is a related field of study, focusing on exploratory data analysis through unsupervised learning.[4][5] In its application across business problems, machine learning is also referred to as predictive analytics.', 'post-bg.jpg', '2020-04-30 15:50:17'),
(3, 'What is data science', 'what-is-data-science', 'Data science is an inter-disciplinary field that uses scientific methods, processes, algorithms and systems to extract knowledge and insights from many structural and unstructured data.[1][2] Data science is related to data mining and big data.\r\n\r\nData science is a \"concept to unify statistics, data analysis, machine learning and their related methods\" in order to \"understand and analyze actual phenomena\" with data.[3] It uses techniques and theories drawn from many fields within the context of mathematics, statistics, computer science, and information science. Turing award winner Jim Gray imagined data science as a \"fourth paradigm\" of science (empirical, theoretical, computational and now data-driven) and asserted that \"everything about science is changing because of the impact of information technology\" and the data deluge.[4][5]', 'post-bg.jpg', '2020-04-30 16:00:37'),
(4, 'What is artificial intelligence', 'what-is-artificial-intelligence', 'In computer science, artificial intelligence (AI), sometimes called machine intelligence, is intelligence demonstrated by machines, in contrast to the natural intelligence displayed by humans and animals. Leading AI textbooks define the field as the study of \"intelligent agents\": any device that perceives its environment and takes actions that maximize its chance of successfully achieving its goals.[1] Colloquially, the term \"artificial intelligence\" is often used to describe machines (or computers) that mimic \"cognitive\" functions that humans associate with the human mind, such as \"learning\" and \"problem solving\".[2]\r\n\r\nAs machines become increasingly capable, tasks considered to require \"intelligence\" are often removed from the definition of AI, a phenomenon known as the AI effect.[3] A quip in Tesler\'s Theorem says \"AI is whatever hasn\'t been done yet.\"[4] For instance, optical character recognition is frequently excluded from things considered to be AI,[5] having become a routine technology.[6] Modern machine capabilities generally classified as AI include successfully understanding human speech,[7] competing at the highest level in strategic game systems (such as chess and Go),[8] autonomously operating cars, intelligent routing in content delivery networks, and military simulations[9].\r\n\r\nArtificial intelligence was founded as an academic discipline in 1955, and in the years since has experienced several waves of optimism,[10][11] followed by disappointment and the loss of funding (known as an \"AI winter\"),[12][13] followed by new approaches, success and renewed funding.[11][14] For most of its history, AI research has been divided into sub-fields that often fail to communicate with each other.[15] These sub-fields are based on technical considerations, such as particular goals (e.g. \"robotics\" or \"machine learning\"),[16] the use of particular tools (\"logic\" or artificial neural networks), or deep philosophical differences.[17][18][19] Sub-fields have also been based on social factors (particular institutions or the work of particular researchers).[15]', 'post-bg.jpg', '2020-05-02 12:11:47'),
(5, 'What is big data and it\'s usecases', 'what-is-big-data-and-it\'s-usecases', 'Big data is a field that treats ways to analyze, systematically extract information from, or otherwise deal with data sets that are too large or complex to be dealt with by traditional data-processing application software. Data with many cases (rows) offer greater statistical power, while data with higher complexity (more attributes or columns) may lead to a higher false discovery rate.[2] Big data challenges include capturing data, data storage, data analysis, search, sharing, transfer, visualization, querying, updating, information privacy and data source. Big data was originally associated with three key concepts: volume, variety, and velocity. When we handle big data, we may not sample but simply observe and track what happens. Therefore, big data often includes data with sizes that exceed the capacity of traditional software to process within an acceptable time and value.\r\n\r\nCurrent usage of the term big data tends to refer to the use of predictive analytics, user behavior analytics, or certain other advanced data analytics methods that extract value from data, and seldom to a particular size of data set. \"There is little doubt that the quantities of data now available are indeed large, but that\'s not the most relevant characteristic of this new data ecosystem.\"[3] Analysis of data sets can find new correlations to \"spot business trends, prevent diseases, combat crime and so on.\"[4] Scientists, business executives, practitioners of medicine, advertising and governments alike regularly meet difficulties with large data-sets in areas including Internet searches, fintech, urban informatics, and business informatics. Scientists encounter limitations in e-Science work, including meteorology, genomics,[5] connectomics, complex physics simulations, biology and environmental research.[6]', 'post-bg.jpg', '2020-05-02 12:17:01'),
(6, 'My 6th dummy post', 'my-6th-dummy-post', 'It is a dummy post.', 'learn-3653430_640.jpg', '2020-05-02 13:36:37'),
(7, 'My 7th dummy post', 'my-7th-dummy-post', 'It is a dummy post. It is the 7th one.', 'clement-h-95YRwf6CNw8-unsplash.jpg', '2020-05-02 13:35:21'),
(10, 'Its my 9th dummy post', 'its-my-9th-dummy-post', 'jsnfjb snf jnfn smf slm sm s s mfks.', 'hardik-sharma-CrPAvN29Nhs-unsplash.jpg', '2020-05-02 17:06:02');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`post_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `id` int(25) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `post_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
