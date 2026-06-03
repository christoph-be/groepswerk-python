-- schema.sql
-- Kookkompas: structuur, data en procedures
DROP DATABASE IF EXISTS recipe_search;
CREATE DATABASE recipe_search CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE recipe_search;

-- ====== TABELLEN ======

CREATE TABLE ingredients (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY name (name)
);

CREATE TABLE meals (
  id int(11) NOT NULL,
  name varchar(255) NOT NULL,
  category varchar(255) DEFAULT NULL,
  area varchar(255) DEFAULT NULL,
  instructions text DEFAULT NULL,
  thumbnail_url varchar(500) DEFAULT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE meal_ingredients (
  meal_id int(11) NOT NULL,
  ingredient_id int(11) NOT NULL,
  PRIMARY KEY (meal_id,ingredient_id),
  KEY fk_mi_ingredient (ingredient_id),
  CONSTRAINT fk_mi_ingredient FOREIGN KEY (ingredient_id) REFERENCES ingredients (id) ON DELETE CASCADE,
  CONSTRAINT fk_mi_meal FOREIGN KEY (meal_id) REFERENCES meals (id) ON DELETE CASCADE
);

CREATE TABLE favorites (
  id int(11) NOT NULL AUTO_INCREMENT,
  meal_id int(11) NOT NULL,
  created_at timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (id),
  KEY fk_fav_meal (meal_id),
  CONSTRAINT fk_fav_meal FOREIGN KEY (meal_id) REFERENCES meals (id) ON DELETE CASCADE
);

CREATE TABLE allergens (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  description varchar(255) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY name (name)
);

CREATE TABLE meal_allergens (
  meal_id int(11) NOT NULL,
  allergen_id int(11) NOT NULL,
  PRIMARY KEY (meal_id,allergen_id),
  KEY fk_ma_allergen (allergen_id),
  CONSTRAINT fk_ma_allergen FOREIGN KEY (allergen_id) REFERENCES allergens (id) ON DELETE CASCADE,
  CONSTRAINT fk_ma_meal FOREIGN KEY (meal_id) REFERENCES meals (id) ON DELETE CASCADE
);

CREATE TABLE gebruikers (
  id int(11) NOT NULL AUTO_INCREMENT,
  naam varchar(255) NOT NULL,
  email varchar(255) NOT NULL,
  aangemaakt_op timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (id),
  UNIQUE KEY email (email)
);

CREATE TABLE gebruiker_allergenen (
  gebruiker_id int(11) NOT NULL,
  allergen_id int(11) NOT NULL,
  PRIMARY KEY (gebruiker_id,allergen_id),
  KEY fk_ga_allergen (allergen_id),
  CONSTRAINT fk_ga_allergen FOREIGN KEY (allergen_id) REFERENCES allergens (id) ON DELETE CASCADE,
  CONSTRAINT fk_ga_gebruiker FOREIGN KEY (gebruiker_id) REFERENCES gebruikers (id) ON DELETE CASCADE
);


-- ====== DATA ======

INSERT INTO ingredients (id, name) VALUES
(1, 'ackee'),
(2, 'all purpose flour'),
(3, 'all-purpose seasoning'),
(4, 'allspice'),
(5, 'allspice berries'),
(6, 'almond essence'),
(7, 'almond extract'),
(8, 'almond flour'),
(9, 'almond milk'),
(10, 'almond paste'),
(11, 'almonds'),
(12, 'ancho chillies'),
(13, 'anchovy fillet'),
(14, 'apple cider vinegar'),
(15, 'apples'),
(16, 'apricot'),
(17, 'apricot jam'),
(18, 'asparagus'),
(19, 'aubergine'),
(20, 'avocado'),
(21, 'baby aubergine'),
(22, 'baby lettuce leaves'),
(23, 'baby new potatoes'),
(24, 'baby pak koi'),
(25, 'baby plum tomatoes'),
(26, 'baby squid'),
(27, 'bacon'),
(28, 'bacon lardon'),
(29, 'baguette'),
(30, 'baked beans'),
(31, 'baking powder'),
(32, 'balsamic vinegar'),
(33, 'bamboo shoot'),
(34, 'banana'),
(35, 'barbeque sauce'),
(36, 'barramundi'),
(37, 'basil'),
(38, 'basil leaves'),
(39, 'basmati rice'),
(40, 'bay leaf'),
(41, 'bay leaves'),
(42, 'bean sprouts'),
(43, 'beef'),
(44, 'beef brisket'),
(45, 'beef cutlet'),
(46, 'beef fillet'),
(47, 'beef flank steak'),
(48, 'beef gravy'),
(49, 'beef shin'),
(50, 'beef stock'),
(51, 'beef stock concentrate'),
(52, 'beef stock cubes'),
(53, 'beef tomatoes'),
(54, 'beer'),
(55, 'beetroot'),
(56, 'bicarbonate of soda'),
(57, 'birds-eye chillies'),
(58, 'biryani masala'),
(59, 'black beans'),
(60, 'black olives'),
(61, 'black pepper'),
(62, 'black pudding'),
(63, 'black treacle'),
(64, 'blackberries'),
(65, 'blackcurrant jam'),
(66, 'blueberries'),
(67, 'boiling water'),
(68, 'bok choi'),
(69, 'borlotti beans'),
(70, 'bouillon cubes'),
(71, 'bouquet garni'),
(72, 'bowtie pasta'),
(73, 'braeburn apples'),
(74, 'bramley apples'),
(75, 'brandy'),
(76, 'bread'),
(77, 'bread flour'),
(78, 'bread rolls'),
(79, 'breadcrumbs'),
(80, 'brie'),
(81, 'broad beans'),
(82, 'broccoli'),
(83, 'brown lentils'),
(84, 'brown rice'),
(85, 'brown rice noodle'),
(86, 'brown sugar'),
(87, 'bryndza cheese'),
(88, 'buckwheat'),
(89, 'buckwheat flour'),
(90, 'bulgur wheat'),
(91, 'bun'),
(92, 'butter'),
(93, 'butter beans'),
(94, 'butternut squash'),
(95, 'cabbage'),
(96, 'cabbage leaves'),
(97, 'cacao'),
(98, 'cajun'),
(99, 'callaloo'),
(100, 'can of chickpeas'),
(101, 'candied peel'),
(102, 'canned tomatoes'),
(103, 'cannellini beans'),
(104, 'canola oil'),
(105, 'capers'),
(106, 'caramel'),
(107, 'caramel sauce'),
(108, 'caramelized sugar sauce'),
(109, 'caraway seed'),
(110, 'cardamom'),
(111, 'carrot'),
(112, 'carrots'),
(113, 'casabe'),
(114, 'cashew nuts'),
(115, 'cashews'),
(116, 'cassaba'),
(117, 'caster sugar'),
(118, 'cavia-kaas uit de alpen'),
(119, 'cayenne pepper'),
(120, 'celeriac'),
(121, 'celery'),
(122, 'celery salt'),
(123, 'challots'),
(124, 'charlotte potatoes'),
(125, 'cheddar cheese'),
(126, 'cheese'),
(127, 'cheese curds'),
(128, 'cherry tomatoes'),
(129, 'chestnut mushroom'),
(130, 'chestnuts'),
(131, 'chicken'),
(132, 'chicken bouillon powder'),
(133, 'chicken breast'),
(134, 'chicken breasts'),
(135, 'chicken drumsticks'),
(136, 'chicken legs'),
(137, 'chicken liver'),
(138, 'chicken stock'),
(139, 'chicken stock cube'),
(140, 'chicken thighs'),
(141, 'chicken wings'),
(142, 'chickpea flour'),
(143, 'chickpeas'),
(144, 'chili powder'),
(145, 'chilled butter'),
(146, 'chilli'),
(147, 'chilli bean paste'),
(148, 'chilli flakes'),
(149, 'chilli powder'),
(150, 'chilli sauce'),
(151, 'chimichurri sauce'),
(152, 'chinese broccoli'),
(153, 'chinese cabbage'),
(154, 'chinese five spice powder'),
(155, 'chinese leaf'),
(156, 'chinese long beans'),
(157, 'chinese sesame sauce'),
(158, 'chives'),
(159, 'chocolate chips'),
(160, 'chopped chive'),
(161, 'chopped onion'),
(162, 'chopped parsley'),
(163, 'chopped tomatoes'),
(164, 'chorizo'),
(165, 'christmas pudding'),
(166, 'chuck roast'),
(167, 'ciabatta'),
(168, 'cider'),
(169, 'cider vinegar'),
(170, 'cilantro'),
(171, 'cilantro leaves'),
(172, 'cinnamon'),
(173, 'cinnamon stick'),
(174, 'clams'),
(175, 'clear honey'),
(176, 'clotted cream'),
(177, 'clove'),
(178, 'cloves'),
(179, 'coco sugar'),
(180, 'cocoa'),
(181, 'cocoa powder'),
(182, 'coconut cream'),
(183, 'coconut flakes'),
(184, 'coconut milk'),
(185, 'coconut oil'),
(186, 'cod'),
(187, 'colby jack cheese'),
(188, 'cold water'),
(189, 'condensed milk'),
(190, 'cooked beetroot'),
(191, 'cooked chestnut'),
(192, 'cooking wine'),
(193, 'coriander'),
(194, 'coriander leaves'),
(195, 'coriander seeds'),
(196, 'corn arepa filled with mozarella cheese'),
(197, 'corn flour'),
(198, 'corn tortillas'),
(199, 'corned beef'),
(200, 'cornmeal'),
(201, 'cornstarch'),
(202, 'courgettes'),
(203, 'couscous'),
(204, 'cranberry'),
(205, 'cream'),
(206, 'cream cheese'),
(207, 'cream of tartar'),
(208, 'creamed corn'),
(209, 'creme fraiche'),
(210, 'crusty bread'),
(211, 'cubed feta cheese'),
(212, 'cucumber'),
(213, 'cumin'),
(214, 'cumin seeds'),
(215, 'currants'),
(216, 'curry powder'),
(217, 'custard'),
(218, 'custard powder'),
(219, 'dark brown soft sugar'),
(220, 'dark brown sugar'),
(221, 'dark chocolate'),
(222, 'dark chocolate chips'),
(223, 'dark rum'),
(224, 'dark soft brown sugar'),
(225, 'dark soy sauce'),
(226, 'demerara sugar'),
(227, 'desiccated coconut'),
(228, 'dessert rice'),
(229, 'diced tomatoes'),
(230, 'digestive biscuits'),
(231, 'dijon mustard'),
(232, 'dill'),
(233, 'dill pickles'),
(234, 'doner meat'),
(235, 'doubanjiang'),
(236, 'double cream'),
(237, 'dried apricots'),
(238, 'dried cherries'),
(239, 'dried chillies'),
(240, 'dried cranberries'),
(241, 'dried fruit'),
(242, 'dried leaves of summer savoury'),
(243, 'dried mint'),
(244, 'dried oregano'),
(245, 'dried red chillies'),
(246, 'dried shrimp'),
(247, 'dried white beans'),
(248, 'dried white corn'),
(249, 'dried white navy beans'),
(250, 'dry sherry'),
(251, 'dry white wine'),
(252, 'duck legs'),
(253, 'duck sauce'),
(254, 'dulce de leche'),
(255, 'dutch stroop'),
(256, 'egg'),
(257, 'egg noodles'),
(258, 'egg plants'),
(259, 'egg roll wrappers'),
(260, 'egg rolls'),
(261, 'egg wash'),
(262, 'egg white'),
(263, 'egg yolks'),
(264, 'eggs'),
(265, 'emmentaler cheese'),
(266, 'enchilada sauce'),
(267, 'english muffins'),
(268, 'english mustard'),
(269, 'extra virgin olive oil'),
(270, 'fajita seasoning'),
(271, 'falafel'),
(272, 'farfalle'),
(273, 'fast action yeast'),
(274, 'feather blade beef'),
(275, 'fennel'),
(276, 'fennel bulb'),
(277, 'fennel seeds'),
(278, 'fenugreek'),
(279, 'fermented black beans'),
(280, 'feta'),
(281, 'fettuccine'),
(282, 'figs'),
(283, 'fillet of steak'),
(284, 'filo pastry'),
(285, 'fine yellow cornmeal'),
(286, 'fish fillet'),
(287, 'fish sauce'),
(288, 'fish stock'),
(289, 'five spice powder'),
(290, 'flaked almonds'),
(291, 'flat rice noodles'),
(292, 'flax eggs'),
(293, 'flour'),
(294, 'flour tortilla'),
(295, 'floury potatoes'),
(296, 'free-range egg, beaten'),
(297, 'free-range eggs, beaten'),
(298, 'freekeh'),
(299, 'french lentils'),
(300, 'fresh basil'),
(301, 'fresh thyme'),
(302, 'freshly chopped parsley'),
(303, 'fried ripe bananas'),
(304, 'fries'),
(305, 'fromage frais'),
(306, 'frozen mixed berries'),
(307, 'frozen peas'),
(308, 'frozen seafood mix'),
(309, 'fruit mix'),
(310, 'full fat sour cream'),
(311, 'full fat yogurt'),
(312, 'galangal'),
(313, 'galangal paste'),
(314, 'garam masala'),
(315, 'garlic'),
(316, 'garlic bulb'),
(317, 'garlic clove'),
(318, 'garlic granules'),
(319, 'garlic powder'),
(320, 'garlic sauce'),
(321, 'gelatine leafs'),
(322, 'german sausages'),
(323, 'ghee'),
(324, 'ginger'),
(325, 'ginger cordial'),
(326, 'ginger garlic paste'),
(327, 'ginger paste'),
(328, 'glace cherry'),
(329, 'glimworm-honing uit de mangroves'),
(330, 'goat meat'),
(331, 'goats cheese'),
(332, 'gochujang'),
(333, 'golden caster sugar'),
(334, 'golden syrup'),
(335, 'goose fat'),
(336, 'gouda cheese'),
(337, 'graham cracker crumbs'),
(338, 'grand marnier'),
(339, 'granulated sugar'),
(340, 'grape nut cereal'),
(341, 'grape tomatoes'),
(342, 'greek yogurt'),
(343, 'green beans'),
(344, 'green chilli'),
(345, 'green olives'),
(346, 'green pepper'),
(347, 'green red lentils'),
(348, 'green salsa'),
(349, 'ground allspice'),
(350, 'ground almonds'),
(351, 'ground annatto'),
(352, 'ground beef'),
(353, 'ground cardomom'),
(354, 'ground cinnamon'),
(355, 'ground clove'),
(356, 'ground coriander'),
(357, 'ground cumin'),
(358, 'ground ginger'),
(359, 'ground nut oil'),
(360, 'ground nutmeg'),
(361, 'ground oats'),
(362, 'ground pistachios'),
(363, 'ground poppy seeds'),
(364, 'ground pork'),
(365, 'ground sugar'),
(366, 'gruyere cheese'),
(367, 'haddock'),
(368, 'hake'),
(369, 'ham'),
(370, 'hard taco shells'),
(371, 'haricot beans'),
(372, 'harissa spice'),
(373, 'hazlenuts'),
(374, 'heavy cream'),
(375, 'herring'),
(376, 'high heat cooking oil'),
(377, 'hind shank'),
(378, 'hispi (sweetheart) cabbage'),
(379, 'hoisin sauce'),
(380, 'honey'),
(381, 'horseradish'),
(382, 'hot beef stock'),
(383, 'hot chilli powder'),
(384, 'hot smoked flaked salmon'),
(385, 'hot smoked paprika'),
(386, 'hotsauce'),
(387, 'hummus'),
(388, 'ice cream'),
(389, 'iceberg lettuce'),
(390, 'icing sugar'),
(391, 'instant yeast'),
(392, 'italian fennel sausages'),
(393, 'italian seasoning'),
(394, 'jalapeno'),
(395, 'jam'),
(396, 'jamaican curry powder'),
(397, 'jasmine rice'),
(398, 'jersey royal potatoes'),
(399, 'jerusalem artichokes'),
(400, 'jumbo shrimp'),
(401, 'juniper berries'),
(402, 'kabanos sausages'),
(403, 'kabse spice'),
(404, 'kale'),
(405, 'khus khus'),
(406, 'kidney beans'),
(407, 'kielbasa'),
(408, 'king prawns'),
(409, 'knafeh'),
(410, 'kosher salt'),
(411, 'lamb'),
(412, 'lamb kidney'),
(413, 'lamb leg'),
(414, 'lamb loin chops'),
(415, 'lamb mince'),
(416, 'lamb shanks'),
(417, 'lamb shoulder'),
(418, 'lamb stock'),
(419, 'lard'),
(420, 'lasagne sheets'),
(421, 'lean minced beef'),
(422, 'lean minced steak'),
(423, 'leek'),
(424, 'lemon'),
(425, 'lemon juice'),
(426, 'lemon zest'),
(427, 'lemongrass'),
(428, 'lemongrass stalks'),
(429, 'lemons'),
(430, 'lentils'),
(431, 'lettuce'),
(432, 'light brown soft sugar'),
(433, 'lime'),
(434, 'lime juice'),
(435, 'lime leaves'),
(436, 'linguine pasta'),
(437, 'liquid cheese'),
(438, 'little gem lettuce'),
(439, 'macaroni'),
(440, 'mackerel'),
(441, 'madras paste'),
(442, 'makrut lime leaves'),
(443, 'malai'),
(444, 'malt vinegar'),
(445, 'manchego'),
(446, 'maple syrup'),
(447, 'marinated tofu'),
(448, 'marjoram'),
(449, 'mars bar'),
(450, 'marzipan'),
(451, 'mascarpone'),
(452, 'massaman curry paste'),
(453, 'mature cheddar'),
(454, 'mayonnaise'),
(455, 'medjool dates'),
(456, 'melted butter'),
(457, 'meringue nests'),
(458, 'milk'),
(459, 'milk chocolate'),
(460, 'minced beef'),
(461, 'minced garlic'),
(462, 'minced pork'),
(463, 'mincemeat'),
(464, 'miniature marshmallows'),
(465, 'mint'),
(466, 'mirin'),
(467, 'mixed beef cuts'),
(468, 'mixed grain'),
(469, 'mixed peel'),
(470, 'mixed peppers'),
(471, 'mixed spice'),
(472, 'molasses'),
(473, 'monkfish'),
(474, 'monterey jack cheese'),
(475, 'morcilla'),
(476, 'mozzarella'),
(477, 'mozzarella balls'),
(478, 'mulukhiyah'),
(479, 'mung bean sprouts'),
(480, 'muscovado sugar'),
(481, 'mushrooms'),
(482, 'mussels'),
(483, 'mustard'),
(484, 'mustard powder'),
(485, 'mustard seeds'),
(486, 'naan bread'),
(487, 'napa cabbage'),
(488, 'natural yoghurt'),
(489, 'new potatoes'),
(490, 'noodles'),
(491, 'nougatine'),
(492, 'nutmeg'),
(493, 'oatmeal'),
(494, 'oats'),
(495, 'oil'),
(496, 'olive oil'),
(497, 'onion'),
(498, 'onion salt'),
(499, 'onions'),
(500, 'orange'),
(501, 'orange blossom water'),
(502, 'orange juice'),
(503, 'orange zest'),
(504, 'oregano'),
(505, 'oreo cream biscuits'),
(506, 'oxtail'),
(507, 'oyster mushrooms'),
(508, 'oyster sauce'),
(509, 'oysters'),
(510, 'paccheri pasta'),
(511, 'padron peppers'),
(512, 'paella rice'),
(513, 'pak choi'),
(514, 'palm sugar'),
(515, 'panang curry paste'),
(516, 'paneer'),
(517, 'paprika'),
(518, 'parma ham'),
(519, 'parmesan'),
(520, 'parmesan cheese'),
(521, 'parmigiano-reggiano'),
(522, 'parsley'),
(523, 'passata'),
(524, 'passion fruit pulp'),
(525, 'peach juice'),
(526, 'peaches'),
(527, 'peanut brittle'),
(528, 'peanut butter'),
(529, 'peanut cookies'),
(530, 'peanut oil'),
(531, 'peanuts'),
(532, 'pears'),
(533, 'peas'),
(534, 'pecan nuts'),
(535, 'pecorino'),
(536, 'penne rigate'),
(537, 'pepper'),
(538, 'peppercorns'),
(539, 'petit pois'),
(540, 'phyllo dough'),
(541, 'pickle juice'),
(542, 'pico de gallo sauce'),
(543, 'pilchards'),
(544, 'pine nuts'),
(545, 'pineapple chunks'),
(546, 'pineapple juice'),
(547, 'pinguin-ham uit antartica'),
(548, 'pink food colouring'),
(549, 'pinto beans'),
(550, 'pistachio'),
(551, 'pistachio paste'),
(552, 'pita bread'),
(553, 'pitted black olives'),
(554, 'pitted dates'),
(555, 'plain chocolate'),
(556, 'plain flour'),
(557, 'plum jam'),
(558, 'plum sauce'),
(559, 'plum tomatoes'),
(560, 'polish kabanos'),
(561, 'pomegranate'),
(562, 'pomegranate molasses'),
(563, 'poppy seeds'),
(564, 'pork'),
(565, 'pork back ribs'),
(566, 'pork belly slices'),
(567, 'pork chops'),
(568, 'pork knuckle'),
(569, 'pork shoulder'),
(570, 'pork shoulder steaks'),
(571, 'pork tenderloin'),
(572, 'porridge oats'),
(573, 'potato starch'),
(574, 'potatoes'),
(575, 'powdered sugar'),
(576, 'prawns'),
(577, 'pretzels'),
(578, 'prosciutto'),
(579, 'prunes'),
(580, 'puff pastry'),
(581, 'pul biber'),
(582, 'pumpkin'),
(583, 'purple sprouting broccoli'),
(584, 'quinoa'),
(585, 'radish'),
(586, 'rainbow trout'),
(587, 'raisins'),
(588, 'rapeseed oil'),
(589, 'ras el hanout'),
(590, 'raspberries'),
(591, 'raspberry jam'),
(592, 'raw frozen prawns'),
(593, 'raw king prawns'),
(594, 'raw tiger prawns'),
(595, 'raw vegetables'),
(596, 'ready rolled shortcrust pastry'),
(597, 'red cabbage'),
(598, 'red chilli'),
(599, 'red chilli flakes'),
(600, 'red chilli powder'),
(601, 'red onions'),
(602, 'red pepper'),
(603, 'red pepper flakes'),
(604, 'red pepper paste'),
(605, 'red potatoes'),
(606, 'red snapper'),
(607, 'red wine'),
(608, 'red wine jelly'),
(609, 'red wine vinegar'),
(610, 'redcurrants'),
(611, 'refried beans'),
(612, 'rhubarb'),
(613, 'rice'),
(614, 'rice flour pancakes'),
(615, 'rice krispies'),
(616, 'rice noodles'),
(617, 'rice paper sheets'),
(618, 'rice stick noodles'),
(619, 'rice vermicelli'),
(620, 'rice vinegar'),
(621, 'rice wine'),
(622, 'ricotta'),
(623, 'rigatoni'),
(624, 'roasted peanut'),
(625, 'roasted pepper'),
(626, 'roasted vegetables'),
(627, 'rocket'),
(628, 'rolled oats'),
(629, 'romano pepper'),
(630, 'rose water'),
(631, 'rosemary'),
(632, 'runner beans'),
(633, 'russet potato'),
(634, 'rye'),
(635, 'rye bread'),
(636, 'saffron'),
(637, 'sage'),
(638, 'sake'),
(639, 'salmon'),
(640, 'salsa'),
(641, 'salt'),
(642, 'salt cod'),
(643, 'salted butter'),
(644, 'sardines'),
(645, 'saskatoon berries'),
(646, 'sauerkraut'),
(647, 'sausages'),
(648, 'savoy cabbage'),
(649, 'sazon'),
(650, 'scallions'),
(651, 'scotch bonnet'),
(652, 'sea bass fillets'),
(653, 'sea salt'),
(654, 'seafood stock'),
(655, 'seasoned rice vinegar'),
(656, 'seasoning'),
(657, 'self-raising flour'),
(658, 'semi-skimmed milk'),
(659, 'semolina'),
(660, 'semolina flour'),
(661, 'serrano ham'),
(662, 'sesame seed'),
(663, 'sesame seed burger buns'),
(664, 'sesame seed oil'),
(665, 'sevaiiya'),
(666, 'shallots'),
(667, 'shaoxing wine'),
(668, 'shelled hazelnuts'),
(669, 'sherry'),
(670, 'sherry vinegar'),
(671, 'shiitake mushrooms'),
(672, 'shortcrust pastry'),
(673, 'shortening'),
(674, 'shredded coconut'),
(675, 'shredded meat'),
(676, 'shredded mexican cheese'),
(677, 'shredded monterey jack cheese'),
(678, 'shrimp'),
(679, 'shrimp paste'),
(680, 'shrimp stock'),
(681, 'sichuan pepper'),
(682, 'silken tofu'),
(683, 'single cream'),
(684, 'sirloin steak'),
(685, 'sirloin steak tips'),
(686, 'skirty steak'),
(687, 'small potatoes'),
(688, 'smoked haddock'),
(689, 'smoked paprika'),
(690, 'smoked salmon'),
(691, 'smoky paprika'),
(692, 'snow peas'),
(693, 'soda water'),
(694, 'sour cream'),
(695, 'soured cream and chive dip'),
(696, 'soy sauce'),
(697, 'soya bean'),
(698, 'soya milk'),
(699, 'spaghetti'),
(700, 'speculaas spice mix'),
(701, 'spinach'),
(702, 'spring onions'),
(703, 'squash'),
(704, 'squid'),
(705, 'stale bread'),
(706, 'star anise'),
(707, 'starch'),
(708, 'stilton cheese'),
(709, 'stir-fry vegetables'),
(710, 'stoned dates'),
(711, 'stout'),
(712, 'strawberries'),
(713, 'streaky bacon'),
(714, 'strong white bread flour'),
(715, 'strong white flour'),
(716, 'strong wholemeal flour'),
(717, 'suet'),
(718, 'sugar'),
(719, 'sugar snap peas'),
(720, 'sugar syrup'),
(721, 'sultanas'),
(722, 'sumac'),
(723, 'sun-dried tomatoes'),
(724, 'sunflower oil'),
(725, 'sushi rice'),
(726, 'swede'),
(727, 'sweet chilli sauce'),
(728, 'sweet peppadew peppers'),
(729, 'sweet potatoes'),
(730, 'sweet red peppers'),
(731, 'sweet sherry'),
(732, 'sweet smoked paprika'),
(733, 'sweetcorn'),
(734, 'sweetened condensed milk'),
(735, 'szechuan peppercorns'),
(736, 'tabasco sauce'),
(737, 'tahini'),
(738, 'tahini paste'),
(739, 'tamarind ball'),
(740, 'tamarind paste'),
(741, 'tamarind pulp'),
(742, 'tarragon leaves'),
(743, 'tempeh'),
(744, 'thai chilli jam'),
(745, 'thai fish sauce'),
(746, 'thai green curry paste'),
(747, 'thai red curry paste'),
(748, 'thyme'),
(749, 'tiger prawns'),
(750, 'tinned tomatos'),
(751, 'toast'),
(752, 'toffee popcorn'),
(753, 'tofu'),
(754, 'tomato'),
(755, 'tomato ketchup'),
(756, 'tomato puree'),
(757, 'tomato sauce'),
(758, 'tomatoes'),
(759, 'toor dal'),
(760, 'tortillas'),
(761, 'trout'),
(762, 'truffle oil'),
(763, 'tuna'),
(764, 'turkey'),
(765, 'turkey ham'),
(766, 'turkey mince'),
(767, 'turkish delight'),
(768, 'turmeric'),
(769, 'turmeric powder'),
(770, 'turnips'),
(771, 'udon noodles'),
(772, 'unflavoured gelatin'),
(773, 'unsalted beef stock'),
(774, 'unsalted butter'),
(775, 'unsalted pistachio'),
(776, 'unsweetened cocoa'),
(777, 'unsweetened coconut milk'),
(778, 'unwaxed lemon'),
(779, 'unwaxed lime'),
(780, 'vampier-tomaten uit transsylvanie'),
(781, 'vanilla'),
(782, 'vanilla bean paste'),
(783, 'vanilla extract'),
(784, 'vanilla pod'),
(785, 'vanilla sugar'),
(786, 'veal'),
(787, 'vegan butter'),
(788, 'vegan white wine vinegar'),
(789, 'vegetable millk'),
(790, 'vegetable oil'),
(791, 'vegetable shortening'),
(792, 'vegetable stock'),
(793, 'vegetable stock cube'),
(794, 'vermicelli pasta'),
(795, 'vermicelli rice noodles'),
(796, 'vinaigrette dressing'),
(797, 'vine leaves'),
(798, 'vine tomatoes'),
(799, 'vinegar'),
(800, 'walnuts'),
(801, 'water'),
(802, 'water chestnut'),
(803, 'whipping cream'),
(804, 'white asparagus'),
(805, 'white bread'),
(806, 'white bread mix'),
(807, 'white cabbage'),
(808, 'white chocolate'),
(809, 'white chocolate chips'),
(810, 'white cornmeal'),
(811, 'white fish'),
(812, 'white fish fillets'),
(813, 'white flour'),
(814, 'white sauerkraut'),
(815, 'white vinegar'),
(816, 'white wine'),
(817, 'white wine vinegar'),
(818, 'white yam'),
(819, 'whole black peppercorns'),
(820, 'whole milk'),
(821, 'whole wheat'),
(822, 'wholegrain bread'),
(823, 'wholegrain mustard'),
(824, 'wild garlic leaves'),
(825, 'wild mushrooms'),
(826, 'wonton skin'),
(827, 'wood ear mushrooms'),
(828, 'worcestershire sauce'),
(829, 'yautia'),
(830, 'yeast'),
(831, 'yellow food colouring'),
(832, 'yellow masarepa'),
(833, 'yellow pepper'),
(834, 'yellow split peas'),
(835, 'yogurt'),
(836, 'zucchini');

INSERT INTO allergens (id, name, description) VALUES
(1, 'Gluten', 'Wheat, rye, barley, oats'),
(2, 'Lactose', 'Milk and dairy products'),
(3, 'Eggs', 'Eggs and egg-containing products'),
(4, 'Nuts', 'Walnuts, almonds, cashews, hazelnuts'),
(5, 'Peanuts', 'Peanuts and peanut products'),
(6, 'Soy', 'Soy and soy products'),
(7, 'Shellfish', 'Shrimp, crab, lobster'),
(8, 'Fish', 'Fish and fish products'),
(9, 'Celery', 'Celery and celery products'),
(10, 'Sesame', 'Sesame seeds and sesame products');

INSERT INTO meals (id, name, category, area, instructions, thumbnail_url) VALUES
(52764, 'Garides Saganaki', 'Seafood', 'Greek', 'Place the prawns in a pot and add enough water to cover. Boil for 5 minutes. Drain, reserving the liquid, and set aside.
Heat 2 tablespoons of oil in a saucepan. Add the onion; cook and stir until soft. Mix in the parsley, wine, tomatoes, garlic and remaining olive oil. Simmer, stirring occasionally, for about 30 minutes, or until the sauce is thickened.
While the sauce is simmering, the prawns should become cool enough to handle. First remove the legs by pinching them, and then pull off the shells, leaving the head and tail on.
When the sauce has thickened, stir in the prawns. Bring to a simmer again if the sauce has cooled with the prawns, and cook for about 5 minutes. Add the feta and remove from the heat. Let stand until the cheese starts to melt. Serve warm with slices of crusty bread.
Though completely untraditional, you can add a few tablespoons of stock or passata to this recipe to make a delicious pasta sauce. Toss with pasta after adding the feta, and serve.', '/static/fotos/52764.jpg'),
(52765, 'Chicken Enchilada Casserole', 'Chicken', 'Mexican', 'Cut each chicken breast in about 3 pieces, so that it cooks faster and put it in a small pot. Pour Enchilada sauce over it and cook covered on low to medium heat until chicken is cooked through, about 20 minutes. No water is needed, the chicken will cook in the Enchilada sauce. Make sure you stir occasionally so that it doesn''t stick to the bottom.
Remove chicken from the pot and shred with two forks.
Preheat oven to 375 F degrees.
Start layering the casserole. Start with about ¼ cup of the leftover Enchilada sauce over the bottom of a baking dish. I used a longer baking dish, so that I can put 2 corn tortillas across. Place 2 tortillas on the bottom, top with ⅓ of the chicken and ⅓ of the remaining sauce. Sprinkle with ⅓ of the cheese and repeat starting with 2 more tortillas, then chicken, sauce, cheese. Repeat with last layer with the remaining ingredients, tortillas, chicken, sauce and cheese.
Bake for 20 to 30 minutes uncovered, until bubbly and cheese has melted and started to brown on top.
Serve warm.', '/static/fotos/52765.jpg'),
(52767, 'Bakewell tart', 'Dessert', 'British', 'To make the pastry, measure the flour into a bowl and rub in the butter with your fingertips until the mixture resembles fine breadcrumbs. Add the water, mixing to form a soft dough.
Roll out the dough on a lightly floured work surface and use to line a 20cm/8in flan tin. Leave in the fridge to chill for 30 minutes.
Preheat the oven to 200C/400F/Gas 6 (180C fan).
Line the pastry case with foil and fill with baking beans. Bake blind for about 15 minutes, then remove the beans and foil and cook for a further five minutes to dry out the base.
For the filing, spread the base of the flan generously with raspberry jam.
Melt the butter in a pan, take off the heat and then stir in the sugar. Add ground almonds, egg and almond extract. Pour into the flan tin and sprinkle over the flaked almonds.
Bake for about 35 minutes. If the almonds seem to be browning too quickly, cover the tart loosely with foil to prevent them burning.', '/static/fotos/52767.jpg'),
(52768, 'Apple Frangipan Tart', 'Dessert', 'British', 'Preheat the oven to 200C/180C Fan/Gas 6.
Put the biscuits in a large re-sealable freezer bag and bash with a rolling pin into fine crumbs. Melt the butter in a small pan, then add the biscuit crumbs and stir until coated with butter. Tip into the tart tin and, using the back of a spoon, press over the base and sides of the tin to give an even layer. Chill in the fridge while you make the filling.
Cream together the butter and sugar until light and fluffy. You can do this in a food processor if you have one. Process for 2-3 minutes. Mix in the eggs, then add the ground almonds and almond extract and blend until well combined.
Peel the apples, and cut thin slices of apple. Do this at the last minute to prevent the apple going brown. Arrange the slices over the biscuit base. Spread the frangipane filling evenly on top. Level the surface and sprinkle with the flaked almonds.
Bake for 20-25 minutes until golden-brown and set.
Remove from the oven and leave to cool for 15 minutes. Remove the sides of the tin. An easy way to do this is to stand the tin on a can of beans and push down gently on the edges of the tin.
Transfer the tart, with the tin base attached, to a serving plate. Serve warm with cream, crème fraiche or ice cream.', '/static/fotos/52768.jpg'),
(52769, 'Kapsalon', 'Lamb', 'Netherlands', 'Cut the meat into strips. Heat oil in a pan and fry the strips for 6 minutes until it''s ready.
Bake the fries until golden brown in a deep fryrer. When ready transfer to a backing dish. Make sure the fries are spread over the whole dish.
Cover the fries with a new layer of meat and spread evenly.
Add a layer of cheese over the meat. You can also use grated cheese. When done put in the oven for a few minutes until the cheese is melted.
Chop the lettuce, tomato and cucumber in small pieces and mix together. for a basic salad. As extra you can add olives jalapenos and a red union.
Dived the salad over the dish and Serve with garlicsauce and hot sauce', '/static/fotos/52769.jpg'),
(52770, 'Spaghetti Bolognese', 'Beef', 'Italian', 'Put the onion and oil in a large pan and fry over a fairly high heat for 3-4 mins. Add the garlic and mince and fry until they both brown. Add the mushrooms and herbs, and cook for another couple of mins.

Stir in the tomatoes, beef stock, tomato ketchup or purée, Worcestershire sauce and seasoning. Bring to the boil, then reduce the heat, cover and simmer, stirring occasionally, for 30 mins.

Meanwhile, cook the spaghetti in a large pan of boiling, salted water, according to packet instructions. Drain well, run hot water through it, put it back in the pan and add a dash of olive oil, if you like, then stir in the meat sauce. Serve in hot bowls and hand round Parmesan cheese, for sprinkling on top.', '/static/fotos/52770.jpg'),
(52771, 'Spicy Arrabiata Penne', 'Vegetarian', 'Italian', 'Bring a large pot of water to a boil. Add kosher salt to the boiling water, then add the pasta. Cook according to the package instructions, about 9 minutes.
In a large skillet over medium-high heat, add the olive oil and heat until the oil starts to shimmer. Add the garlic and cook, stirring, until fragrant, 1 to 2 minutes. Add the chopped tomatoes, red chile flakes, Italian seasoning and salt and pepper to taste. Bring to a boil and cook for 5 minutes. Remove from the heat and add the chopped basil.
Drain the pasta and add it to the sauce. Garnish with Parmigiano-Reggiano flakes and more basil and serve warm.', '/static/fotos/52771.jpg'),
(52772, 'Teriyaki Chicken Casserole', 'Chicken', 'Japanese', 'Preheat oven to 350° F. Spray a 9x13-inch baking pan with non-stick spray.
Combine soy sauce, ½ cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once boiling.
Meanwhile, stir together the corn starch and 2 tablespoons of water in a separate dish until smooth. Once sauce is boiling, add mixture to the saucepan and stir to combine. Cook until the sauce starts to thicken then remove from heat.
Place the chicken breasts in the prepared pan. Pour one cup of the sauce over top of chicken. Place chicken in oven and bake 35 minutes or until cooked through. Remove from oven and shred chicken in the dish using two forks.
*Meanwhile, steam or cook the vegetables according to package directions.
Add the cooked vegetables and rice to the casserole dish with the chicken. Add most of the remaining sauce, reserving a bit to drizzle over the top when serving. Gently toss everything together in the casserole dish until combined. Return to oven and cook 15 minutes. Remove from oven and let stand 5 minutes before serving. Drizzle each serving with remaining sauce. Enjoy!', '/static/fotos/52772.jpg'),
(52773, 'Honey Teriyaki Salmon', 'Seafood', 'Japanese', 'Mix all the ingredients in the Honey Teriyaki Glaze together. Whisk to blend well. Combine the salmon and the Glaze together.

Heat up a skillet on medium-low heat. Add the oil, Pan-fry the salmon on both sides until it’s completely cooked inside and the glaze thickens.

Garnish with sesame and serve immediately.', '/static/fotos/52773.jpg'),
(52774, 'Pad See Ew', 'Chicken', 'Thai', 'Mix Sauce in small bowl.
Mince garlic into wok with oil. Place over high heat, when hot, add chicken and Chinese broccoli stems, cook until chicken is light golden.
Push to the side of the wok, crack egg in and scramble. Don''t worry if it sticks to the bottom of the wok - it will char and which adds authentic flavour.
Add noodles, Chinese broccoli leaves and sauce. Gently mix together until the noodles are stained dark and leaves are wilted. Serve immediately!', '/static/fotos/52774.jpg'),
(52775, 'Vegan Lasagna', 'Vegan', 'Italian', '1) Preheat oven to 180 degrees celcius. 
2) Boil vegetables for 5-7 minutes, until soft. Add lentils and bring to a gentle simmer, adding a stock cube if desired. Continue cooking and stirring until the lentils are soft, which should take about 20 minutes. 
3) Blanch spinach leaves for a few minutes in a pan, before removing and setting aside. 
4) Top up the pan with water and cook the lasagne sheets. When cooked, drain and set aside.
5) To make the sauce, melt the butter and add the flour, then gradually add the soya milk along with the mustard and the vinegar. Cook and stir until smooth and then assemble the lasagne as desired in a baking dish. 
6) Bake in the preheated oven for about 25 minutes.', '/static/fotos/52775.jpg'),
(52776, 'Chocolate Gateau', 'Dessert', 'France', 'Preheat the oven to 180°C/350°F/Gas Mark 4. Grease and line the base of an 8 in round spring form cake tin with baking parchment
Break the chocolate into a heatproof bowl and place over a saucepan of gently simmering water and stir until it melts. (or melt in the microwave for 2-3 mins stirring occasionally)
Place the butter and sugar in a mixing bowl and cream together with a wooden spoon until light and fluffy. Gradually beat in the eggs, adding a little flour if the mixture begins to curdle. Fold in the remaining flour with the cooled, melted chocolate and milk. Mix until smooth.
Spread the mixture into the cake tin and bake for 50-55 mins or until firm in the centre and a skewer comes out cleanly. Cool for 10 minutes, then turn out and cool completely.', '/static/fotos/52776.jpg'),
(52777, 'Mediterranean Pasta Salad', 'Seafood', 'Italian', 'Bring a large saucepan of salted water to the boil
Add the pasta, stir once and cook for about 10 minutes or as directed on the packet.
Meanwhile, wash the tomatoes and cut into quarters. Slice the olives. Wash the basil.
Put the tomatoes into a salad bowl and tear the basil leaves over them. Add a tablespoon of olive oil and mix.
When the pasta is ready, drain into a colander and run cold water over it to cool it quickly.
Toss the pasta into the salad bowl with the tomatoes and basil.
Add the sliced olives, drained mozzarella balls, and chunks of tuna. Mix well and let the salad rest for at least half an hour to allow the flavours to mingle.
Sprinkle the pasta with a generous grind of black pepper and drizzle with the remaining olive oil just before serving.', '/static/fotos/52777.jpg'),
(52779, 'Cream Cheese Tart', 'Starter', 'United States', 'Crust: make a dough from 250g flour (I like mixing different flours like plain and wholegrain spelt flour), 125g butter, 1 egg and a pinch of salt, press it into a tart form and place it in the fridge. Filling: stir 300g cream cheese and 100ml milk until smooth, add in 3 eggs, 100g grated parmesan cheese and season with salt, pepper and nutmeg. Take the crust out of the fridge and prick the bottom with a fork. Pour in the filling and bake at 175 degrees C for about 25 minutes. Cover the tart with some aluminium foil after half the time. In the mean time, slice about 350g mini tomatoes. In a small pan heat 3tbsp olive oil, 3tbsp white vinegar, 1 tbsp honey, salt and pepper and combine well. Pour over the tomato slices and mix well. With a spoon, place the tomato slices on the tart, avoiding too much liquid on it. Decorate with basil leaves and enjoy', '/static/fotos/52779.jpg'),
(52780, 'Potato Gratin with Chicken', 'Chicken', 'Italian', '15 minute potato gratin with chicken and bacon greens: a gratin always seems more effort and more indulgent than ordinary boiled or roasts, but it doesn''t have to take 45mins, it''s nice for a change and you can control the calorie content by going with full fat to low fat creme fraiche. (It''s always tastes better full fat though obviously!) to serve 4: use 800g of potatoes, finely slice and boil in a pan for about 5-8 mins till firmish, not soft. Finely slice 3 onions and place in an oven dish with 2 tblsp of olive oil and 100ml of chicken stock. Cook till the onions are soft then drain the potatoes and pour onto the onions. Season and spoon over cream or creme fraiche till all is covered but not swimming. Grate Parmesan over the top then finish under the grill till nicely golden. serve with chicken and bacon, peas and spinach.', '/static/fotos/52780.jpg'),
(52781, 'Irish stew', 'Beef', 'Irish', 'Heat the oven to 180C/350F/gas mark 4. Drain and rinse the soaked wheat, put it in a medium pan with lots of water, bring to a boil and simmer for an hour, until cooked. Drain and set aside.

Season the lamb with a teaspoon of salt and some black pepper. Put one tablespoon of oil in a large, deep sauté pan for which you have a lid; place on a medium-high heat. Add some of the lamb – don''t overcrowd the pan – and sear for four minutes on all sides. Transfer to a bowl, and repeat with the remaining lamb, adding oil as needed.

Lower the heat to medium and add a tablespoon of oil to the pan. Add the shallots and fry for four minutes, until caramelised. Tip these into the lamb bowl, and repeat with the remaining vegetables until they are all nice and brown, adding more oil as you need it.

Once all the vegetables are seared and removed from the pan, add the wine along with the sugar, herbs, a teaspoon of salt and a good grind of black pepper. Boil on a high heat for about three minutes.

Tip the lamb, vegetables and whole wheat back into the pot, and add the stock. Cover and boil for five minutes, then transfer to the oven for an hour and a half.

Remove the stew from the oven and check the liquid; if there is a lot, remove the lid and boil for a few minutes.', '/static/fotos/52781.jpg'),
(52782, 'Lamb tomato and sweet spices', 'Lamb', 'Moroccan', 'Use pickled vine leaves here, preserved in brine. Small delicate leaves are better than the large bristly ones but, if only large leaves are to hand, then trim them to roughly 12 by 12 cms so that you don''t get too many layers of leaves around the filling. And remove any stalks. Drain the preserved leaves, immerse them in boiling water for 10 minutes and then leave to dry on a tea towel before use. 
Basmati rice with butter and pine nuts is an ideal accompaniment. Couscous is great, too. Serves four.
First make the filling. Put all the ingredients, apart from the tomatoes, in a bowl. Cut the tomatoes in half, coarsely grate into the bowl and discard the skins. Add half a teaspoon of salt and some black pepper, and stir. Leave on the side, or in the fridge, for up to a day. Before using, gently squeeze with your hands and drain away any juices that come out.
To make the sauce, heat the oil in a medium pan. Add the ginger and garlic, cook for a minute or two, taking care not to burn them, then add the tomato, lemon juice and sugar. Season, and simmer for 20 minutes.
While the sauce is bubbling away, prepare the vine leaves. Use any torn or broken leaves to line the base of a wide, heavy saucepan. Trim any leaves from the fennel, cut it vertically into 0.5cm-thick slices and spread over the base of the pan to cover completely.
Lay a prepared vine leaf (see intro) on a work surface, veiny side up. Put two teaspoons of filling at the base of the leaf in a 2cm-long by 1cm-wide strip. Fold the sides of the leaf over the filling, then roll it tightly from bottom to top, in a cigar shape. Place in the pan, seam down, and repeat with the remaining leaves, placing them tightly next to each other in lines or circles (in two layers if necessary).
Pour the sauce over the leaves (and, if needed, add water just to cover). Place a plate on top, to weigh the leaves down, then cover with a lid. Bring to a boil, reduce the heat and cook on a bare simmer for 70 minutes. Most of the liquid should evaporate. Remove from the heat, and leave to cool a little - they are best served warm. When serving, bring to the table in the pan - it looks great. Serve a few vine leaves and fennel slices with warm rice. Spoon the braising juices on top and garnish with coriander.', '/static/fotos/52782.jpg'),
(52783, 'Rigatoni with fennel sausage sauce', 'Lamb', 'Italian', 'Heat a tablespoon of oil in a large saute pan for which you have a lid. Add the sausage pieces and fry on a medium-high heat for 10 minutes, stirring regularly, until golden-brown all over. Transfer the sausages to a plate, then add the onion and fennel to the hot pan and fry for 15 minutes, stirring once in a while, until soft and caramelised; if the pan goes a bit dry, add a teaspoon or so of extra oil. Stir in the paprika, garlic and half the fennel seeds, fry for two minutes more, then pour on the wine and boil for 30 seconds, to reduce by half. Add the tomatoes, sugar, 100ml water, the seared sausage and half a teaspoon of salt, cover and simmer for 30 minutes; remove the lid after 10 minutes, and cook until the sauce is thick and rich. Remove from the heat, stir through the olives and remaining fennel seeds and set aside until you’re ready to serve.

Bring a large pot of salted water to a boil, add the pasta and cook for 12-14 minutes (or according to the instructions on the packet), until al dente. Meanwhile, reheat the sauce. Drain the pasta, return it to the pot, stir in a tablespoon of oil, then divide between the bowls. 

Put all the pesto ingredients except the basil in the small bowl of a food processor. Add a tablespoon of water and blitz to a rough paste. Add the basil, then blitz until just combined (the pesto has a much better texture if the basil is not overblended).

Spoon over the ragù and top with a spoonful of pesto. Finish with a sprinkling of chopped fennel fronds, if you have any, and serve at once.', '/static/fotos/52783.jpg'),
(52784, 'Smoky Lentil Chili with Squash', 'Vegetarian', 'British', 'Begin by roasting the squash. Slice it into thin crescents and drizzle with a little oil and sprinkle with sea salt. I added a fresh little sage I had in the fridge, but it’s unnecessary. Roast the squash a 205 C (400 F) for 20-30 minutes, flipping halfway through, until soft and golden. Let cool and chop into cubes.
Meanwhile, rinse the lentils and cover them with water. Bring them to the boil then turn down to a simmer and let cook (uncovered) for 20-30 minutes, or until tender. Drain and set aside.
While the lentils are cooking heat the 1 Tbsp. of oil on low in a medium pot. Add the onions and leeks and sauté for 5 or so minutes, or until they begin to soften. Add the garlic next along with the cumin and coriander, cooking for a few more minutes. Add the remaining spices – paprika, cinnamon, chilli, cocoa, Worcestershire sauce, salt, and oregano. Next add the can of tomatoes, the water or stock, and carrots. Let simmer, covered, for 20 minutes or until the veg is tender and the mixture has thickened up. You’ll need to check on the pot periodically for a stir and a top of of liquid if needed.
Add the lentils and chopped roasted squash. Let cook for 10 more minutes to heat through.
Serve with sliced jalapeno, lime wedges, cilantro, green onions, and cashew sour cream.

SIMPLE CASHEW SOUR CREAM

1 Cup Raw Unsalted Cashews
Pinch Sea Salt
1 tsp. Apple Cider Vinegar
Water

Bring some water to the boil, and use it to soak the cashews for at least four hours. Alternatively, you can use cold water and let the cashews soak overnight, but I’m forgetful/lazy, so often use the boil method which is much faster.
After the cashews have soaked, drain them and add to a high speed blender. Begin to puree, slowly adding about 1/2 cup fresh water, until a creamy consistency is reached. You may need to add less or more water to reach the desired consistency.
Add a pinch of sea salt and vinegar (or lemon juice).', '/static/fotos/52784.jpg'),
(52785, 'Dal fry', 'Vegetarian', 'India', 'Wash and soak toor dal in approx. 3 cups of water, for at least one hours. Dal will be double in volume after soaking. Drain the water.
Cook dal with 2-1/2 cups water and add salt, turmeric, on medium high heat, until soft in texture (approximately 30 mins) it should be like thick soup.
In a frying pan, heat the ghee. Add cumin seeds, and mustard seeds. After the seeds crack, add bay leaves, green chili, ginger and chili powder. Stir for a few seconds.
Add tomatoes, salt and sugar stir and cook until tomatoes are tender and mushy.
Add cilantro and garam masala cook for about one minute.
Pour the seasoning over dal mix it well and cook for another minute.
Serve with Naan.', '/static/fotos/52785.jpg'),
(52786, 'Rocky Road Fudge', 'Dessert', 'United States', 'Line an 8-inch-square baking pan with wax paper or foil, and coat with non-stick spray.
Pour ½ cup of the miniature marshmallows into the bottom of the lined baking dish.
In a microwave-safe bowl, combine the chocolate chips and peanut butter. Microwave the chocolate mixture in 20-second intervals, stirring in between each interval, until the chocolate is melted.
Add the vanilla extract and stir well, until smooth.
Reserve 2 tablespoons of the chopped almonds or peanuts, and set aside.
Fold 1 ½ cups of the miniature marshmallows and the remaining chopped nuts into the chocolate mixture.
Transfer the chocolate mixture into the prepared pan and spread into an even layer. Immediately top with the reserved chopped nuts and the mallow bits or additional miniature marshmallows, if using.
Refrigerate for 4 hours, or until set.
Remove the fudge and wax paper from the pan. Carefully peel all of wax paper from the fudge.
Cut the fudge into bite-sized pieces and serve.', '/static/fotos/52786.jpg'),
(52787, 'Hot Chocolate Fudge', 'Dessert', 'United States', 'Line an 8-inch-square baking pan with wax paper or foil, and coat with non-stick spray.
In a microwave-safe bowl, combine the dark chocolate chips, heavy cream and half of the sweetened condensed milk. Microwave the dark chocolate mixture in 20-second intervals, stirring in between each interval, until the chocolate is melted.
Add the vanilla extract to the dark chocolate mixture and stir well until smooth.
Transfer the dark chocolate mixture into the prepared pan and spread into an even layer.
In a separate bowl, combine the white chocolate chips with the remaining half of the sweetened condensed milk. Microwave the white chocolate mixture in 20-second intervals, stirring in between each interval, until the chocolate is melted.
Evenly spread the white chocolate mixture on top of dark chocolate layer.
Top the chocolate layers with the Mallow Bits or miniature marshmallows, and gently press them down.
Refrigerate for 4 hours, or until set.
Remove the fudge and wax paper from the pan. Carefully peel all of the wax paper from the fudge.
Cut the fudge into bite-sized pieces and serve.', '/static/fotos/52787.jpg'),
(52788, 'Christmas Pudding Flapjack', 'Dessert', 'British', 'Preheat the oven to 180°C/fan 160°C/gas mark 4 and grease and line a 25cm x 20cm tin. Melt the butter, sugar, syrup and orange zest in a large saucepan over a medium heat. The aim is to dissolve all the ingredients so that they are smooth, but to not lose any volume through boiling so be careful not to overheat.

Add the oats and stir well until evenly coated. Stir through the leftover Christmas pudding and tip into the prepared tin. Use a spoon to flatten the top and bake for 40 minutes until the edges start to brown. Whilst still warm in the tin, score into 12 squares. Allow to cool completely before cutting along the scores.

Keeps for 5 days in an air tight tin or freeze for up to 1 month.', '/static/fotos/52788.jpg'),
(52791, 'Eton Mess', 'Dessert', 'British', 'Purée half the strawberries in a blender. Chop the remaining strawberries, reserving four for decoration.
Whip the double cream until stiff peaks form, then fold in the strawberry purée and crushed meringue. Fold in the chopped strawberries and ginger cordial, if using.
Spoon equal amounts of the mixture into four cold wine glasses. Serve garnished with the remaining strawberries and a sprig of mint.', '/static/fotos/52791.jpg'),
(52792, 'Bread and Butter Pudding', 'Dessert', 'British', 'Grease a 1 litre/2 pint pie dish with butter.
Cut the crusts off the bread. Spread each slice with on one side with butter, then cut into triangles.
Arrange a layer of bread, buttered-side up, in the bottom of the dish, then add a layer of sultanas. Sprinkle with a little cinnamon, then repeat the layers of bread and sultanas, sprinkling with cinnamon, until you have used up all of the bread. Finish with a layer of bread, then set aside.
Gently warm the milk and cream in a pan over a low heat to scalding point. Don''t let it boil.
Crack the eggs into a bowl, add three quarters of the sugar and lightly whisk until pale.
Add the warm milk and cream mixture and stir well, then strain the custard into a bowl.
Pour the custard over the prepared bread layers and sprinkle with nutmeg and the remaining sugar and leave to stand for 30 minutes.
Preheat the oven to 180C/355F/Gas 4.
Place the dish into the oven and bake for 30-40 minutes, or until the custard has set and the top is golden-brown.', '/static/fotos/52792.jpg'),
(52793, 'Sticky Toffee Pudding Ultimate', 'Dessert', 'British', 'Stone and chop the dates quite small, put them in a bowl, then pour the boiling water over. Leave for about 30 mins until cool and well-soaked, then mash a bit with a fork. Stir in the vanilla extract. Butter and flour seven mini pudding tins (each about 200ml/7fl oz) and sit them on a baking sheet. Heat oven to 180C/fan 160C/gas 4.
While the dates are soaking, make the puddings. Mix the flour and bicarbonate of soda together and beat the eggs in a separate bowl. Beat the butter and sugar together in a large bowl for a few mins until slightly creamy (the mixture will be grainy from the sugar). Add the eggs a little at a time, beating well between additions. Beat in the black treacle then, using a large metal spoon, gently fold in one-third of the flour, then half the milk, being careful not to overbeat. Repeat until all the flour and milk is used. Stir the soaked dates into the pudding batter. The mix may look a little curdled at this point and will be like a soft, thick batter. Spoon it evenly between the tins and bake for 20-25 mins, until risen and firm.
Meanwhile, put the sugar and butter for the sauce in a medium saucepan with half the cream. Bring to the boil over a medium heat, stirring all the time, until the sugar has completely dissolved. Stir in the black treacle, turn up the heat slightly and let the mixture bubble away for 2-3 mins until it is a rich toffee colour, stirring occasionally to make sure it doesn’t burn. Take the pan off the heat and beat in the rest of the cream.
Remove the puddings from the oven. Leave in the tins for a few mins, then loosen them well from the sides of the tins with a small palette knife before turning them out. You can serve them now with the sauce drizzled over, but they’ll be even stickier if left for a day or two coated in the sauce. To do this, pour about half the sauce into one or two ovenproof serving dishes. Sit the upturned puddings on the sauce, then pour the rest of the sauce over them. Cover with a loose tent of foil so that the sauce doesn’t smudge (no need to chill).
When ready to serve, heat oven to 180C/fan 160C/gas 4. Warm the puddings through, still covered, for 15-20 mins or until the sauce is bubbling. Serve them on their own, or with cream or custard.', '/static/fotos/52793.jpg'),
(52794, 'Vegan Chocolate Cake', 'Vegan', 'United States', 'Simply mix all dry ingredients with wet ingredients and blend altogether. Bake for 45 min on 180 degrees. Decorate with some melted vegan chocolate ', '/static/fotos/52794.jpg'),
(52795, 'Chicken Handi', 'Chicken', 'India', 'Take a large pot or wok, big enough to cook all the chicken, and heat the oil in it. Once the oil is hot, add sliced onion and fry them until deep golden brown. Then take them out on a plate and set aside.
To the same pot, add the chopped garlic and sauté for a minute. Then add the chopped tomatoes and cook until tomatoes turn soft. This would take about 5 minutes.
Then return the fried onion to the pot and stir. Add ginger paste and sauté well.
Now add the cumin seeds, half of the coriander seeds and chopped green chillies. Give them a quick stir.
Next goes in the spices – turmeric powder and red chilli powder. Sauté the spices well for couple of minutes.
Add the chicken pieces to the wok, season it with salt to taste and cook the chicken covered on medium-low heat until the chicken is almost cooked through. This would take about 15 minutes. Slowly sautéing the chicken will enhance the flavor, so do not expedite this step by putting it on high heat.
When the oil separates from the spices, add the beaten yogurt keeping the heat on lowest so that the yogurt doesn’t split. Sprinkle the remaining coriander seeds and add half of the dried fenugreek leaves. Mix well.
Finally add the cream and give a final mix to combine everything well.
Sprinkle the remaining kasuri methi and garam masala and serve the chicken handi hot with naan or rotis. Enjoy!', '/static/fotos/52795.jpg'),
(52796, 'Chicken Alfredo Primavera', 'Chicken', 'Italian', 'Heat 1 tablespoon of butter and 2 tablespoons of olive oil in a large skillet over medium-high heat. Season both sides of each chicken breast with seasoned salt and a pinch of pepper. Add the chicken to the skillet and cook for 5-7 minutes on each side, or until cooked through.  While the chicken is cooking, bring a large pot of water to a boil. Season the boiling water with a few generous pinches of kosher salt. Add the pasta and give it a stir. Cook, stirring occasionally, until al dente, about 12 minutes. Reserve 1/2 cup of  pasta water before draining the pasta.  Remove the chicken from the pan and transfer it to a cutting board; allow it to rest. Turn the heat down to medium and dd the remaining 1 tablespoon of butter and olive oil to the same pan you used to cook the chicken. Add the veggies (minus the garlic) and red pepper flakes to the pan and stir to coat with the oil and butter (refrain from seasoning with salt until the veggies are finished browning). Cook, stirring often, until the veggies are tender, about 5 minutes. Add the garlic and a generous pinch of salt and pepper to the pan and cook for 1 minute.  Deglaze the pan with the white wine. Continue to cook until the wine has reduced by half, about 3 minutes. Stir in the milk, heavy cream, and reserved pasta water. Bring the mixture to a gentle boil and allow to simmer and reduce for 2-3 minutes. Turn off the heat and add the Parmesan cheese and cooked pasta. Season with salt and pepper to taste. Garnish with Parmesan cheese and chopped parsley, if desired. ', '/static/fotos/52796.jpg'),
(52797, 'Spicy North African Potato Salad', 'Vegetarian', 'Moroccan', 'Cook potatoes - place potatoes in a pot of cold water, and bring to the boil. Boil 20 minutes, or until potatoes are tender. You know they are cooked when you can stick a knife in them and the knife goes straight through.
Combine harissa spice, olive oil, salt and pepper and lemon juice in a small bowl and whisk until combined.
Once potatoes are cooked, drain water and roughly chop potatoes in half.
Add harissa mix and spring onions/green onions to potatoes and stir.
In a large salad bowl, lay out arugula/rocket.
Top with potato mix and toss.
Add fetta, mint and sprinkle over pine nuts.
Adjust salt and pepper to taste.', '/static/fotos/52797.jpg'),
(52802, 'Fish pie', 'Seafood', 'British', '01.Put the potatoes in a large pan of cold salted water and bring to the boil. Lower the heat, cover, then simmer gently for 15 minutes until tender. Drain, then return to the pan over a low heat for 30 seconds to drive off any excess water. Mash with 1 tbsp olive oil, then season.
02.Meanwhile put the milk in a large sauté pan, add the fish and bring to the boil. Remove from the heat, cover and stand for 3 minutes. Remove the fish (reserving the milk) and pat dry with kitchen paper, then gently flake into an ovenproof dish, discarding the skin and any bones.
03.Heat the remaining oil in a pan, stir in the flour and cook for 30 seconds. Gradually stir in 200-250ml of the reserved milk (discard the rest). Grate in nutmeg, season, then bubble until thick. Stir in the cream.
04.Preheat the oven to 190°C/fan170°C/gas 5. Grate the artichokes and add to the dish with the leek, prawns and herbs. Stir the lemon zest and juice into the sauce, then pour over. Mix gently with a wooden spoon.
05.Spoon the mash onto the fish mixture, then use a fork to make peaks, which will crisp and brown as it cooks. Sprinkle over the cheese, then bake for 35-40 minutes until golden and bubbling. Serve with wilted greens.', '/static/fotos/52802.jpg'),
(52803, 'Beef Wellington', 'Beef', 'British', 'Put the mushrooms into a food processor with some seasoning and pulse to a rough paste. Scrape the paste into a pan and cook over a high heat for about 10 mins, tossing frequently, to cook out the moisture from the mushrooms. Spread out on a plate to cool.
Heat in a frying pan and add a little olive oil. Season the beef and sear in the hot pan for 30 secs only on each side. (You don''t want to cook it at this stage, just colour it). Remove the beef from the pan and leave to cool, then brush all over with the mustard.
Lay a sheet of cling film on a work surface and arrange the Parma ham slices on it, in slightly overlapping rows. With a palette knife, spread the mushroom paste over the ham, then place the seared beef fillet in the middle. Keeping a tight hold of the cling film from the edge, neatly roll the Parma ham and mushrooms around the beef to form a tight barrel shape. Twist the ends of the cling film to secure. Chill for 15-20 mins to allow the beef to set and keep its shape.
Roll out the puff pastry on a floured surface to a large rectangle, the thickness of a £1 coin. Remove the cling film from the beef, then lay in the centre. Brush the surrounding pastry with egg yolk. Fold the ends over, the wrap the pastry around the beef, cutting off any excess. Turn over, so the seam is underneath, and place on a baking sheet. Brush over all the pastry with egg and chill for about 15 mins to let the pastry rest.
Heat the oven to 200C, 400F, gas 6.
Lightly score the pastry at 1cm intervals and glaze again with beaten egg yolk. Bake for 20 minutes, then lower the oven setting to 180C, 350F, gas 4 and cook for another 15 mins. Allow to rest for 10-15 mins before slicing and serving with the side dishes of your choice. The beef should still be pink in the centre when you serve it.', '/static/fotos/52803.jpg'),
(52804, 'Poutine', 'Miscellaneous', 'Canadian', 'Heat oil in a deep fryer or deep heavy skillet to 365°F (185°C).
Warm gravy in saucepan or microwave.
Place the fries into the hot oil, and cook until light brown, about 5 minutes.
Remove to a paper towel lined plate to drain.
Place the fries on a serving platter, and sprinkle the cheese over them.
Ladle gravy over the fries and cheese, and serve immediately.', '/static/fotos/52804.jpg'),
(52805, 'Lamb Biryani', 'Lamb', 'India', 'Grind the cashew, poppy seeds and cumin seeds into a smooth paste, using as little water as possible. Set aside. 

Deep fry the sliced onions when it is hot. Don’t overcrowd the oil. When the onions turn light brown, remove from oil and drain on paper towel. The fried onion will crisp up as it drains. Also fry the cashewnuts till golden brown. Set aside.

Wash the rice and soak in water for twenty minutes.
Meanwhile, take a big wide pan, add oil in medium heat, add the sliced onions, add the blended paste, to it add the green chillies, ginger garlic paste and garlic and fry for a minute.
Then add the tomatoes and sauté them well till they are cooked and not mushy.

Then to it add the red chilli powder, biryani powder, mint, coriander leaves and sauté them well.
Add the yogurt and mix well. I always move the skillet away from the heat when adding yogurt which prevents it from curdling.

Now after returning the skillet back to the stove, add the washed lamb and salt and ½ cup water and mix well. Cook for 1 hour and cook it covered in medium low heat or put it in a pressure cooker for 6 whistles. If the water is not drained totally, heat it by keeping it open.

Take another big pan, add thrice the cup of rice you use, and boil it. When it is boiling high, add the rice, salt and jeera and mix well. After 7 minutes exact or when the rice is 80% done. Switch off and drain the rice.

Now, the layering starts. To the lamb, pat and level it. Add the drained hot rice on the top of it. Garnish with fried onions, ghee, mint, coriander leaves and saffron dissolved in milk.

Cover the dish and bake in a 350f oven for 15 minutes or till the cooked but not mushy. Or cook in the stove medium heat for 12 minutes and lowest heat for 5 minutes. And switch off. Mix and serve hot!
Notes
1. If you are cooking in oven, do make sure to cook in a big oven safe pan and cover it tight and then keep in oven for the final step.
2. You can skip biryani masala if you don’t have and add just garam masala (1 tsp and red chilli powder – 3 tsp instead of 1 tsp)
3. If it is spicy in the end, squeeze some lemon, it will reduce the heat and enhance the flavors also.', '/static/fotos/52805.jpg'),
(52806, 'Tandoori chicken', 'Chicken', 'India', 'Mix the lemon juice with the paprika and red onions in a large shallow dish. Slash each chicken thigh three times, then turn them in the juice and set aside for 10 mins.
Mix all of the marinade ingredients together and pour over the chicken. Give everything a good mix, then cover and chill for at least 1 hr. This can be done up to a day in advance.
Heat the grill. Lift the chicken pieces onto a rack over a baking tray. Brush over a little oil and grill for 8 mins on each side or until lightly charred and completely cooked through.', '/static/fotos/52806.jpg'),
(52807, 'Baingan Bharta', 'Vegetarian', 'India', 'Rinse the baingan (eggplant or aubergine) in water. Pat dry with a kitchen napkin. Apply some oil all over and
keep it for roasting on an open flame. You can also grill the baingan or roast in the oven. But then you won''t get
the smoky flavor of the baingan. Keep the eggplant turning after a 2 to 3 minutes on the flame, so that its evenly
cooked. You could also embed some garlic cloves in the baingan and then roast it.
2. Roast the aubergine till its completely cooked and tender. With a knife check the doneness. The knife should slid
easily in aubergines without any resistance. Remove the baingan and immerse in a bowl of water till it cools
down.
3. You can also do the dhungar technique of infusing charcoal smoky flavor in the baingan. This is an optional step.
Use natural charcoal for this method. Heat a small piece of charcoal on flame till it becomes smoking hot and red.
4. Make small cuts on the baingan with a knife. Place the red hot charcoal in the same plate where the roasted
aubergine is kept. Add a few drops of oil on the charcoal. The charcoal would begin to smoke.
5. As soon as smoke begins to release from the charcoal, cover the entire plate tightly with a large bowl. Allow the
charcoal smoke to get infused for 1 to 2 minutes. The more you do, the more smoky the baingan bharta will
become. I just keep for a minute. Alternatively, you can also do this dhungar method once the baingan bharta is
cooked, just like the way we do for Dal Tadka.
6. Peel the skin from the roasted and smoked eggplant.
7. Chop the cooked eggplant finely or you can even mash it.
8. In a kadai or pan, heat oil. Then add finely chopped onions and garlic.
9. Saute the onions till translucent. Don''t brown them.
10. Add chopped green chilies and saute for a minute.
11. Add the chopped tomatoes and mix it well.
12. Bhuno (saute) the tomatoes till the oil starts separating from the mixture.
13. Now add the red chili powder. Stir and mix well.
14. Add the chopped cooked baingan.
15. Stir and mix the chopped baingan very well with the onion­tomato masala mixture.
16. Season with salt. Stir and saute for some more 4 to 5 minutes more.
17. Finally stir in the coriander leaves with the baingan bharta or garnish it with them. Serve Baingan Bharta with
phulkas, rotis or chapatis. It goes well even with bread, toasted or grilled bread and plain rice or jeera rice.', '/static/fotos/52807.jpg'),
(52808, 'Lamb Rogan josh', 'Lamb', 'India', '
Put the onions in a food processor and whizz until very finely chopped. Heat the oil in a large heavy-based pan, then fry the onion with the lid on, stirring every now and then, until it is really golden and soft. Add the garlic and ginger, then fry for 5 mins more.
Tip the curry paste, all the spices and the bay leaves into the pan, with the tomato purée. Stir well over the heat for about 30 secs, then add the meat and 300ml water. Stir to mix, turn down the heat, then add the yogurt.
Cover the pan, then gently simmer for 40-60 mins until the meat is tender and the sauce nice and thick. Serve scattered with coriander, with plain basmati or pilau rice.', '/static/fotos/52808.jpg'),
(52809, 'Recheado Masala Fish', 'Seafood', 'India', 'Soak all the spices, ginger, garlic, tamarind pulp and kashmiri chilies except oil in vinegar.
Add sugar and salt.
Also add turmeric powder.
Combine all nicely and marinate for 35-40 mins.
Grind the mixture until soft and smooth. Add more vinegar if required but ensure the paste has to be thick so add vinegar accordingly. If the masala paste is thin then it would not stick to the fish.
Rinse the fish slit from the center and give some incision from the top. You could see the fish below for clarity.
Now stuff the paste into the center and into the incision. Coat the entire fish with this paste. Marinate the fish for 30 mins.
Place oil in a shallow pan, once oil is quite hot shallow fry the stuffed mackerels.
Fry until golden brown from both sides
Serve the recheado mackerels hot with salad, lime wedges, rice and curry.
Notes
1. Ensure the masala paste is thick else the result won''t be good.
2. If you aren''t able to find kashmiri chilies then use bedgi chilies or kashmiri red chili powder.
3. You could use white vinegar or coconut vinegar.
4. Any left over paste could be stored in the fridge for future use.
5. Cinnamon could be avoided as it''s a strong spice used generally for meat or chicken.', '/static/fotos/52809.jpg'),
(52810, 'Osso Buco alla Milanese', 'Miscellaneous', 'Italian', 'Heat the oven to 300 degrees.
Dredging the shanks: pour the flour into a shallow dish (a pie plate works nicely). Season the veal shanks on all sides with salt and pepper. One at a time, roll the shanks around in the flour coat, and shake and pat the shank to remove any excuses flour. Discard the remaining flour.
Browning the shanks: put the oil and 1 tablespoon of the butter in a wide Dutch oven or heavy braising pot (6 to 7 quart) and heat over medium-high heat. When the butter has melted and the oil is shimmering, lower the shanks into the pot, flat side down; if the shanks won’t fit without touching one another, do this in batches. Brown the shanks, turning once with tongs, until both flat sides are well caramelized, about 5 minutes per side. If the butter-oil mixture starts to burn, lower the heat just a bit. Transfer the shanks to a large platter or tray and set aside.
The aromatics: pour off and discard the fat from the pot. Wipe out any burnt bits with a damp paper towel, being careful not to remove any delicious little caramelized bits. Ad the remaining 2 tablespoons butter to the pot and melt it over medium heat. When the butter has stopped foaming, add the onion, carrot, celery, and fennel. Season with salt and pepper, stir, and cook the vegetables until they begin to soften but do not brown, about 6 minutes. Stir in the garlic, orange zest, marjoram, and bay leaf, and stew for another minute or two.
The braising liquid: add the wine, increase the heat to high, and bring to a boil. Boil, stirring occasionally, to reduce the wine by about half, 5 minutes. Add the stock and tomatoes, with their juice, and boil again to reduce the liquid to about 1 cup total, about 10 minutes.
The braise: Place the shanks in the pot so that they are sitting with the exposed bone facing up, and pour over any juices that accumulated as they sat. Cover with parchment paper, pressing down so the parchment nearly touches the veal and the edges hang over the sides of the pot by about an inch. Cover tightly with the lid, and slide into the lower part of the oven to braise at a gentle simmer. Check the pot after the first 15 minutes, and if the liquid is simmering too aggressively, lower the oven heat by 10 or 15 degrees. Continue braising, turning the shanks and spooning some pan juices over the top after the first 40 minutes, until the meat is completely tender and pulling away from the bone, about 2 hours.
The gremolata: While the shanks are braising, stir together the garlic, parsley, and lemon zest in a small bowl. Cover with plastic wrap and set aside in a cool place (or the refrigerator, if your kitchen is very warm.)
The finish: When the veal is fork-tender and falling away from the bone, remove the lid and sprinkle over half of the gremolata. Return the veal to the oven, uncovered, for another 15 minutes to caramelize it some.
Using a slotted spatula or spoon, carefully lift the shanks from the braising liquid, doing your best to keep them intact. The shanks will be very tender and threatening to fall into pieces, and the marrow will be wobbly inside the bones, so this can be a bit tricky. But if they do break apart, don’t worry, the flavor won’t suffer at all. Arrange the shanks on a serving platter or other large plate, without stacking, and cover with foil to keep warm.
Finishing the sauce: Set the braising pot on top of the stove and evaluate the sauce: if there is a visible layer of fat floating on the surface, use a large spoon to skim it off and discard it. Taste the sauce for concentration of flavor. If it tastes a bit weak or flat, bring it to a boil over high heat, and boil to reduce the volume and intensify the flavor for 5 to 10 minutes. Taste again for salt and pepper. If the sauce wants more zip, stir in a teaspoon or two of the remaining gremolata.
Portioning the veal shanks: if the shanks are reasonably sized, serve one per person. If the shanks are gargantuan or you’re dealing with modest appetites, pull apart the larger shanks, separating them at their natural seams, and serve smaller amounts. Be sure to give the marrow bones to whomever prizes them most.
Serving: Arrange the veal shanks on warm dinner plates accompanied by the risotto, if serving. Just before carrying the plates to the table, sprinkle on the remaining gremolata and then spoon over a generous amount of sauce – the contact with the hot liquid will aromatize the gremolata and perk up everyone’s appetite with the whiff of garlic and lemon.', '/static/fotos/52810.jpg'),
(52811, 'Ribollita', 'Vegetarian', 'Italian', 'Put 2 tablespoons of the oil in a large pot over medium heat. When it’s hot, add onion, carrot, celery and garlic; sprinkle with salt and pepper and cook, stirring occasionally, until vegetables are soft, 5 to 10 minutes.
Heat the oven to 500 degrees. Drain the beans; if they’re canned, rinse them as well. Add them to the pot along with tomatoes and their juices and stock, rosemary and thyme. Bring to a boil, then reduce heat so the soup bubbles steadily; cover and cook, stirring once or twice to break up the tomatoes, until the flavors meld, 15 to 20 minutes.
Fish out and discard rosemary and thyme stems, if you like, and stir in kale. Taste and adjust seasoning. Lay bread slices on top of the stew so they cover the top and overlap as little as possible. Scatter red onion slices over the top, drizzle with the remaining 3 tablespoons oil and sprinkle with Parmesan.
Put the pot in the oven and bake until the bread, onions and cheese are browned and crisp, 10 to 15 minutes. (If your pot fits under the broiler, you can also brown the top there.) Divide the soup and bread among 4 bowls and serve.', '/static/fotos/52811.jpg'),
(52812, 'Beef Brisket Pot Roast', 'Beef', 'United States', '1 Prepare the brisket for cooking: On one side of the brisket there should be a layer of fat, which you want. If there are any large chunks of fat, cut them off and discard them. Large pieces of fat will not be able to render out completely.
Using a sharp knife, score the fat in parallel lines, about 3/4-inch apart. Slice through the fat, not the beef. Repeat in the opposite direction to make a cross-hatch pattern.
Salt the brisket well and let it sit at room temperature for 30 minutes.
 
2 Sear the brisket: You''ll need an oven-proof, thick-bottomed pot with a cover, or Dutch oven, that is just wide enough to hold the brisket roast with a little room for the onions.
Pat the brisket dry and place it, fatty side down, into the pot and place it on medium high heat. Cook for 5-8 minutes, lightly sizzling, until the fat side is nicely browned. (If the roast seems to be cooking too fast, turn the heat down to medium. You want a steady sizzle, not a raging sear.)
Turn the brisket over and cook for a few minutes more to brown the other side.

3 Sauté the onions and garlic: When the brisket has browned, remove it from the pot and set aside. There should be a couple tablespoons of fat rendered in the pot, if not, add some olive oil.
Add the chopped onions and increase the heat to high. Sprinkle a little salt on the onions. Sauté, stirring often, until the onions are lightly browned, 5-8 minutes. Stir in the garlic and cook 1-2 more minutes.
 
4 Return brisket to pot, add herbs, stock, bring to simmer, cover, cook in oven: Preheat the oven to 300°F. Use kitchen twine to tie together the bay leaves, rosemary and thyme.
Move the onions and garlic to the sides of the pot and nestle the brisket inside. Add the beef stock and the tied-up herbs. Bring the stock to a boil on the stovetop.
Cover the pot, place the pot in the 300°F oven and cook for 3 hours. Carefully flip the brisket every hour so it cooks evenly.
 
5 Add carrots, continue to cook: After 3 hours, add the carrots. Cover the pot and cook for 1 hour more, or until the carrots are cooked through and the brisket is falling-apart tender.
6 Remove brisket to cutting board, tent with foil: When the brisket is falling-apart tender, take the pot out of the oven and remove the brisket to a cutting board. Cover it with foil. Pull out and discard the herbs.
7 Make sauce (optional): At this point you have two options. You can serve as is, or you can make a sauce with the drippings and some of the onions. If you serve as is, skip this step.
To make a sauce, remove the carrots and half of the onions, set aside and cover them with foil. Pour the ingredients that are remaining into the pot into a blender, and purée until smooth. If you want, add 1 tablespoon of mustard to the mix. Put into a small pot and keep warm.
8 Slice the meat across the grain: Notice the lines of the muscle fibers of the roast. This is the "grain" of the meat. Slice the meat perpendicular to these lines, or across the grain (cutting this way further tenderizes the meat), in 1/4-inch to 1/2-inch slices.
Serve with the onions, carrots and gravy. Serve with mashed, roasted or boiled potatoes, egg noodles or polenta.', '/static/fotos/52812.jpg'),
(52813, 'Kentucky Fried Chicken', 'Chicken', 'United States', 'Preheat fryer to 350°F. Thoroughly mix together all the spice mix ingredients.
Combine spice mix with flour, brown sugar and salt.
Dip chicken pieces in egg white to lightly coat them, then transfer to flour mixture. Turn a few times and make sure the flour mix is really stuck to the chicken. Repeat with all the chicken pieces.
Let chicken pieces rest for 5 minutes so crust has a chance to dry a bit.
Fry chicken in batches. Breasts and wings should take 12-14 minutes, and legs and thighs will need a few more minutes. Chicken pieces are done when a meat thermometer inserted into the thickest part reads 165°F.
Let chicken drain on a few paper towels when it comes out of the fryer. Serve hot.', '/static/fotos/52813.jpg'),
(52814, 'Thai Green Curry', 'Chicken', 'Thai', 'Put the potatoes in a pan of boiling water and cook for 5 minutes. Throw in the beans and cook for a further 3 minutes, by which time both should be just tender but not too soft. Drain and put to one side.
In a wok or large frying pan, heat the oil until very hot, then drop in the garlic and cook until golden, this should take only a few seconds. Don’t let it go very dark or it will spoil the taste. Spoon in the curry paste and stir it around for a few seconds to begin to cook the spices and release all the flavours. Next, pour in the coconut milk and let it come to a bubble.
Stir in the fish sauce and sugar, then the pieces of chicken. Turn the heat down to a simmer and cook, covered, for about 8 minutes until the chicken is cooked.
Tip in the potatoes and beans and let them warm through in the hot coconut milk, then add a lovely citrussy flavour by stirring in the shredded lime leaves (or lime zest). The basil leaves go in next, but only leave them briefly on the heat or they will quickly lose their brightness. Scatter with the lime garnish and serve immediately with boiled rice.', '/static/fotos/52814.jpg'),
(52815, 'French Lentils With Garlic and Thyme', 'Miscellaneous', 'France', 'Place a large saucepan over medium heat and add oil. When hot, add chopped vegetables and sauté until softened, 5 to 10 minutes.
Add 6 cups water, lentils, thyme, bay leaves and salt. Bring to a boil, then reduce to a fast simmer.
Simmer lentils until they are tender and have absorbed most of the water, 20 to 25 minutes. If necessary, drain any excess water after lentils have cooked. Serve immediately, or allow them to cool and reheat later.
For a fuller taste, use some chicken stock and reduce the water by the same amount.', '/static/fotos/52815.jpg'),
(52816, 'Roasted Eggplant With Tahini, Pine Nuts, and Lentils', 'Vegetarian', 'United States', '
For the Lentils: Adjust oven rack to center position and preheat oven to 450°F to prepare for roasting eggplant. Meanwhile, heat 2 tablespoons olive oil in a medium saucepan over medium heat until shimmering. Add carrots, celery, and onion and cook, stirring, until softened but not browned, about 4 minutes. Add garlic and cook, stirring, until fragrant, about 30 seconds. Add lentils, bay leaves, stock or water, and a pinch of salt. Bring to a simmer, cover with the lid partially ajar, and cook until lentils are tender, about 30 minutes. (Top up with water if lentils are at any point not fully submerged.) Remove lid, stir in vinegar, and reduce until lentils are moist but not soupy. Season to taste with salt and pepper, cover, and keep warm until ready to serve.

2.
For the Eggplant: While lentils cook, cut each eggplant in half. Score flesh with the tip of a paring knife in a cross-hatch pattern at 1-inch intervals. Transfer to a foil-lined rimmed baking sheet, cut side up, and brush each eggplant half with 1 tablespoon oil, letting each brushstroke be fully absorbed before brushing with more. Season with salt and pepper. Place a rosemary sprig on top of each one. Transfer to oven and roast until completely tender and well charred, 25 to 35 minutes. Remove from oven and discard rosemary.

3.
To Serve: Heat 2 tablespoons olive oil and pine nuts in a medium skillet set over medium heat. Cook, tossing nuts frequently, until golden brown and aromatic, about 4 minutes. Transfer to a bowl to halt cooking. Stir half of parsley and rosemary into lentils and transfer to a serving platter. Arrange eggplant halves on top. Spread a few tablespoons of tahini sauce over each eggplant half and sprinkle with pine nuts. Sprinkle with remaining parsley and rosemary, drizzle with additional olive oil, and serve.', '/static/fotos/52816.jpg'),
(52817, 'Stovetop Eggplant With Harissa, Chickpeas, and Cumin Yogurt', 'Vegetarian', 'United States', 'Heat the oil in a 12-inch skillet over high heat until shimmering. Add the eggplants and lower the heat to medium. Season with salt and pepper as you rotate the eggplants, browning them on all sides. Continue to cook, turning regularly, until a fork inserted into the eggplant meets no resistance (you may have to stand them up on their fat end to finish cooking the thickest parts), about 20 minutes, lowering the heat and sprinkling water into the pan as necessary if the eggplants threaten to burn or smoke excessively.

2.
Mix the harissa, chickpeas and tomatoes together, then add to the eggplants. Cook until the tomatoes have blistered and broken down, about 5 minutes more. Season with salt and pepper and add water as necessary to thin to a saucy consistency. Meanwhile, combine the yogurt and cumin in a serving bowl. Season with salt and pepper.

3.
Top the eggplant mixture with the parsley, drizzle with more extra virgin olive oil, and serve with the yogurt on the side.', '/static/fotos/52817.jpg'),
(52818, 'Chicken Fajita Mac and Cheese', 'Chicken', 'United States', 'Fry your onion, peppers and garlic in olive oil until nicely translucent. Make a well in your veg and add your chicken. Add your seasoning and salt. Allow to colour slightly.
Add your cream, stock and macaroni.
Cook on low for 20 minutes. Add your cheeses, stir to combine.
Top with roasted peppers and parsley.', '/static/fotos/52818.jpg'),
(52819, 'Cajun spiced fish tacos', 'Seafood', 'Mexican', 'Cooking in a cajun spice and cayenne pepper marinade makes this fish super succulent and flavoursome. Top with a zesty dressing and serve in a tortilla for a quick, fuss-free main that''s delightfully summery.

On a large plate, mix the cajun spice and cayenne pepper with a little seasoning and use to coat the fish all over.

Heat a little oil in a frying pan, add in the fish and cook over a medium heat until golden. Reduce the heat and continue frying until the fish is cooked through, about 10 minutes. Cook in batches if you don’t have enough room in the pan.

Meanwhile, prepare the dressing by combining all the ingredients with a little seasoning.
Soften the tortillas by heating in the microwave for 5-10 seconds. Pile high with the avocado, lettuce and spring onion, add a spoonful of salsa, top with large flakes of fish and drizzle over the dressing.', '/static/fotos/52819.jpg'),
(52820, 'Katsu Chicken curry', 'Chicken', 'Japanese', 'Prep:15min  ›  Cook:30min  ›  Ready in:45min 

For the curry sauce: Heat oil in medium non-stick saucepan, add onion and garlic and cook until softened. Stir in carrots and cook over low heat for 10 to 12 minutes.
Add flour and curry powder; cook for 1 minute. Gradually stir in stock until combined; add honey, soy sauce and bay leaf. Slowly bring to the boil.
Turn down heat and simmer for 20 minutes or until sauce thickens but is still of pouring consistency. Stir in garam masala. Pour the curry sauce through a sieve; return to saucepan and keep on low heat until ready to serve.
For the chicken: Season both sides of chicken breasts with salt and pepper. Place flour, egg and breadcrumbs in separate bowls and arrange in a row. Coat the chicken breasts in flour, then dip them into the egg, then coat in breadcrumbs, making sure you cover both sides.
Heat oil in large frying pan over medium-high heat. Place chicken into hot oil and cook until golden brown, about 3 or 4 minutes each side. Once cooked, place on kitchen paper to absorb excess oil.
Pour curry sauce over chicken, serve with white rice and enjoy!', '/static/fotos/52820.jpg'),
(52821, 'Laksa King Prawn Noodles', 'Seafood', 'Malaysian', 'Heat the oil in a medium saucepan and add the chilli. Cook for 1 min, then add the curry paste, stir and cook for 1 min more. Dissolve the stock cube in a large jug in 700ml boiling water, then pour into the pan and stir to combine. Tip in the coconut milk and bring to the boil.
Add the fish sauce and a little seasoning. Toss in the noodles and cook for a further 3-4 mins until softening. Squeeze in the lime juice, add the prawns and cook through until warm, about 2-3 mins. Scatter over some of the coriander.
Serve in bowls with the remaining coriander and lime wedges on top for squeezing over.', '/static/fotos/52821.jpg'),
(52822, 'Toad In The Hole', 'Pork', 'British', 'Preheat the oven to 200°C/fan180°C/gas 6. fry sausages in a non-stick pan until browned.
Drizzle vegetable oil in a 30cm x 25cm x 6cm deep roasting tray and heat in the oven for 5 minutes.
Put the plain flour in a bowl, crack in the medium free-range eggs, then stir in the grated horseradish. Gradually beat in the semi-skimmed milk. Season.
Put the sausages into the hot roasting tray and pour over the batter. Top with cherry tomatoes on the vine and cook for 30 minutes until puffed and golden.', '/static/fotos/52822.jpg'),
(52823, 'Salmon Prawn Risotto', 'Seafood', 'Italian', 'Melt the butter in a thick-based pan and gently cook the onion without colour until it is soft.
Add the rice and stir to coat all the grains in the butter
Add the wine and cook gently stirring until it is absorbed
Gradually add the hot stock, stirring until each addition is absorbed. Keep stirring until the rice is tender
Season with the lemon juice and zest, and pepper to taste. (there will probably be sufficient saltiness from the salmon to not need to add salt) Stir gently to heat through
Serve scattered with the Parmesan and seasonal vegetables.
Grill the salmon and gently place onto the risotto with the prawns and asparagus', '/static/fotos/52823.jpg'),
(52824, 'Beef Sunday Roast', 'Beef', 'British', 'Cook the Broccoli and Carrots in a pan of boiling water until tender.

Roast the Beef and Potatoes in the oven for 45mins, the potatoes may need to be checked regularly to not overcook.

To make the Yorkshire puddings:
Heat oven to 230C/fan 210C/gas 8. Drizzle a little sunflower oil evenly into 2 x 4-hole Yorkshire pudding tins or a 12-hole non-stick muffin tin and place in the oven to heat through
To make the batter, tip 140g plain flour into a bowl and beat in four eggs until smooth. Gradually add 200ml milk and carry on beating until the mix is completely lump-free. Season with salt and pepper. Pour the batter into a jug, then remove the hot tins from the oven. Carefully and evenly pour the batter into the holes. Place the tins back in the oven and leave undisturbed for 20-25 mins until the puddings have puffed up and browned. Serve immediately.

Plate up and add the Gravy as desired.', '/static/fotos/52824.jpg'),
(52826, 'Braised Beef Chilli', 'Beef', 'Mexican', 'Preheat the oven to 120C/225F/gas mark 1.

Take the meat out of the fridge to de-chill. Pulse the onions and garlic in a food processor until finely chopped. Heat 2 tbsp olive oil in a large casserole and sear the meat on all sides until golden.

Set to one side and add another small slug of oil to brown the chorizo. Remove and add the onion and garlic, spices, herbs and chillies then cook until soft in the chorizo oil. Season with salt and pepper and add the vinegar, tomatoes, ketchup and sugar.

Put all the meat back into the pot with 400ml water (or red wine if you prefer), bring up to a simmer and cook, covered, in the low oven.

After 2 hours, check the meat and add the beans. Cook for a further hour and just before serving, pull the meat apart with a pair of forks.', '/static/fotos/52826.jpg'),
(52827, 'Massaman Beef curry', 'Beef', 'Thai', 'Heat oven to 200C/180C fan/gas 6, then roast the peanuts on a baking tray for 5 mins until golden brown. When cool enough to handle, roughly chop. Reduce oven to 180C/160C fan/gas 4.
Heat 2 tbsp coconut cream in a large casserole dish with a lid. Add the curry paste and fry for 1 min, then stir in the beef and fry until well coated and sealed. Stir in the rest of the coconut with half a can of water, the potatoes, onion, lime leaves, cinnamon, tamarind, sugar, fish sauce and most of the peanuts. Bring to a simmer, then cover and cook for 2 hrs in the oven until the beef is tender.
Sprinkle with sliced chilli and the remaining peanuts, then serve straight from the dish with jasmine rice.', '/static/fotos/52827.jpg'),
(52828, 'Vietnamese Grilled Pork (bun-thit-nuong)', 'Pork', 'Vietnamese', 'Slice the uncooked pork thinly, about ⅛". It helps to slightly freeze it (optional).
Mince garlic and shallots. Mix in a bowl with sugar, fish sauce, thick soy sauce, pepper, and oil until sugar dissolves.
Marinate the meat for 1 hour, or overnight for better results.
Bake the pork at 375F for 10-15 minutes or until about 80% cooked. Finish cooking by broiling in the oven until a nice golden brown color develops, flipping the pieces midway.
Assemble your bowl with veggies, noodles, and garnish. Many like to mix the whole bowl up and pour the fish sauce on top, but I like to make individual bites and sauce it slowly.', '/static/fotos/52828.jpg'),
(52829, 'Grilled Mac and Cheese Sandwich', 'Pasta', 'United States', 'Make the mac and cheese

1. Bring a medium saucepan of generously salted water (you want it to taste like seawater) to a boil. Add the pasta and cook, stirring occasionally, until al dente, 8 to 10 minutes, or according to the package directions. The pasta should be tender but still chewy.
2. While the pasta is cooking, in a small bowl, whisk together the flour, mustard powder, garlic powder, salt, black pepper, and cayenne pepper.
3. Drain the pasta in a colander. Place the empty pasta pan (no need to wash it) over low heat and add the butter. When the butter has melted, whisk in the flour mixture and continue to cook, whisking frequently, until the mixture is beginning to brown and has a pleasant, nutty aroma, about 1 minute. Watch carefully so it does not scorch on the bottom of the pan.
4. Slowly whisk the milk and cream into the flour mixture until everything is really well combined. Cook, whisking constantly, until the sauce is heated through and just begins to thicken, about 2 minutes. Remove from the heat. Gradually add the cheese while stirring constantly with a wooden spoon or silicone spatula and keep stirring until the cheese has melted into the sauce. Then stir in the drained cooked pasta.
5. Line a 9-by-13-inch (23-by-33-centimeter) rimmed baking sheet with parchment paper or aluminum foil. Coat the paper or foil with nonstick cooking spray or slick it with butter. Pour the warm mac and cheese onto the prepared baking sheet and spread it evenly with a spatula. Coat another piece of parchment paper with cooking spray or butter and place it, oiled or buttered side down, directly on the surface of the mac and cheese. Refrigerate until cool and firm, about 1 hour.

Make the grilled cheese
6. Heat a large cast-iron or nonstick skillet over medium-low heat.
7. In a small bowl, stir together the 4 tablespoons (55 grams) butter and garlic powder until well blended.
8. Remove the mac and cheese from the refrigerator and peel off the top layer of parchment paper. Carefully cut into 8 equal pieces. Each piece will make 1 grilled mac and cheese sandwich. (You can stash each individual portion in a double layer of resealable plastic bags and refrigerate for up to 3 days or freeze it for up to 1 month.)
9. Spread 3/4 teaspoon garlic butter on one side of each bread slice. Place half of the slices, buttered-side down, on a clean cutting board. Top each with one slice of Cheddar, then 1 piece of the mac and cheese. (Transfer from the baking sheet by scooting your hand or a spatula under each piece of mac and cheese and then flipping it over onto a sandwich.) Place 1 slice of Jack on top of each. Finish with the remaining bread slices, buttered-side up.
10. Using a wide spatula, place as many sandwiches in the pan as will fit without crowding it. Cover and cook until the bottoms are nicely browned, about 4 minutes. Turn and cook until the second sides are browned, the cheese is melted, and the mac and cheese is heated through, about 4 minutes more.
11. Repeat with the remaining ingredients. Cut the sandwiches in half, if desired, and serve.', '/static/fotos/52829.jpg'),
(52830, 'Crock Pot Chicken Baked Tacos', 'Chicken', 'Mexican', 'Put the uncooked chicken breasts in the crock pot. Pour the full bottle of salad dressing over the chicken. Sprinkle the rest of the ingredients over the top and mix them in a bit with a spoon.
Cover your crock pot with the lid and cook on high for 4 hours.
Remove all the chicken breasts from the crock pot and let cool.
Shred the chicken breasts and move to a glass bowl.
Pour most of the liquid over the shredded chicken.
FOR THE TACOS:
Make the guacamole sauce by mixing the avocado and green salsa together. Pour the guacamole mixture through a strainer until smooth and transfer to a squeeze bottle. Cut the tip off the lid of the squeeze bottle to make the opening more wide if needed.
Make the sour cream sauce by mixing the sour cream and milk together until you get a more liquid sour cream sauce. Transfer to a squeeze bottle.
In a 9x 13 glass baking dish, fill all 12+ tacos with a layer of refried beans, cooked chicken and shredded cheese.
Bake at 450 for 10-15 minutes just until the cheese is melted and bubbling.
Out of the oven top all the tacos with the sliced grape tomaotes, jalapeno and cilantro.
Finish with a drizzle of guacamole and sour cream.
Enjoy!', '/static/fotos/52830.jpg'),
(52831, 'Chicken Karaage', 'Chicken', 'Japanese', 'Add the ginger, garlic, soy sauce, sake and sugar to a bowl and whisk to combine. Add the chicken, then stir to coat evenly. Cover and refrigerate for at least 1 hour.

Add 1 inch of vegetable oil to a heavy bottomed pot and heat until the oil reaches 360 degrees F. Line a wire rack with 2 sheets of paper towels and get your tongs out. Put the potato starch in a bowl

Add a handful of chicken to the potato starch and toss to coat each piece evenly.

Fry the karaage in batches until the exterior is a medium brown and the chicken is cooked through. Transfer the fried chicken to the paper towel lined rack. If you want the karaage to stay crispy longer, you can fry the chicken a second time, until it''s a darker color after it''s cooled off once. Serve with lemon wedges.', '/static/fotos/52831.jpg'),
(52832, 'Coq au vin', 'Chicken', 'France', 'Heat 1 tbsp of the oil in a large, heavy-based saucepan or flameproof dish. Tip in the bacon and fry until crisp. Remove and drain on kitchen paper. Add the shallots to the pan and fry, stirring or shaking the pan often, for 5-8 mins until well browned all over. Remove and set aside with the bacon.
Pat the chicken pieces dry with kitchen paper. Pour the remaining oil into the pan, then fry half the chicken pieces, turning regularly, for 5-8 mins until well browned. Remove, then repeat with the remaining chicken. Remove and set aside.
Scatter in the garlic and fry briefly, then, with the heat medium-high, pour in the brandy or Cognac, stirring the bottom of the pan to deglaze. The alcohol should sizzle and start to evaporate so there is not much left.
Return the chicken legs and thighs to the pan along with any juices, then pour in a little of the wine, stirring the bottom of the pan again. Stir in the rest of the wine, the stock and tomato purée, drop in the bouquet garni, season with pepper and a pinch of salt, then return the bacon and shallots to the pan. Cover, lower the heat to a gentle simmer, add the chicken breasts and cook for 50 mins-1hr.
Just before ready to serve, heat the oil for the mushrooms in a large non-stick frying pan. Add the mushrooms and fry over a high heat for a few mins until golden. Remove and keep warm.
Lift the chicken, shallots and bacon from the pan and transfer to a warmed serving dish. Remove the bouquet garni. To make the thickener, mix the flour, olive oil and butter in a small bowl using the back of a teaspoon. Bring the wine mixture to a gentle boil, then gradually drop in small pieces of the thickener, whisking each piece in using a wire whisk. Simmer for 1-2 mins. Scatter the mushrooms over the chicken, then pour over the wine sauce. Garnish with chopped parsley.', '/static/fotos/52832.jpg'),
(52833, 'Salted Caramel Cheescake', 'Dessert', 'United States', '1) Blitz the biscuits and the pretzels in a food processor and mix the biscuits with the melted butter. Spread on the bottom of an 8″/20cm Deep Springform Tin and press down firmly. Leave to set in the fridge whilst you make the rest!

2) Using an electric mixer, I use my KitchenAid with the whisk attachment, whisk together the cream cheese, vanilla, and icing sugar until smooth and then add the caramel and whisk again until smooth and lump free – this could take a couple of minutes, I whisk it at half speed so not too quick or slow!

3) Pour in the double cream & Salt flakes and continue to whisk for a couple of minutes until its very thick and mousse like (I mix it on a medium speed, level 6/10) – Now this could take up to 5 minutes depending on your mixer, but you seriously have to stick at it – it will hold itself completely when finished mixing (like a meringue does!) If you don’t mix it enough it will not set well enough, but don’t get impatient and whisk it really quick because that’ll make it split! Spread over the biscuit base and leave to set in the fridge overnight.

4) Remove the Cheesecake from the tin carefully and decorate the cheesecake – I drizzled over some of the spare caramel, and then some Toffee Popcorn and more Pretzels!', '/static/fotos/52833.jpg'),
(52834, 'Beef stroganoff', 'Beef', 'Russian', 'Heat the olive oil in a non-stick frying pan then add the sliced onion and cook on a medium heat until completely softened, so around 15 mins, adding a little splash of water if they start to stick at all. Crush in the garlic and cook for a 2-3 mins further, then add the butter. Once the butter is foaming a little, add the mushrooms and cook for around 5 mins until completely softened. Season everything well, then tip onto a plate.
Tip the flour into a bowl with a big pinch of salt and pepper, then toss the steak in the seasoned flour. Add the steak pieces to the pan, splashing in a little oil if the pan looks particularly dry, and fry for 3-4 mins, until well coloured. Tip the onions and mushrooms back into the pan. Whisk the crème fraîche, mustard and beef stock together, then pour into the pan. Cook over a medium heat for around 5 mins. Scatter with parsley, then serve with pappardelle or rice.', '/static/fotos/52834.jpg'),
(52835, 'Fettucine alfredo', 'Pasta', 'Italian', 'In a medium saucepan, stir the clotted cream, butter and cornflour over a low-ish heat and bring to a low simmer. Turn off the heat and keep warm.
Meanwhile, put the cheese and nutmeg in a small bowl and add a good grinding of black pepper, then stir everything together (don’t add any salt at this stage).
Put the pasta in another pan with 2 tsp salt, pour over some boiling water and cook following pack instructions (usually 3-4 mins). When cooked, scoop some of the cooking water into a heatproof jug or mug and drain the pasta, but not too thoroughly.
Add the pasta to the pan with the clotted cream mixture, then sprinkle over the cheese and gently fold everything together over a low heat using a rubber spatula. When combined, splash in 3 tbsp of the cooking water. At first, the pasta will look wet and sloppy: keep stirring until the water is absorbed and the sauce is glossy. Check the seasoning before transferring to heated bowls. Sprinkle over some chives or parsley, then serve immediately.', '/static/fotos/52835.jpg'),
(52836, 'Seafood fideuà', 'Seafood', 'Spanish', 'Boil the kettle. Empty the mussels into a colander and run under cold water. Throw away any with broken shells. Pick through the shells, tapping each one on the side of the sink – they should be closed or should slowly close when tapped – if they stay open, throw them away. If any of the shells still have barnacles or stringy beards attached, pull them off with a cutlery knife and rinse the shells well. Keep in the colander, covered with a cold, damp cloth, until you’re ready to cook. Peel the prawn shells on the body section only – leave the heads and tails intact. Score down the backs and pull out any gritty entrails. Chill until you’re ready to cook.
Put the saffron in a small cup, cover with 50ml kettle-hot water and set aside for 10 mins. If using vermicelli, put in a bowl and crush to little pieces (about 1cm long) with your hands.
Heat the oil in a large frying pan with at least a 3cm lip, or a 40cm paella pan. Add the onion and stir around the pan for 5 mins until soft. Add the garlic and cook for 1 min more, then tip in the vermicelli and cook for 5 mins, stirring from time to time, until the vermicelli is toasted brown. Stir in the paprika.
Keeping the heat moderate, stir through the monkfish, squid and saffron with its water, seasoning well. Spread the ingredients out in an even layer, then pour over the hot stock and scatter the tomatoes on top. Bring to a simmer, then cover the whole dish with a tight-fitting lid (or foil). Turn the heat to medium and cook for 6 mins.
Uncover and stir to incorporate the dry top layer of pasta. Push the mussels into the pasta so the hinges are buried in the bottom of the dish, and they stand straight up. Arrange the prawns on top, cover tightly and cook for another 6 mins or until the mussels are open, the prawns are pink and the pasta is cooked through. Leave to simmer for another 2-3 mins to cook off most of the remaining liquid (leave a little in the pan to prevent the pasta from sticking together). Allow to sit for 2-3 mins, then squeeze over the lemon juice and arrange the wedges on top. Scatter with parsley before serving.', '/static/fotos/52836.jpg'),
(52837, 'Pilchard puttanesca', 'Pasta', 'Italian', 'Cook the pasta following pack instructions. Heat the oil in a non-stick frying pan and cook the onion, garlic and chilli for 3-4 mins to soften. Stir in the tomato purée and cook for 1 min, then add the pilchards with their sauce. Cook, breaking up the fish with a wooden spoon, then add the olives and continue to cook for a few more mins.

Drain the pasta and add to the pan with 2-3 tbsp of the cooking water. Toss everything together well, then divide between plates and serve, scattered with Parmesan.', '/static/fotos/52837.jpg'),
(52838, 'Venetian Duck Ragu', 'Pasta', 'Italian', 'Heat the oil in a large pan. Add the duck legs and brown on all sides for about 10 mins. Remove to a plate and set aside. Add the onions to the pan and cook for 5 mins until softened. Add the garlic and cook for a further 1 min, then stir in the cinnamon and flour and cook for a further min. Return the duck to the pan, add the wine, tomatoes, stock, herbs, sugar and seasoning. Bring to a simmer, then lower the heat, cover with a lid and cook for 2 hrs, stirring every now and then.
Carefully lift the duck legs out of the sauce and place on a plate – they will be very tender so try not to lose any of the meat. Pull off and discard the fat, then shred the meat with 2 forks and discard the bones. Add the meat back to the sauce with the milk and simmer, uncovered, for a further 10-15 mins while you cook the pasta.
Cook the pasta following pack instructions, then drain, reserving a cup of the pasta water, and add the pasta to the ragu. Stir to coat all the pasta in the sauce and cook for 1 min more, adding a splash of cooking liquid if it looks dry. Serve with grated Parmesan, if you like.', '/static/fotos/52838.jpg'),
(52839, 'Chilli prawn linguine', 'Pasta', 'Italian', 'Mix the dressing ingredients in a small bowl and season with salt and pepper. Set aside.

Cook the pasta according to the packet instructions. Add the sugar snap peas for the last minute or so of cooking time.

Meanwhile, heat the oil in a wok or large frying pan, toss in the garlic and chilli and cook over a fairly gentle heat for about 30 seconds without letting the garlic brown. Tip in the prawns and cook over a high heat, stirring frequently, for about 3 minutes until they turn pink.

Add the tomatoes and cook, stirring occasionally, for 3 minutes until they just start to soften. Drain the pasta and sugar snaps well, then toss into the prawn mixture. Tear in the basil leaves, stir, and season with salt and pepper.

Serve with salad leaves drizzled with the lime dressing, and warm crusty bread.', '/static/fotos/52839.jpg'),
(52840, 'Clam chowder', 'Starter', 'United States', 'Rinse the clams in several changes of cold water and drain well. Tip the clams into a large pan with 500ml of water. Cover, bring to the boil and simmer for 2 mins until the clams have just opened. Tip the contents of the pan into a colander over a bowl to catch the clam stock. When cool enough to handle, remove the clams from their shells – reserving a handful of empty shells for presentation if you want. Strain the clam stock into a jug, leaving any grit in the bottom of the bowl. You should have around 800ml stock.
Heat the butter in the same pan and sizzle the bacon for 3-4 mins until it starts to brown. Stir in the onion, thyme and bay and cook everything gently for 10 mins until the onion is soft and golden. Scatter over the flour and stir in to make a sandy paste, cook for 2 mins more, then gradually stir in the clam stock then the milk and the cream.
Throw in the potatoes, bring everything to a simmer and leave to bubble away gently for 10 mins or until the potatoes are cooked. Use a fork to crush a few of the potato chunks against the side of the pan to help thicken – you still want lots of defined chunks though. Stir through the clam meat and the few clam shells, if you''ve gone down that route, and simmer for a minute to reheat. Season with plenty of black pepper and a little salt, if needed, then stir through the parsley just before ladling into bowls or hollowed-out crusty rolls.', '/static/fotos/52840.jpg'),
(52841, 'Creamy Tomato Soup', 'Starter', 'British', 'Put the oil, onions, celery, carrots, potatoes and bay leaves in a big casserole dish, or two saucepans. Fry gently until the onions are softened – about 10-15 mins. Fill the kettle and boil it.
Stir in the tomato purée, sugar, vinegar, chopped tomatoes and passata, then crumble in the stock cubes. Add 1 litre boiling water and bring to a simmer. Cover and simmer for 15 mins until the potato is tender, then remove the bay leaves. Purée with a stick blender (or ladle into a blender in batches) until very smooth. Season to taste and add a pinch more sugar if it needs it. The soup can now be cooled and chilled for up to 2 days, or frozen for up to 3 months.
To serve, reheat the soup, stirring in the milk – try not to let it boil. Serve in small bowls with cheesy sausage rolls.', '/static/fotos/52841.jpg'),
(52842, 'Broccoli & Stilton soup', 'Starter', 'British', 'Heat the rapeseed oil in a large saucepan and then add the onions. Cook on a medium heat until soft. Add a splash of water if the onions start to catch.

Add the celery, leek, potato and a knob of butter. Stir until melted, then cover with a lid. Allow to sweat for 5 minutes. Remove the lid.

Pour in the stock and add any chunky bits of broccoli stalk. Cook for 10 – 15 minutes until all the vegetables are soft.

Add the rest of the broccoli and cook for a further 5 minutes. Carefully transfer to a blender and blitz until smooth. Stir in the stilton, allowing a few lumps to remain. Season with black pepper and serve.', '/static/fotos/52842.jpg'),
(52843, 'Lamb Tagine', 'Lamb', 'Moroccan', 'Heat the olive oil in a heavy-based pan and add the onion and carrot. Cook for 3- 4 mins until softened.

Add the diced lamb and brown all over. Stir in the garlic and all the spices and cook for a few mins more or until the aromas are released.

Add the honey and apricots, crumble in the stock cube and pour over roughly 500ml boiling water or enough to cover the meat. Give it a good stir and bring to the boil. Turn down to a simmer, put the lid on and cook for 1 hour.

Remove the lid and cook for a further 30 mins, then stir in the squash. Cook for 20 – 30 mins more until the squash is soft and the lamb is tender. Serve alongside rice or couscous and sprinkle with parsley and pine nuts, if using.', '/static/fotos/52843.jpg'),
(52844, 'Lasagne', 'Pasta', 'Italian', 'Heat the oil in a large saucepan. Use kitchen scissors to snip the bacon into small pieces, or use a sharp knife to chop it on a chopping board. Add the bacon to the pan and cook for just a few mins until starting to turn golden. Add the onion, celery and carrot, and cook over a medium heat for 5 mins, stirring occasionally, until softened.
Add the garlic and cook for 1 min, then tip in the mince and cook, stirring and breaking it up with a wooden spoon, for about 6 mins until browned all over.
Stir in the tomato purée and cook for 1 min, mixing in well with the beef and vegetables. Tip in the chopped tomatoes. Fill each can half full with water to rinse out any tomatoes left in the can, and add to the pan. Add the honey and season to taste. Simmer for 20 mins.
Heat oven to 200C/180C fan/gas 6. To assemble the lasagne, ladle a little of the ragu sauce into the bottom of the roasting tin or casserole dish, spreading the sauce all over the base. Place 2 sheets of lasagne on top of the sauce overlapping to make it fit, then repeat with more sauce and another layer of pasta. Repeat with a further 2 layers of sauce and pasta, finishing with a layer of pasta.
Put the crème fraîche in a bowl and mix with 2 tbsp water to loosen it and make a smooth pourable sauce. Pour this over the top of the pasta, then top with the mozzarella. Sprinkle Parmesan over the top and bake for 25–30 mins until golden and bubbling. Serve scattered with basil, if you like.', '/static/fotos/52844.jpg'),
(52845, 'Turkey Meatloaf', 'Miscellaneous', 'British', 'Heat oven to 180C/160C fan/gas 4. Heat the oil in a large frying pan and cook the onion for 8-10 mins until softened. Add the garlic, Worcestershire sauce and 2 tsp tomato purée, and stir until combined. Set aside to cool.

Put the turkey mince, egg, breadcrumbs and cooled onion mix in a large bowl and season well. Mix everything to combine, then shape into a rectangular loaf and place in a large roasting tin. Spread 2 tbsp barbecue sauce over the meatloaf and bake for 30 mins.

Meanwhile, drain 1 can of beans only, then pour both cans into a large bowl. Add the remaining barbecue sauce and tomato purée. Season and set aside.

When the meatloaf has had its initial cooking time, scatter the beans around the outside and bake for 15 mins more until the meatloaf is cooked through and the beans are piping hot. Scatter over the parsley and serve the meatloaf in slices.', '/static/fotos/52845.jpg'),
(52846, 'Chicken & mushroom Hotpot', 'Chicken', 'British', 'Heat oven to 200C/180C fan/gas 6. Put the butter in a medium-size saucepan and place over a medium heat. Add the onion and leave to cook for 5 mins, stirring occasionally. Add the mushrooms to the saucepan with the onions.

Once the onion and mushrooms are almost cooked, stir in the flour – this will make a thick paste called a roux. If you are using a stock cube, crumble the cube into the roux now and stir well. Put the roux over a low heat and stir continuously for 2 mins – this will cook the flour and stop the sauce from having a floury taste.

Take the roux off the heat. Slowly add the fresh stock, if using, or pour in 500ml water if you’ve used a stock cube, stirring all the time. Once all the liquid has been added, season with pepper, a pinch of nutmeg and mustard powder. Put the saucepan back onto a medium heat and slowly bring it to the boil, stirring all the time. Once the sauce has thickened, place on a very low heat. Add the cooked chicken and vegetables to the sauce and stir well. Grease a medium-size ovenproof pie dish with a little butter and pour in the chicken and mushroom filling.

Carefully lay the potatoes on top of the hot-pot filling, overlapping them slightly, almost like a pie top.

Brush the potatoes with a little melted butter and cook in the oven for about 35 mins. The hot-pot is ready once the potatoes are cooked and golden brown.', '/static/fotos/52846.jpg'),
(52847, 'Pork Cassoulet', 'Pork', 'France', 'Heat oven to 140C/120C fan/gas 1. Put a large ovenproof pan (with a tight-fitting lid) on a high heat. Add your fat and diced meat, cook for a few mins to seal the edges, giving it a quick stir to cook evenly. Reduce the heat to low, add the sliced onion, whole garlic cloves, carrot and fennel seeds, and cook gently to soften the veg for a few mins.
Pour over the red wine vinegar, scraping any meaty bits off the bottom of the pan. Add the stock, tomato purée, and half the rosemary and parsley. Bring to the boil and simmer for 10 mins, then season, cover with a lid and put into the oven for 2 hrs, removing the lid for the final hour of cooking. Stir occasionally and add the beans with 30 mins to go.
Remove the pan from the oven and heat the grill. Scatter the top with the remaining herbs and breadcrumbs, drizzle a little oil over the top, and return to the oven for 5-10 mins, until the breadcrumbs are golden. Serve with crusty bread and green veg.', '/static/fotos/52847.jpg'),
(52848, 'Bean & Sausage Hotpot', 'Miscellaneous', 'British', 'In a large casserole, fry the sausages until brown all over – about 10 mins.

Add the tomato sauce, stirring well, then stir in the beans, treacle or sugar and mustard. Bring to the simmer, cover and cook for 30 mins. Great served with crusty bread or rice.', '/static/fotos/52848.jpg'),
(52849, 'Spinach & Ricotta Cannelloni', 'Vegetarian', 'Italian', 'First make the tomato sauce. Heat the oil in a large pan and fry the garlic for 1 min. Add the sugar, vinegar, tomatoes and some seasoning and simmer for 20 mins, stirring occasionally, until thick. Add the basil and divide the sauce between 2 or more shallow ovenproof dishes (see Tips for freezing, below). Set aside. Make a sauce by beating the mascarpone with the milk until smooth, season, then set aside.

Put the spinach in a large colander and pour over a kettle of boiling water to wilt it (you may need to do this in batches). When cool enough to handle squeeze out the excess water. Roughly chop the spinach and mix in a large bowl with 100g Parmesan and ricotta. Season well with salt, pepper and the nutmeg.

Heat oven to 200C/180C fan/gas 6. Using a piping bag or plastic food bag with the corner snipped off, squeeze the filling into the cannelloni tubes. Lay the tubes, side by side, on top of the tomato sauce and spoon over the mascarpone sauce. Top with Parmesan and mozzarella. You can now freeze the cannelloni, uncooked, or you can cook it first and then freeze. Bake for 30-35 mins until golden and bubbling. Remove from oven and let stand for 5 mins before serving.', '/static/fotos/52849.jpg'),
(52850, 'Chicken Couscous', 'Chicken', 'Moroccan', 'Heat the olive oil in a large frying pan and cook the onion for 1-2 mins just until softened. Add the chicken and fry for 7-10 mins until cooked through and the onions have turned golden. Grate over the ginger, stir through the harissa to coat everything and cook for 1 min more.

Tip in the apricots, chickpeas and couscous, then pour over the stock and stir once. Cover with a lid or tightly cover the pan with foil and leave for about 5 mins until the couscous has soaked up all the stock and is soft. Fluff up the couscous with a fork and scatter over the coriander to serve. Serve with extra harissa, if you like.', '/static/fotos/52850.jpg'),
(52851, 'Nutty Chicken Curry', 'Chicken', 'India', 'Finely slice a quarter of the chilli, then put the rest in a food processor with the ginger, garlic, coriander stalks and one-third of the leaves. Whizz to a rough paste with a splash of water if needed.
Heat the oil in a frying pan, then quickly brown the chicken chunks for 1 min. Stir in the paste for another min, then add the peanut butter, stock and yogurt. When the sauce is gently bubbling, cook for 10 mins until the chicken is just cooked through and sauce thickened. Stir in most of the remaining coriander, then scatter the rest on top with the chilli, if using. Eat with rice or mashed sweet potato.', '/static/fotos/52851.jpg'),
(52852, 'Tuna Nicoise', 'Seafood', 'France', 'Heat oven to 200C/fan 180C/gas 6. Toss the potatoes with 2 tsp oil and some seasoning. Tip onto a large baking tray, then roast for 20 mins, stirring halfway, until crisp, golden and cooked through.
Meanwhile, put eggs in a small pan of water, bring to the boil, then simmer for 8-10 mins, depending on how you like them cooked. Plunge into a bowl of cold water to cool for a few mins. Peel away the shells, then cut into halves.
In a large salad bowl, whisk together the remaining oil, red wine vinegar, capers and chopped tomatoes. Season, tip in the onion, spinach, tuna and potatoes, then gently toss together. Top with the eggs, then serve straight away.', '/static/fotos/52852.jpg'),
(52853, 'Chocolate Avocado Mousse', 'Dessert', 'British', '1. Blend all the mousse ingredients together in your food processor until smooth. Add the cacao powder first and, as you blend, have all the ingredients to hand in order to adjust the ratios slightly as the size of avocados and bananas varies so much. The perfect ratio in order to avoid the dish tasting too much of either is to use equal amounts of both.

2. Taste and add a few drops of stevia if you feel you need more sweetness.

3. Fill little cups or shot glasses with the mousse, sprinkle with the cacao powder or nibs and serve.

Tip If you don’t have a frozen banana to hand you can just use a normal one and then chill the mousse before serving for a cooling dessert.', '/static/fotos/52853.jpg'),
(52854, 'Pancakes', 'Dessert', 'United States', 'Put the flour, eggs, milk, 1 tbsp oil and a pinch of salt into a bowl or large jug, then whisk to a smooth batter. Set aside for 30 mins to rest if you have time, or start cooking straight away.
Set a medium frying pan or crêpe pan over a medium heat and carefully wipe it with some oiled kitchen paper. When hot, cook your pancakes for 1 min on each side until golden, keeping them warm in a low oven as you go.
Serve with lemon wedges and sugar, or your favourite filling. Once cold, you can layer the pancakes between baking parchment, then wrap in cling film and freeze for up to 2 months.', '/static/fotos/52854.jpg'),
(52855, 'Banana Pancakes', 'Dessert', 'United States', 'In a bowl, mash the banana with a fork until it resembles a thick purée. Stir in the eggs, baking powder and vanilla.
Heat a large non-stick frying pan or pancake pan over a medium heat and brush with half the oil. Using half the batter, spoon two pancakes into the pan, cook for 1-2 mins each side, then tip onto a plate. Repeat the process with the remaining oil and batter. Top the pancakes with the pecans and raspberries.', '/static/fotos/52855.jpg'),
(52856, 'Choc Chip Pecan Pie', 'Dessert', 'United States', 'First, make the pastry. Tip the ingredients into a food processor with 1 /4 tsp salt. Blend until the mixture resembles breadcrumbs. Drizzle 2-3 tsp cold water into the funnel while the blade is running – the mixture should start to clump together. Tip onto a work surface and bring together, kneading briefly into a ball. Pat into a disc, wrap in cling film, and chill for at least 20 mins. Heat oven to 200C/180C fan/gas 6.

Remove the pastry from the fridge and leave at room temperature for 5 mins to soften. Flour the work surface, then unwrap the pastry and roll to a circle the thickness of a £1 coin. Use the pastry to line a deep, 23cm round fluted tin – mine was about 3cm deep. Press the pastry into the corners and up the sides, making sure there are no gaps. Leave 1cm pastry overhanging (save some of the pastry scraps for later). Line with baking parchment (scrunch it up first to make it more pliable) and fill with baking beans. Blind-bake for 15-20 mins until the sides are set, then remove the parchment and beans and return to the oven for 5 mins until golden brown. Trim the pastry so it’s flush with the top of the tin – a small serrated knife is best for this. If there are any cracks, patch them up with the pastry scraps.

Meanwhile, weigh the butter, syrup and sugars into a pan, and add 1 /4 tsp salt. Heat until the butter has melted and the sugar dissolved, stirring until smooth. Remove from the heat and cool for 10 mins. Reduce oven to 160C/140C fan/gas 3.

Beat the eggs in a bowl. Add the syrup mixture, vanilla and pecans, and mix until well combined. Pour half the mixture into the tart case, scatter over half the chocolate chips, then cover with the remaining filling and chocolate chips. Bake on the middle shelf for 50-55 mins until set. Remove from the oven and leave to cool, then chill for at least 2 hrs before serving.', '/static/fotos/52856.jpg'),
(52857, 'Pumpkin Pie', 'Dessert', 'United States', 'Place the pumpkin in a large saucepan, cover with water and bring to the boil. Cover with a lid and simmer for 15 mins or until tender. Drain pumpkin; let cool.
Heat oven to 180C/160C fan/gas 4. Roll out the pastry on a lightly floured surface and use it to line a 22cm loose-bottomed tart tin. Chill for 15 mins. Line the pastry with baking parchment and baking beans, then bake for 15 mins. Remove the beans and paper, and cook for a further 10 mins until the base is pale golden and biscuity. Remove from the oven and allow to cool slightly.
Increase oven to 220C/200C fan/gas 7. Push the cooled pumpkin through a sieve into a large bowl. In a separate bowl, combine the sugar, salt, nutmeg and half the cinnamon. Mix in the beaten eggs, melted butter and milk, then add to the pumpkin purée and stir to combine. Pour into the tart shell and cook for 10 mins, then reduce the temperature to 180C/160C fan/gas 4. Continue to bake for 35-40 mins until the filling has just set.
Leave to cool, then remove the pie from the tin. Mix the remaining cinnamon with the icing sugar and dust over the pie. Serve chilled.', '/static/fotos/52857.jpg'),
(52858, 'New York cheesecake', 'Dessert', 'United States', 'Position an oven shelf in the middle of the oven. Preheat the oven to fan 160C/conventional 180C/gas 4. Line the base of a 23cm springform cake tin with parchment paper. For the crust, melt the butter in a medium pan. Stir in the biscuit crumbs and sugar so the mixture is evenly moistened. Press the mixture into the bottom of the pan and bake for 10 minutes. Cool on a wire rack while preparing the filling.
For the filling, increase the oven temperature to fan 200C/conventional 240C/gas 9. In a table top mixer fitted with the paddle attachment, beat the soft cheese at medium-low speed until creamy, about 2 minutes. With the mixer on low, gradually add the sugar, then the flour and a pinch of salt, scraping down the sides of the bowl and the paddle twice.
Swap the paddle attachment for the whisk. Continue by adding the vanilla, lemon zest and juice. Whisk in the eggs and yolk, one at a time, scraping the bowl and whisk at least twice. Stir the 284ml carton of soured cream until smooth, then measure 200ml/7fl oz (just over 3⁄4 of the carton). Continue on low speed as you add the measured soured cream (reserve the rest). Whisk to blend, but don''t over-beat. The batter should be smooth, light and somewhat airy.
Brush the sides of the springform tin with melted butter and put on a baking sheet. Pour in the filling - if there are any lumps, sink them using a knife - the top should be as smooth as possible. Bake for 10 minutes. Reduce oven temperature to fan 90C/conventional 110C/gas 1⁄4 and bake for 25 minutes more. If you gently shake the tin, the filling should have a slight wobble. Turn off the oven and open the oven door for a cheesecake that''s creamy in the centre, or leave it closed if you prefer a drier texture. Let cool in the oven for 2 hours. The cheesecake may get a slight crack on top as it cools.
Combine the reserved soured cream with the 142ml carton, the sugar and lemon juice for the topping. Spread over the cheesecake right to the edges. Cover loosely with foil and refrigerate for at least 8 hours or overnight.
Run a round-bladed knife around the sides of the tin to loosen any stuck edges. Unlock the side, slide the cheesecake off the bottom of the tin onto a plate, then slide the parchment paper out from underneath.', '/static/fotos/52858.jpg'),
(52859, 'Key Lime Pie', 'Dessert', 'United States', 'Heat the oven to 160C/fan 140C/gas 3. Whizz the biscuits to crumbs in a food processor (or put in a strong plastic bag and bash with a rolling pin). Mix with the melted butter and press into the base and up the sides of a 22cm loose-based tart tin. Bake in the oven for 10 minutes. Remove and cool.
Put the egg yolks in a large bowl and whisk for a minute with electric beaters. Add the condensed milk and whisk for 3 minutes then add the zest and juice and whisk again for 3 minutes. Pour the filling into the cooled base then put back in the oven for 15 minutes. Cool then chill for at least 3 hours or overnight if you like.
When you are ready to serve, carefully remove the pie from the tin and put on a serving plate. To decorate, softly whip together the cream and icing sugar. Dollop or pipe the cream onto the top of the pie and finish with extra lime zest.', '/static/fotos/52859.jpg'),
(52860, 'Chocolate Raspberry Brownies', 'Dessert', 'United States', 'Heat oven to 180C/160C fan/gas 4. Line a 20 x 30cm baking tray tin with baking parchment. Put the chocolate, butter and sugar in a pan and gently melt, stirring occasionally with a wooden spoon. Remove from the heat.
Stir the eggs, one by one, into the melted chocolate mixture. Sieve over the flour and cocoa, and stir in. Stir in half the raspberries, scrape into the tray, then scatter over the remaining raspberries. Bake on the middle shelf for 30 mins or, if you prefer a firmer texture, for 5 mins more. Cool before slicing into squares. Store in an airtight container for up to 3 days.', '/static/fotos/52860.jpg'),
(52861, 'Peanut Butter Cheesecake', 'Dessert', 'United States', 'Oil and line a 20cm round loose- bottomed cake tin with cling film, making it as smooth as possible. Melt the butter in a pan. Crush the biscuits by bashing them in a bag with a rolling pin, then stir them into the butter until very well coated. Press the mixture firmly into the base of the tin and chill.
Soak the gelatine in water while you make the filling. Tip the ricotta into a bowl, then beat in the peanut butter and syrup. Ricotta has a slightly grainy texture so blitz until smooth with a stick blender for a smoother texture if you prefer.
Take the soaked gelatine from the water and squeeze dry. Put it into a pan with the milk and heat very gently until the gelatine dissolves. Beat into the peanut mixture, then tip onto the biscuit base. Chill until set.
To freeze, leave in the tin and as soon as it is solid, cover the surface with cling film, then wrap the tin with cling film and foil.
To defrost, thaw in the fridge overnight.
To serve, carefully remove from the tin. Whisk the cream with the sugar until it holds its shape, then spread on top of the cheesecake and scatter with the peanut brittle.', '/static/fotos/52861.jpg'),
(52862, 'Peach & Blueberry Grunt', 'Dessert', 'United States', 'Heat oven to 190C/170C fan/gas 5. Butter a wide shallow ovenproof dish. Blend the cornflour with the orange zest and juice, and put in a large pan with the sugar. Halve, stone and slice the peaches and add to the pan. Bring slowly to the boil, stirring gently until the sauce is shiny and thickened, about 3-4 mins. Remove from the heat, stir in the blueberries and tip into the prepared dish.
Tip the flour into a mixing bowl and add the 50g butter. Rub the butter into the flour until it resembles fine breadcrumbs, then stir in half the sugar. Mix the remaining sugar with the cinnamon and set aside.
Add the milk to the dry ingredients and mix to a soft dough. Turn out onto a lightly floured surface and knead briefly. Roll out to an oblong roughly 16 x 24cm. Brush with melted butter and sprinkle evenly with the spicy sugar. Roll up from one long side and cut into 12 slices. Arrange around the top of the dish, leaving the centre uncovered.
Bake for 20-25 mins, until the topping is crisp and golden. Serve warm.', '/static/fotos/52862.jpg'),
(52863, 'Vegetarian Casserole', 'Vegetarian', 'British', 'Heat the oil in a large, heavy-based pan. Add the onions and cook gently for 5 – 10 mins until softened.
Add the garlic, spices, dried thyme, carrots, celery and peppers and cook for 5 minutes.
Add the tomatoes, stock, courgettes and fresh thyme and cook for 20 - 25 minutes.
Take out the thyme sprigs. Stir in the lentils and bring back to a simmer. Serve with wild and white basmati rice, mash or quinoa.', '/static/fotos/52863.jpg'),
(52864, 'Mushroom & Chestnut Rotolo', 'Vegetarian', 'British', 'Soak the dried mushrooms in 350ml boiling water and set aside until needed. Blitz ¾ of the chestnuts with 150ml water until creamy. Roughly chop the remaining chestnuts.
Heat 2 tbsp olive oil in a large non-stick frying pan. Fry the shallots with a pinch of salt until softened, then add the garlic, chopped chestnuts and rosemary, and fry for 2 mins more. Add the wild mushrooms, 2 tbsp oil and some seasoning. Cook for 3 mins until they begin to soften. Drain and roughly chop the dried mushrooms (reserve the soaking liquid), then add those too, along with the soy sauce, and fry for 2 mins more.
Whisk the wine, reserved mushroom liquid and chestnut cream together to create a sauce. Season, then add half to the mushroom mixture in the pan and cook for 1 min until the sauce becomes glossy. Remove and discard the rosemary sprigs, then set the mixture aside.
Heat oven to 180C/160C fan/gas 4. Bring a large pan of salted water to the boil and get a large bowl of ice water ready. Drop the lasagne sheets into the boiling water for 2 mins or until pliable and a little cooked, then immediately plunge them into the cold water. Using your fingers, carefully separate the sheets and transfer to a clean tea towel. Spread a good spoonful of the sauce on the bottom two thirds of each sheet, then, rolling away from yourself, roll up the shorter ends. Cut each roll in half, then position the rolls of pasta cut-side up in a pie dish that you are happy to serve from at the table. If you have any mushroom sauce remaining after you’ve rolled up all the sheets, simply push it into some of the exposed rolls of pasta.
Pour the rest of the sauce over the top of the pasta, then bake for 10 mins or until the pasta no longer has any resistance when tested with a skewer.
Meanwhile, put the breadcrumbs, the last 2 tbsp olive oil, sage leaves and some seasoning in a bowl, and toss everything together. Scatter the rotolo with the crumbs and sage, then bake for another 10 mins, until the top is golden and the sage leaves are crispy. Leave to cool for 10 mins to allow the pasta to absorb the sauce, then drizzle with a little truffle oil, if you like, before taking your dish to the table.', '/static/fotos/52864.jpg'),
(52865, 'Matar Paneer', 'Vegetarian', 'India', 'Heat the oil in a frying pan over high heat until it’s shimmering hot. Add the paneer, then turn the heat down a little. Fry until it starts to brown at the edges, then turn it over and brown on each side – the paneer will brown faster than you think, so don’t walk away. Remove the paneer from the pan and drain on kitchen paper.
Put the ginger, cumin, turmeric, ground coriander and chilli in the pan, and fry everything for 1 min. Add the tomatoes, mashing them with the back of a spoon and simmer everything for 5 mins until the sauce smells fragrant. Add a splash of water if it’s too thick. Season well. Add the peas and simmer for a further 2 mins, then stir in the paneer and sprinkle over the garam masala. Divide between two bowls, top with coriander leaves and serve with naan bread, roti or rice.', '/static/fotos/52865.jpg'),
(52866, 'Squash linguine', 'Vegetarian', 'Italian', 'Heat oven to 200C/180C fan/gas 6. Put the squash and garlic on a baking tray and drizzle with the olive oil. Roast for 35-40 mins until soft. Season.
Cook the pasta according to pack instructions. Drain, reserving the water. Use a stick blender to whizz the squash with 400ml cooking water. Heat some oil in a frying pan, fry the sage until crisp, then drain on kitchen paper. Tip the pasta and sauce into the pan and warm through. Scatter with sage.', '/static/fotos/52866.jpg'),
(52867, 'Vegetarian Chilli', 'Vegetarian', 'British', 'Heat oven to 200C/180C fan/ gas 6. Cook the vegetables in a casserole dish for 15 mins. Tip in the beans and tomatoes, season, and cook for another 10-15 mins until piping hot. Heat the pouch in the microwave on High for 1 min and serve with the chilli.', '/static/fotos/52867.jpg'),
(52868, 'Kidney Bean Curry', 'Vegetarian', 'India', 'Heat the oil in a large frying pan over a low-medium heat. Add the onion and a pinch of salt and cook slowly, stirring occasionally, until softened and just starting to colour. Add the garlic, ginger and coriander stalks and cook for a further 2 mins, until fragrant.

Add the spices to the pan and cook for another 1 min, by which point everything should smell aromatic. Tip in the chopped tomatoes and kidney beans in their water, then bring to the boil.

Turn down the heat and simmer for 15 mins until the curry is nice and thick. Season to taste, then serve with the basmati rice and the coriander leaves.', '/static/fotos/52868.jpg'),
(52869, 'Tahini Lentils', 'Vegetarian', 'Moroccan', 'In a jug, mix the tahini with the zest and juice of the lemon and 50ml of cold water to make a runny dressing. Season to taste, then set aside.
Heat the oil in a wok or large frying pan over a medium-high heat. Add the red onion, along with a pinch of salt, and fry for 2 mins until starting to soften and colour. Add the garlic, pepper, green beans and courgette and fry for 5 min, stirring frequently.
Tip in the kale, lentils and the tahini dressing. Keep the pan on the heat for a couple of mins, stirring everything together until the kale is wilted and it’s all coated in the creamy dressing.', '/static/fotos/52869.jpg'),
(52870, 'Chickpea Fajitas', 'Vegetarian', 'Mexican', 'Heat oven to 200C/180C fan/gas 6 and line a baking tray with foil. Drain the chickpeas, pat dry and tip onto the prepared baking tray. Add the oil and paprika, toss to coat, then roast for 20-25 mins until browned and crisp, shaking halfway through cooking.

Meanwhile, put the tomatoes and onion in a small bowl with the vinegar and set aside to pickle. Put the avocado in another bowl and mash with a fork, leaving some larger chunks. Stir in the lime juice and season well. Mix the soured cream with the harissa and set aside until ready to serve.

Heat a griddle pan until nearly smoking. Add the tortillas , one at a time, charring each side until hot with griddle lines. 

Put everything on the table and build the fajitas : spread a little of the harissa cream over the tortilla, top with roasted chickpeas, guacamole, pickled salsa and coriander, if you like. Serve with the lime wedges for squeezing over.', '/static/fotos/52870.jpg'),
(52871, 'Yaki Udon', 'Vegetarian', 'Japanese', 'Boil some water in a large saucepan. Add 250ml cold water and the udon noodles. (As they are so thick, adding cold water helps them to cook a little bit slower so the middle cooks through). If using frozen or fresh noodles, cook for 2 mins or until al dente; dried will take longer, about 5-6 mins. Drain and leave in the colander.
Heat 1 tbsp of the oil, add the onion and cabbage and sauté for 5 mins until softened. Add the mushrooms and some spring onions, and sauté for 1 more min. Pour in the remaining sesame oil and the noodles. If using cold noodles, let them heat through before adding the ingredients for the sauce – otherwise tip in straight away and keep stir-frying until sticky and piping hot. Sprinkle with the remaining spring onions.', '/static/fotos/52871.jpg'),
(52872, 'Spanish Tortilla', 'Vegetarian', 'Spanish', 'Put a large non-stick frying pan on a low heat. Cook the onion slowly in the oil and butter until soft but not brown – this should take about 15 mins. Add the potatoes, cover the pan and cook for a further 15-20 mins, stirring occasionally to make sure they fry evenly.
When the potatoes are soft and the onion is shiny, crush 2 garlic cloves and stir in, followed by the beaten eggs.
Put the lid back on the pan and leave the tortilla to cook gently. After 20 mins, the edges and base should be golden, the top set but the middle still a little wobbly. To turn it over, slide it onto a plate and put another plate on top, turn the whole thing over and slide it back into the pan to finish cooking. Once cooked, transfer to a plate and serve the tortilla warm or cold, scattered with the chopped parsley.
To accompany, take slices of warmed baguette, stab all over with a fork and rub with the remaining garlic, pile on grated tomatoes and season with sea salt and a drizzle of olive oil.', '/static/fotos/52872.jpg'),
(52873, 'Beef Dumpling Stew', 'Beef', 'British', 'Preheat the oven to 180C/350F/Gas 4.

For the beef stew, heat the oil and butter in an ovenproof casserole and fry the beef until browned on all sides.

Sprinkle over the flour and cook for a further 2-3 minutes.

Add the garlic and all the vegetables and fry for 1-2 minutes.

Stir in the wine, stock and herbs, then add the Worcestershire sauce and balsamic vinegar, to taste. Season with salt and freshly ground black pepper.

Cover with a lid, transfer to the oven and cook for about two hours, or until the meat is tender.

For the dumplings, sift the flour, baking powder and salt into a bowl.
Add the suet and enough water to form a thick dough.

With floured hands, roll spoonfuls of the dough into small balls.

After two hours, remove the lid from the stew and place the balls on top of the stew. Cover, return to the oven and cook for a further 20 minutes, or until the dumplings have swollen and are tender. (If you prefer your dumplings with a golden top, leave the lid off when returning to the oven.)

To serve, place a spoonful of mashed potato onto each of four serving plates and top with the stew and dumplings. Sprinkle with chopped parsley.', '/static/fotos/52873.jpg'),
(52874, 'Beef and Mustard Pie', 'Beef', 'British', 'Preheat the oven to 150C/300F/Gas 2.
Toss the beef and flour together in a bowl with some salt and black pepper.
Heat a large casserole until hot, add half of the rapeseed oil and enough of the beef to just cover the bottom of the casserole.
Fry until browned on each side, then remove and set aside. Repeat with the remaining oil and beef.
Return the beef to the pan, add the wine and cook until the volume of liquid has reduced by half, then add the stock, onion, carrots, thyme and mustard, and season well with salt and pepper.
Cover with a lid and place in the oven for two hours.
Remove from the oven, check the seasoning and set aside to cool. Remove the thyme.
When the beef is cool and you''re ready to assemble the pie, preheat the oven to 200C/400F/Gas 6.
Transfer the beef to a pie dish, brush the rim with the beaten egg yolks and lay the pastry over the top. Brush the top of the pastry with more beaten egg.
Trim the pastry so there is just enough excess to crimp the edges, then place in the oven and bake for 30 minutes, or until the pastry is golden-brown and cooked through.
For the green beans, bring a saucepan of salted water to the boil, add the beans and cook for 4-5 minutes, or until just tender.
Drain and toss with the butter, then season with black pepper.
To serve, place a large spoonful of pie onto each plate with some green beans alongside.', '/static/fotos/52874.jpg'),
(52875, 'Chicken Ham and Leek Pie', 'Chicken', 'British', 'Heat the chicken stock in a lidded saucepan. Add the chicken breast and bring to a low simmer. Cover with a lid and cook for 10 minutes. Remove the chicken breasts from the water with tongs and place on a plate. Pour the cooking liquor into a large jug.
Melt 25g/1oz of the butter in a large heavy-based saucepan over a low heat. Stir in the leeks and fry gently for two minutes, stirring occasionally until just softened. Add the garlic and cook for a further minute. Add the remaining butter and stir in the flour as soon as the butter has melted. Cook for 30 seconds, stirring constantly.
Slowly pour the milk into the pan, just a little at a time, stirring well between each adding. Gradually add 250ml/10fl oz of the reserved stock and the wine, if using, stirring until the sauce is smooth and thickened slightly. Bring to a gentle simmer and cook for 3 minutes.
Season the mixture, to taste, with salt and freshly ground black pepper. Remove from the heat and stir in the cream. Pour into a large bowl and cover the surface of the sauce with cling ilm to prevent a skin forming. Set aside to cool.
Preheat the oven to 200C/400F/Gas 6. Put a baking tray in the oven to heat.
For the pastry, put the flour and butter in a food processor and blend on the pulse setting until the mixture resembles fine breadcrumbs. With the motor running, add the beaten egg and water and blend until the mixture forms a ball. Portion off 250g/10oz of pastry for the lid.
Roll the remaining pastry out on a lightly floured surface, turning the pastry frequently until around 5mm/¼in thick and 4cm/1½in larger than the pie dish. Lift the pastry over the rolling pin and place it gently into the pie dish. Press the pastry firmly up the sides, making sure there are no air bubbles. Leave the excess pastry overhanging the sides.
Cut the chicken breasts into 3cm/1¼in pieces. Stir the chicken, ham and leeks into the cooled sauce. Pour the chicken filling into the pie dish. Brush the rim of the dish with beaten egg. Roll out the reserved pastry for the lid.
Cover the pie with the pastry lid and press the edges together firmly to seal. Trim any excess pastry.
Make a small hole in the centre of the pie with the tip of a knife. Glaze the top of the pie with beaten egg. Bake on the preheated tray in the centre of the oven for 35-40 minutes or until the pie is golden-brown all over and the filling is piping hot.', '/static/fotos/52875.jpg'),
(52876, 'Minced Beef Pie', 'Beef', 'British', 'Preheat the oven to 200C/400F/Gas 6.
Heat the oil in a deep frying pan and fry the beef mince for 4-5 minutes, breaking it up with a wooden spoon as it browns.
Add the onion and cook for 2-3 minutes, then stir in the tomato purée and cook for 2-3 more minutes. Stir in the flour and cook for a further minute, then add the chopped mushrooms, the stout or beef stock and a couple of dashes of Worcestershire sauce. Bring to the boil, then reduce the heat, cover the pan with a lid and leave to simmer for 20 minutes. Set aside and leave to cool, then turn the meat mixture into a one litre pie dish.
Roll out the pastry on a floured work surface until it is slightly larger than the pie dish. Gently drape the pastry over the dish, pressing firmly onto the edges. Trim, then shape the edges into a fluted shape.
Cut some leaf shapes out of the pastry trimmings and decorate the top of the pie, sticking them to the pastry with the beaten egg yolk.
Make three or four slits in the pastry to allow the steam to escape, then brush the pie with the rest of the beaten egg yolk and bake in the oven for 20-25 minutes, or until golden-brown.
To serve, slice into wedges.', '/static/fotos/52876.jpg'),
(52877, 'Lamb and Potato pie', 'Lamb', 'British', 'Dust the meat with flour to lightly coat.
Heat enough vegetable oil in a large saucepan to fill the base, and fry the onion and meat until lightly browned. Season with salt and pepper.
Add the carrots, stock and more seasoning to taste.
Bring to the boil, cover and reduce the heat to a simmer. Simmer for at least an hour or until the meat is tender. Take your time cooking the meat, the longer you leave it to cook, the better the flavour will be.
Preheat the oven to 180C/350F/Gas 4.
Add the drained potato cubes to the lamb.
Turn the mixture into a pie dish or casserole and cover with the shortcrust pastry. Make three slits in the top of the pastry to release any steam while cooking.
Brush with beaten egg and bake for about 40 minutes, until the pastry is golden brown.
Serve.', '/static/fotos/52877.jpg'),
(52878, 'Beef and Oyster pie', 'Beef', 'British', 'Season the beef cubes with salt and black pepper. Heat a tablespoon of oil in the frying pan and fry the meat over a high heat. Do this in three batches so that you don’t overcrowd the pan, transferring the meat to a large flameproof casserole dish once it is browned all over. Add extra oil if the pan seems dry.
In the same pan, add another tablespoon of oil and cook the shallots for 4-5 minutes, then add the garlic and fry for 30 seconds. Add the bacon and fry until slightly browned. Transfer the onion and bacon mixture to the casserole dish and add the herbs.
Preheat the oven to 180C/350F/Gas 4.
Pour the stout into the frying pan and bring to the boil, stirring to lift any stuck-on browned bits from the bottom of the pan. Pour the stout over the beef in the casserole dish and add the stock. Cover the casserole and place it in the oven for 1½-2 hours, or until the beef is tender and the sauce is reduced.
Skim off any surface fat, taste and add salt and pepper if necessary, then stir in the cornflour paste. Put the casserole dish on the hob – don’t forget that it will be hot – and simmer for 1-2 minutes, stirring, until thickened. Leave to cool.
Increase the oven to 200C/400F/Gas 6. To make the pastry, put the flour and salt in a very large bowl. Grate the butter and stir it into the flour in three batches. Gradually add 325ml/11fl oz cold water – you may not need it all – and stir with a round-bladed knife until the mixture just comes together. Knead the pastry lightly into a ball on a lightly floured surface and set aside 250g/9oz for the pie lid.
Roll the rest of the pastry out until about 2cm/¾in larger than the dish you’re using. Line the dish with the pastry then pile in the filling, tucking the oysters in as well. Brush the edge of the pastry with beaten egg.
Roll the remaining pastry until slightly larger than your dish and gently lift over the filling, pressing the edges firmly to seal, then trim with a sharp knife. Brush with beaten egg to glaze. Put the dish on a baking tray and bake for 25-30 minutes, or until the pastry is golden-brown and the filling is bubbling.', '/static/fotos/52878.jpg'),
(52879, 'Chicken Parmentier', 'Chicken', 'France', 'For the topping, boil the potatoes in salted water until tender. Drain and push through a potato ricer, or mash thoroughly. Stir in the butter, cream and egg yolks. Season and set aside.
For the filling, melt the butter in a large pan. Add the shallots, carrots and celery and gently fry until soft, then add the garlic. Pour in the wine and cook for 1 minute. Stir in the tomato purée, chopped tomatoes and stock and cook for 10–15 minutes, until thickened. Add the shredded chicken, olives and parsley. Season to taste with salt and pepper.
Preheat the oven to 180C/160C Fan/Gas 4.
Put the filling in a 20x30cm/8x12in ovenproof dish and top with the mashed potato. Grate over the Gruyère. Bake for 30–35 minutes, until piping hot and the potato is golden-brown.', '/static/fotos/52879.jpg'),
(52880, 'McSinghs Scotch pie', 'Lamb', 'British', 'Heat a large frying pan and toast the cumin seeds for a few minutes, then set aside. Heat the oil in the same pan and fry the onion, garlic, chilli, pepper and a good pinch of salt for around eight minutes, until there is no moisture left. Remove from the heat, stir in the toasted cumin seeds, ground mace (or nutmeg) and ground coriander. Leave to cool.
In a large bowl mix together the minced lamb, white pepper, fresh coriander, and the cooled spiced onion mixture until combined. Set aside, covered, in the fridge.
Preheat the oven to 200C/400F/Gas 6 and generously grease a 20cm/8in diameter loose-bottomed or springform round cake tin with lard.
To make the pastry, sift the flour and salt in a large bowl and make a well in the centre.
Put the milk, lard and 90ml/3fl oz of water in a saucepan and heat gently. When the lard has melted, increase the heat and bring to the boil.
Pour the boiling liquid into the flour, and use a wooden spoon to combine until cool enough to handle. Bring together into a ball.
Dust a work surface with flour and, working quickly, knead the dough briefly – it will be soft and moist. Set aside a third of the pastry and roll the rest out on a well-floured surface. Line the pie dish with the pastry, pressing it right up the sides until it pokes just over the top of the tin.
Add the filling into the pastry-lined tin bit by bit. As you reach the top, form a slight peak. Roll out the reserved pastry and top the pie with it. Pinch the edges to seal and trim the excess. Poke a hole in the top of the pie and insert a small tube made from aluminium foil to allow steam to escape.
Brush the top of the pie with a little beaten egg yolk, and bake in the preheated oven for 30 minutes (put a tray on the shelf below to catch any drips). Then reduce the temperature to 160C/325F/Gas 3 and cook for a further 1¼ hours until golden-brown. Leave to cool completely before refrigerating for two hours, or overnight.
Run a knife around the edge of the pie, remove from the tin and serve with chutneys, salads or pickles.', '/static/fotos/52880.jpg'),
(52881, 'Steak and Kidney Pie', 'Beef', 'British', 'Preheat the oven to 220C/425F/Gas 7
Heat the vegetable oil in a large frying pan, and brown the beef all over. (You may need to do this in batches.) Set aside, then brown the kidneys on both sides in the same pan. Add the onions and cook for 3-4 minutes.
Return the beef to the pan, sprinkle flour over and coat the meat and onions
Add the stock to the pan, stir well and bring to the boil.
Turn the heat down and simmer for 1½ hours without a lid. If the liquid evaporates too much, add more stock.
Remove from the heat. Add salt, pepper and Worcestershire sauce and allow to cool completely. Place the cooked meat mixture into a pie dish.
Roll out the pastry to 5mm/¼in thick and 5cm/2in larger than the dish you are using.
Using a rolling pin, lift the pastry and place it over the top of the pie dish. Trim and crimp the edges with your fingers and thumb.
Brush the surface with the beaten egg mixture and bake for 30-40 minutes until golden-brown and puffed.
Serve with creamy mash and steamed vegetables to soak up the gravy.', '/static/fotos/52881.jpg'),
(52882, 'Three Fish Pie', 'Seafood', 'British', 'Preheat the oven to 200C/400F/Gas 6 (180C fan).
Put the potatoes into a saucepan of cold salted water. Bring up to the boil and simmer until completely tender. Drain well and then mash with the butter and milk. Add pepper and taste to check the seasoning. Add salt and more pepper if necessary.
For the fish filling, melt the butter in a saucepan, add the leeks and stir over the heat. Cover with a lid and simmer gently for 10 minutes, or until soft. Measure the flour into a small bowl. Add the wine and whisk together until smooth.
Add the milk to the leeks, bring to the boil and then add the wine mixture. Stir briskly until thickened. Season and add the parsley and fish. Stir over the heat for two minutes, then spoon into an ovenproof casserole. Scatter over the eggs. Allow to cool until firm.
Spoon the mashed potatoes over the fish mixture and mark with a fork. Sprinkle with cheese.
Bake for 30-40 minutes, or until lightly golden-brown on top and bubbling around the edges.', '/static/fotos/52882.jpg'),
(52883, 'Sticky Toffee Pudding', 'Dessert', 'British', 'Preheat the oven to 180C/160C Fan/Gas 4. Butter a wide shallow 1.7-litre/3-pint ovenproof dish.
Put the butter, sugar, eggs, flour, baking powder, bicarbonate of soda and treacle into a mixing bowl. Beat using an electric handheld whisk for about 30 seconds or until combined. Pour in the milk gradually and whisk again until smooth. Pour into the prepared dish. Bake for 35–40 minutes or until well risen and springy in the centre.
To make the sauce, put all the ingredients into a saucepan and stir over a low heat until the sugar has dissolved and the butter has melted. Bring to the boil, stirring for a minute.
To serve, pour half the sauce over the pudding in the baking dish. Serve with the cream or ice cream.', '/static/fotos/52883.jpg'),
(52884, 'Lancashire hotpot', 'Lamb', 'British', 'Heat oven to 160C/fan 140C/gas 3. Heat some dripping or butter in a large shallow casserole dish, brown the lamb in batches, lift to a plate, then repeat with the kidneys.
Fry the onions and carrots in the pan with a little more dripping until golden. Sprinkle over the flour, allow to cook for a couple of mins, shake over the Worcestershire sauce, pour in the stock, then bring to the boil. Stir in the meat and bay leaves, then turn off the heat. Arrange the sliced potatoes on top of the meat, then drizzle with a little more dripping. Cover, then place in the oven for about 1½ hrs until the potatoes are cooked.
Remove the lid, brush the potatoes with a little more dripping, then turn the oven up to brown the potatoes, or finish under the grill for 5-8 mins until brown.', '/static/fotos/52884.jpg'),
(52886, 'Spotted Dick', 'Dessert', 'British', 'Put the flour and salt in a bowl. Add the suet, currants, sugar, lemon and orange zest.
Pour in 150ml milk and mix to a firm but moist dough, adding the extra milk if necessary.
Shape into a fat roll about 20cm long. Place on a large rectangle of baking parchment. Wrap loosely to allow for the pudding to rise and tie the ends with string like a Christmas cracker.
Place a steamer over a large pan of boiling water, add the pudding to the steamer, cover and steam for 1 1/2 hours. Top up the pan with water from time to time.
Remove from the steamer and allow to cool slightly before unwrapping. Serve sliced with custard.', '/static/fotos/52886.jpg'),
(52887, 'Kedgeree', 'Seafood', 'British', 'For the rice, heat the oil in a large, lidded pan, add the onion, then gently fry for 5 mins until softened but not coloured. Add the spices, season with salt, then continue to fry until the mix start to go brown and fragrant; about 3 mins.
Add the rice and stir in well. Add 600ml water, stir, then bring to the boil. Reduce to a simmer, then cover for 10 mins. Take off the heat and leave to stand, covered, for 10-15 mins more. The rice will be perfectly cooked if you do not lift the lid before the end of the cooking.
Meanwhile, put the haddock and bay leaves in a frying pan, cover with the milk, then poach for 10 mins until the flesh flakes. Remove from the milk, peel away the skin, then flake the flesh into thumbsize pieces. Place the eggs in a pan, cover with water, bring to the boil, then reduce to a simmer. Leave for 4½-5 mins, plunge into cold water, then peel and cut the eggs into quarters. Gently mix the fish, eggs, parsley, coriander and rice together in the pan. Serve hot, sprinkled with a few extra herbs.', '/static/fotos/52887.jpg'),
(52888, 'Eccles Cakes', 'Dessert', 'British', 'To make the pastry, dice the butter and put it in the freezer to go really hard. Tip flour into the bowl of a food processor with half the butter and pulse to the texture of breadcrumbs. Pour in the lemon juice and 100ml iced water, and pulse to a dough. Tip in the rest of the butter and pulse a few times until the dough is heavily flecked with butter. It is important that you don’t overdo this as the flecks of butter are what makes the pastry flaky.
On a floured surface roll the pastry out to a neat rectangle about 20 x 30cm. Fold the two ends of the pastry into the middle (See picture 1), then fold in half (pic 2). Roll the pastry out again and refold the same way 3 more times resting the pastry for at least 15 mins each time between roll and fold, then leave to rest in the fridge for at least 30 mins before using.
To make the filling, melt the butter in a large saucepan. Take it off the heat and stir in all the other ingredients until completely mixed, then set aside.
To make the cakes, roll the pastry out until it’s just a little thicker than a £1 coin and cut out 8 rounds about 12cm across. Re-roll the trimming if needed. Place a good heaped tablespoon of mixture in the middle of each round, brush the edges of the rounds with water, then gather the pastry around the filling and squeeze it together (pic 3). Flip them over so the smooth top is upwards and pat them into a smooth round. Flatten each round with a rolling pin to an oval until the fruit just starts to poke through, then place on a baking tray. Cut 2 little slits in each Eccles cakes, brush generously with egg white and sprinkle with the sugar (pic 4).
Heat the oven to 220C/200C fan/gas 8. Bake the Eccles cakes for 15-20 mins until just past golden brown and sticky. Leave to cool on a rack and enjoy while still warm or cold with a cup of tea. If you prefer, Eccles cakes also go really well served with a wedge of hard, tangy British cheese such as Lancashire or cheddar.', '/static/fotos/52888.jpg'),
(52889, 'Summer Pudding', 'Dessert', 'British', 'Bring out the juices: Wash fruit and gently dry on kitchen paper – keep strawberries separate. Put sugar and 3 tbsp water into a large pan. Gently heat until sugar dissolves – stir a few times. Bring to a boil for 1 min, then tip in the fruit (not strawberries). Cook for 3 mins over a low heat, stirring 2-3 times. The fruit will be softened, mostly intact and surrounded by dark red juice. Put a sieve over a bowl and tip in the fruit and juice.
Line the bowl with cling film and prepare the bread: Line the 1.25-litre basin with cling film as this will help you to turn out the pudding. Overlap two pieces of cling film in the middle of the bowl as it’s easier than trying to get one sheet to stick to all of the curves. Let the edges overhang by about 15cm. Cut the crusts off the bread. Cut 4 pieces of bread in half, a little on an angle, to give 2 lopsided rectangles per piece. Cut 2 slices into 4 triangles each and leave the final piece whole.
Build the pud: Dip the whole piece of bread into the juice for a few secs just to coat. Push this into the bottom of the basin. Now dip the wonky rectangular pieces one at a time and press around the basin’s sides so that they fit together neatly, alternately placing wide and narrow ends up. If you can’t quite fit the last piece of bread in it doesn’t matter, just trim into a triangle, dip in juice and slot in. Now spoon in the softened fruit, adding the strawberries here and there as you go.
Let flavours mingle then serve: Dip the bread triangles in juice and place on top – trim off overhang with scissors. Keep leftover juice for later. Bring cling film up and loosely seal. Put a side plate on top and weight down with cans. Chill for 6 hrs or overnight. To serve, open out cling film then put a serving plate upside-down on top and flip over. serve with leftover juice, any extra berries and cream.', '/static/fotos/52889.jpg'),
(52890, 'Jam Roly-Poly', 'Dessert', 'British', 'Put a deep roasting tin onto the bottom shelf of the oven, and make sure that there’s another shelf directly above it. Pull the roasting tin out on its shelf, fill two-thirds with boiling water from the kettle, then carefully slide it back in. Heat oven to 180C/160C fan/gas 4. Tear off a large sheet of foil and greaseproof paper (about 30 x 40cm). Sit the greaseproof on top of the foil and butter it.
Tip butter, flour and vanilla seeds into a food processor; pulse until the butter has disappeared. Tip into a mixing bowl. Stir through the suet, pour in the milk and work together with a cutlery knife until you get a sticky dough. You may need a drop more milk, depending on your flour.
Tip the dough out onto a floured surface, quickly pat together to smooth, then roll out to a square roughly 25 x 25cm. Spread the jam all over, leaving a gap along one edge, then roll up from the opposite edge. Pinch the jam-free edge into the dough where it meets, and pinch the ends roughly, too. Carefully lift onto the greased paper, join-side down (you might find a flat baking sheet helpful for this), loosely bring up the paper and foil around it, then scrunch together along the edges and ends to seal. The roly-poly will puff quite a bit during cooking so don’t wrap it tightly. Lift the parcel directly onto the rack above the tin and cook for 1 hr.
Let the pudding sit for 5 mins before unwrapping, then carefully open the foil and paper, and thickly slice to serve.', '/static/fotos/52890.jpg'),
(52891, 'Blackberry Fool', 'Dessert', 'British', 'For the biscuits, preheat the oven to 200C/180C (fan)/Gas 6 and line two large baking trays with baking parchment. Scatter the nuts over a baking tray and roast in the oven for 6-8 minutes, or until golden-brown. Watch them carefully so that they don’t have a chance to burn. Remove from the oven, tip onto a board and leave to cool.
Put the butter and sugar in a large bowl and beat with a wooden spoon until light and creamy. Roughly chop the cooled nuts and add to the creamed butter and sugar, along with the lemon zest, flour and baking powder. Stir well until the mixture comes together and forms a ball – you may need to use your hands.
Divide the biscuit dough into 24 even pieces and roll into small balls. Place the balls the prepared baking trays, spaced well apart to allow for spreading.
Press the biscuits to flatten to around 1cm/½in thick. Bake the biscuits, one tray at a time, for 12 minutes or until very pale golden-brown. Leave to cool on the trays. They will be very soft when you take them out of the oven, but will crisp as they cool.
Store in an airtight tin and eat within five days.
For the fool, rinse the blackberries in a colander to wash away any dust or dirt. Put the blackberries in a non-stick saucepan and sprinkle over the caster sugar.
Stir in the lemon juice and heat gently for two minutes, or until the blackberries begin to soften and release their juices. Remove and reserve 12 blackberries for decoration and continue cooking the rest.
Simmer the blackberries very gently for 15 minutes, stirring regularly until very soft and squidgy. Remove from the heat and press the berries and juice through a sieve over a bowl, using the bottom of a ladle to help you extract as much of the purée as possible. Leave the purée to cool and discard the seeds. You should end up with around 325ml/11fl oz of purée.
Put the cream and yoghurt in a large bowl and whip with an electric whisk until soft peaks form when the whisk is removed from the bowl – the acidity of the fruit will thicken the cream further, so don’t take it too far.
When the purée is completely cold, adjust the sweetness to taste by adding more sugar if needed. Pour it into the bowl with the whipped cream and yoghurt and stir just once or twice until very lightly combined.
Spoon the blackberry fool into individual wide, glass dishes – or one large, single bowl. It should look quite marbled, so don’t over-stir it. Scatter a few tiny mint leaves on top and decorate with the reserved blackberries. Sprinkle with a little sugar if you like and serve with the hazelnut biscuits.', '/static/fotos/52891.jpg'),
(52892, 'Treacle Tart', 'Dessert', 'British', 'First make the short crust pastry: measure the flour into a large bowl and rub in the butter with your fingertips until the mixture resembles fine breadcrumbs (alternatively, this can be done in a food processor). Add about three tablespoons of cold water and mix to a firm dough, wrap in cling film and chill in the fridge for about 20 minutes.
Preheat the oven to 200C/400F/Gas 6 and put a heavy baking tray in the oven to heat up. Grease a deep 18cm/7in loose-bottomed fluted flan tin with butter.
Remove about 150g/5½oz of pastry from the main ball and set aside for the lattice top.
Roll the rest of the pastry out thinly on a lightly floured work surface and line the prepared flan tin with the pastry.
Prick the base with a fork, to stop the base rising up during baking.
Place the reserved pastry for the lattice top on cling film and roll out thinly. Egg wash the pastry and set aside to chill in the fridge (the cling film makes it easier to move about). Do not cut into strips at this stage. Do not egg wash the strips once they are on the tart as it will drip into the treacle mixture.
To make the filling, heat the syrup gently in a large pan but do not boil.
Once melted, add the breadcrumbs, lemon juice and zest to the syrup. (You can add less lemon if you would prefer less citrus taste.) If the mixture looks runny, add a few more breadcrumbs.
Pour the syrup mixture into the lined tin and level the surface.
Remove the reserved pastry from the fridge and cut into long strips, 1cm/½in wide. Make sure they are all longer than the edges of the tart tin.
Egg wash the edge of the pastry in the tin, and start to make the woven laying lattice pattern over the mixture, leave the strips hanging over the edge of the tin.
Once the lattice is in place, use the tin edge to cut off the strips by pressing down with your hands, creating a neat finish.
Bake on the pre-heated baking tray in the hot oven for about 10 minutes until the pastry has started to colour, and then reduce the oven temperature to 180C/350F/Gas 4. If at this stage the lattice seems to be getting too dark brown, cover the tart with tin foil.
Bake for a further 25-30 minutes until the pastry is golden-brown and the filling set.
Remove the tart from the oven and leave to firm up in the tin. Serve warm or cold.', '/static/fotos/52892.jpg'),
(52893, 'Apple & Blackberry Crumble', 'Dessert', 'British', 'Heat oven to 190C/170C fan/gas 5. Tip the flour and sugar into a large bowl. Add the butter, then rub into the flour using your fingertips to make a light breadcrumb texture. Do not overwork it or the crumble will become heavy. Sprinkle the mixture evenly over a baking sheet and bake for 15 mins or until lightly coloured.
Meanwhile, for the compote, peel, core and cut the apples into 2cm dice. Put the butter and sugar in a medium saucepan and melt together over a medium heat. Cook for 3 mins until the mixture turns to a light caramel. Stir in the apples and cook for 3 mins. Add the blackberries and cinnamon, and cook for 3 mins more. Cover, remove from the heat, then leave for 2-3 mins to continue cooking in the warmth of the pan.
To serve, spoon the warm fruit into an ovenproof gratin dish, top with the crumble mix, then reheat in the oven for 5-10 mins. Serve with vanilla ice cream.', '/static/fotos/52893.jpg'),
(52894, 'Battenberg Cake', 'Dessert', 'British', 'Heat oven to 180C/160C fan/gas 4 and line the base and sides of a 20cm square tin with baking parchment (the easiest way is to cross 2 x 20cm-long strips over the base). To make the almond sponge, put the butter, sugar, flour, ground almonds, baking powder, eggs, vanilla and almond extract in a large bowl. Beat with an electric whisk until the mix comes together smoothly. Scrape into the tin, spreading to the corners, and bake for 25-30 mins – when you poke in a skewer, it should come out clean. Cool in the tin for 10 mins, then transfer to a wire rack to finish cooling while you make the second sponge.
For the pink sponge, line the tin as above. Mix all the ingredients together as above, but don’t add the almond extract. Fold in some pink food colouring. Then scrape it all into the tin and bake as before. Cool.
To assemble, heat the jam in a small pan until runny, then sieve. Barely trim two opposite edges from the almond sponge, then well trim a third edge. Roughly measure the height of the sponge, then cutting from the well-trimmed edge, use a ruler to help you cut 4 slices each the same width as the sponge height. Discard or nibble leftover sponge. Repeat with pink cake.
Take 2 x almond slices and 2 x pink slices and trim so they are all the same length. Roll out one marzipan block on a surface lightly dusted with icing sugar to just over 20cm wide, then keep rolling lengthways until the marzipan is roughly 0.5cm thick. Brush with apricot jam, then lay a pink and an almond slice side by side at one end of the marzipan, brushing jam in between to stick sponges, and leaving 4cm clear marzipan at the end. Brush more jam on top of the sponges, then sandwich remaining 2 slices on top, alternating colours to give a checkerboard effect. Trim the marzipan to the length of the cakes.
Carefully lift up the marzipan and smooth over the cake with your hands, but leave a small marzipan fold along the bottom edge before you stick it to the first side. Trim opposite side to match size of fold, then crimp edges using fingers and thumb (or, more simply, press with prongs of fork). If you like, mark the 10 slices using the prongs of a fork.
Assemble second Battenberg and keep in an airtight box or well wrapped in cling film for up to 3 days. Can be frozen for up to a month.', '/static/fotos/52894.jpg'),
(52895, 'English Breakfast', 'Breakfast', 'British', 'Heat the flat grill plate over a low heat, on top of 2 rings/flames if it fits, and brush sparingly with light olive oil.
Cook the sausages first. Add the sausages to the hot grill plate/the coolest part if there is one and allow to cook slowly for about 15-20 minutes, turning occasionally, until golden. After the first 10 minutes, increase the heat to medium before beginning to cook the other ingredients. If you are struggling for space, completely cook the sausages and keep hot on a plate in the oven.
Snip a few small cuts into the fatty edge of the bacon. Place the bacon straight on to the grill plate and fry for 2-4 minutes each side or until your preferred crispiness is reached. Like the sausages, the cooked bacon can be kept hot on a plate in the oven.
For the mushrooms, brush away any dirt using a pastry brush and trim the stalk level with the mushroom top. Season with salt and pepper and drizzle over a little olive oil. Place stalk-side up on the grill plate and cook for 1-2 minutes before turning and cooking for a further 3-4 minutes. Avoid moving the mushrooms too much while cooking, as this releases the natural juices, making them soggy.
For the tomatoes, cut the tomatoes across the centre/or in half lengthways if using plum tomatoes , and with a small, sharp knife remove the green ''eye''. Season with salt and pepper and drizzle with a little olive oil. Place cut-side down on the grill plate and cook without moving for 2 minutes. Gently turn over and season again. Cook for a further 2-3 minutes until tender but still holding their shape.
For the black pudding, cut the black pudding into 3-4 slices and remove the skin. Place on the grill plate and cook for 1½-2 minutes each side until slightly crispy.
For ''proper'' fried bread it''s best to cook it in a separate pan. Ideally, use bread that is a couple of days old. Heat a frying pan to a medium heat and cover the base with oil. Add the bread and cook for 2-3 minutes each side until crispy and golden. If the pan becomes too dry, add a little more oil. For a richer flavour, add a knob of butter after you turn the slice.
For the fried eggs, break the egg straight into the pan with the fried bread and leave for 30 seconds. Add a good knob of butter and lightly splash/baste the egg with the butter when melted. Cook to your preferred stage, season and gently remove with a fish slice.
Once all the ingredients are cooked, serve on warm plates and enjoy straight away with a good squeeze of tomato ketchup or brown sauce.', '/static/fotos/52895.jpg'),
(52896, 'Full English Breakfast', 'Breakfast', 'British', 'Heat the flat grill plate over a low heat, on top of 2 rings/flames if it fits, and brush sparingly with light olive oil.
Cook the sausages first. Add the sausages to the hot grill plate/the coolest part if there is one and allow to cook slowly for about 15-20 minutes, turning occasionally, until golden. After the first 10 minutes, increase the heat to medium before beginning to cook the other ingredients. If you are struggling for space, completely cook the sausages and keep hot on a plate in the oven.
Snip a few small cuts into the fatty edge of the bacon. Place the bacon straight on to the grill plate and fry for 2-4 minutes each side or until your preferred crispiness is reached. Like the sausages, the cooked bacon can be kept hot on a plate in the oven.
For the mushrooms, brush away any dirt using a pastry brush and trim the stalk level with the mushroom top. Season with salt and pepper and drizzle over a little olive oil. Place stalk-side up on the grill plate and cook for 1-2 minutes before turning and cooking for a further 3-4 minutes. Avoid moving the mushrooms too much while cooking, as this releases the natural juices, making them soggy.
For the tomatoes, cut the tomatoes across the centre/or in half lengthways if using plum tomatoes , and with a small, sharp knife remove the green ''eye''. Season with salt and pepper and drizzle with a little olive oil. Place cut-side down on the grill plate and cook without moving for 2 minutes. Gently turn over and season again. Cook for a further 2-3 minutes until tender but still holding their shape.
For the black pudding, cut the black pudding into 3-4 slices and remove the skin. Place on the grill plate and cook for 1½-2 minutes each side until slightly crispy.
For ''proper'' fried bread it''s best to cook it in a separate pan. Ideally, use bread that is a couple of days old. Heat a frying pan to a medium heat and cover the base with oil. Add the bread and cook for 2-3 minutes each side until crispy and golden. If the pan becomes too dry, add a little more oil. For a richer flavour, add a knob of butter after you turn the slice.
For the fried eggs, break the egg straight into the pan with the fried bread and leave for 30 seconds. Add a good knob of butter and lightly splash/baste the egg with the butter when melted. Cook to your preferred stage, season and gently remove with a fish slice.
Once all the ingredients are cooked, serve on warm plates and enjoy straight away with a good squeeze of tomato ketchup or brown sauce.', '/static/fotos/52896.jpg'),
(52897, 'Carrot Cake', 'Dessert', 'British', 'For the carrot cake, preheat the oven to 160C/325F/Gas 3. Grease and line a 26cm/10in springform cake tin.
Mix all of the ingredients for the carrot cake, except the carrots and walnuts, together in a bowl until well combined. Stir in the carrots and walnuts.
Spoon the mixture into the cake tin and bake for 1 hour 15 minutes, or until a skewer inserted into the middle comes out clean. Remove the cake from the oven and set aside to cool for 10 minutes, then carefully remove the cake from the tin and set aside to cool completely on a cooling rack.
Meanwhile, for the icing, beat the cream cheese, caster sugar and butter together in a bowl until fluffy. Spread the icing over the top of the cake with a palette knife.', '/static/fotos/52897.jpg'),
(52898, 'Chelsea Buns', 'Dessert', 'British', 'Sift the flour and salt into a large bowl. Make a well in the middle and add the yeast.
Meanwhile, warm the milk and butter in a saucepan until the butter melts and the mixture is lukewarm.
Add the milk mixture and egg to the flour mixture and stir until the contents of the bowl come together as a soft dough. (You may need to add a little extra flour.)
Tip the dough onto a generously floured work surface. Knead for five minutes, adding more flour if necessary, until the dough is smooth and elastic and no longer feels sticky.
Lightly oil a bowl with a little of the vegetable oil. Place the dough into the bowl and turn until it is covered in the oil. Cover the bowl with cling film and set aside in a warm place for one hour, or until the dough has doubled in size.
Lightly grease a baking tray.
For the filling, knock the dough back to its original size and turn out onto a lightly floured work surface. Roll the dough out into a rectangle 0.5cm/¼in thick. Brush all over with the melted butter, then sprinkle over the brown sugar, cinnamon and dried fruit.
Roll the dough up into a tight cylinder , cut ten 4cm/1½in slice and place them onto a lightly greased baking sheet, leaving a little space between each slice. Cover with a tea towel and set aside to rise for 30 minutes.
Preheat oven to 190C/375F/Gas 5.
Bake the buns in the oven for 20-25 minutes, or until risen and golden-brown.
Meanwhile, for the glaze, heat the milk and sugar in a saucepan until boiling. Reduce the heat and simmer for 2-3 minutes.
Remove the buns from the oven and brush with the glaze, then set aside to cool on a wire rack.', '/static/fotos/52898.jpg'),
(52899, 'Dundee cake', 'Dessert', 'British', 'Put the almonds into a small bowl and pour over boiling water to just cover. Leave for 5 mins then drain in a sieve and leave to dry.
Preheat the oven to 180C/160 C fan/Gas Mark 4. Line a deep loose-based 20cm cake tin with baking parchment.
Put the butter in a large bowl and beat well until soft. Add the sugar and beat until light and fluffy. Stir in the orange zest and apricot jam.
Sieve together the flour and baking powder. Add the eggs to the creamed butter and sugar, a little at a time, beating well between each addition. If the mixture starts to curdle, stir in a little flour.
Add the remaining flour and ground almonds and mix well. Mix in the milk and then add the dried fruit and cherries and mix gently together.
Spoon the mixture into the prepared tin and spread level using the back of a spoon. Arrange the whole almonds close together in neat circles on the top of the cake. Bake in the oven for 45 mins.
Lower the oven temperature to 160C/140 C fan/Gas Mark 3 and cook for a further 60–80 minutes. Check the cake after 50 minutes by inserting a wooden or metal skewer into the cake. When it’s done it should have just a few crumbs attached. Check every 10 minutes - it’s important not to overcook this cake so the centre will be a little soft.
When cooked, remove the cake briefly from the oven, put the milk and sugar into a small pan and heat gently until the sugar has dissolved. Brush over the top of the cake and return the cake to the oven for 2-3 mins. Remove and allow the cake to cool in the tin. When quite cold remove from the tin and wrap in foil and keep for at least 2 days before cutting.', '/static/fotos/52899.jpg'),
(52900, 'Madeira Cake', 'Dessert', 'British', 'Pre-heat the oven to 180C/350F/Gas 4. Grease an 18cm/7in round cake tin, line the base with greaseproof paper and grease the paper.
Cream the butter and sugar together in a bowl until pale and fluffy. Beat in the eggs, one at a time, beating the mixture well between each one and adding a tablespoon of the flour with the last egg to prevent the mixture curdling.
Sift the flour and gently fold in, with enough milk to give a mixture that falls slowly from the spoon. Fold in the lemon zest.
Spoon the mixture into the prepared tin and lightly level the top. Bake on the middle shelf of the oven for 30-40 minutes, or until golden-brown on top and a skewer inserted into the centre comes out clean.
Remove from the oven and set aside to cool in the tin for 10 minutes, then turn it out on to a wire rack and leave to cool completely.
To serve, decorate the cake with the candied peel.', '/static/fotos/52900.jpg'),
(52901, 'Rock Cakes', 'Dessert', 'British', 'Preheat oven to 180C/350F/Gas 4 and line a baking tray with baking parchment.
Mix the flour, sugar and baking powder in a bowl and rub in the cubed butter until the mixture looks like breadcrumbs, then mix in the dried fruit.
In a clean bowl, beat the egg and milk together with the vanilla extract.
Add the egg mixture to the dry ingredients and stir with a spoon until the mixture just comes together as a thick, lumpy dough. Add a teaspoon more milk if you really need it to make the mixture stick together.
Place golfball-sized spoons of the mixture onto the prepared baking tray. Leave space between them as they will flatten and spread out to double their size during baking.
Bake for 15-20 minutes, until golden-brown. Remove from the oven, allow to cool for a couple of minutes then turn them out onto a wire rack to cool.', '/static/fotos/52901.jpg'),
(52902, 'Parkin Cake', 'Dessert', 'British', 'Heat oven to 160C/140C fan/gas 3. Grease a deep 22cm/9in square cake tin and line with baking parchment. Beat the egg and milk together with a fork.

Gently melt the syrup, treacle, sugar and butter together in a large pan until the sugar has dissolved. Remove from the heat. Mix together the oatmeal, flour and ginger and stir into the syrup mixture, followed by the egg and milk.

Pour the mixture into the tin and bake for 50 mins - 1 hr until the cake feels firm and a little crusty on top. Cool in the tin then wrap in more parchment and foil and keep for 3-5 days before eating if you can – it’ll become softer and stickier the longer you leave it, up to 2 weeks.
', '/static/fotos/52902.jpg'),
(52903, 'French Onion Soup', 'Side', 'France', 'Melt the butter with the oil in a large heavy-based pan. Add the onions and fry with the lid on for 10 mins until soft. Sprinkle in the sugar and cook for 20 mins more, stirring frequently, until caramelised. The onions should be really golden, full of flavour and soft when pinched between your fingers. Take care towards the end to ensure that they don’t burn.
Add the garlic for the final few mins of the onions’ cooking time, then sprinkle in the flour and stir well. Increase the heat and keep stirring as you gradually add the wine, followed by the hot stock. Cover and simmer for 15-20 mins.
To serve, turn on the grill, and toast the bread. Ladle the soup into heatproof bowls. Put a slice or two of toast on top of the bowls of soup, and pile on the cheese. Grill until melted. Alternatively, you can complete the toasts under the grill, then serve them on top.', '/static/fotos/52903.jpg'),
(52904, 'Beef Bourguignon', 'Beef', 'France', 'Heat a large casserole pan and add 1 tbsp goose fat. Season the beef and fry until golden brown, about 3-5 mins, then turn over and fry the other side until the meat is browned all over, adding more fat if necessary. Do this in 2-3 batches, transferring the meat to a colander set over a bowl when browned.
In the same pan, fry the bacon, shallots or pearl onions, mushrooms, garlic and bouquet garni until lightly browned. Mix in the tomato purée and cook for a few mins, stirring into the mixture. This enriches the bourguignon and makes a great base for the stew. Then return the beef and any drained juices to the pan and stir through.
Pour over the wine and about 100ml water so the meat bobs up from the liquid, but isn’t completely covered. Bring to the boil and use a spoon to scrape the caramelised cooking juices from the bottom of the pan – this will give the stew more flavour.
Heat oven to 150C/fan 130C/gas 2. Make a cartouche: tear off a square of foil slightly larger than the casserole, arrange it in the pan so it covers the top of the stew and trim away any excess foil. Then cook for 3 hrs. If the sauce looks watery, remove the beef and veg with a slotted spoon, and set aside. Cook the sauce over a high heat for a few mins until the sauce has thickened a little, then return the beef and vegetables to the pan.
To make the celeriac mash, peel the celeriac and cut into cubes. Heat the olive oil in a large frying pan. Tip in the celeriac and fry for 5 mins until it turns golden. Season well with salt and pepper. Stir in the rosemary, thyme, bay and cardamom pods, then pour over 200ml water, enough to nearly cover the celeriac. Turn the heat to low, partially cover the pan and leave to simmer for 25-30 mins.
After 25-30 mins, the celeriac should be soft and most of the water will have evaporated. Drain away any remaining water, then remove the herb sprigs, bay and cardamom pods. Lightly crush with a potato masher, then finish with a glug of olive oil and season to taste. Spoon the beef bourguignon into serving bowls and place a large spoonful of the celeriac mash on top. Garnish with one of the bay leaves, if you like.', '/static/fotos/52904.jpg'),
(52905, 'Chocolate Souffle', 'Dessert', 'France', 'Heat oven to 220C/fan 200C/gas 7 and place a baking tray on the top shelf. For the sauce, heat the cream and sugar until boiling. Remove from the heat, stir in the chocolate and butter until melted, then keep warm.
Brush 6 x 150ml ramekins with melted butter, sprinkle with the 2 tbsp caster sugar, then tip out any excess. Melt the chocolate and cream in a bowl over a pan of simmering water, cool, then mix in the egg yolks. Whisk the egg whites until they hold their shape, then add the sugar, 1 tbsp at a time, whisking back to the same consistency. Mix a spoonful into the chocolate, then gently fold in the rest.
Working quickly, fill the ramekins, wipe the rims clean and run your thumb around the edges. Turn oven down to 200C/fan 180C/gas 6, place the ramekins onto the baking tray, then bake for 8-10 mins until risen with a slight wobble. Don’t open the oven door too early as this may make them collapse.
Once the soufflés are ready, dust with icing sugar, scoop a small hole from their tops, then pour in some of the hot chocolate sauce. Replace the lids and serve straight away.', '/static/fotos/52905.jpg'),
(52906, 'Flamiche', 'Vegetarian', 'France', 'For the pastry, sift the flour and salt into the bowl of a food processor, add the butter and lard, then whizz together briefly until the mixture looks like fine breadcrumbs. Tip the mixture into a bowl, then stir in the cheese and enough of the water for the mixture to come together. Tip out onto a lightly floured surface and knead briefly until smooth. Roll out thinly and line a 23cm x 4cm loose-?bottomed fluted flan tin. Prick the base with a fork. Chill for 20 minutes.
02.Melt the 75g butter in a saucepan over a low heat, then add the leeks and the salt. Cover and cook for ?10 minutes until soft. Uncover the pan, increase the heat and cook ?for 2 minutes, stirring occasionally, until the liquid has evaporated. Spoon onto a plate and leave to cool.
03.Preheat the oven to 200°C/fan180°C/gas 6. Line the pastry case with baking paper and baking beans or rice and blind bake for 15-20 minutes until the edges are biscuit-coloured. Remove the paper and beans/rice and return the case to the oven for 7-10 minutes until the base is crisp and lightly golden. Remove and set aside. Reduce the oven temperature to 190°C/fan170°C/gas 5.
04.Put the crème fraîche into a bowl with the whole egg, egg yolks and nutmeg. Lightly beat together, then season. Stir in the leeks. Spoon ?the mixture into the tart case and bake for 35-40 minutes until set ?and lightly golden. Remove from ?the oven and leave for 10 minutes. Take out of the tin and serve.', '/static/fotos/52906.jpg'),
(52907, 'Duck Confit', 'Miscellaneous', 'France', 'The day before you want to make the dish, scatter half the salt, half the garlic and half of the herbs over the base of a small shallow dish. Lay the duck legs, skin-side up, on top, then scatter over the remaining salt, garlic and herbs. Cover the duck and refrigerate overnight. This can be done up to 2 days ahead.
Pour the wine into a saucepan that will snugly fit the duck legs in a single layer. Brush the salt off the duck legs and place them, skin-side down, in the wine. Cover the pan with a lid and place over a medium heat. As soon as the wine starts to bubble, turn the heat down to the lowest setting and cook for 2 hours, checking occasionally that the liquid is just barely simmering. (If you own a heat diffuser, it would be good to use it here.) After 2 hours, the duck legs should be submerged in their own fat and the meat should feel incredibly tender when prodded. Leave to cool.
The duck legs are now cooked and can be eaten immediately – or you can follow the next step if you like them crisp. If you are preparing ahead, pack the duck legs tightly into a plastic container or jar and pour over the fat, but not the liquid at the bottom of the pan. Cover and leave in the fridge for up to a month, or freeze for up to 3 months. The liquid you are left with makes a tasty gravy, which can be chilled or frozen until needed.
To reheat and crisp up the duck legs, heat oven to 220C/fan 200C/gas 7. Remove the legs from the fat and place them, skin-side down, in an ovenproof frying pan. Roast for 30-40 mins, turning halfway through, until brown and crisp. Serve with the reheated gravy, a crisp salad and some crisp golden ptoatoes.', '/static/fotos/52907.jpg'),
(52908, 'Ratatouille', 'Vegetarian', 'France', 'Cut the aubergines in half lengthways. Place them on the board, cut side down, slice in half lengthways again and then across into 1.5cm chunks. Cut off the courgettes ends, then across into 1.5cm slices. Peel the peppers from stalk to bottom. Hold upright, cut around the stalk, then cut into 3 pieces. Cut away any membrane, then chop into bite-size chunks.
Score a small cross on the base of each tomato, then put them into a heatproof bowl. Pour boiling water over the tomatoes, leave for 20 secs, then remove. Pour the water away, replace the tomatoes and cover with cold water. Leave to cool, then peel the skin away. Quarter the tomatoes, scrape away the seeds with a spoon, then roughly chop the flesh.
Set a sauté pan over medium heat and when hot, pour in 2 tbsp olive oil. Brown the aubergines for 5 mins on each side until the pieces are soft. Set them aside and fry the courgettes in another tbsp oil for 5 mins, until golden on both sides. Repeat with the peppers. Don’t overcook the vegetables at this stage, as they have some more cooking left in the next step.
Tear up the basil leaves and set aside. Cook the onion in the pan for 5 mins. Add the garlic and fry for a further min. Stir in the vinegar and sugar, then tip in the tomatoes and half the basil. Return the vegetables to the pan with some salt and pepper and cook for 5 mins. Serve with basil.', '/static/fotos/52908.jpg'),
(52909, 'Tarte Tatin', 'Dessert', 'France', 'Roll the pastry to a 3mm-thick round on a lightly floured surface and cut a 24cm circle, using a plate as a guide. Lightly prick all over with a fork, wrap in cling film on a baking sheet and freeze while preparing the apples.
Heat oven to 180C/160C fan/gas 4. Peel, quarter and core the apples. Put the sugar in a flameproof 20cm ceramic Tatin dish or a 20cm ovenproof heavy-based frying pan and place over a medium-high heat. Cook the sugar for 5-7 mins to a dark amber caramel syrup that’s starting to smoke, then turn off the heat and stir in the 60g diced chilled butter.
To assemble the Tarte Tatin, arrange the apple quarters very tightly in a circle around the edge of the dish first, rounded-side down, then fill in the middle in a similar fashion. Gently press with your hands to ensure there are no gaps. Brush the fruit with the melted butter.
Bake in the oven for 30 mins, then remove and place the disc of frozen puff pastry on top – it will quickly defrost. Tuck the edges down the inside of the dish and, with a knife, prick a few holes in the pastry to allow steam to escape. Bake for a further 40-45 mins until the pastry is golden brown and crisp.
Allow to cool to room temperature for 1 hr before running a knife around the edge of the dish and inverting it onto a large serving plate that is deep enough to contain the juices. Serve with crème fraîche or vanilla ice cream.', '/static/fotos/52909.jpg'),
(52910, 'Chinon Apple Tarts', 'Dessert', 'France', 'To make the red wine jelly, put the red wine, jam sugar, star anise, clove, cinnamon stick, allspice, split vanilla pod and seeds in a medium saucepan. Stir together, then heat gently to dissolve the sugar. Turn up the heat and boil for 20 mins until reduced and syrupy. Strain into a small, sterilised jam jar and leave to cool completely. Will keep in the fridge for up to 1 month.

Take the pastry out of the fridge and leave at room temperature for 10 mins, then unroll. Heat the grill to high and heat the oven to 180C/160C fan/gas 4. Cut out 2 x 13cm circles of pastry, using a plate as a guide, and place on a non-stick baking sheet. Sprinkle each circle with 1 tbsp sugar and grill for 5 mins to caramelise, watching carefully so that the sugar doesn’t burn. Remove from the grill. Can be done a few hours ahead, and left, covered, out of the fridge.

Peel, quarter and core the apples, cut into 2mm-thin slices and arrange on top of the pastry. Sprinkle over the remaining sugar and pop in the oven for 20-25 mins until the pastry is cooked through and golden, and the apples are softened. Remove and allow to cool slightly. Warm 3 tbsp of the red wine jelly in a small pan over a low heat with 1 tsp water to make it a little more runny, then brush over the top of the tarts.

Tip the crème fraîche into a bowl, sift over the icing sugar and cardamom, and mix together. Carefully lift the warm tarts onto serving plates and serve with the cardamom crème fraîche.', '/static/fotos/52910.jpg'),
(52911, 'Summer Pistou', 'Vegetarian', 'France', 'Heat the oil in a large pan and fry the leeks and courgette for 5 mins to soften. Pour in the stock, add three-quarters of the haricot beans with the green beans, half the tomatoes, and simmer for 5-8 mins until the vegetables are tender.
Meanwhile, blitz the remaining beans and tomatoes, the garlic and basil in a food processor (or in a bowl with a stick blender) until smooth, then stir in the Parmesan. Stir the sauce into the soup, cook for 1 min, then ladle half into bowls or pour into a flask for a packed lunch. Chill the remainder. Will keep for a couple of days.', '/static/fotos/52911.jpg'),
(52912, 'Three-cheese souffles', 'Miscellaneous', 'France', 'Heat oven to 200C/180C fan/ gas 6 and butter 4 small (about 200ml) ramekins. Sprinkle the Parmesan into the ramekins, turning until all sides are covered. Place the milk and bay leaves in a large saucepan over a gentle heat and bring to the boil. Turn off the heat and leave to infuse for 15 mins.
Discard the bay leaves, add the butter and flour, and return to a low heat. Very gently simmer, stirring continuously with a balloon whisk, for about 6 mins until you get a smooth, thick white sauce. Make sure that you get right into the corners of the pan to stop the sauce from catching or becoming lumpy.
Once thickened, transfer the sauce to a large bowl and stir in the mustard powder, cayenne pepper, Gruyère and egg yolks until fully combined.
In a spotlessly clean bowl and with a clean whisk, beat the egg whites just until peaks begin to form.
Carefully fold the egg whites into the cheese sauce in three stages making sure you fold, rather than stir, to keep the egg whites light and airy. Fill the prepared ramekins with the soufflé mix.
Top each soufflé with a slice of goat’s cheese, then place on a baking tray. Bake for 20-25 mins or until springy and well risen but cooked through.
Leave to cool, then run a knife around the edge of each dish and remove the soufflés. If preparing in advance, place soufflés upside down (for neat presentation), on a tray. Cover tray in cling film. Chill for a few days or freeze for up to 1 month.
When ready to re-bake, heat oven to 200C/180C fan/gas 6. Place the upside-down soufflés in a shallow baking dish, top with the remaining goat’s cheese slices and pour over the cream (this stops them from drying out when baked for the second time). Cook for 8-10 mins until golden. Serve immediately alongside some simply dressed salad.', '/static/fotos/52912.jpg'),
(52913, 'Brie wrapped in prosciutto & brioche', 'Side', 'France', 'Mix the flour, 1 tsp salt, caster sugar, yeast, milk and eggs together in a mixer using the dough attachment for 5 mins until the dough is smooth. Add the butter and mix for a further 4 mins on medium speed. Scrape the dough bowl and mix again for 1 min. Place the dough in a container, cover with cling film and leave in the fridge for at least 6 hrs before using.
Wrap the Brie in the prosciutto and set aside. Turn out the dough onto a lightly floured surface. Roll into a 25cm circle. Place the wrapped Brie in the middle of the circle and fold the edges in neatly. Put the parcel onto a baking tray lined with baking parchment and brush with beaten egg. Chill in the fridge for 30 mins, then brush again with beaten egg and chill for a further 30 mins. Leave to rise for 1 hr at room temperature. Heat oven to 200C/180C fan/gas 6, then bake for 22 mins. Serve warm.', '/static/fotos/52913.jpg'),
(52914, 'Boulangère Potatoes', 'Side', 'France', 'Heat oven to 200C/fan 180C/gas 6. Fry the onions and thyme sprigs in the oil until softened and lightly coloured (about 5 mins).
Spread a layer of potatoes over the base of a 1.5-litre oiled gratin dish. Sprinkle over a few onions (see picture, above) and continue layering, finishing with a layer of potatoes. Pour over the stock and bake for 50-60 mins until the potatoes are cooked and the top is golden and crisp.', '/static/fotos/52914.jpg'),
(52915, 'French Omelette', 'Miscellaneous', 'France', 'Get everything ready. Warm a 20cm (measured across the top) non-stick frying pan on a medium heat. Crack the eggs into a bowl and beat them with a fork so they break up and mix, but not as completely as you would for scrambled egg. With the heat on medium-hot, drop one knob of butter into the pan. It should bubble and sizzle, but not brown. Season the eggs with the Parmesan and a little salt and pepper, and pour into the pan.
Let the eggs bubble slightly for a couple of seconds, then take a wooden fork or spatula and gently draw the mixture in from the sides of the pan a few times, so it gathers in folds in the centre. Leave for a few seconds, then stir again to lightly combine uncooked egg with cooked. Leave briefly again, and when partly cooked, stir a bit faster, stopping while there’s some barely cooked egg left. With the pan flat on the heat, shake it back and forth a few times to settle the mixture. It should slide easily in the pan and look soft and moist on top. A quick burst of heat will brown the underside.
Grip the handle underneath. Tilt the pan down away from you and let the omelette fall to the edge. Fold the side nearest to you over by a third with your fork, and keep it rolling over, so the omelette tips onto a plate – or fold it in half, if that’s easier. For a neat finish, cover the omelette with a piece of kitchen paper and plump it up a bit with your fingers. Rub the other knob of butter over to glaze. Serve immediately.', '/static/fotos/52915.jpg'),
(52916, 'Pear Tarte Tatin', 'Dessert', 'France', 'Core the pears, then peel as neatly as possible and halve. If you like, they can be prepared up to a day ahead and kept in the fridge, uncovered, so that they dry out.
Tip the sugar, butter, star anise, cardamom and cinnamon into an ovenproof frying pan, about 20cm wide, and place over a high heat until bubbling. Shake the pan and stir the buttery sauce until it separates and the sugar caramelises to a toffee colour.
Lay the pears in the pan, then cook in the sauce for 10-12 mins, tossing occasionally, until completely caramelised. Don’t worry about them burning – they won’t – but you want to caramelise them as much as possible. Splash in the brandy and let it flambé, then set the pears aside.
Heat oven to 200C/fan 180C/gas 6. Roll the pastry out to the thickness of a £1 coin. Using a plate slightly larger than the top of the pan, cut out a circle, then press the edges of the circle of pastry to thin them out.
When the pears have cooled slightly, arrange them in the pan, cut side up, in a floral shape, with the pears around the edge pointing inwards. Rest the cinnamon stick on the top in the centre, with the cardamom pods scattered around.
Drape the pastry over the pears, then tuck the edges down the pan sides and under the fruit (see Gordon’s guide). Pierce the pastry a few times, then bake for 15 mins. If a lot of juice bubbles up the side of the pan, pour it off at this stage (see guide). Reduce oven to 180C/fan 160C/gas 4 and bake for 15 mins more until the pastry is golden. Leave the tart to stand for 10 mins, then invert it carefully onto a serving dish.', '/static/fotos/52916.jpg'),
(52917, 'White chocolate creme brulee', 'Dessert', 'France', 'Heat the cream, chocolate and vanilla pod in a pan until the chocolate has melted. Take off the heat and allow to infuse for 10 mins, scraping the pod seeds into the cream. If using the vanilla extract, add straight away. Heat oven to 160C/fan 140C/gas 3.
Beat yolks and sugar until pale. stir in the chocolate cream. Strain into a jug and pour into ramekins. Place in a deep roasting tray and pour boiling water halfway up the sides. Bake for 15-20 mins until just set with a wobbly centre. Chill in the fridge for at least 4 hrs.
To serve, sprinkle some sugar on top of the brûlées and caramelise with a blowtorch or briefly under a hot grill. Leave caramel to harden, then serve.', '/static/fotos/52917.jpg'),
(52918, 'Fish Stew with Rouille', 'Seafood', 'France', 'Twist the heads from the prawns, then peel away the legs and shells, but leave the tails intact. Devein each prawn. Fry the shells in 1 tbsp oil for 5 mins, until dark pink and golden in patches. Add the wine, boil down by two thirds, then pour in the stock. Strain into a jug, discarding the shells.
Heat the rest of the oil in a deep frying pan or casserole. Add the fennel, onion and garlic, season, then cover and gently cook for 10 mins until softened. Meanwhile, peel the potato and cut into 2cm-ish chunks. Put into a pan of cold water, bring to the boil and cook for 5 mins until almost tender. Drain in a colander.
Peel a strip of zest from the orange. Put the zest, star anise, bay and ½ tsp harissa into the pan. Fry gently, uncovered, for 5-10 mins, until the vegetables are soft, sweet and golden.
Stir in the tomato purée, cook for 2 mins, then add the tomatoes and stock. Simmer for 10 mins until the sauce thickens slightly. Season to taste. The sauce can be made ahead, then reheated later in the day. Meantime, scrub the mussels or clams and pull away any stringy beards. Any that are open should be tapped sharply on the worktop – if they don’t close after a few seconds, discard them.
Reheat the sauce if necessary, then stir the potato, chunks of fish and prawns very gently into the stew. Bring back to the boil, then cover and gently simmer for 3 mins. Scatter the mussels or clams over the stew, then cover and cook for 2 mins more or until the shells have opened wide. Discard any that remain closed. The chunks of fish should flake easily and the prawns should be pink through. Scatter with the thyme leaves.
To make the quick rouille, stir the rest of the harissa through the mayonnaise. Serve the stew in bowls, topped with spoonfuls of rouille, which will melt into the sauce and enrich it. Have some good bread ready, as you’ll definitely want to mop up the juices.', '/static/fotos/52918.jpg'),
(52919, 'Fennel Dauphinoise', 'Side', 'France', 'Heat oven to 180C/160C fan/gas 4. Put potatoes, fennel, and garlic in a medium non-stick pan. Pour in milk and double cream, season well and simmer gently, covered, for 10 mins, stirring halfway through, until potatoes are just tender.
Divide the mixture between 2 small (about 150ml) buttered ramekins and scatter with Parmesan. Bake for 40 mins until the potatoes are golden and tender when pierced with a knife. Snip the reserved fennel fronds over before serving.', '/static/fotos/52919.jpg'),
(52920, 'Chicken Marengo', 'Chicken', 'France', 'Heat the oil in a large flameproof casserole dish and stir-fry the mushrooms until they start to soften. Add the chicken legs and cook briefly on each side to colour them a little.
Pour in the passata, crumble in the stock cube and stir in the olives. Season with black pepper – you shouldn’t need salt. Cover and simmer for 40 mins until the chicken is tender. Sprinkle with parsley and serve with pasta and a salad, or mash and green veg, if you like.', '/static/fotos/52920.jpg'),
(52921, 'Provençal Omelette Cake', 'Vegetarian', 'France', 'Break the eggs into two bowls, five in each. Whisk lightly and season with salt and pepper. Heat the oil in a pan, add the courgettes and spring onions, then fry gently for about 10 mins until softened. Cool, then stir into one bowl of eggs with a little salt and pepper. Add the roasted peppers to the other bowl of eggs with the garlic, chilli, salt and pepper.
Heat a little oil in a 20-23cm frying pan, preferably non-stick. Pour the eggs with courgette into a measuring jug, then pourabout one-third of the mixture into the pan, swirling it to cover the base of the pan. Cook until the egg is set and lightly browned underneath, then cover the pan with a plate and invert the omelette onto it. Slide it back into the pan to cook the other side. Repeat with the remaining mix to make two more omelettes, adding a little oil to the pan each time. Stack the omelettes onto a plate. Make three omelettes in the same way with the red pepper mixture, then stack them on a separate plate.
Now make the filling. Beat the cheese to soften it, then beat in the milk to make a spreadable consistency. Stir in the herbs, salt and pepper. Line a deep, 20-23cm round cake tin with cling film (use a tin the same size as the frying pan). Select the best red pepper omelette and place in the tin, prettiest side down. Spread with a thin layer of cheese filling, then cover with a courgette omelette. Repeat, alternating the layers, until all the omelettes and filling are in the tin, finishing with an omelette. Flip the cling film over the omelette, then chill for up to 24 hrs.
To serve, invert the omelette cake onto a serving plate and peel off the cling film. Pile rocket on the top and scatter over the cheese, a drizzle of olive oil and a little freshly ground black pepper. Serve cut into wedges.', '/static/fotos/52921.jpg'),
(52922, 'Prawn & Fennel Bisque', 'Side', 'France', 'Shell the prawns, then fry the shells in the oil in a large pan for about 5 mins. Add the onion, fennel and carrots and cook for about 10 mins until the veg start to soften. Pour in the wine and brandy, bubble hard for about 1 min to drive off the alcohol, then add the tomatoes, stock and paprika. Cover and simmer for 30 mins. Meanwhile, chop the prawns.
Blitz the soup as finely as you can with a stick blender or food processor, then press through a sieve into a bowl. Spend a bit of time really working the mixture through the sieve as this will give the soup its velvety texture.
Tip back into a clean pan, add the prawns and cook for 10 mins, then blitz again until smooth. You can make and chill this a day ahead or freeze it for 1 month. Thaw ovenight in the fridge. To serve, gently reheat in a pan with the cream. If garnishing, cook the 8 prawns in a little butter. Spoon into small bowls and top with the prawns and snipped fennel fronds.', '/static/fotos/52922.jpg'),
(52923, 'Canadian Butter Tarts', 'Dessert', 'Canadian', 'Preheat the oven to fan 170C/ conventional 190C/gas 5. Roll out the pastry on a lightly floured surface so it’s slightly thinner than straight from the pack. Then cut out 18-20 rounds with a 7.5cm fluted cutter, re-rolling the trimmings. Use the rounds to line two deep 12-hole tart tins (not muffin tins). If you only have a regular-sized, 12-hole tart tin you will be able to make a few more slightly shallower tarts.
Beat the eggs in a large bowl and combine with the rest of the ingredients except the walnuts. Tip this mixture into a pan and stir continuously for 3-4 minutes until the butter melts, and the mixture bubbles and starts to thicken. It should be thick enough to coat the back of a wooden spoon. Don’t overcook, and be sure to stir all the time as the mixture can easily burn. Remove from the heat and stir in the nuts.
Spoon the filling into the unbaked tart shells so it’s level with the pastry. Bake for 15-18 minutes until set and pale golden. Leave in the tin to cool for a few minutes before lifting out on to a wire rack. Serve warm or cold.', '/static/fotos/52923.jpg'),
(52924, 'Nanaimo Bars', 'Dessert', 'Canadian', 'Start by making the biscuit base. In a bowl, over a pan of simmering water, melt the butter with the sugar and cocoa powder, stirring occasionally until smooth. Whisk in the egg for 2 to 3 mins until the mixture has thickened. Remove from heat and mix in the biscuit crumbs, coconut and almonds if using, then press into the base of a lined 20cm square tin. Chill for 10 mins.
For the middle layer, make the custard icing; whisk together the butter, cream and custard powder until light and fluffy, then gradually add the icing sugar until fully incorporated. Spread over the bottom layer and chill in the fridge for at least 10 mins until the custard is no longer soft.
Melt the chocolate and butter together in the microwave, then spread over the chilled bars and put back in the fridge. Leave until the chocolate has fully set (about 2 hrs). Take the mixture out of the tin and slice into squares to serve.', '/static/fotos/52924.jpg'),
(52925, 'Split Pea Soup', 'Side', 'Canadian', 'Put the gammon in a very large pan with 2 litres water and bring to the boil. Remove from the heat and drain off the water – this helps to get rid of some of the saltiness. Recover with 2 litres cold water and bring to the boil again. Put everything but the frozen peas into the pan and bring to the boil. Reduce to a simmer and cook for 1½-2½ hrs, topping up the water as and when you need to, to a similar level it started at. As the ham cooks and softens, you can halve it if you want, so it is all submerged under the liquid. When the ham is tender enough to pull into shreds, it is ready.
Lift out the ham, peel off and discard the skin. While it is still hot (wear a clean pair of rubber gloves), shred the meat. Remove bay from the soup and stir in the frozen peas. Simmer for 1 min, then blend until smooth. Add a splash of water if too thick, and return to the pan to heat through if it has cooled, or if you are making ahead.
When you are ready to serve, mix the hot soup with most of the ham – gently reheat if made ahead. Serve in bowls with the remaining ham scattered on top, and eat with crusty bread and butter.', '/static/fotos/52925.jpg'),
(52926, 'Tourtiere', 'Pork', 'Canadian', 'Heat oven to 200C/180C fan/gas 6. Boil the potato until tender, drain and mash, then leave to cool. Heat the oil in a non-stick pan, add the mince and onion and quickly fry until browned. Add the garlic, spices, stock, plenty of pepper and a little salt and mix well. Remove from the heat, stir into the potato and leave to cool.
Roll out half the pastry and line the base of a 20-23cm pie plate or flan tin. Fill with the pork mixture and brush the edges of the pastry with water. Roll out the remaining dough and cover the pie. Press the edges of the pastry to seal, trimming off the excess. Prick the top of the pastry case to allow steam to escape and glaze the top with the beaten egg.
Bake for 30 mins until the pastry is crisp and golden. Serve cut into wedges with a crisp green salad. Leftovers are good cold for lunch the next day, served with a selection of pickles.', '/static/fotos/52926.jpg'),
(52927, 'Montreal Smoked Meat', 'Beef', 'Canadian', 'To make the cure, in a small bowl mix together salt, pink salt, black pepper, coriander, sugar, bay leaf, and cloves. Coat entire brisket with the cure and place in an extra-large resealable plastic bag. Place in the coldest part of the refrigerator and cure for 4 days, flipping brisket twice a day.
Remove brisket from bag and wash as much cure off as possible under cold running water. Place brisket in a large container and fill with water and let soak for 2 hours, replacing water every 30 minutes. Remove from water and pat dry with paper towels.
To make the rub, mix together black pepper, coriander, paprika, garlic powder, onion powder, dill weed, mustard, celery seed, and crushed red papper in a small bowl. Coat entire brisket with the rub.
Fire up smoker or grill to 225 degrees, adding chunks of smoking wood chunks when at temperature. When wood is ignited and producing smoke, place brisket in, fat side up, and smoke until an instant read thermometer registers 165 degrees when inserted into thickest part of the brisket, about 6 hours.
Transfer brisket to large roasting pan with V-rack. Place roasting pan over two burners on stovetop and fill with 1-inch of water. Bring water to a boil over high heat, reduce heat to medium, cover roasting pan with aluminum foil, and steam brisket until an instant read thermometer registers 180 degrees when inserted into thickest part of the meat, 1 to 2 hours, adding more hot water as needed.
Transfer brisket to cutting board and let cool slightly. Slice and serve, preferably on rye with mustard.', '/static/fotos/52927.jpg'),
(52928, 'BeaverTails', 'Dessert', 'Canadian', 'In the bowl of a stand mixer, add warm water, a big pinch of sugar and yeast. Allow to sit until frothy.
Into the same bowl, add 1/2 cup sugar, warm milk, melted butter, eggs and salt, and whisk until combined.
Place a dough hook on the mixer, add the flour with the machine on, until a smooth but slightly sticky dough forms.
Place dough in a bowl, cover with plastic wrap, and allow to proof for 1 1/2 hours.
Cut dough into 12 pieces, and roll out into long oval-like shapes about 1/4 inch thick that resemble a beaver’s tail.
In a large, deep pot, heat oil to 350 degrees. Gently place beavertail dough into hot oil and cook for 30 to 45 seconds on each side until golden brown.
Drain on paper towels, and garnish as desired. Toss in cinnamon sugar, in white sugar with a squeeze of lemon, or with a generous slathering of Nutella and a handful of toasted almonds. Enjoy!', '/static/fotos/52928.jpg'),
(52929, 'Timbits', 'Dessert', 'Canadian', 'Sift together dry ingredients.
Mix together wet ingredients and incorporate into dry. Stir until smooth.
Drop by teaspoonfuls(no bigger) into hot oil (365 degrees, no hotter), turning after a few moments until golden brown on all sides.
Remove and drain.
Roll in cinnamon sugar while still warm and serve.', '/static/fotos/52929.jpg'),
(52930, 'Pate Chinois', 'Beef', 'Canadian', 'In a large pot of salted water, cook the potatoes until they are very tender. Drain.
With a masher, coarsely crush the potatoes with at least 30 ml (2 tablespoons) of butter. With an electric mixer, purée with the milk. Season with salt and pepper. Set aside.
With the rack in the middle position, preheat the oven to 190 °C (375 °F).
In a large skillet, brown the onion in the remaining butter. Add the meat and cook until golden brown. Season with salt and pepper. Remove from the heat.
Lightly press the meat at the bottom of a 20-cm (8-inch) square baking dish. Cover with the corn and the mashed potatoes. Sprinkle with paprika and parsley.
Bake for about 30 minutes. Finish cooking under the broiler. Let cool for 10 minutes.', '/static/fotos/52930.jpg'),
(52931, 'Sugar Pie', 'Dessert', 'Canadian', 'Preheat oven to 350 degrees F (175 degrees C). Grease a 9-inch pie dish.
Place the brown sugar and butter in a mixing bowl, and beat them together with an electric mixer until creamy and very well combined, without lumps. Beat in eggs, one at a time, incorporating the first egg before adding the next one. Add the vanilla extract and salt; beat the flour in, a little at a time, and then the milk, making a creamy batter. Pour the batter into the prepared pie dish.
Bake in the preheated oven for 35 minutes; remove pie, and cover the rim with aluminum foil to prevent burning. Return to oven, and bake until the middle sets and the top forms a crusty layer, about 15 more minutes. Let the pie cool to room temperature, then refrigerate for at least 1 hour before serving.', '/static/fotos/52931.jpg'),
(52932, 'Pouding chomeur', 'Dessert', 'Canadian', 'In a large bowl, with an electric mixer, mix the butter and sugar till the mix is light.
Add eggs and vanilla and mix.
In another bowl, mix flour and baking powder.
Alternate flour mix and milk to the butter mix.
Pour into a 13 inch by 9 inch greased pan.
MAPLE SAUCE.
In a large casserole, bring to boil the syrup, brown sugar, cream and butter and constantly stir.
Reduce heat and and gently cook 2 minutes or till sauce has reduced a little bit.
Pour sauce gently over cake.
Bake at 325°f (160°c) about 35 minutes or till cake is light brown and when toothpick inserted comes out clean.', '/static/fotos/52932.jpg'),
(52933, 'Rappie Pie', 'Chicken', 'Canadian', 'Preheat oven to 400 degrees F (200 degrees C). Grease a 10x14x2-inch baking pan.
Heat margarine in a skillet over medium heat; stir in onion. Cook and stir until onion has softened and turned translucent, about 5 minutes. Reduce heat to low and continue to cook and stir until onion is very tender and dark brown, about 40 minutes more.
Bring chicken broth to a boil in a large pot; stir in chicken breasts, reduce heat, and simmer until chicken is no longer pink at the center, about 20 minutes. Remove from heat. Remove chicken breasts to a plate using a slotted spoon; reserve broth.
Juice potatoes with an electric juicer; place dry potato flesh into a bowl and discard juice. Stir salt and pepper into potatoes; stir in enough reserved broth to make the mixture the consistency of oatmeal. Set remaining broth aside.
Spread half of potato mixture evenly into the prepared pan. Lay cooked chicken breast evenly over potatoes; scatter caramelized onion evenly over chicken. Spread remaining potato mixture over onions and chicken to cover.
Bake in the preheated oven until golden brown, about 1 hour. Reheat chicken broth; pour over individual servings as desired.', '/static/fotos/52933.jpg'),
(52934, 'Chicken Basquaise', 'Chicken', 'France', 'Preheat the oven to 180°C/Gas mark 4. Have the chicken joints ready to cook. Heat the butter and 3 tbsp olive oil in a flameproof casserole or large frying pan. Brown the chicken pieces in batches on both sides, seasoning them with salt and pepper as you go. Don''t crowd the pan - fry the chicken in small batches, removing the pieces to kitchen paper as they are done.

Add a little more olive oil to the casserole and fry the onions over a medium heat for 10 minutes, stirring frequently, until softened but not browned. Add the rest of the oil, then the peppers and cook for another 5 minutes.

Add the chorizo, sun-dried tomatoes and garlic and cook for 2-3 minutes. Add the rice, stirring to ensure it is well coated in the oil. Stir in the tomato paste, paprika, bay leaves and chopped thyme. Pour in the stock and wine. When the liquid starts to bubble, turn the heat down to a gentle simmer. Press the rice down into the liquid if it isn''t already submerged and place the chicken on top. Add the lemon wedges and olives around the chicken.

Cover and cook in the oven for 50 minutes. The rice should be cooked but still have some bite, and the chicken should have juices that run clear when pierced in the thickest part with a knife. If not, cook for another 5 minutes and check again.', '/static/fotos/52934.jpg'),
(52935, 'Steak Diane', 'Beef', 'France', 'Heat oil in a 12" skillet over medium-high heat. Season steaks with salt and pepper, and add to skillet; cook, turning once, until browned on both sides and cooked to desired doneness, about 4 to 5 minutes for medium-rare. Transfer steaks to a plate, and set aside.
Return skillet to high heat, and add stock; cook until reduced until to 1⁄2 cup, about 10 minutes. Pour into a bowl, and set aside. Return skillet to heat, and add butter; add garlic and shallots, and cook, stirring, until soft, about 2 minutes. Add mushrooms, and cook, stirring, until they release any liquid and it evaporates and mushrooms begin to brown, about 2 minutes. Add cognac, and light with a match to flambée; cook until flame dies down. Stir in reserved stock, cream, Dijon, Worcestershire, and hot sauce, and then return steaks to skillet; cook, turning in sauce, until warmed through and sauce is thickened, about 4 minutes. Transfer steak to serving plates and stir parsley and chives into sauce; pour sauce over steaks to serve.', '/static/fotos/52935.jpg'),
(52936, 'Saltfish and Ackee', 'Seafood', 'Jamaican', 'For the saltfish, soak the salt cod overnight, changing the water a couple of times.
Drain, then put the cod in a large pan of fresh water and bring to the boil. Drain again, add fresh water and bring to the boil again.
Simmer for about five minutes, or until cooked through, then drain and flake the fish into large pieces. Discard any skin or bones.
For the dumplings, mix the flour and suet with a pinch of salt and 250ml/9fl oz water to make a dough.
Wrap the mixture in clingfilm and leave in the fridge to rest.
Open the can of ackee, drain and rinse, then set aside.
Heat a tablespoon of olive oil in a pan and fry the onion until softened but not brown.
Add the spices, seasoning, pepper sauce and sliced peppers and continue to fry until the peppers are tender.
Add the chopped tomatoes, then the salt cod and mix together. Lastly stir in the ackee very gently and leave to simmer until ready to serve.
When you’re almost ready to eat, heat about 1cm/½in vegetable oil in a frying pan and heat until just smoking.
Shape the dumpling mix into plum-size balls and shallow-fry until golden-brown. (CAUTION: hot oil can be dangerous. Do not leave the pan unattended.)
Drain the dumplings on kitchen paper and serve with the saltfish and ackee.', '/static/fotos/52936.jpg'),
(52937, 'Jerk chicken with rice & peas', 'Chicken', 'Jamaican', 'To make the jerk marinade, combine all the ingredients in a food processor along with 1 tsp salt, and blend to a purée. If you’re having trouble getting it to blend, just keep turning off the blender, stirring the mixture, and trying again. Eventually it will start to blend up – don’t be tempted to add water, as you want a thick paste.

Taste the jerk mixture for seasoning – it should taste pretty salty, but not unpleasantly, puckering salty. You can now throw in more chillies if it’s not spicy enough for you. If it tastes too salty and sour, try adding in a bit more brown sugar until the mixture tastes well balanced.

Make a few slashes in the chicken thighs and pour the marinade over the meat, rubbing it into all the crevices. Cover and leave to marinate overnight in the fridge.

If you want to barbecue your chicken, get the coals burning 1 hr or so before you’re ready to cook. Authentic jerked meats are not exactly grilled as we think of grilling, but sort of smoke-grilled. To get a more authentic jerk experience, add some wood chips to your barbecue, and cook your chicken over slow, indirect heat for 30 mins. To cook in the oven, heat to 180C/160C fan/gas 4. Put the chicken pieces in a roasting tin with the lime halves and cook for 45 mins until tender and cooked through.

While the chicken is cooking, prepare the rice & peas. Rinse the rice in plenty of cold water, then tip it into a large saucepan with all the remaining ingredients except the kidney beans. Season with salt, add 300ml cold water and set over a high heat. Once the rice begins to boil, turn it down to a medium heat, cover and cook for 10 mins.

Add the beans to the rice, then cover with a lid. Leave off the heat for 5 mins until all the liquid is absorbed. Squeeze the roasted lime over the chicken and serve with the rice & peas, and some hot sauce if you like it really spicy.', '/static/fotos/52937.jpg'),
(52938, 'Jamaican Beef Patties', 'Beef', 'Jamaican', 'Make the Pastry Dough

To a large bowl, add flour, 1 teaspoon salt, and turmeric and mix thoroughly.
Rub shortening into flour until there are small pieces of shortening completely covered with flour.
Pour in 1/2 cup of the ice water and mix with your hands to bring the dough together. Keep adding ice water 2 to 3 tablespoons at a time until the mixture forms a dough.
At this stage, you can cut the dough into 2 large pieces, wrap in plastic and refrigerate for 30 minutes before using it.
Alternatively, cut the dough into 10 to 12 equal pieces, place on a platter or baking sheet, cover securely with plastic wrap and let chill for 30 minutes while you make the filling.
Make the Filling

Add ground beef to a large bowl. Sprinkle in allspice and black pepper. Mix together and set aside.
Heat oil in a skillet until hot.
Add onions and sauté until translucent. Add hot pepper, garlic and thyme and continue to sauté for another minute. Add 1/4 teaspoon salt.
Add seasoned ground beef and toss to mix, breaking up any clumps, and let cook until the meat is no longer pink.
Add ketchup and more salt to taste.
Pour in 2 cups of water and stir. Bring the mixture to a boil then reduce heat and let simmer until most of the liquid has evaporated and whatever is remaining has reduced to a thick sauce.
Fold in green onions. Remove from heat and let cool completely.
Assemble the Patties

Beat the egg and water together to make an egg wash. Set aside.
Now you can prepare the dough in two ways.
First Method: Flour the work surface and rolling pin. If you had cut it into 2 large pieces, then take one of the large pieces and roll it out into a very large circle. Take a bowl with a wide rim (about 5 inches) and cut out three circles.

Place about 3 heaping tablespoons of the filling onto 1/2 of each circle. Dip a finger into the water and moisten the edges of the pastry. Fold over the other half and press to seal. 

Take a fork and crimp the edges. Cut off any extra to make it look neat and uniform. Place on a parchment-lined baking sheet and continue to work until you have rolled all the dough and filled the patties.
Second Method: If you had pre-cut the dough into individual pieces, work with one piece of dough at a time. Roll it out on a floured surface into a 5-inch circle or a little larger. Don’t worry if the edges are not perfect.

Place 3 heaping tablespoons of the filling on one side of the circle. Dip a finger into the water and moisten the edges of the pastry. Fold over the other half and press to seal.

Take a fork and crimp the edges. Cut off any extra to make it look neat and uniform. Place on a parchment-lined baking sheet and continue work until you have rolled all the dough and filled the patties.

Frying and Serving the Patties

After forming the patties, place the pans in the refrigerator while you heat the oven to 350 F.
Just before adding the pans with the patties to the oven, brush the patties with egg wash.
Bake patties for 30 minutes or until golden brown.
Cool on wire racks.
Serve warm.', '/static/fotos/52938.jpg'),
(52939, 'Callaloo Jamaican Style', 'Miscellaneous', 'Jamaican', 'Cut leaves and soft stems from the kale branches, them soak in a bowl of cold water for about 5-10 minutes or until finish with prep.
Proceed to slicing the onions, mincing the garlic and dicing the tomatoes. Set aside
Remove kale from water cut in chunks.
Place bacon on saucepan and cook until crispy. Then add onions, garlic, thyme, stir for about a minute or more
Add tomatoes; scotch bonnet pepper, smoked paprika. Sauté for about 2-3 more minutes.
Finally add vegetable, salt, mix well, and steamed for about 6-8 minutes or until leaves are tender. Add a tiny bit of water as needed. Adjust seasonings and turn off the heat.
Using a sharp knife cut both ends off the plantain. This will make it easy to grab the skin of the plantains. Slit a shallow line down the long seam of the plantain; peel only as deep as the peel. Remove plantain peel by pulling it back.
Slice the plantain into medium size lengthwise slices and set aside.
Coat a large frying pan with cooking oil spray. Spray the tops of the plantains with a generous layer of oil spray and sprinkle with salt, freshly ground pepper.
Let the plantains "fry" on medium heat, shaking the frying pan to redistribute them every few minutes.
As the plantains brown, continue to add more cooking oil spray, salt and pepper (if needed) until they have reached the desired color and texture.
Remove and serve with kale', '/static/fotos/52939.jpg'),
(52940, 'Brown Stew Chicken', 'Chicken', 'Jamaican', 'Squeeze lime over chicken and rub well. Drain off excess lime juice.
Combine tomato, scallion, onion, garlic, pepper, thyme, pimento and soy sauce in a large bowl with the chicken pieces. Cover and marinate at least one hour.
Heat oil in a dutch pot or large saucepan. Shake off the seasonings as you remove each piece of chicken from the marinade. Reserve the marinade for sauce.
Lightly brown the chicken a few pieces at a time in very hot oil. Place browned chicken pieces on a plate to rest while you brown the remaining pieces.
Drain off excess oil and return the chicken to the pan. Pour the marinade over the chicken and add the carrots. Stir and cook over medium heat for 10 minutes.
Mix flour and coconut milk and add to stew, stirring constantly. Turn heat down to minimum and cook another 20 minutes or until tender.', '/static/fotos/52940.jpg'),
(52941, 'Red Peas Soup', 'Beef', 'Jamaican', 'Wash and rinse the dried kidney beans.. then cover with water in a deep bowl. Remember as they soak they will expand to at least triple the size they were originally so add a lot of water to the bowl. Soak them overnight or for at least 2 hrs to make the cooking step go quicker. I tossed out the water they were soaked in after it did the job.

Have your butcher cut the salted pigtail into 2 inch pieces as it will be very difficult to cut with an ordinary kitchen knife. Wash, then place a deep pot with water and bring to a boil. Cook for 20 minutes, then drain + rinse and repeat (boil again in water). The goal is to make the pieces of pig tails tender and to remove most of the salt it was cured in.

Time to start the soup. Place everything in the pot (except the flour and potato), then cover with water and place on a high flame to bring to a boil. As it comes to a boil, skim off any scum/froth at the top and discard. Reduce the heat to a gentle boil and allow it to cook for 1 hr and 15 mins.. basically until the beans are tender and start falling apart.

It’s now time to add the potato (and Yams etc if you’re adding it) as well as the coconut milk and continue cooking for 15 minutes.

Now is a good time to start making the basic dough for the spinner dumplings. Mix the flour and water (add a pinch of salt if you want) until you have a soft/smooth dough. allow it to rest for 5 minutes, then pinch of a tablespoon at a time and roll between your hands to form a cigarette shape.

Add them to the pot, stir well and continue cooking for another 15 minutes on a rolling boil.

You’ll notice that I didn’t add any salt to the pot as the remaining salt from the salted pigtails will be enough to properly season this dish. However you can taste and adjust accordingly. Lets recap the timing part of things so you’re not confused. Cook the base of the soup for 1 hr and 15 minute or until tender, then add the potatoes and cook for 15 minutes, then add the dumplings and cook for a further 15 minutes. Keep in mind that this soup will thicken quite a bit as it cools.

While this is not a traditional recipe to any one specific island, versions of this soup (sometimes called stewed peas) can be found throughout the Caribbean, Latin America and Africa. A hearty bowl of this soup will surely give you the sleepies (some may call it ethnic fatigue). You can certainly freeze the leftovers and heat it up another day.', '/static/fotos/52941.jpg'),
(52942, 'Roast fennel and aubergine paella', 'Vegan', 'Spanish', '1 Put the fennel, aubergine, pepper and courgette in a roasting tray. Add a glug of olive oil, season with salt and pepper and toss around to coat the veggies in the oil. Roast in the oven for 20 minutes, turning a couple of times until the veg are pretty much cooked through and turning golden.

2 Meanwhile, heat a paella pan or large frying pan over a low– medium heat and add a glug of olive oil. Sauté the onion for 8–10 minutes until softened. Increase the heat to medium and stir in the rice, paprika and saffron. Cook for around 1 minute to start toasting the rice, then add the white wine. Reduce by about half before stirring in two-thirds of the stock. Reduce to a simmer and cook for 10 minutes without a lid, stirring a couple of times.

3 Stir in the peas, add some seasoning, then gently mix in the roasted veg. Pour over the remaining stock, arrange the lemon wedges on top and cover with a lid or some aluminium foil. Cook for a further 10 minutes.

4 To ensure you get the classic layer of toasted rice at the bottom of the pan, increase the heat to high until you hear a slight crackle. Remove from the heat and sit for 5 minutes before sprinkling over the parsley and serving.', '/static/fotos/52942.jpg'),
(52943, 'Oxtail with broad beans', 'Beef', 'Jamaican', 'Toss the oxtail with the onion, spring onion, garlic, ginger, chilli, soy sauce, thyme, salt and pepper. Heat the vegetable oil in a large frying pan over medium-high heat. Brown the oxtail in the pan until browned all over, about 10 minutes. Place into a pressure cooker, and pour in 375ml water. Cook at pressure for 25 minutes, then remove from heat, and remove the lid according to manufacturer''s directions.
Add the broad beans and pimento berries, and bring to a simmer over medium-high heat. Dissolve the cornflour in 2 tablespoons water, and stir into the simmering oxtail. Cook and stir a few minutes until the sauce has thickened, and the broad beans are tender.', '/static/fotos/52943.jpg'),
(52944, 'Escovitch Fish', 'Seafood', 'Jamaican', 'Rinse fish; rub with lemon or lime, seasoned with salt and pepper or use your favorite seasoning. I used creole seasoning. Set aside or place in the oven to keep it warm until sauce is ready.

In large skillet heat oil over medium heat, until hot, add the fish, cook each side- for about 5-7 minutes until cooked through and crispy on both sides. Remove fish and set aside. Drain oil and leave about 2-3 tablespoons of oil
Add, bay leave, garlic and ginger, stir-fry for about a minute making sure the garlic does not burn
Then add onion, bell peppers, thyme, scotch bonnet, sugar, all spice-continue stirring for about 2-3 minutes. Add vinegar, mix an adjust salt and pepper according to preference. Let it simmer for about 2 more minutes. 

Discard bay leave, thyme spring and serve over fish with a side of this bammy. You may make the sauce about 2 days in advance.', '/static/fotos/52944.jpg'),
(52945, 'Kung Pao Chicken', 'Chicken', 'Chinese', 'Combine the sake or rice wine, soy sauce, sesame oil and cornflour dissolved in water. Divide mixture in half.
In a glass dish or bowl, combine half of the sake mixture with the chicken pieces and toss to coat. Cover dish and place in refrigerator for about 30 minutes.
In a medium frying pan, combine remaining sake mixture, chillies, vinegar and sugar. Mix together and add spring onion, garlic, water chestnuts and peanuts. Heat sauce slowly over medium heat until aromatic.
Meanwhile, remove chicken from marinade and sauté in a large frying pan until juices run clear. When sauce is aromatic, add sautéed chicken and let simmer together until sauce thickens.', '/static/fotos/52945.jpg'),
(52946, 'Kung Po Prawns', 'Seafood', 'Chinese', 'Mix the cornflour and 1 tbsp soy sauce, toss in the prawns and set aside for 10 mins. Stir the vinegar, remaining soy sauce, tomato purée, sugar and 2 tbsp water together to make a sauce.

When you’re ready to cook, heat a large frying pan or wok until very hot, then add 1 tbsp oil. Fry the prawns until they are golden in places and have opened out– then tip them out of the pan.

Heat the remaining oil and add the peanuts, chillies and water chestnuts. Stir-fry for 2 mins or until the peanuts start to colour, then add the ginger and garlic and fry for 1 more min. Tip in the prawns and sauce and simmer for 2 mins until thickened slightly. Serve with rice.', '/static/fotos/52946.jpg'),
(52947, 'Ma Po Tofu', 'Beef', 'Chinese', 'Add a small pinch of salt and sesame oil to minced beef. Mix well and set aside.
Mix 1 tablespoon of cornstarch with 2 and ½ tablespoons of water in a small bowl to make water starch.
Cut tofu into square cubes (around 2cms). Bring a large amount of water to a boil and then add a pinch of salt. Slide the tofu in and cook for 1 minute. Move out and drain.
Get a wok and heat up around 2 tablespoons of oil, fry the minced meat until crispy. Transfer out beef out and leave the oil in.
Fry doubanjiang for 1 minute over slow fire and then add garlic, scallion white, ginger and fermented black beans to cook for 30 seconds until aroma. Then mix pepper flakes in.
Add water to the seasonings and bring to boil over high fire. Gently slide the tofu cubes. Add light soy sauce and beef.Slow the heat after boiling and then simmer for 6-8 minutes. Then add chopped garlic greens.
Stir the water starch and then pour half of the mixture to the simmering pot. Wait for around 30 seconds and then pour the other half. You can slightly taste the tofu and add pinch of salt if not salty enough. By the way, if you feel it is too spicy, add some sugar can milder the taste. But be carefully as the broth is very hot at this point.
Transfer out when almost all the seasonings stick to tofu cubes. Sprinkle Szechuan peppercorn powder (to taste)and chopped garlic greens if using.
Serve immediately with steamed rice.', '/static/fotos/52947.jpg'),
(52948, 'Wontons', 'Pork', 'Chinese', 'Combine pork, garlic, ginger, soy sauce, sesame oil, and vegetables in a bowl.
Separate wonton skins.
Place a heaping teaspoon of filling in the center of the wonton.
Brush water on 2 borders of the skin, covering 1/4 inch from the edge.
Fold skin over to form a triangle, sealing edges.
Pinch the two long outside points together.
Heat oil to 450 degrees and fry 4 to 5 at a time until golden.
Drain and serve with sauce.', '/static/fotos/52948.jpg'),
(52949, 'Sweet and Sour Pork', 'Pork', 'Chinese', 'Preparation
1. Crack the egg into a bowl. Separate the egg white and yolk.

Sweet and Sour Pork
2. Slice the pork tenderloin into strips.

3. Prepare the marinade using a pinch of salt, one teaspoon of starch, two teaspoons of light soy sauce, and an egg white.

4. Marinade the pork strips for about 20 minutes.

5. Put the remaining starch in a bowl. Add some water and vinegar to make a starchy sauce.

Sweet and Sour Pork
Cooking Instructions
1. Pour the cooking oil into a wok and heat to 190°C (375°F). Add the marinated pork strips and fry them until they turn brown. Remove the cooked pork from the wok and place on a plate.

2. Leave some oil in the wok. Put the tomato sauce and white sugar into the wok, and heat until the oil and sauce are fully combined.

3. Add some water to the wok and thoroughly heat the sweet and sour sauce before adding the pork strips to it.

4. Pour in the starchy sauce. Stir-fry all the ingredients until the pork and sauce are thoroughly mixed together.

5. Serve on a plate and add some coriander for decoration.', '/static/fotos/52949.jpg'),
(52950, 'Szechuan Beef', 'Beef', 'Chinese', 'STEP 1 - MARINATING THE BEEF
In a bowl, add the beef, salt, sesame seed oil, white pepper, egg white, 2 Tablespoon of corn starch and 1 Tablespoon of oil.
STEP 2 - STIR FRY
First Cook the beef by adding 2 Tablespoon of oil until the beef is golden brown.
Set the beef aside
In a wok add 1 Tablespoon of oil, minced ginger, minced garlic and stir-fry for few seconds.
Next add all of the vegetables and then add sherry cooking wine and 1 cup of water.
To make the sauce add oyster sauce, hot pepper sauce, and sugar.
add the cooked beef and 1 spoon of soy sauce
To thicken the sauce, whisk together 1 Tablespoon of cornstarch and 2 Tablespoon of water in a bowl and slowly add to your stir-fry until it''s the right thickness.', '/static/fotos/52950.jpg'),
(52951, 'General Tsos Chicken', 'Chicken', 'Chinese', 'DIRECTIONS:
STEP 1 - SAUCE
In a bowl, add 2 Cups of water, 2 Tablespoon soy sauce, 2 Tablespoon white vinegar, sherry cooking wine, 1/4 Teaspoon white pepper, minced ginger, minced garlic, hot pepper, ketchup, hoisin sauce, and sugar.
Mix together well and set aside.
STEP 2 - MARINATING THE CHICKEN
In a bowl, add the chicken, 1 pinch of salt, 1 pinch of white pepper, 2 egg whites, and 3 Tablespoon of corn starch
STEP 3 - DEEP FRY THE CHICKEN
Deep fry the chicken at 350 degrees for 3-4 minutes or until it is golden brown and loosen up the chicken so that they don''t stick together.
Set the chicken aside.
STEP 4 - STIR FRY
Add the sauce to the wok and then the broccoli and wait until it is boiling.
To thicken the sauce, whisk together 2 Tablespoon of cornstarch and 4 Tablespoon of water in a bowl and slowly add to your stir-fry until it''s the right thickness.
Next add in the chicken and stir-fry for a minute and serve on a plate', '/static/fotos/52951.jpg'),
(52952, 'Beef Lo Mein', 'Beef', 'Chinese', 'STEP 1 - MARINATING THE BEEF
In a bowl, add the beef, salt, 1 pinch white pepper, 1 Teaspoon sesame seed oil, 1/2 egg, corn starch,1 Tablespoon of oil and mix together.
STEP 2 - BOILING THE THE NOODLES
In a 6 qt pot add your noodles to boiling water until the noodles are submerged and boil on high heat for 10 seconds. After your noodles is done boiling strain and cool with cold water.
STEP 3 - STIR FRY
Add 2 Tablespoons of oil, beef and cook on high heat untill beef is medium cooked.
Set the cooked beef aside
In a wok add 2 Tablespoon of oil, onions, minced garlic, minced ginger, bean sprouts, mushrooms, peapods and 1.5 cups of water or until the vegetables are submerged in water.
Add the noodles to wok
To make the sauce, add oyster sauce, 1 pinch white pepper, 1 teaspoon sesame seed oil, sugar, and 1 Teaspoon of soy sauce.
Next add the beef to wok and stir-fry', '/static/fotos/52952.jpg'),
(52953, 'Shrimp Chow Fun', 'Seafood', 'Chinese', 'STEP 1 - SOAK THE RICE NOODLES
Soak the rice noodles overnight untill they are soft
STEP 2 - BOIL THE RICE NOODLES
Boil the noodles for 10-15 minutes and then rinse with cold water to stop the cooking process of the noodles.
STEP 3 -MARINATING THE SHRIMP
In a bowl add the shrimp, egg, 1 pinch of white pepper, 1 Teaspoon of sesame seed oil, 1 Tablespoon corn starch and 1 tablespoon of oil
Mix together well
STEP 4 - STIR FRY
In a wok add 2 Tablespoons of oil, shrimp and stir fry them until it is golden brown
Set the shrimp aside
Add 1 Tablespoon of oil to the work and then add minced garlic, ginger and all of the vegetables.
Add the noodles to the wok
Next add sherry cooking wine, oyster sauce, sugar, vinegar, sesame seed oil, 1 pinch white pepper, and soy sauce
Add back in the shrimp
To thicken the sauce, whisk together 1 Tablespoon of corn starch and 2 Tablespoon of water in a bowl and slowly add to your stir-fry until it''s the right thickness.', '/static/fotos/52953.jpg'),
(52954, 'Hot and Sour Soup', 'Pork', 'Chinese', 'STEP 1 - MAKING THE SOUP
In a wok add chicken broth and wait for it to boil.
Next add salt, sugar, sesame seed oil, white pepper, hot pepper sauce, vinegar and soy sauce and stir for few seconds.
Add Tofu, mushrooms, black wood ear mushrooms to the wok.
To thicken the sauce, whisk together 1 Tablespoon of cornstarch and 2 Tablespoon of water in a bowl and slowly add to your soup until it''s the right thickness.
Next add 1 egg slightly beaten with a knife or fork and add it to the soup and stir for 8 seconds
Serve the soup in a bowl and add the bbq pork and sliced green onions on top.', '/static/fotos/52954.jpg'),
(52955, 'Egg Drop Soup', 'Vegetarian', 'Chinese', 'In a wok add chicken broth and wait for it to boil.
Next add salt, sugar, white pepper, sesame seed oil.
When the chicken broth is boiling add the vegetables to the wok.
To thicken the sauce, whisk together 1 Tablespoon of cornstarch and 2 Tablespoon of water in a bowl and slowly add to your soup until it''s the right thickness.
Next add 1 egg slightly beaten with a knife or fork and add it to the soup slowly and stir for 8 seconds
Serve the soup in a bowl and add the green onions on top.', '/static/fotos/52955.jpg'),
(52956, 'Chicken Congee', 'Chicken', 'Chinese', 'STEP 1 - MARINATING THE CHICKEN
In a bowl, add chicken, salt, white pepper, ginger juice and then mix it together well.
Set the chicken aside.
STEP 2 - RINSE THE WHITE RICE
Rinse the rice in a metal bowl or pot a couple times and then drain the water.
STEP 2 - BOILING THE WHITE RICE
Next add 8 cups of water and then set the stove on high heat until it is boiling. Once rice porridge starts to boil, set the stove on low heat and then stir it once every 8-10 minutes for around 20-25 minutes.
After 25 minutes, this is optional but you can add a little bit more water to make rice porridge to make it less thick or to your preference.
Next add the marinated chicken to the rice porridge and leave the stove on low heat for another 10 minutes.
After an additional 10 minutes add the green onions, sliced ginger, 1 pinch of salt, 1 pinch of white pepper and stir for 10 seconds.
Serve the rice porridge in a bowl
Optional: add Coriander on top of the rice porridge.', '/static/fotos/52956.jpg'),
(52957, 'Fruit and Cream Cheese Breakfast Pastries', 'Breakfast', 'United States', 'Preheat oven to 400ºF (200ºC), and prepare two cookie sheets with parchment paper. In a bowl, mix cream cheese, sugar, and vanilla until fully combined. Lightly flour the surface and roll out puff pastry on top to flatten. Cut each sheet of puff pastry into 9 equal squares. On the top right and bottom left of the pastry, cut an L shape approximately ½ inch (1 cm) from the edge.
NOTE: This L shape should reach all the way down and across the square, however both L shapes should not meet at the ends. Your pastry should look like a picture frame with two corners still intact.
Take the upper right corner and fold down towards the inner bottom corner. You will now have a diamond shape.
Place 1 to 2 teaspoons of the cream cheese filling in the middle, then place berries on top.
Repeat with the remaining pastry squares and place them onto the parchment covered baking sheet.
Bake for 15-20 minutes or until pastry is golden brown and puffed.
Enjoy!
', '/static/fotos/52957.jpg'),
(52958, 'Peanut Butter Cookies', 'Dessert', 'United States', 'Preheat oven to 350ºF (180ºC).
In a large bowl, mix together the peanut butter, sugar, and egg.
Scoop out a spoonful of dough and roll it into a ball. Place the cookie balls onto a nonstick baking sheet.
For extra decoration and to make them cook more evenly, flatten the cookie balls by pressing a fork down on top of them, then press it down again at a 90º angle to make a criss-cross pattern.
Bake for 8-10 minutes or until the bottom of the cookies are golden brown.
Remove from baking sheet and cool.
Enjoy!', '/static/fotos/52958.jpg'),
(52959, 'Baked salmon with fennel & tomatoes', 'Seafood', 'British', 'Heat oven to 180C/fan 160C/gas 4. Trim the fronds from the fennel and set aside. Cut the fennel bulbs in half, then cut each half into 3 wedges. Cook in boiling salted water for 10 mins, then drain well. Chop the fennel fronds roughly, then mix with the parsley and lemon zest.

Spread the drained fennel over a shallow ovenproof dish, then add the tomatoes. Drizzle with olive oil, then bake for 10 mins. Nestle the salmon among the veg, sprinkle with lemon juice, then bake 15 mins more until the fish is just cooked. Scatter over the parsley and serve.', '/static/fotos/52959.jpg'),
(52960, 'Salmon Avocado Salad', 'Seafood', 'British', 'Season the salmon, then rub with oil. Mix the dressing ingredients together. Halve, stone, peel and slice the avocados. Halve and quarter the cucumber lengthways, then cut into slices. Divide salad, avocado and cucumber between four plates, then drizzle with half the dressing.

Heat a non-stick pan. Add the salmon and fry for 3-4 mins on each side until crisp but still moist inside. Put a salmon fillet on top of each salad and drizzle over the remaining dressing. Serve warm.', '/static/fotos/52960.jpg'),
(52961, 'Budino Di Ricotta', 'Dessert', 'Italian', 'Mash the ricotta and beat well with the egg yolks, stir in the flour, sugar, cinnamon, grated lemon rind and the rum and mix well. You can do this in a food processor. Beat the egg whites until stiff, fold in and pour into a buttered and floured 25cm cake tin. Bake in the oven at 180ºC/160ºC fan/gas 4 for about 40 minutes, or until it is firm.

Serve hot or cold dusted with icing sugar.', '/static/fotos/52961.jpg'),
(52962, 'Salmon Eggs Eggs Benedict', 'Breakfast', 'United States', 'First make the Hollandaise sauce. Put the lemon juice and vinegar in a small bowl, add the egg yolks and whisk with a balloon whisk until light and frothy. Place the bowl over a pan of simmering water and whisk until mixture thickens. Gradually add the butter, whisking constantly until thick – if it looks like it might be splitting, then whisk off the heat for a few mins. Season and keep warm.

To poach the eggs, bring a large pan of water to the boil and add the vinegar. Lower the heat so that the water is simmering gently. Stir the water so you have a slight whirlpool, then slide in the eggs one by one. Cook each for about 4 mins, then remove with a slotted spoon.

Lightly toast and butter the muffins, then put a couple of slices of salmon on each half. Top each with an egg, spoon over some Hollandaise and garnish with chopped chives.', '/static/fotos/52962.jpg'),
(52963, 'Shakshuka', 'Vegetarian', 'Egyptian', 'Heat the oil in a frying pan that has a lid, then soften the onions, chilli, garlic and coriander stalks for 5 mins until soft. Stir in the tomatoes and sugar, then bubble for 8-10 mins until thick. Can be frozen for 1 month.

Using the back of a large spoon, make 4 dips in the sauce, then crack an egg into each one. Put a lid on the pan, then cook over a low heat for 6-8 mins, until the eggs are done to your liking. Scatter with the coriander leaves and serve with crusty bread.', '/static/fotos/52963.jpg'),
(52964, 'Smoked Haddock Kedgeree', 'Breakfast', 'India', 'Melt 50g butter in a large saucepan (about 20cm across), add 1 finely chopped medium onion and cook gently over a medium heat for 5 minutes, until softened but not browned.

Stir in 3 split cardamom pods, ¼ tsp turmeric, 1 small cinnamon stick and 2 bay leaves, then cook for 1 minute.

Tip in 450g basmati rice and stir until it is all well coated in the spicy butter.

Pour in 1 litre chicken or fish stock, add ½ teaspoon salt and bring to the boil, stir once to release any rice from the bottom of the pan. Cover with a close-fitting lid, reduce the heat to low and leave to cook very gently for 12 minutes.

Meanwhile, bring some water to the boil in a large shallow pan. Add 750g un-dyed smoked haddock fillet and simmer for 4 minutes, until the fish is just cooked. Lift it out onto a plate and leave until cool enough to handle.

Hard-boil 3 eggs for 8 minutes.

Flake the fish, discarding any skin and bones. Drain the eggs, cool slightly, then peel and chop. 

Uncover the rice and remove the bay leaves, cinnamon stick and cardamom pods if you wish to. Gently fork in the fish and the chopped eggs, cover again and return to the heat for 2-3 minutes, or until the fish has heated through.

Gently stir in almost all the 3 tbsp chopped fresh parsley, and season with a little salt and black pepper to taste. Serve scattered with the remaining parsley and garnished with 1 lemon, cut into wedges.', '/static/fotos/52964.jpg'),
(52965, 'Breakfast Potatoes', 'Breakfast', 'Canadian', 'Before you do anything, freeze your bacon slices that way when you''re ready to prep, it''ll be so much easier to chop!
Wash the potatoes and cut medium dice into square pieces. To prevent any browning, place the already cut potatoes in a bowl filled with water.
In the meantime, heat 1-2 tablespoons of oil in a large skillet over medium-high heat. Tilt the skillet so the oil spreads evenly.
Once the oil is hot, drain the potatoes and add to the skillet. Season with salt, pepper, and Old Bay as needed.
Cook for 10 minutes, stirring the potatoes often, until brown. If needed, add a tablespoon more of oil.
Chop up the bacon and add to the potatoes. The bacon will start to render and the fat will begin to further cook the potatoes. Toss it up a bit! The bacon will take 5-6 minutes to crisp.
Once the bacon is cooked, reduce the heat to medium-low, add the minced garlic and toss. Season once more. Add dried or fresh parsley. Control heat as needed.
Let the garlic cook until fragrant, about one minute.
Just before serving, drizzle over the maple syrup and toss. Let that cook another minute, giving the potatoes a caramelized effect.
Serve in a warm bowl with a sunny side up egg!', '/static/fotos/52965.jpg'),
(52966, 'Chocolate Caramel Crispy', 'Dessert', 'British', 'Grease and line a 20 x 20cm/8" x 8" baking tin with parchment paper.
Put the mars bars and butter in a heat proof bowl and place over a pan of barely simmering water. Mixing with a whisk, melt until the mixture is smooth.
Pour over the rice krispies in a mixing bowl and mix until all the ingredients are evenly combined. Press evenly into the prepare baking tin and set aside.
Melt the milk chocolate in the microwave or over a pan of barely simmering water.
Spread the melted chocolate over the rice krispie mixture and leave to set in a cool place. Once set slice into squares and serve!', '/static/fotos/52966.jpg'),
(52967, 'Home-made Mandazi', 'Breakfast', 'Kenyan', 'This is one recipe a lot of people have requested and I have tried to make it as simple as possible and I hope it will work for you. Make sure you use the right flour which is basically one with raising agents. Adjust the amount of sugar to your taste and try using different flavours to have variety whenever you have them.
You can use Coconut milk instead of regular milk, you can also add desiccated coconut to the dry flour or other spices like powdered cloves or cinnamon.
For “healthy looking” mandazis do not roll the dough too thin before frying and use the procedure I have indicated above.

1. Mix the flour,cinnamon and sugar in a suitable bowl.
2. In a separate bowl whisk the egg into the milk
3. Make a well at the centre of the flour and add the milk and egg mixture and slowly mix to form a dough.
4. Knead the dough for 3-4 minutes or until it stops sticking to the sides of the bowl and you have a smooth surface.
5. Cover the dough with a damp cloth  and allow to rest for 15 minutes.
6. Roll the dough on a lightly floured surface into a 1cm thick piece.
7. Using a sharp small knife, cut the dough into the desired size setting aside ready for deep frying.
8. Heat your oil in a suitable pot and gently dip the mandazi pieces to cook until light brown on the first side then turn to cook on the second side.
9. Serve them warm or cold', '/static/fotos/52967.jpg'),
(52968, 'Mbuzi Choma (Roasted Goat)', 'Goat', 'Kenyan', '1. Steps for the Meat: 
 Roast meat over medium heat for 50 minutes and salt it as you turn it.

2. Steps for Ugali:
Bring the water and salt to a boil in a heavy-bottomed saucepan. Stir in the cornmeal slowly, letting it fall through the fingers of your hand.

3. Reduce heat to medium-low and continue stirring regularly, smashing any lumps with a spoon, until the mush pulls away from the sides of the pot and becomes very thick, about 10 minutes.

4.Remove from heat and allow to cool.

5. Place the ugali into a large serving bowl. Wet your hands with water, form a ball and serve.

6. Steps for Kachumbari: Mix the tomatoes, onions, chili and coriander leaves in a bowl.

7. Serve and enjoy!

', '/static/fotos/52968.jpg'),
(52969, 'Chakchouka ', 'Miscellaneous', 'Tunisian', 'In a large cast iron skillet or sauté pan with a lid, heat oil over medium high heat. Add the onion and sauté for 2-3 minutes, until softened. Add the peppers and garlic, and sauté for an additional 3-5 minutes. Add the tomatoes, cumin, paprika, salt, and chili powder. Mix well and bring the mixture to a simmer. Reduce the heat to medium low and continue to simmer, uncovered, 10-15 minutes until the mixture has thickened to your desired consistency. (Taste the sauce at this point and adjust for salt and spice, as desired.) Using the back of a spoon, make four craters in the mixture, large enough to hold an egg. Crack one egg into each of the craters. Cover the skillet and simmer for 5-7 minutes, until the eggs have set. Serve immediately with crusty bread or pita.', '/static/fotos/52969.jpg'),
(52970, 'Tunisian Orange Cake', 'Dessert', 'Tunisian', 'Preheat oven to 190 C / Gas 5. Grease a 23cm round springform tin.
Cut off the hard bits from the top and bottom of the orange. Slice the orange and remove all seeds. Puree the orange with its peel in a food processor. Add one third of the sugar and the olive oil and continue to mix until well combined.
Sieve together flour and baking powder.
Beat the eggs and the remaining sugar with an electric hand mixer for at least five minutes until very fluffy. Fold in half of the flour mixture, then the orange and the vanilla, then fold in the remaining flour. Mix well but not for too long.
Pour cake mixture into prepared tin and smooth out. Bake in preheated oven for 20 minutes. Reduce the oven temperature to 160 C / Gas 2 and bake again for 30 minutes Bake until the cake is golden brown and a skewer comes out clean. Cool on a wire cake rack.', '/static/fotos/52970.jpg'),
(52971, 'Kafteji', 'Vegetarian', 'Tunisian', 'Peel potatoes and cut into 5cm cubes.
Pour 1-2 cm of olive oil into a large pan and heat up very hot. Fry potatoes until golden brown for 20 minutes, turning from time to time. Place on kitchen paper to drain.
Cut the peppers in half and remove seeds. Rub a little olive oil on them and place the cut side down on a baking tray. Place them under the grill. Grill until the skin is dark and bubbly. While the peppers are still hot, put them into a plastic sandwich bag and seal it. Take them out after 15 minutes and remove skins.
In the meantime, heat more olive oil another pan. Peel the onions and cut into thin rings. Fry for 15 minutes until golden brown, turning them often. Add the Ras el hanout at the end.
Cut the pumpkin into 5cm cubes and fry in the same pan you used for the potatoes for 10-15 minutes until it is soft and slightly browned. Place on kitchen paper.
Pour the remaining olive oil out of the pan and put all the cooked vegetables into the pan and mix. Whisk eggs and pour them over the vegetables. Put the lid on the pan so that the eggs cook. Put the contents of the pan onto a large chopping board, add salt and pepper and chopped and mix everything with a big knife.', '/static/fotos/52971.jpg'),
(52972, 'Tunisian Lamb Soup', 'Lamb', 'Tunisian', 'Add the lamb to a casserole and cook over high heat. When browned, remove from the heat and set aside.
Keep a tablespoon of fat in the casserole and discard the rest. Reduce to medium heat then add the garlic, onion and spinach and cook until the onion is translucent and the spinach wilted or about 5 minutes.
Return the lamb to the casserole with the onion-spinach mixture, add the tomato puree, cumin, harissa, chicken, chickpeas, lemon juice, salt and pepper in the pan. Simmer over low heat for about 20 minutes.
Add the pasta and cook for 15 minutes or until pasta is cooked.', '/static/fotos/52972.jpg'),
(52973, 'Leblebi Soup', 'Vegetarian', 'Tunisian', 'Heat the oil in a large pot. Add the onion and cook until translucent.
Drain the soaked chickpeas and add them to the pot together with the vegetable stock. Bring to the boil, then reduce the heat and cover. Simmer for 30 minutes.
In the meantime toast the cumin in a small ungreased frying pan, then grind them in a mortar. Add the garlic and salt and pound to a fine paste.
Add the paste and the harissa to the soup and simmer until the chickpeas are tender, about 30 minutes.
Season to taste with salt, pepper and lemon juice and serve hot.', '/static/fotos/52973.jpg'),
(52974, 'Keleya Zaara', 'Lamb', 'Tunisian', 'Heat the vegetable oil in a large frying pan over medium-high heat. Add the lamb and cook until browned on all sides, about 5 minutes. Season with saffron, salt and pepper to taste; stir in all but 4 tablespoons of the onion, and pour in the water. Bring to the boil, then cover, reduce heat to medium-low, and simmer until the lamb is tender, about 15 minutes.
Uncover the pan, stir in the butter and allow the sauce reduce 5 to 10 minutes to desired consistency. Season to taste with salt and pepper, then pour into a serving dish. Sprinkle with the remaining chopped onions and parsley. Garnish with lemon wedges to serve.
', '/static/fotos/52974.jpg'),
(52975, 'Tuna and Egg Briks', 'Seafood', 'Tunisian', 'Heat 2 tsp of the oil in a large saucepan and cook the spring onions over a low heat for 3 minutes or until beginning to soften. Add the spinach, cover with a tight-fitting lid and cook for a further 2–3 minutes or until tender and wilted, stirring once or twice. Tip the mixture into a sieve or colander and leave to drain and cool.
Using a saucer as a guide, cut out 24 rounds about 12.5 cm (5 in) in diameter from the filo pastry, cutting 6 rounds from each sheet. Stack the filo rounds in a pile, then cover with cling film to prevent them from drying out.
When the spinach mixture is cool, squeeze out as much excess liquid as possible, then transfer to a bowl. Add the tuna, eggs, hot pepper sauce, and salt and pepper to taste. Mix well.
Preheat the oven to 200°C (400°F, gas mark 6). Take one filo round and very lightly brush with some of the remaining oil. Top with a second round and brush with a little oil, then place a third round on top and brush with oil.
Place a heaped tbsp of the filling in the middle of the round, then fold the pastry over to make a half-moon shape. Fold in the edges, twisting them to seal, and place on a non-stick baking sheet. Repeat with the remaining pastry and filling to make 8 briks in all.
Lightly brush the briks with the remaining oil. Bake for 12–15 minutes or until the pastry is crisp and golden brown.
Meanwhile, combine the tomatoes and cucumber in a bowl and sprinkle with the lemon juice and seasoning to taste. Serve the briks hot with this salad and the chutney.', '/static/fotos/52975.jpg'),
(52976, 'Cashew Ghoriba Biscuits', 'Dessert', 'Tunisian', 'Preheat the oven at 180 C / Gas 4. Line a baking tray with greaseproof paper.
In a bowl, mix the cashews and icing sugar. Add the egg yolks and orange blossom water and mix to a smooth homogeneous paste.
Take lumps of the cashew paste and shape into small balls. Roll the balls in icing sugar and transfer to the baking tray. Push an almond in the centre of each ghribia.
Bake until the biscuits are lightly golden, about 20 minutes. Keep an eye on them, they burn quickly.', '/static/fotos/52976.jpg'),
(52977, 'Corba', 'Side', 'Turkish', 'Pick through your lentils for any foreign debris, rinse them 2 or 3 times, drain, and set aside.  Fair warning, this will probably turn your lentils into a solid block that you’ll have to break up later
In a large pot over medium-high heat, sauté the olive oil and the onion with a pinch of salt for about 3 minutes, then add the carrots and cook for another 3 minutes.
Add the tomato paste and stir it around for around 1 minute. Now add the cumin, paprika, mint, thyme, black pepper, and red pepper as quickly as you can and stir for 10 seconds to bloom the spices. Congratulate yourself on how amazing your house now smells.
Immediately add the lentils, water, broth, and salt. Bring the soup to a (gentle) boil.
After it has come to a boil, reduce heat to medium-low, cover the pot halfway, and cook for 15-20 minutes or until the lentils have fallen apart and the carrots are completely cooked.
After the soup has cooked and the lentils are tender, blend the soup either in a blender or simply use a hand blender to reach the consistency you desire. Taste for seasoning and add more salt if necessary.
Serve with crushed-up crackers, torn up bread, or something else to add some extra thickness.  You could also use a traditional thickener (like cornstarch or flour), but I prefer to add crackers for some texture and saltiness.  Makes great leftovers, stays good in the fridge for about a week.', '/static/fotos/52977.jpg'),
(52978, 'Kumpir', 'Side', 'Turkish', 'If you order kumpir in Turkey, the standard filling is first, lots of butter mashed into the potato, followed by cheese. There’s then a row of other toppings that you can just point at to your heart’s content – sweetcorn, olives, salami, coleslaw, Russian salad, allsorts – and you walk away with an over-stuffed potato because you got ever-excited by the choices on offer.

Grate (roughly – you can use as much as you like) 150g of cheese.
Finely chop one onion and one sweet red pepper.
Put these ingredients into a large bowl with a good sprinkling of salt and pepper, chilli flakes (optional).', '/static/fotos/52978.jpg'),
(52979, 'Bitterballen (Dutch meatballs)', 'Beef', 'Netherlands', 'Melt the butter in a skillet or pan. When melted, add the flour little by little and stir into a thick paste. Slowly stir in the stock, making sure the roux absorbs the liquid. Simmer for a couple of minutes on a low heat while you stir in the onion, parsley and the shredded meat. The mixture should thicken and turn into a heavy, thick sauce.

Pour the mixture into a shallow container, cover and refrigerate for several hours, or until the sauce has solidified.

Take a heaping tablespoon of the cold, thick sauce and quickly roll it into a small ball. Roll lightly through the flour, then the egg and finally the breadcrumbs. Make sure that the egg covers the whole surface of the bitterbal. When done, refrigerate the snacks while the oil in your fryer heats up to 190C (375F). Fry four bitterballen at a time, until golden.

Serve on a plate with a nice grainy or spicy mustard. 
', '/static/fotos/52979.jpg'),
(52980, 'Stamppot', 'Pork', 'Netherlands', '
Wash and peel the potatoes and cut into similarly sized pieces for even cooking.

In a large soup pot, boil the potatoes and the bay leaves in salted water for 20 minutes. Discard the bay leaves.

If you''re not using a bag of ready-cut curly kale, wash the bunches thoroughly under cool running water to get rid of all soil—you wouldn''t want that gritty texture in your finished dish. Trim any coarse stems and discard any brown leaves. With a sharp knife, cut the curly kale into thin strips.

Peel and chop the shallots.

In a frying pan or skillet, melt 1 tbsp. of butter and saute the shallots for a few minutes before adding the curly kale and 2 tbsp. of water. Season and cook for about 10 minutes, or until tender.

Warm the milk on the stove or in the microwave.

Drain, shake and dry the potatoes with kitchen towels before mashing with a potato masher or ricer. Working quickly, add the warm milk and the remaining butter. Season to taste with nutmeg, salt, and pepper. 

Mix the cooked curly kale through the cooked mashed potato mixture.

Top with slices of the smoked sausage and serve hot with your favorite mustard or gravy.

Serve and enjoy!', '/static/fotos/52980.jpg'),
(52981, 'Snert (Dutch Split Pea Soup)', 'Side', 'Netherlands', 'Gather the ingredients.

In a large soup pot, bring water, split peas, pork belly or bacon, pork chop, and bouillon cube to a boil. Reduce the heat to a simmer, cover and let cook for 45 minutes, stirring occasionally and skimming off any foam that rises to the top. 

Remove the pork chop, debone, and thinly slice the meat. Set aside.

Add the celery, carrots, potato, onion, leek, and celeriac to the soup. Return to the boil, reduce the heat to a simmer and let cook, uncovered, for another 30 minutes, adding a little extra water if the ingredients start to stick to the bottom of the pot.

Add the smoked sausage for the last 15 minutes of cooking time. When the vegetables are tender, remove the bacon and smoked sausage, slice thinly and set aside.

If you prefer a smooth consistency, purée the soup with a stick blender. Season to taste with salt and pepper. Add the meat back to the soup, setting some slices of rookworst aside.

Serve in heated bowls or soup plates, garnished with slices of rookworst and chopped celery leaf.

Enjoy!', '/static/fotos/52981.jpg'),
(52982, 'Spaghetti alla Carbonara', 'Pasta', 'Italian', 'STEP 1
Put a large saucepan of water on to boil.

STEP 2
Finely chop the 100g pancetta, having first removed any rind. Finely grate 50g pecorino cheese and 50g parmesan and mix them together.

STEP 3
Beat the 3 large eggs in a medium bowl and season with a little freshly grated black pepper. Set everything aside.

STEP 4
Add 1 tsp salt to the boiling water, add 350g spaghetti and when the water comes back to the boil, cook at a constant simmer, covered, for 10 minutes or until al dente (just cooked).

STEP 5
Squash 2 peeled plump garlic cloves with the blade of a knife, just to bruise it.

STEP 6
While the spaghetti is cooking, fry the pancetta with the garlic. Drop 50g unsalted butter into a large frying pan or wok and, as soon as the butter has melted, tip in the pancetta and garlic.

STEP 7
Leave to cook on a medium heat for about 5 minutes, stirring often, until the pancetta is golden and crisp. The garlic has now imparted its flavour, so take it out with a slotted spoon and discard.

STEP 8
Keep the heat under the pancetta on low. When the pasta is ready, lift it from the water with a pasta fork or tongs and put it in the frying pan with the pancetta. Don’t worry if a little water drops in the pan as well (you want this to happen) and don’t throw the pasta water away yet.

STEP 9
Mix most of the cheese in with the eggs, keeping a small handful back for sprinkling over later.

STEP 10
Take the pan of spaghetti and pancetta off the heat. Now quickly pour in the eggs and cheese. Using the tongs or a long fork, lift up the spaghetti so it mixes easily with the egg mixture, which thickens but doesn’t scramble, and everything is coated.

STEP 11
Add extra pasta cooking water to keep it saucy (several tablespoons should do it). You don’t want it wet, just moist. Season with a little salt, if needed.

STEP 12
Use a long-pronged fork to twist the pasta on to the serving plate or bowl. Serve immediately with a little sprinkling of the remaining cheese and a grating of black pepper. If the dish does get a little dry before serving, splash in some more hot pasta water and the glossy sauciness will be revived.', '/static/fotos/52982.jpg'),
(52987, 'Lasagna Sandwiches', 'Pasta', 'United States', '1. In a small bowl, combine the first four ingredients; spread on four slices of bread. Layer with bacon, tomato and cheese; top with remaining bread.

2. In a large skillet or griddle, melt 2 tablespoons butter. Toast sandwiches until lightly browned on both sides and cheese is melted, adding butter if necessary.

Nutrition Facts
1 sandwich: 445 calories, 24g fat (12g saturated fat), 66mg cholesterol, 1094mg sodium, 35g carbohydrate (3g sugars, 2g fiber), 21g protein.', '/static/fotos/52987.jpg'),
(52988, 'Classic Christmas pudding', 'Dessert', 'British', 'Get everything for the pudding prepared. Chop the almonds coarsely. Peel, core and chop the cooking apples. Sharpen your knife and chop the candied peel. (You can chop the almonds and apples in a food processor, but the peel must be done by hand.) Grate three quarters of the nutmeg (sounds a lot but it''s correct).

Mix the almonds, apples, candied peel, nutmeg, raisins, flour, breadcrumbs, light muscovado sugar, eggs and 2 tbsp brandy or cognac in a large bowl. 

Holding the butter in its wrapper, grate a quarter of it into the bowl, then stir everything together. Repeat until all the butter is grated, then stir for 3-4 mins – the mixture is ready when it subsides slightly after each stir. Ask the family to stir too, and get everyone to make a wish. 

Generously butter two 1.2 litre bowls and put a circle of baking parchment in the bottom of each. Pack in the pudding mixture. Cover with a double layer of baking parchment, pleating it to allow for expansion, then tie with string (keep the paper in place with a rubber band while tying). Trim off any excess paper. 

Now stand each bowl on a large sheet of foil and bring the edges up over the top, then put another sheet of foil over the top and bring it down underneath to make a double package (this makes the puddings watertight). Tie with more string, and make a handle for easy lifting in and out of the pan. Watch our video to see how to tie up a pudding correctly.

Boil or oven steam the puddings for 8 hrs, topping up with water as necessary. Remove from the pans and leave to cool overnight. When cold, discard the messy wrappings and re-wrap in new baking parchment, foil and string. Store in a cool, dry place until Christmas. 

To make the brandy butter, cream the butter with the orange zest and icing sugar. Gradually beat in the brandy or cognac and chopped stem ginger. Put in a small bowl, fork the top attractively and put in the fridge to set. The butter will keep for a week in the fridge, or it can be frozen for up to six weeks. 

On Christmas Day, boil or oven steam for 1 hr. Unwrap and turn out. To flame, warm 3-4 tbsp brandy in a small pan, pour it over the pudding and set light to it.', '/static/fotos/52988.jpg'),
(52989, 'Christmas Pudding Trifle', 'Dessert', 'British', 'Peel the oranges using a sharp knife, ensuring all the pith is removed. Slice as thinly as possible and arrange over a dinner plate. Sprinkle with the demerara sugar followed by the Grand Marnier and set aside.

Crumble the Christmas pudding into large pieces and scatter over the bottom of a trifle bowl. Lift the oranges onto the pudding in a layer and pour over any juices.

Beat the mascarpone until smooth, then stir in the custard. Spoon the mixture over the top of the oranges.

Lightly whip the cream and spoon over the custard. Sprinkle with the flaked almonds and grated chocolate. You can make this a day in advance if you like, chill until ready to serve.', '/static/fotos/52989.jpg'),
(52990, 'Christmas cake', 'Dessert', 'British', 'Heat oven to 160C/fan 140C/gas 3. Line the base and sides of a 20 cm round, 7.5 cm deep cake tin. Beat the butter and sugar with an electric hand mixer for 1-2 mins until very creamy and pale in colour, scraping down the sides of the bowl half way through. Stir in a spoonful of the flour, then stir in the beaten egg and the rest of the flour alternately, a quarter at a time, beating well each time with a wooden spoon. Stir in the almonds.

Mix in the sherry (the mix will look curdled), then add the peel, cherries, raisins, cherries, nuts, lemon zest, spice, rosewater and vanilla. Beat together to mix, then stir in the baking powder.

Spoon mixture into the tin and smooth the top, making a slight dip in the centre. Bake for 30 mins, then lower temperature to 150C/fan 130C/gas 2 and bake a further 2-2¼ hrs, until a skewer insterted in the middle comes out clean. Leave to cool in the tin, then take out of the tin and peel off the lining paper. When completely cold, wrap well in cling film and foil to store until ready to decorate. The cake will keep for several months.', '/static/fotos/52990.jpg'),
(52991, 'Mince Pies', 'Dessert', 'British', 'To make the pastry, rub 225g cold, diced butter into 350g plain flour, then mix in 100g golden caster sugar and a pinch of salt.

Combine the pastry into a ball – don’t add liquid – and knead it briefly. The dough will be fairly firm, like shortbread dough. You can use the dough immediately, or chill for later.

Preheat the oven to 200C/gas 6/fan 180C. Line 18 holes of two 12-hole patty tins, by pressing small walnut-sized balls of pastry into each hole.

Spoon 280g mincemeat into the pies.

Take slightly smaller balls of pastry than before and pat them out between your hands to make round lids, big enough to cover the pies. 

Top the pies with their lids, pressing the edges gently together to seal – you don’t need to seal them with milk or egg as they will stick on their own. (The pies may now be frozen for up to 1 month).

Beat 1 small egg and brush the tops of the pies. Bake for 20 mins until golden. Leave to cool in the tin for 5 mins, then remove to a wire rack.

To serve, lightly dust with icing sugar.', '/static/fotos/52991.jpg'),
(52992, 'Soy-Glazed Meatloaves with Wasabi Mashed Potatoes & Roasted Carrots', 'Beef', 'United States', '1. Preheat oven to 425 degrees. Wash and dry all produce. Dice potatoes into 1/2-inch pieces. Trim, peel, and cut carrots on a diagonal into 1/2-inch-thick pieces. Trim and thinly slice scallions, separating whites from greens; finely chop whites. Peel and finely chop garlic.

2. In a medium bowl, soak bread with 2 TBSP water (4 TBSP for 4 servings); break up with your hands until pasty. Stir in beef, sriracha, scallion whites, half the garlic, salt (we used 3/4 tsp kosher salt; 11/2 tsp for 4), and pepper. Form into two 1-inch-tall loaves (four loaves for 4). Place on one side of a baking sheet. Toss carrots on empty side of same sheet with a drizzle of oil, salt, and pepper. (For 4, spread meatloaves out across whole sheet and add carrots to a second sheet.) Bake for 20 minutes (we''ll glaze the meatloaves then).

3. Meanwhile, place potatoes in a medium pot with enough salted water to cover by 2 inches. Bring to a boil and cook until very
tender, 12-15 minutes. Reserve 1/2 cup potato cooking liquid, then drain. While potatoes cook, in a small bowl, combine soy sauce, garlic powder, 1/4 cup ketchup (1/2 cup for 4 servings), and 2 tsp sugar (4 tsp for 4).

4. Once meatloaves and carrots have baked 20 minutes, remove from oven. Spoon half the ketchup glaze over meatloaves (save
the rest for serving); return to oven until carrots are browned and tender, meatloaves are cooked through, and glaze is tacky, 4-5 minutes more.

5. Meanwhile, melt 2 TBSP butter (4 TBSP for 4 servings) in pot used for potatoes over medium heat. Add remaining garlic and cook
until fragrant, 30 seconds. Add potatoes and 1/4 tsp wasabi. Mash, adding splashes of reserved potato cooking liquid as necessary until smooth. Season with salt and pepper. (If you like things spicy, stir in more wasabi!)

6. Divide meatloaves, mashed potatoes, and roasted carrots between plates. Sprinkle with scallion greens and serve with remaining ketchup glaze on the side for dipping.', '/static/fotos/52992.jpg'),
(52993, 'Honey Balsamic Chicken with Crispy Broccoli & Potatoes', 'Chicken', 'United States', '2 Servings

1. Preheat oven to 425 degrees. Wash and dry all produce. Cut potatoes into 1/2-inch-thick wedges. Toss on one side of a baking sheet with a drizzle of oil, salt, and pepper. (For 4 servings, spread potatoes out across entire sheet.) Roast on top rack for 5 minutes (we''ll add the broccoli then). 

2. Meanwhile, cut broccoli florets into bite-size pieces, if necessary. Peel and finely chop garlic. In a small microwave-safe bowl, combine 1 TBSP olive oil (2 TBSP for 4 servings) and half the garlic. Microwave until garlic sizzles, 30 seconds. 

3. Once potatoes have roasted 5 minutes, remove sheet from oven and add broccoli to empty side; carefully toss with garlic oil, salt, and pepper. (For 4 servings, add broccoli to a second sheet.) Continue roasting until potatoes and broccoli are browned and crispy, 15-20 minutes more. 

4. While veggies roast, pat chicken dry with paper towels; season all over with salt and pepper. Heat a drizzle of oil in a large pan over medium-high heat. Add chicken and cook until browned and cooked through, 5-6 minutes per side. (If chicken browns too quickly, reduce heat to medium.) Turn off heat; set chicken aside to rest. Wash out pan. 

5. Heat pan used for chicken over medium-high heat. Add a drizzle of oil and remaining garlic; cook until fragrant, 30 seconds. Stir in vinegar, honey, stock concentrate, and 1/4 cup water (1/3 cup for 4 servings). Simmer until thick and glossy, 2-3 minutes. Remove from heat and stir in 1 TBSP butter (2 TBSP for 4). Season with salt and pepper. 

6. Return chicken to pan and turn to coat in glaze. Divide chicken, broccoli, and potatoes between plates. Spoon any remaining glaze over chicken and serve. ', '/static/fotos/52993.jpg'),
(52994, 'Skillet Apple Pork Chops with Roasted Sweet Potatoes & Zucchini', 'Pork', 'United States', '
Serves 2


1. 

Adjust racks to top and middle positions and preheat oven to 450 degrees. Wash and dry all produce. Dice sweet potatoes into 1/2-inch pieces. Toss on a baking sheet with a drizzle of oil, salt, and pepper. Roast on top rack for 12 minutes (we''ll roast the zucchini then). 


2. 

Meanwhile, halve and core apple; thinly slice into half-moons. Peel and finely chop garlic. Quarter lemon. Trim and halve zucchini lengthwise; cut crosswise into 1/2-inch-thick half-moons. Toss on a second baking sheet with a drizzle of oil and a pinch of salt and pepper. Set aside. 


3. 

Pat pork dry with paper towels and season all over with salt and pepper. Heat a drizzle of oil in a large pan over medium-high heat. Add pork and cook until browned and cooked through, 4-5 minutes per side. Turn off heat; transfer to a plate. 


4. 

Once sweet potatoes have roasted 12 minutes, transfer baking sheet with zucchini to middle rack and continue roasting until both veggies are browned and softened, 12-15 minutes more. 


5. 

Meanwhile, melt 1 TBSP butter (2 TBSP for 4 servings) in pan used for pork over medium-high heat. Add apple and season with salt and pepper. Cook, scraping up any browned bits from bottom of pan, until apple is slightly softened, 2-3 minutes. Add garlic; cook until fragrant, 30 seconds. Add 1/z cup water (3/4 cup for 4), stock concentrate, and 11/2 tsp sugar (3 tsp for 4). Cook, stirring, until sauce has thickened and apple is very tender, 3-5 minutes. Season with salt and pepper. 


6. 

Remove pan with apple from heat; stir in 1 TBSP butter (2 TBSP for 4 servings) and a squeeze of lemon juice. Divide pork, zucchini, and sweet potatoes between plates. Top pork with glazed apple sauce. Top zucchini with a squeeze of lemon juice. ', '/static/fotos/52994.jpg'),
(52995, 'BBQ Pork Sloppy Joes', 'Pork', 'United States', '1

Preheat oven to 450 degrees. Wash and dry all produce. Cut sweet potatoes into ½-inch-thick wedges. Toss on a baking sheet with a drizzle of oil, salt, and pepper. Roast until browned and tender, 20-25 minutes.

2

Meanwhile, halve and peel onion. Slice as thinly as possible until you have ¼ cup (½ cup for 4 servings); finely chop remaining onion. Peel and finely chop garlic. Halve lime; squeeze juice into a small bowl. Halve buns. Add 1 TBSP butter (2 TBSP for 4) to a separate small microwave-safe bowl; microwave until melted, 30 seconds. Brush onto cut sides of buns.

3

To bowl with lime juice, add sliced onion, ¼ tsp sugar (½ tsp for 4 servings), and a pinch of salt. Stir to combine; set aside to quick-pickle.

4

Heat a drizzle of oil in a large pan over medium-high heat. Add chopped onion and season with salt and pepper. Cook, stirring, until softened, 4-5 minutes. Add garlic and cook until fragrant, 30 seconds more. Add pork and season with salt and pepper. Cook, breaking up meat into pieces, until browned and cooked through, 4-6 minutes.

5

While pork cooks, in a third small bowl, combine BBQ sauce, pickling liquid from onion, 3 TBSP ketchup (6 TBSP for 4 servings), ½ tsp sugar (1 tsp for 4), and ¼ cup water (⅓ cup for 4). Once pork is cooked through, add BBQ sauce mixture to pan. Cook, stirring, until sauce is thickened, 2-3 minutes. Taste and season with salt and pepper.

6

Meanwhile, toast buns in oven or toaster oven until golden, 3-5 minutes. Divide toasted buns between plates and fill with as much BBQ pork as you’d like. Top with pickled onion and hot sauce. Serve with sweet potato wedges on the side.', '/static/fotos/52995.jpg'),
(52996, 'French Onion Chicken with Roasted Carrots & Mashed Potatoes', 'Chicken', 'United States', '1

Preheat oven to 425 degrees. Wash and dry all produce. Trim, peel, and cut carrots on a diagonal into ¼-inch-thick pieces. Dice potatoes into ½-inch pieces. Halve, peel, and thinly slice onion.

2

Toss carrots on a baking sheet with a drizzle of oil, salt, and pepper. Roast until browned and tender, 15-20 minutes.

3

Meanwhile, place potatoes in a medium pot with enough salted water to cover by 2 inches. Bring to a boil and cook until tender, 12-15 minutes. Drain and return potatoes to pot; cover to keep warm.

4

While potatoes cook, heat a drizzle of oil in a large pan over medium-high heat. Add onion and cook, stirring occasionally, until lightly browned and softened, 8-10 minutes. Sprinkle with 1 tsp sugar (2 tsp for 4 servings). Stir in stock concentrate and 2 TBSP water (¼ cup for 4); season with salt and pepper. Cook until jammy, 2-3 minutes more. Turn off heat; transfer to a small bowl. Wash out pan.

5

Pat chicken dry with paper towels; season all over with salt and pepper. Heat a drizzle of oil in pan used for onion over medium-high heat. Add chicken and cook until browned and cooked through, 5-6 minutes per side. In the last 1-2 minutes of cooking, top with caramelized onion and cheese. Cover pan until cheese melts. (If your pan doesn’t have a lid, cover with a baking sheet!)

6

Heat pot with drained potatoes over low heat; mash with sour cream, 2 TBSP butter (4 TBSP for 4 servings), salt, pepper, and a splash of water (or milk, for extra richness) until smooth. Divide chicken, roasted carrots, and mashed potatoes between plates.', '/static/fotos/52996.jpg'),
(52997, 'Beef Banh Mi Bowls with Sriracha Mayo, Carrot & Pickled Cucumber', 'Beef', 'Vietnamese', 'Add''l ingredients: mayonnaise, siracha

1

Place rice in a fine-mesh sieve and rinse until water runs clear. Add to a small pot with 1 cup water (2 cups for 4 servings) and a pinch of salt. Bring to a boil, then cover and reduce heat to low. Cook until rice is tender, 15 minutes. Keep covered off heat for at least 10 minutes or until ready to serve.

2

Meanwhile, wash and dry all produce. Peel and finely chop garlic. Zest and quarter lime (for 4 servings, zest 1 lime and quarter both). Trim and halve cucumber lengthwise; thinly slice crosswise into half-moons. Halve, peel, and medium dice onion. Trim, peel, and grate carrot.

3

In a medium bowl, combine cucumber, juice from half the lime, ¼ tsp sugar (½ tsp for 4 servings), and a pinch of salt. In a small bowl, combine mayonnaise, a pinch of garlic, a squeeze of lime juice, and as much sriracha as you’d like. Season with salt and pepper.

4

Heat a drizzle of oil in a large pan over medium-high heat. Add onion and cook, stirring, until softened, 4-5 minutes. Add beef, remaining garlic, and 2 tsp sugar (4 tsp for 4 servings). Cook, breaking up meat into pieces, until beef is browned and cooked through, 4-5 minutes. Stir in soy sauce. Turn off heat; taste and season with salt and pepper.

5

Fluff rice with a fork; stir in lime zest and 1 TBSP butter. Divide rice between bowls. Arrange beef, grated carrot, and pickled cucumber on top. Top with a squeeze of lime juice. Drizzle with sriracha mayo.', '/static/fotos/52997.jpg'),
(52998, 'Corned Beef and Cabbage', 'Beef', 'Irish', '1

Place corned beef in large pot or Dutch oven and cover with water. Add the spice packet that came with the corned beef. Cover pot and bring to a boil, then reduce to a simmer. Simmer approximately 50 minutes per pound or until tender.

2

Add whole potatoes and peeled and cut carrots, and cook until the vegetables are almost tender. Add cabbage and cook for 15 more minutes. Remove meat and let rest 15 minutes.

3

Place vegetables in a bowl and cover. Add as much broth (cooking liquid reserved in the Dutch oven or large pot) as you want. Slice meat across the grain.', '/static/fotos/52998.jpg'),
(52999, 'Crispy Sausages and Greens', 'Pork', 'Irish', 'Preheat the oven to 350°. Remove the stems from one bunch of Tuscan kale and tear the leaves into 1" pieces (mustard greens, collards, spinach, and chard are great, too). Coarsely chop half a head of green cabbage. Combine the greens in a large baking dish and add 4 cloves of thinly sliced garlic. Adding some sliced onions and shiitake mushrooms at this point is optional, but highly recommended (I''ll sauté the onions and mushrooms in a cast iron baking dish right on the stove before adding to the greens). Coat the greens with some olive oil and pour ½ cup chicken stock or broth over everything. Cover the dish with foil and bake until the greens are wilted, about 15 minutes. Remove foil and season with salt and pepper. Continue to bake until cabbage is tender, about 20-25 minutes more.

Meanwhile, heat a little olive oil in a large skillet over medium-high. Prick four sweet Italian sausages with a fork and cook until browned on all sides and cooked through, 10 to 12 minutes. When the greens are done, slice the sausage and toss into the greens with a splash of your favorite vinegar (I like sherry or red wine).', '/static/fotos/52999.jpg'),
(53000, 'Vegetable Shepherds Pie', 'Beef', 'Irish', 'Add Ingredients:

12 cups chopped mixed vegetables
1   cup chopped fresh mushrooms 
1   cup pearl onions

TOPPING:

Preheat oven to 450°. Bake potatoes on a foil-lined baking sheet until tender, about 45 minutes. Let cool slightly, then peel. Press potatoes through a ricer, food mill, or colander into a large bowl. Add butter; stir until well blended. Stir in milk. Season to taste with salt.

FILLING:

Soak dried porcini in 3 cups hot water; set aside. Combine lentils, 1 garlic clove, 1 tsp. salt, and 4 cups water in a medium saucepan. Bring to a boil; reduce heat and simmer, stirring occasionally, until lentils are tender but not mushy, 15–20 minutes. Drain lentils and discard garlic.

Heat 3 Tbsp. oil in a large heavy pot over medium heat. Add onions and cook, stirring occasionally, until soft, about 12 minutes. Add chopped garlic and cook for 1 minute. Stir in tomato paste. Cook, stirring constantly, until tomato paste is caramelized, 2–3 minutes.

Add bay leaves and wine; stir, scraping up any browned bits. Stir in porcini, slowly pouring porcini soaking liquid into pan but leaving any sediment behind. Bring to a simmer and cook until liquid is reduced by half, about 10 minutes. Stir in broth and cook, stirring occasionally, until reduced by half, about 45 minutes.

Strain mixture into a large saucepan and bring to a boil; discard solids in strainer. Stir cornstarch and 2 Tbsp. water in a small bowl to dissolve. Add cornstarch mixture; simmer until thickened, about 5 minutes. Whisk in miso. Season sauce with salt and pepper. Set aside.

Preheat oven to 450°. Toss vegetables and pearl onions with remaining 2 Tbsp. oil, 5 garlic cloves, and rosemary sprigs in a large bowl; season with salt and pepper. Divide between 2 rimmed baking sheets. Roast, stirring once, until tender, 20–25 minutes. Transfer garlic cloves to a small bowl; mash well with a fork and stir into sauce. Discard rosemary. DO AHEAD: Lentils, sauce, and vegetables can be made 1 day ahead. Cover separately; chill.
Arrange lentils in an even layer in a 3-qt. baking dish; set dish on a foil-lined rimmed baking sheet. Toss roasted vegetables with fresh mushrooms and chopped herbs; layer on top of lentils. Pour sauce over vegetables. Spoon potato mixture evenly over.

Bake until browned and bubbly, about 30 minutes. Let stand for 15 minutes before serving.', '/static/fotos/53000.jpg'),
(53005, 'Strawberry Rhubarb Pie', 'Dessert', 'British', 'Pie Crust:  In a food processor, place the flour, salt, and sugar and process until combined. Add the butter and process until the mixture resembles coarse

meal (about 15 seconds). Pour 1/4 cup (60 ml) water in a slow, steady stream, through the feed tube until the dough just holds together when pinched. If necessary, add more water. Do not process more than 30 seconds.
Turn the dough onto your work surface and gather into a ball. Divide the dough in half, flattening each half into a disk, cover with plastic wrap, and refrigerate for about one hour before using. This will chill the butter and relax the gluten in the flour. 

After the dough has chilled sufficiently, remove one portion of the dough from the fridge and place it on a lightly floured surface.  Roll the pastry into a 12 inch (30 cm) circle. (To prevent the pastry from sticking to the counter and to ensure uniform thickness, keep lifting up and turning the pastry a quarter turn as you roll (always roll from the center of the pastry outwards).)  Fold the dough in half and gently transfer to a 9 inch (23 cm) pie pan. Brush off any excess flour and trim any overhanging pastry to an edge of 1/2 inch (1.5 cm). Refrigerate the pastry, covered with plastic wrap, while you make the filling. 

Remove the second round of pastry and roll it into a 13 inch (30 cm) circle. Using a pastry wheel or pizza cutter, cut the pastry into about 3/4 inch (2 cm) strips. Place the strips of pastry on a parchment paper-lined baking sheet, cover with plastic wrap, and place in the refrigerator for about 10 minutes. 

Make the Strawberry Rhubarb Filling: Place the cut strawberries and rhubarb in a large bowl. In a small bowl mix together the cornstarch, sugar, and ground cinnamon. 

Remove the chilled pie crust from the fridge. Sprinkle about 2 tablespoons of the sugar mixture over the bottom of the pastry crust. Add the remaining sugar mixture to the strawberries and rhubarb and gently toss to combine. Pour the fruit mixture into the prepared pie shell. Sprinkle the fruit with about 1 teaspoon of lemon juice and dot with 2 tablespoons of butter.

Remove the lattice pastry from the refrigerator and, starting at the center with the longest strips and working outwards, place half the strips, spacing about 1 inch (2.5 cm) apart, on top of the filling. (Use the shortest pastry strips at the outer edges.) Then, gently fold back, about halfway, every other strip of pastry. Take another strip of pastry and place it perpendicular on top of the first strips of pastry. Unfold the bottom strips of pastry and then fold back the strips that weren''t folded back the first time. Lay another strip of pastry perpendicular on top of the filling and then continue with the remaining strips. Trim the edges of the pastry strips, leaving a 1 inch (2.5 cm) overhang. Seal the edges of the pastry strips by folding them under the bottom pastry crust and flute the edges of the pastry. Brush the lattice pastry with milk and sprinkle with a little sugar. Cover and place in the refrigerator while you preheat the oven to 400 degrees F (205 degrees C) and place the oven rack in the lower third of the oven. Put a baking sheet, lined with aluminum foil, on the oven rack (to catch any spills.)

Place the pie plate on the hot baking sheet and bake the pie for about 35 minutes and then, if the edges of the pie are browning too much, cover with a foil ring. Continue to bake the pie for about another 10 minutes or until the crust is a golden brown color and the fruit juices begin to bubble.

Remove the pie from the oven and place on a wire rack to cool for several hours. Serve at room temperature with softly whipped cream or vanilla ice cream. Leftovers can be stored in the refrigerator for about 3 days. Reheat before serving. This pie can be frozen.

Makes one 9 inch (23 cm) pie.', '/static/fotos/53005.jpg'),
(53006, 'Moussaka', 'Beef', 'Greek', 'Heat the grill to high. Brown the beef in a deep ovenproof frying pan over a high heat for 5 mins. Meanwhile, prick the aubergine with a fork, then microwave on High for 3-5 mins until soft. Mix the yogurt, egg and parmesan together, then add a little seasoning.

Stir the tomatoes, purée and potatoes in with the beef with some seasoning and heat through. Smooth the surface of the beef mixture with the back of a spoon, then slice the cooked aubergine and arrange on top. Pour the yogurt mixture over the aubergines, smooth out evenly, then grill until the topping has set and turned golden.', '/static/fotos/53006.jpg'),
(53007, 'Honey Yogurt Cheesecake', 'Dessert', 'Greek', 'Heat oven to 160C/140C fan/gas 3. Crush the biscuits and most of the almonds inside a plastic food bag using a rolling pin. Mix with the butter, then press into the bottom of a deep, oval, 23cm dish (or something similar in size – a roasting tin, baking dish or cake tin will work). Bake for 10 mins until crisp.

Stir or mash together the yogurt and mascarpone, then whisk in the eggs, one at a time. Stir in the lemon and orange zests, then stir in most of the honey, reserving about 3 tbsp. Spread over the biscuit base, cover loosely with foil and cook for 1 hr. Remove the foil and cook for 15 mins more until lightly golden and the top is firm with just the slightest wobble in the middle. Leave to cool. Can be kept in the fridge for up to 2 days.

To serve, scatter with almonds, drizzle over the remaining honey, and hand around fresh fruit to go with it.', '/static/fotos/53007.jpg'),
(53008, 'Stuffed Lamb Tomatoes', 'Lamb', 'Greek', 'Heat oven to 180C/160C fan/gas 4. Slice the tops off the tomatoes and reserve. Scoop out most of the pulp with a teaspoon, being careful not to break the skin. Finely chop the pulp, and keep any juices. Sprinkle the insides of the tomatoes with a little sugar to take away the acidity, then place them on a baking tray.

Heat 2 tbsp olive oil in a large frying pan, add the onion and garlic, then gently cook for about 10 mins until soft but not coloured. Add the lamb, cinnamon and tomato purée, turn up the heat, then fry until the meat is browned. Add the tomato pulp and juice, the rice and the stock. Season generously. Bring to the boil, then simmer for 15 mins or until the rice is tender and the liquid has been absorbed. Set aside to cool a little, then stir in the herbs.

Stuff the tomatoes up to the brim, top tomatoes with their lids, drizzle with 2 tbsp more olive oil, sprinkle 3 tbsp water into the tray, then bake for 35 mins. Serve with salad and crusty bread, hot or cold.', '/static/fotos/53008.jpg'),
(53009, 'Lamb and Lemon Souvlaki', 'Lamb', 'Greek', 'Pound the garlic with sea salt in a pestle and mortar (or use a small food processor), until the garlic forms a paste. Whisk together the oil, lemon juice, zest, dill and garlic. Mix in the lamb and combine well. Cover and marinate for at least 2 hrs or overnight in the fridge. If you’re going to use bamboo skewers, soak them in cold water.

If you’ve prepared the lamb the previous day, take it out of the fridge 30 mins before cooking. Thread the meat onto the soaked or metal skewers. Heat the grill to high or have a hot griddle pan or barbecue ready. Cook the skewers for 2-3 mins on each side, basting with the remaining marinade. Heat the pitta or flatbreads briefly, then stuff with the souvlaki. Add Greek salad (see ''Goes well with'', right) and Tzatziki (below), if you like.', '/static/fotos/53009.jpg'),
(53010, 'Lamb Tzatziki Burgers', 'Lamb', 'Greek', 'Tip the bulghar into a pan, cover with water and boil for 10 mins. Drain really well in a sieve, pressing out any excess water.

To make the tzatziki, squeeze and discard the juice from the cucumber, then mix into the yogurt with the chopped mint and a little salt.

Work the bulghar into the lamb with the spices, garlic (if using) and seasoning, then shape into 4 burgers. Brush with a little oil and fry or barbecue for about 5 mins each side until cooked all the way through. Serve in the buns (toasted if you like) with the tzatziki, tomatoes, onion and a few mint leaves.', '/static/fotos/53010.jpg'),
(53011, 'Chicken Quinoa Greek Salad', 'Chicken', 'Greek', 'Cook the quinoa following the pack instructions, then rinse in cold water and drain thoroughly.

Meanwhile, mix the butter, chilli and garlic into a paste. Toss the chicken fillets in 2 tsp of the olive oil with some seasoning. Lay in a hot griddle pan and cook for 3-4 mins each side or until cooked through. Transfer to a plate, dot with the spicy butter and set aside to melt.

Next, tip the tomatoes, olives, onion, feta and mint into a bowl. Toss in the cooked quinoa. Stir through the remaining olive oil, lemon juice and zest, and season well. Serve with the chicken fillets on top, drizzled with any buttery chicken juices.', '/static/fotos/53011.jpg'),
(53012, 'Gigantes Plaki', 'Vegetarian', 'Greek', 'Soak the beans overnight in plenty of water. Drain, rinse, then place in a pan covered with water. Bring to the boil, reduce the heat, then simmer for approx 50 mins until slightly tender but not soft. Drain, then set aside.

Heat oven to 180C/160C fan/gas 4. Heat the olive oil in a large frying pan, tip in the onion and garlic, then cook over a medium heat for 10 mins until softened but not browned. Add the tomato purée, cook for a further min, add remaining ingredients, then simmer for 2-3 mins. Season generously, then stir in the beans. Tip into a large ovenproof dish, then bake for approximately 1 hr, uncovered and without stirring, until the beans are tender. The beans will absorb all the fabulous flavours and the sauce will thicken. Allow to cool, then scatter with parsley and drizzle with a little more olive oil to serve.', '/static/fotos/53012.jpg'),
(53013, 'Big Mac', 'Beef', 'United States', 'For the Big Mac sauce, combine all the ingredients in a bowl, season with salt and chill until ready to use.
2. To make the patties, season the mince with salt and pepper and form into 4 balls using about 1/3 cup mince each. Place each onto a square of baking paper and flatten to form into four x 15cm circles. Heat oil in a large frypan over high heat. In 2 batches, cook beef patties for 1-2 minutes each side until lightly charred and cooked through. Remove from heat and keep warm. Repeat with remaining two patties.
3. Carefully slice each burger bun into three acrossways, then lightly toast.
4. To assemble the burgers, spread a little Big Mac sauce over the bottom base. Top with some chopped onion, shredded lettuce, slice of cheese, beef patty and some pickle slices. Top with the middle bun layer, and spread with more Big Mac sauce, onion, lettuce, pickles, beef patty and then finish with more sauce. Top with burger lid to serve.
5. After waiting half an hour for your food to settle, go for a jog.', '/static/fotos/53013.jpg'),
(53014, 'Pizza Express Margherita', 'Miscellaneous', 'Italian', '1 Preheat the oven to 230°C.

2 Add the sugar and crumble the fresh yeast into warm water.

3 Allow the mixture to stand for 10 – 15 minutes in a warm place (we find a windowsill on a sunny day works best) until froth develops on the surface.

4 Sift the flour and salt into a large mixing bowl, make a well in the middle and pour in the yeast mixture and olive oil.

5 Lightly flour your hands, and slowly mix the ingredients together until they bind.

6 Generously dust your surface with flour.

7 Throw down the dough and begin kneading for 10 minutes until smooth, silky and soft.

8 Place in a lightly oiled, non-stick baking tray (we use a round one, but any shape will do!)

9 Spread the passata on top making sure you go to the edge.

10 Evenly place the mozzarella (or other cheese) on top, season with the oregano and black pepper, then drizzle with a little olive oil.

11 Cook in the oven for 10 – 12 minutes until the cheese slightly colours.

12 When ready, place the basil leaf on top and tuck in!', '/static/fotos/53014.jpg'),
(53015, 'Krispy Kreme Donut', 'Dessert', 'United States', 'Dissolve yeast in warm water in 2 1/2-quart bowl. Add milk, sugar, salt, eggs, shortening and 2 cups flour. Beat on low for 30 seconds, scraping bowl constantly. Beat on medium speed for 2 minutes, scraping bowl occasionally. Stir in remaining flour until smooth. Cover and let rise until double, 50-60 minutes. (Dough is ready when indentation remains when touched.) Turn dough onto floured surface; roll around lightly to coat with flour. Gently roll dough 1/2-inch thick with floured rolling pin. Cut with floured doughnut cutter. Cover and let rise until double, 30-40 minutes.
Heat vegetable oil in deep fryer to 350°. Slide doughnuts into hot oil with wide spatula. Turn doughnuts as they rise to the surface. Fry until golden brown, about 1 minute on each side. Remove carefully from oil (do not prick surface); drain. Dip the doughnuts into creamy glaze set on rack.


Glaze: 
Heat butter until melted. Remove from heat. Stir in powdered sugar and vanilla until smooth. Stir in water, 1 tablespoon at a time, until desired consistency.', '/static/fotos/53015.jpg'),
(53016, 'Chick-Fil-A Sandwich', 'Chicken', 'United States', 'Wrap the chicken loosely between plastic wrap and pound gently with the flat side of a meat tenderizer until about 1/2 inch thick all around.
Cut into two pieces, as even as possible.
Marinate in the pickle juice for 30 minutes to one hour (add a teaspoon of Tabasco sauce now for a spicy sandwich).
Beat the egg with the milk in a bowl.
Combine the flour, sugar, and spices in another bowl.
Dip the chicken pieces each into the egg on both sides, then coat in flour on both sides.
Heat the oil in a skillet (1/2 inch deep) to about 345-350.
Fry each cutlet for 2 minutes on each side, or until golden and cooked through.
Blot on paper and serve on toasted buns with pickle slices.', '/static/fotos/53016.jpg'),
(53017, 'Paszteciki (Polish Pasties)', 'Beef', 'Polish', 'Sift flour and salt into a large mixing bowl.
Use a spoon to push the egg yolk through a fine sieve into the flour.
Add the raw egg and mix well.
Beat in butter 1 tablespoon at a time.
Place dough on a floured surface and knead until smooth and elastic, then wrap in waxed paper and refrigerate until firm (at least 30 minutes).
In a heavy skillet, melt 2 tablespoons butter over medium heat; saute the onion and rutabaga until the onion is soft and transparent (5 minutes).
Put the onions, rutabaga, and beef through a meat grinder twice if you have one, if not just chop them up as fine as possible.
Melt the remaining 4 tablespoons butter over medium heat, and add the meat mixture.
Cook over low heat, stirring occasionally, until all of the liquid has evaporated and the mixture is thick enough to hold its shape.
Remove from heat and let cool, then stir in 1 egg, and season with salt and pepper.
Preheat oven to 350°F.
On a lightly floured surface, roll the dough out into a 13x8" rectangle (1/8" thick).
Spoon the filling down the center of the rectangle lengthwise, leaving about an inch of space on each end.
Lightly brush the long sides with cold water, then fold one of the long sides over the filling and the other side over the top of that.
Brush the short ends with cold water and fold them over the top, enclosing the filling.
Place pastry seam side down on a baking sheet and brush the top evenly with the remaining scrambled egg.
Bake in preheated oven until rich golden brown (30 minutes).
Slice pastry diagonally into 1.5" long pieces and serve as an appetizer or with soup.', '/static/fotos/53017.jpg'),
(53018, 'Bigos (Hunters Stew)', 'Pork', 'Polish', 'Preheat the oven to 350 degrees F (175 degrees C).

Heat a large pot over medium heat. Add the bacon and kielbasa; cook and stir until the bacon has rendered its fat and sausage is lightly browned. Use a slotted spoon to remove the meat and transfer to a large casserole or Dutch oven.

Coat the cubes of pork lightly with flour and fry them in the bacon drippings over medium-high heat until golden brown. Use a slotted spoon to transfer the pork to the casserole. Add the garlic, onion, carrots, fresh mushrooms, cabbage and sauerkraut. Reduce heat to medium; cook and stir until the carrots are soft, about 10 minutes. Do not let the vegetables brown.

Deglaze the pan by pouring in the red wine and stirring to loosen all of the bits of food and flour that are stuck to the bottom. Season with the bay leaf, basil, marjoram, paprika, salt, pepper, caraway seeds and cayenne pepper; cook for 1 minute.

Mix in the dried mushrooms, hot pepper sauce, Worcestershire sauce, beef stock, tomato paste and tomatoes. Heat through just until boiling. Pour the vegetables and all of the liquid into the casserole dish with the meat. Cover with a lid.

Bake in the preheated oven for 2 1/2 to 3 hours, until meat is very tender.', '/static/fotos/53018.jpg'),
(53019, 'Pierogi (Polish Dumplings)', 'Side', 'Polish', 'To prepare the sauerkraut filling, melt the butter in a skillet over medium heat. Stir in the onion, and cook until translucent, about 5 minutes. Add the drained sauerkraut and cook for an additional 5 minutes. Season to taste with salt and pepper, then remove to a plate to cool.

For the mashed potato filling, melt the butter in a skillet over medium heat. Stir in the onion, and cook until translucent, about 5 minutes. Stir into the mashed potatoes, and season with salt and white pepper.

To make the dough, beat together the eggs and sour cream until smooth. Sift together the flour, salt, and baking powder; stir into the sour cream mixture until dough comes together. Knead the dough on a lightly floured surface until firm and smooth. Divide the dough in half, then roll out one half to 1/8 inch thickness. Cut into 3 inch rounds using a biscuit cutter.

Place a small spoonful of the mashed potato filling into the center of each round. Moisten the edges with water, fold over, and press together with a fork to seal. Repeat procedure with the remaining dough and the sauerkraut filling.

Bring a large pot of lightly salted water to a boil. Add perogies and cook for 3 to 5 minutes or until pierogi float to the top. Remove with a slotted spoon.', '/static/fotos/53019.jpg'),
(53020, 'Rosol (Polish Chicken Soup)', 'Chicken', 'Polish', 'Add chicken to a large Dutch oven or stock pot 
Cover with water
Bring to a boil and simmer for 2 to 2 1/2 hours, skimming any impurities off the top to insure a clear broth
If your pot is big enough, add the vegetables and spices for the last hour of the cooking time
My Dutch oven wasn’t big enough to hold everything, just the chicken and other bones filled the pot, so I cooked the meat/bones for the full cooking time, then removed them, and cooked the vegetables and spices separately
Strain everything out of the broth
Bone the chicken, pulling the meat into large chunks
Slice the carrots
Return the chicken and carrots to the broth
Cook noodles according to package instructions if you’re using them
Add noodles to bowl and then top with hot soup', '/static/fotos/53020.jpg'),
(53021, 'Golabki (cabbage roll)', 'Beef', 'Polish', 'Bring a large pot of lightly salted water to a boil. Place cabbage head into water, cover pot, and cook until cabbage leaves are slightly softened enough to remove from head, 3 minutes. Remove cabbage from pot and let cabbage sit until leaves are cool enough to handle, about 10 minutes.

Remove 18 whole leaves from the cabbage head, cutting out any thick tough center ribs. Set whole leaves aside. Chop the remainder of the cabbage head and spread it in the bottom of a casserole dish.

Melt butter in a large skillet over medium-high heat. Cook and stir onion in hot butter until tender, 5 to 10 minutes. Cool.

Stir onion, beef, pork, rice, garlic, 1 teaspoon salt, and 1/4 teaspoon pepper together in a large bowl.

Preheat oven to 350 degrees F (175 degrees C).

Place about 1/2 cup beef mixture on a cabbage leaf. Roll cabbage around beef mixture, tucking in sides to create an envelope around the meat. Repeat with remaining leaves and meat mixture. Place cabbage rolls in a layer atop the chopped cabbage in the casserole dish; season rolls with salt and black pepper.

Whisk tomato soup, tomato juice, and ketchup together in a bowl. Pour tomato soup mixture over cabbage rolls and cover dish wish aluminum foil.

Bake in the preheated oven until cabbage is tender and meat is cooked through, about 1 hour.', '/static/fotos/53021.jpg'),
(53022, 'Polskie Nalesniki (Polish Pancakes)', 'Dessert', 'Polish', 'Add flour, eggs, milk, water, and salt in a large bowl then mix with a hand mixer until you have a smooth, lump-free batter.
At this point, mix in the butter or the vegetable oil. Alternatively, you can use them to grease the pan before frying each pancake.
Heat a non-stick pan over medium heat, then pour in the batter, swirling the pan to help it spread.
When the pancake starts pulling away a bit from the sides, and the top is no longer wet, flip it and cook shortly on the other side as well.
Transfer to a plate. Cook the remaining batter until all used up.
Serve warm, with the filling of your choice.', '/static/fotos/53022.jpg'),
(53023, 'Sledz w Oleju (Polish Herrings)', 'Seafood', 'Polish', 'Soak herring in cold water for at least 1 hour. If very salty, repeat, changing the water each time.

Drain thoroughly and slice herring into bite-size pieces.

Place in a jar large enough to accommodate the pieces and cover with oil, allspice, peppercorns, and bay leaf. Close the jar.

Refrigerate for 2 to 3 days before eating. This will keep refrigerated up to 2 weeks.

Serve with finely chopped onion or onion slices, lemon, and parsley or dill.', '/static/fotos/53023.jpg'),
(53024, 'Rogaliki (Polish Croissant Cookies)', 'Dessert', 'Polish', 'In a medium bowl mix egg yolks, philly cheese and baking powder using a hand held mixer. Carefully start adding the flour. When the mixture will not be mixing well, and will look like wood chips, put away the blending mixer and using your hands knead the dough.
Create a roll and cover in foil and freeze for 15 minutes. At this time preheat the oven to 375.
Take the dough out and separate into two. Roll and cut out 3 inch trangles.
Make as many as you can and on centre of each put a small spoon of jam. Roll them into a croissant shape.
Place the croissants onto a greased cookie sheet, and bake for 10-12 minutes or until golden.
Repeat with the rest of the dough.
When you take them out, put aside and sprinkle with powdered sugar on top.
This makes about 3 batches of 20 cookies each.
Total count about 60 cookies.', '/static/fotos/53024.jpg'),
(53025, 'Ful Medames', 'Vegetarian', 'Egyptian', 'As the cooking time varies depending on the quality and age of the beans, it is good to cook them in advance and to reheat them when you are ready to serve. Cook the drained beans in a fresh portion of unsalted water in a large saucepan with the lid on until tender, adding water to keep them covered, and salt when the beans have softened. They take 2–2 1/2 hours of gentle simmering. When the beans are soft, let the liquid reduce. It is usual to take out a ladle or two of the beans and to mash them with some of the cooking liquid, then stir this back into the beans. This is to thicken the sauce.
Serve the beans in soup bowls sprinkled with chopped parsley and accompanied by Arab bread.
Pass round the dressing ingredients for everyone to help themselves: a bottle of extra-virgin olive oil, the quartered lemons, salt and pepper, a little saucer with the crushed garlic, one with chili-pepper flakes, and one with ground cumin.
The beans are eaten gently crushed with the fork, so that they absorb the dressing.
Optional Garnishes
Peel hard-boiled eggs—1 per person—to cut up in the bowl with the beans.
Top the beans with a chopped cucumber-and-tomato salad and thinly sliced mild onions or scallions. Otherwise, pass round a good bunch of scallions and quartered tomatoes and cucumbers cut into sticks.
Serve with tahina cream sauce (page 65) or salad (page 67), with pickles and sliced onions soaked in vinegar for 30 minutes.
Another way of serving ful medames is smothered in a garlicky tomato sauce (see page 464).
In Syria and Lebanon, they eat ful medames with yogurt or feta cheese, olives, and small cucumbers.
Variations
A traditional way of thickening the sauce is to throw a handful of red lentils (1/4 cup) into the water at the start of the cooking.
In Iraq, large brown beans are used instead of the small Egyptian ones, in a dish called badkila, which is also sold for breakfast in the street.', '/static/fotos/53025.jpg'),
(53026, 'Tamiya', 'Vegetarian', 'Egyptian', 'oak the beans in water to cover overnight.Drain. If skinless beans are unavailable, rub to loosen the skins, then discard the skins. Pat the beans dry with a towel.
Grind the beans in a food mill or meat grinder.If neither appliance is available, process them in a food processor but only until the beans form a paste. (If blended too smoothly, the batter tends to fall apart during cooking.) Add the scallions, garlic, cilantro, cumin, baking powder, cayenne, salt, pepper, and coriander, if using.  Refrigerate for at least 30 minutes.
Shape the bean mixture into 1-inch balls.Flatten slightly and coat with flour.
Heat at least 1½-inches of oil over medium heat to 365 degrees.
Fry the patties in batches, turning once, until golden brown on all sides, about 5 minutes.Remove with a wire mesh skimmer or slotted spoon. Serve as part of a meze or in pita bread with tomato-cucumber salad and tahina sauce.', '/static/fotos/53026.jpg'),
(53027, 'Koshari', 'Vegetarian', 'Egyptian', 'Cook the lentils. Bring lentils and 4 cups of water to a boil in a medium pot or saucepan over high heat. Reduce the heat to low and cook until lentils are just tender (15-17 minutes). Drain from water and season with a little salt. (Note: when the lentils are ready, they should not be fully cooked. They should be only par-cooked and still have a bite to them as they need to finish cooking with the rice).
Now, for the rice. Drain the rice from its soaking water. Combine the par-cooked lentils and the rice in the saucepan over medium-high heat with 1 tbsp cooking oil, salt, pepper, and coriander. Cook for 3 minutes, stirring regularly. Add warm water to cover the rice and lentil mixture by about 1 1/2 inches (you’ll probably use about 3 cups of water here). Bring to a boil; the water should reduce a bit. Now cover and cook until all the liquid has been absorbed and both the rice and lentils are well cooked through (about 20 minutes).  Keep covered and undisturbed for 5 minutes or so.
Now make the pasta. While the rice and lentils are cooking, make the pasta according to package instructions by adding the elbow pasta to boiling water with a dash of salt and a little oil. Cook until the pasta is al dente. Drain.
Cover the chickpeas and warm in the microwave briefly before serving.

Make the crispy onion topping. 

Sprinkle the onion rings with salt, then toss them in the flour to coat. Shake off excess flour.
In a large skillet, heat the cooking oil over medium-high heat, cook the onion rings, stirring often, until they turn a nice caramelized brown. Onions must be crispy, but not burned (15-20 minutes).', '/static/fotos/53027.jpg'),
(53028, 'Shawarma', 'Chicken', 'Egyptian', 'Combine the marinade ingredients in a large ziplock bag (or bowl).
Add the chicken and use your hands to make sure each piece is coated. If using a ziplock bag, I find it convenient to close the bag then massage the bag to disperse the rub all over each chicken piece.
Marinate overnight or up to 24 hours.
Combine the Yoghurt Sauce ingredients in a bowl and mix. Cover and put in the fridge until required (it will last for 3 days in the fridge).
Heat grill/BBQ (or large heavy based pan on stove) on medium high. You should not need to oil it because the marinade has oil in it and also thigh fillets have fat. But if you are worried then oil your hotplate/grill. (See notes for baking)
Place chicken on the grill and cook the first side for 4 to 5 minutes until nicely charred, then turn and cook the other side for 3 to 4 minutes (the 2nd side takes less time).
Remove chicken from the grill and cover loosely with foil. Set aside to rest for 5 minutes.
TO SERVE
Slice chicken and pile onto platter alongside flatbreads, Salad and the Yoghurt Sauce.
To make a wrap, get a piece of flatbread and smear with Yoghurt Sauce. Top with a bit of lettuce and tomato and Chicken Shawarma. Roll up and enjoy!', '/static/fotos/53028.jpg'),
(53029, 'Mulukhiyah', 'Beef', 'Egyptian', 'Saute the onions in the 3-4 tablespoons olive oil
Add the beef cubes or the chicken cutlets, sear for 3-4 min on each side
Add 1 liter of water or just enough to cover the meat
Cook over medium heat until the meat is done (I usually do this in the pressure cooker and press them for 5 min)

Add the frozen mulukhyia and stir until it thaws completely and then comes to a boil

In another pan add the 1/4 to 1/2 cup of olive oil and the cloves of garlic and cook over medium low heat until you can smell the garlic (don’t brown it, it will become bitter)

Add the oil and garlic to the mulukhyia and lower the heat and simmer for 5-10 minutes
Add salt to taste

Serve with a generous amount of lemon juice.

You can serve it with some short grain rice or some pita bread', '/static/fotos/53029.jpg'),
(53030, 'Feteer Meshaltet', 'Side', 'Egyptian', 'Mix the flour and salt then pour one cup of water and start kneading.
If you feel the dough is still not coming together or too dry, gradually add the remaining water until you get a dough that is very elastic so that when you pull it and it won’t be torn.
Let the dough rest for just 10 minutes then divide the dough into 6-8 balls depending on the size you want for your feteer.
Warm up the butter/ghee or oil you are using and pour into a deep bowl.
Immerse the dough balls into the warm butter. Let it rest for 15 to 20 minutes.
Preheat oven to 550F.
Stretch the first ball with your hands on a clean countertop. Stretch it as thin as you can, the goal here is to see your countertop through the dough.
Fold the dough over itself to form a square brushing in between folds with the butter mixture.
Set aside and start making the next ball.
Stretch the second one thin as we have done for the first ball.
Place the previous one on the middle seam side down. Fold the outer one over brushing with more butter mixture as you fold. Set aside.
Keep doing this for the third and fourth balls. Now we have one ready, place on a 10 inch baking/pie dish seam side down and brush the top with more butter.
Repeat for the remaining 4 balls to make a second one. With your hands lightly press the folded feteer to spread it on the baking dish.
Place in preheated oven for 10 minutes when the feteer starts puffing turn on the broiler to brown the top.
When it is done add little butter on top and cover so it won’t get dry.', '/static/fotos/53030.jpg'),
(53031, 'Egyptian Fatteh', 'Beef', 'Egyptian', 'To prepare bread for bottom of dish: Take pita bread and rip into bite size pieces. In a frying pan, add about a 1/4 stick of butter, add bread pieces and fry until golden brown and crisp. Put these pieces in a glass baking dish, preferably a square sized dish. Set aside.
Then add to same pan, a little more butter, salt, approximately 2 cloves of crushed fresh garlic, and a teaspoon or so of cumin stir around a bit until you can smell aroma, then add fried bread pieces to this mixture, stir to coat bread and put back into glass baking dish. Set aside.
To prepare meat: put some butter in a pot, stir fry meat until brown, add 1 onion quartered, salt & pepper, 1 cube of chicken bouillon and water to cover meat. Bring to a boil, turn down to simmer, cover and cook until tender, approximately 2 hours. After meat has cooled, take out chunks of meat and put in a bowl, set aside. Reserve soup from the meat separately.
To prepare the rice: Put some butter into a pot, add shareya (fideo noodles) like a handful or so, keep stirring until golden brown, not too dark, but very golden. Then add two cups of rice, stir a little bit until some of the rice turns an opaque white. Add 2-1/4 cups of water and salt to taste. Bring to a boil, cover and turn down to simmer, cook until tender. Test the rice tenderness after about 35 minutes.
Now take some of the soup from meat and add to the top of the bread pieces in baking dish to saturate.Add cooked rice on top of bread pieces. Slowly spoon remainder of soup onto rice, looking at glass dish sides to see level of soup, should reach just to top of rice, don’t worry, this doesn’t have to be exact. Now you’re ready to make the sauce and fry the meat to put on top.
To prepare red sauce: In a pan, add a little oil or butter, crushed tomato, a half teaspoon of tomato paste, salt & pepper, 2 cloves of fresh crushed garlic and cumin. Add also approximately 3 tablespoons of vinegar, stir this until you smell aroma and it is a bit smooth. It should be a bit thick, not watery, but if too thick you can add a bit of water. Spread with a wooden spoon atop the rice to cover.
To fry meat: In a pan add a bit of butter or oil, the meat, just a touch of tomato paste, about a tablespoon of fresh crushed garlic, salt & pepper, a teaspoon of cumin. Cook until meat is golden fried.
Spoon this atop the rice and serve. Enjoy!', '/static/fotos/53031.jpg'),
(53032, 'Tonkatsu pork', 'Pork', 'Japanese', 'STEP 1
Remove the large piece of fat on the edge of each pork loin, then bash each of the loins between two pieces of baking parchment until around 1cm in thickness – you can do this using a meat tenderiser or a rolling pin. Once bashed, use your hands to reshape the meat to its original shape and thickness – this step will ensure the meat is as succulent as possible.

STEP 2
Put the flour, eggs and panko breadcrumbs into three separate wide-rimmed bowls. Season the meat, then dip first in the flour, followed by the eggs, then the breadcrumbs.

STEP 3
In a large frying or sauté pan, add enough oil to come 2cm up the side of the pan. Heat the oil to 180C – if you don’t have a thermometer, drop a bit of panko into the oil and if it sinks a little then starts to fry, the oil is ready. Add two pork chops and cook for 1 min 30 secs on each side, then remove and leave to rest on a wire rack for 5 mins. Repeat with the remaining pork chops.

STEP 4
While the pork is resting, make the sauce by whisking the ingredients together, adding a splash of water if it’s particularly thick. Slice the tonkatsu and serve drizzled with the sauce.', '/static/fotos/53032.jpg'),
(53033, 'Japanese gohan rice', 'Side', 'Japanese', 'STEP 1
Rinsing and soaking your rice is key to achieving the perfect texture. Measure the rice into a bowl, cover with cold water, then use your fingers to massage the grains of rice – the water will become cloudy. Drain and rinse again with fresh water. Repeat five more times until the water stays clear.

STEP 2
Tip the rinsed rice into a saucepan with 400ml water, or 200ml dashi and 200ml water, bring to the boil, then turn down the heat to a low simmer, cover with a tight-fitting lid with a steam hole and cook for 15 mins. Remove from the heat and leave to sit for another 15 mins, then stir through the mirin. Remove the lid and give it a good stir. Serve with any or all of the optional toppings.', '/static/fotos/53033.jpg'),
(53034, 'Japanese Katsudon', 'Pork', 'Japanese', 'STEP 1
Heat the oil in a pan, fry the sliced onion until golden brown, then add the tonkatsu (see recipe here), placing it in the middle of the pan. Mix the dashi, soy, mirin and sugar together and tip three-quarters of the mixture around the tonkatsu. Sizzle for a couple of mins so the sauce thickens a little and the tonkatsu reheats.

STEP 2
Tip the beaten eggs around the tonkatsu and cook for 2-3 mins until the egg is cooked through but still a little runny. Divide the rice between two bowls, then top each with half the egg and tonkatsu mix, sprinkle over the chives and serve immediately, drizzling with a little more soy if you want an extra umami kick.', '/static/fotos/53034.jpg'),
(53035, 'Ham hock colcannon', 'Pork', 'Irish', 'STEP 1
Peel and cut the potatoes into even, medium-sized chunks. Put in a large pan filled with cold salted water, bring to the boil and cook for 10-15 mins until a knife can be inserted into the potatoes easily.

STEP 2
Meanwhile, melt the butter in a large sauté pan over a medium heat. Add the garlic, cabbage, spring onions and some seasoning. Stir occasionally until the cabbage is wilted but still retains a little bite, then set aside.

STEP 3
Drain the potatoes, leave to steam-dry for a couple of mins, then mash with the cream, mustard and seasoning in the same saucepan. Stir in the cabbage and ham hock. Keep warm over a low heat.

STEP 4
Reheat the pan you used to cook the cabbage (no need to wash first), add a splash of oil, crack in the eggs and fry to your liking. To serve, divide the colcannon between bowls and top each with a fried egg.', '/static/fotos/53035.jpg'),
(53036, 'Boxty Breakfast', 'Pork', 'Irish', 'STEP 1
Before you start, put your oven on its lowest setting, ready to keep things warm. Peel the potatoes, grate 2 of them, then set aside. Cut the other 2 into large chunks, then boil for 10-15 mins or until tender. Meanwhile, squeeze as much of the liquid from the grated potatoes as you can using a clean tea towel. Mash the boiled potatoes, then mix with the grated potato, spring onions and flour.

STEP 2
Whisk the egg white in a large bowl until it holds soft peaks. Fold in the buttermilk, then add the bicarbonate of soda. Fold into the potato mix.

STEP 3
Heat a large non-stick frying pan over a medium heat, then add 1 tbsp butter and some of the oil. Drop 3-4 spoonfuls of the potato mixture into the pan, then gently cook for 3-5 mins on each side until golden and crusty. Keep warm on a plate in the oven while you cook the next batch, adding more butter and oil to the pan before you do so. You will get 16 crumpet-size boxty from the mix. Can be made the day ahead, drained on kitchen paper, then reheated in a low oven for 20 mins.

STEP 4
Heat the grill to medium and put the tomatoes in a heavy-based pan. Add a good knob of butter and a little oil, then fry for about 5 mins until softened. Grill the bacon, then pile onto a plate and keep warm. Stack up the boxty, bacon and egg, and serve the tomatoes on the side.', '/static/fotos/53036.jpg'),
(53037, 'Coddled pork with cider', 'Pork', 'Irish', 'STEP 1
Heat the butter in a casserole dish until sizzling, then fry the pork for 2-3 mins on each side until browned. Remove from the pan.

STEP 2
Tip the bacon, carrot, potatoes and swede into the pan, then gently fry until slightly coloured. Stir in the cabbage, sit the chops back on top, add the bay leaf, then pour over the cider and stock. Cover the pan, then leave everything to gently simmer for 20 mins until the pork is cooked through and the vegetables are tender.

STEP 3
Serve at the table spooned straight from the dish.', '/static/fotos/53037.jpg'),
(53038, 'Mustard champ', 'Side', 'Irish', 'STEP 1
Boil the potatoes for 15 mins or until tender. Drain, then mash.

STEP 2
Heat the milk and half the butter in the corner of the pan, then beat into the mash, along with the wholegrain mustard.

STEP 3
Gently fry the spring onions in the remaining butter for 2 mins until just soft but still a perky green. Fold into the mash and serve. Great with gammon or to top a fish pie.', '/static/fotos/53038.jpg'),
(53039, 'Piri-piri chicken and slaw', 'Chicken', 'Portuguese', 'STEP 1

Whizz together all of the marinade ingredients in a small food processor. Rub the marinade onto the chicken and leave for 1 hour at room temperature.

STEP 2

Heat the oven to 190C/fan 170C/gas 5. Put the chicken in a roasting tray and cook for 1 hour 20 minutes. Rest under loose foil for 20 minutes. While the chicken is resting, mix together the slaw ingredients and season. Serve the chicken with slaw, fries and condiments.', '/static/fotos/53039.jpg'),
(53040, 'Spring onion and prawn empanadas', 'Seafood', 'Portuguese', 'STEP 1

To make the dough, rub the butter into the flour and then add the egg white and half the yolk (keep the rest), vinegar, a pinch of salt and enough cold water to make a soft dough. Knead on a floured surface until smooth and then wrap and rest for 30 minutes.

STEP 2

Heat the oven to 180c/fan 160c/gas 4. Trim the green ends of the spring onions and then finely slice the rest. Heat a little oil in a pan and fry them gently until soft but not browned. Add the chilli and garlic, stir and then add the prawns and cook until they are opaque. Season well. Scoop out the prawns and bubble the juices until they thicken, then add back the prawns.

STEP 3

Divide the empanada dough into eight balls and roll out to thin circles on a floured surface. Put some filling on one half of the dough, sprinkle the feta on top and fold the other half over. Trim the edge and then fold and crimp the dough together so the empanada is tightly sealed, put it on an oiled baking sheet either on its side or sitting on its un-crimped edge like a cornish pasty. Repeat with the remaining dough and mixture. Mix the leftover egg yolk with a splash of water and brush the top of the empanadas.

STEP 4

Bake for 30 minutes or until golden and slightly crisp around the edges.', '/static/fotos/53040.jpg'),
(53041, 'Grilled Portuguese sardines', 'Seafood', 'Portuguese', 'STEP 1

Put all of the ingredients, except the sardines, into a bowl and mix together with some seasoning. Pour into a baking dish, add the sardines and toss really well. Cover and chill for a few hours.

STEP 2

Heat a BBQ or griddle pan until hot. Cook the sardines for 4-5 minutes on each side or until really caramelised and charred. Put onto a serving plate, drizzle with oil, sprinkle with a little more paprika and squeeze over the lemon wedges.', '/static/fotos/53041.jpg'),
(53042, 'Portuguese prego with green piri-piri', 'Beef', 'Portuguese', 'STEP 1

Rub the garlic over the steaks then put in a sandwich bag and tip in the olive oil, sherry vinegar and parsley stalks. Smoosh everything together, then use a rolling pin to bash the steaks a few times. Leave for 1-2 hours.

STEP 2

To make the sauce, put all the ingredients into a blender with 1 tbsp water and whizz until as smooth as possible. This will make more than you’ll need for the recipe but will keep for a week in an airtight jar.

STEP 3

Heat a griddle or frying pan to high. Brush away the garlic and parsley stalks from the steaks and season well. Sear the steaks for 2 minutes on each side then rest on a plate. Put the ciabatta halves onto the plate, toasted-side down, to soak up any juices.

STEP 4

Slice the steaks then stuff into the rolls with the green sauce and rocket.', '/static/fotos/53042.jpg'),
(53043, 'Fish fofos', 'Seafood', 'Portuguese', 'STEP 1

Put the fish into a lidded pan and pour over enough water to cover. Bring to a simmer and gently poach for 10 minutes over a low heat with the lid on. Drain and flake the fish.

STEP 2

Put the fish, potato, green chilli, coriander, cumin, black pepper, garlic and ginger in a large bowl. Season, add the rice flour, mix well and break in 1 egg. Stir the mixture and divide into 15, then form into small logs. Break the remaining eggs into a bowl and whisk lightly. Put the breadcrumbs into another bowl. Dip each fofo in the beaten egg followed by the breadcrumb mixture. Chill for 20 minutes.

STEP 3

Heat 1cm of oil in a large frying pan over a medium heat. Fry the fofos in batches for 2 minutes on each side, turning gently to get an even golden brown colour all over. Drain on kitchen paper and repeat with the remaining fofos.

STEP 4

For the onion salad, mix together the onion, coriander and lemon juice with a pinch of salt. Serve with the fofos and mango chutney.', '/static/fotos/53043.jpg'),
(53044, 'Portuguese barbecued pork (Febras assadas)', 'Pork', 'Portuguese', 'STEP 1

Cut the tenderloins into 5 equal-size pieces leaving the tail ends a little longer. Take a clear plastic bag and slip one of the pieces in. Bash it into an escalope the size of a side-plate with a rolling pin and repeat with the remaining pieces.

STEP 2

Put the wine, paprika, some salt and pepper and the juice of ½ a lemon in a bowl and add the pork. Leave to marinate for 20-30 minutes, while you get your barbecue to the stage where the coals are glowing but there are no flames.

STEP 3

To make the chips, fill a basin with cool water and cut the potatoes into 3cm-thick chips. Soak them in the water for 5 minutes and then change the water. Leave for 5 more minutes. Drain and then pat dry on a towel or with kitchen paper.

STEP 4

Heat the oil in a deep fryer or a deep heavy-based pan with a lid to 130C and lower the chips into the oil (in batches). Blanch for 8-10 minutes. Remove from the oil and drain well. Place on a tray to cool. Reheat the oil to 180C (make sure it’s hot or your chips will be soggy) and lower the basket of chips into the oil (again, do this in batches). Leave to cook for 2 minutes and then give them a little shake. Cook for another minute or so until they are well coloured and crisp to the touch. Drain well for a few minutes, tip into a bowl and sprinkle with sea salt.

STEP 5

The pork will cook quickly so do it in 2 batches. Take the pieces out of the marinade, rub them with oil, and drop them onto the barbecue (you could also use a chargrill). Cook for 1 minute on each side – they may flare up as you do so. This should really be enough time as they will keep on cooking. Take them off the barbecue and pile onto a plate. Repeat with the remaining batch.

STEP 6

Serve by piling a plate with chips, drop the pork on top of each pile and pouring the juices from the plate over so the chips take up the flavours. Top with a spoon of mayonnaise and a wedge of lemon.', '/static/fotos/53044.jpg'),
(53045, 'Portuguese fish stew (Caldeirada de peixe)', 'Seafood', 'Portuguese', 'STEP 1

Heat a drizzle of oil in a large, deep-sided frying pan, and fry the onion and pepper on a medium heat until softened but not browned. Finely chop the coriander stalks (keep the leaves for later), and add to the pan with the chilli and chopped garlic. Fry for another few minutes. Add the wine, saffron and bay leaf and let it simmer until reduced by half.

STEP 2

Add the potatoes, tomatoes, and 300ml water and bring to a gentle boil. Break up the tomatoes with a spoon on the side of the pan and simmer for 20-25 minutes until the potatoes are just tender, and the tomatoes have broken down.

STEP 3

Season well, then gently push the fish into the sauce, and arrange the squid, prawns, clams and mussels on the surface. Put the lid on and cook for 6-8 minutes until the mussel and clam shells have opened, the prawns are cooked and the fish is flaky. Toast the bread, rub lightly with the halved garlic clove and drizzle with olive oil. Serve the stew scatted with chopped coriander leaves, and the toasts for dunking.', '/static/fotos/53045.jpg'),
(53046, 'Portuguese custard tarts', 'Dessert', 'Portuguese', 'STEP 1
Roll the pastry
Mix the flour and icing sugar, and use this to dust the work surface. Roll the pastry out to make a 45 x 30cm rectangle. Roll up lengthways to create a long sausage shape.

STEP 2
Cutting pastry into rounds
Cut the pastry into 24 wheels, about 1-2cm thick.

STEP 3
Roll out each pastry portion
Roll each wheel lightly with the rolling pin to fit 2 x 12-hole non-stick fairy cake tins.

STEP 4
Press pastry into the tin
Press the pastry circles into the tins and mould into the tins to make thin cases. Chill until needed.

STEP 5
Make the infused syrup
Heat the oven to 220C/fan 200C/gas 7. Make a sugar syrup by bringing the sugar, 200ml water, lemon zest and cinnamon stick to the boil. Reduce until syrupy, allow to cool, then remove the cinnamon and lemon. Whisk the eggs, egg yolks and cornflour until smooth in another large pan.

STEP 6
Making custard
Heat the milk and vanilla pod seeds in a separate pan until just below the boil. Gradually pour the hot milk over the eggs and cornflour, then cook on a low heat, continually whisking.

STEP 7
Add syrup to custard
Add the cooled sugar syrup to the custard and whisk until thickened slightly.

STEP 8
Pour custard into the tins
Pour the custard through a sieve. Pour into the pastry cases and bake for 15 minutes until the pastry is golden and the custard has darkened.

STEP 9
cool and dust with icing sugar
Cool completely in the tins then sift over icing sugar and ground cinnamon to serve.



 ', '/static/fotos/53046.jpg'),
(53047, 'Moroccan Carrot Soup', 'Vegetarian', 'Moroccan', 'Step 1
Preheat oven to 180° C.
Step 2
Combine carrots, onion, garlic, cumin seeds, coriander seeds, salt and olive oil in a bowl and mix well. Transfer on a baking tray.
Step 3
Put the baking tray in preheated oven and roast for 10-12 minutes or till carrots soften. Remove from heat and cool.
Step 4
Grind the baked carrot mixture along with some water to make a smooth paste and strain in a bowl.
Step 5
Heat the carrot mixture in a non-stick pan. Add two cups of water and bring to a boil. Add garam masala powder and mix. Add salt and mix well.
Step 6
Remove from heat, add lemon juice and mix well.
Step 7
Serve hot.', '/static/fotos/53047.jpg'),
(53048, 'Mee goreng mamak', 'Seafood', 'Malaysian', 'Heat oil in a pan at medium heat. Then, add peanuts, dried chilies, dried shrimps and dhal. Fry the aromatics until fragrant. Remove from pan and leave aside.

Blend fried ingredients with tamarind paste and water until fine. Then, sauté the blended ingredients in oil heated over low heat. Continue cooking until the oil separates from the paste and turns a darker shade.

Skin and cut potatoes into small chunks and boil them in a pot of water until knife-tender. Once ready, remove them from the pot and leave aside. Discard water.

Slice onion and fried tofu, mince garlic, cut some cabbage and Chinese flowering cabbage (choi sam). Prepare prawn fritters and cut them. Boil noodles to soften them if bought dried. Also mix black soy sauce with water.

To fry one portion of mee goreng mamak, heat oil and add 1/4 of the following ingredients in this order: garlic, onion, paste. Sauté until fragrant. Optionally, add prawns.

Add in 1/4 amount of tofu, boiled potatoes, cabbage, Chinese flowering cabbage and prawn fritters. Sauté for another 30 seconds.

Add noodles to the wok. Add 3 tablespoons of dark soy sauce mixture. Mix evenly for the next 1 minute. Then, move the noodles to the side of the wok. Stir in an egg. Garnish with a slice of lime and slices of green chilies. To cook another plate of noodles, repeat from step 5 onwards.', '/static/fotos/53048.jpg'),
(53049, 'Apam balik', 'Dessert', 'Malaysian', 'Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.

Spread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.

Add butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.

Cut into wedges and best eaten when it is warm.', '/static/fotos/53049.jpg'),
(53050, 'Ayam Percik', 'Chicken', 'Malaysian', 'In a blender, add the ingredients for the spice paste and blend until smooth.
Over medium heat, pour the spice paste in a skillet or pan and fry for 10 minutes until fragrant. Add water or oil 1 tablespoon at a time if the paste becomes too dry. Don''t burn the paste. Lower the fire slightly if needed.
Add the cloves, cardamom, tamarind pulp, coconut milk, water, sugar and salt. Turn the heat up and bring the mixture to boil. Turn the heat to medium low and simmer for 10 minutes. Stir occasionally. It will reduce slightly. This is the marinade/sauce, so taste and adjust seasoning if necessary. Don''t worry if it''s slightly bitter. It will go away when roasting.
When the marinade/sauce has cooled, pour everything over the chicken and marinate overnight to two days.
Preheat the oven to 425 F.
Remove the chicken from the marinade. Spoon the marinade onto a greased (or aluminum lined) baking sheet. Lay the chicken on top of the sauce (make sure the chicken covers the sauce and the sauce isn''t exposed or it''ll burn) and spread the remaining marinade on the chicken. Roast for 35-45 minutes or until internal temp of the thickest part of chicken is at least 175 F.
Let chicken rest for 5 minutes. Brush the chicken with some of the oil. Serve chicken with the sauce over steamed rice (or coconut rice).', '/static/fotos/53050.jpg'),
(53051, 'Nasi lemak', 'Seafood', 'Malaysian', 'In a medium saucepan over medium heat, stir together coconut milk, water, ground ginger, ginger root, salt, bay leaf, and rice. Cover, and bring to a boil. Reduce heat, and simmer for 20 to 30 minutes, or until done.

 Step 2
Place eggs in a saucepan, and cover with cold water. Bring water to a boil, and immediately remove from heat. Cover, and let eggs stand in hot water for 10 to 12 minutes. Remove eggs from hot water, cool, peel and slice in half. Slice cucumber.

 Step 3
Meanwhile, in a large skillet or wok, heat 1 cup vegetable oil over medium-high heat. Stir in peanuts and cook briefly, until lightly browned. Remove peanuts with a slotted spoon and place on paper towels to soak up excess grease. Return skillet to stove. Stir in the contents of one package anchovies; cook briefly, turning, until crisp. Remove with a slotted spoon and place on paper towels. Discard oil. Wipe out skillet.

 Step 4
Heat 2 tablespoons oil in the skillet. Stir in the onion, garlic, and shallots; cook until fragrant, about 1 or 2 minutes. Mix in the chile paste, and cook for 10 minutes, stirring occasionally. If the chile paste is too dry, add a small amount of water. Stir in remaining anchovies; cook for 5 minutes. Stir in salt, sugar, and tamarind juice; simmer until sauce is thick, about 5 minutes.

 Step 5
Serve the onion and garlic sauce over the warm rice, and top with peanuts, fried anchovies, cucumbers, and eggs.', '/static/fotos/53051.jpg'),
(53052, 'Roti john', 'Beef', 'Malaysian', 'Mix all the ingredients in a bowl.
Heat a pan or griddle with a little vegetable oil.
Pour the mixture onto the pan and place a piece of open-faced baguette on top.
Press on the bread with a spatula and grill for 2 minutes.
Turn the bread over to make it a little crispy.
Remove from pan and cut the bread into small portions.
Add mayonnaise and/or Sambal before cutting the sandwich (optional).', '/static/fotos/53052.jpg'),
(53053, 'Beef Rendang', 'Beef', 'Malaysian', 'Chop the spice paste ingredients and then blend it in a food processor until fine.
Heat the oil in a stew pot, add the spice paste, cinnamon, cloves, star anise, and cardamom and stir-fry until aromatic. Add the beef and the pounded lemongrass and stir for 1 minute. Add the coconut milk, tamarind juice, water, and simmer on medium heat, stirring frequently until the meat is almost cooked. Add the kaffir lime leaves, kerisik (toasted coconut), sugar or palm sugar, stirring to blend well with the meat.
Lower the heat to low, cover the lid, and simmer for 1 to 1 1/2 hours or until the meat is really tender and the gravy has dried up. Add more salt and sugar to taste. Serve immediately with steamed rice and save some for overnight.', '/static/fotos/53053.jpg'),
(53054, 'Seri muka kuih', 'Dessert', 'Malaysian', 'Soak glutinous rice with water for at least 1 ½ hours prior to using. Drain.
Prepare a 9-inch round or square cake pan and spray with cooking spray or line with plastic wrap.
Mix coconut milk, water, salt and the rice. Pour it into cake pan, topped with the pandan knots.
Steam for 30 minutes.
After 30 minutes, fluff up the rice and remove pandan knots. Then, using a greased spatula, flatten the steamed rice. Make sure there are no holes/air bubbles and gaps in the rice, especially the sides.
Steam for another 10 minutes.

Combine pandan juice, coconut milk, all purpose flour, cornflour, and sugar. Mix well.
Add eggs and whisk well then strain into a medium sized metal bowl or pot.
Place pandan mixture over simmering water (double boiler or bain-marie)
Stir continuously and cook till custard starts to thicken. (15 minutes)
Pour pandan custard into glutinous rice layer, give it a little tap (for air bubbles) and continue to steam for 30 minutes.
Remove kuih seri muka from the steamer and allow to cool completely before cutting into rectangles or diamond shapes.', '/static/fotos/53054.jpg'),
(53055, 'Cevapi Sausages', 'Beef', 'Croatian', 'Place the ground meat in a bowl. Chop the onion very finely and grate the garlic cloves. Add to the bowl. Add the chopped parsley, all sorts of paprika, baking soda, dried breadcrumbs, water, Vegeta, salt, and pepper.
Mix well with the hand mixer fitted with the dough hooks. Cover the bowl with cling film/ plastic foil and leave to rest for 1 or 2 hours in the refrigerator.
Take portions of the meat mixture, about 50-55 g/ 1.7-1.9 oz/ ¼ cup portions, and form the cevapi. The rolls should be about as thick as your thumb and about 7-10 cm/ 3-4 inches long. I had 18 sausages. The recipe can be easily doubled.
Grill the cevapcici on the hot grill pan or on the barbecue for about 12-14 minutes, turning them several times in between, or until brown and cooked through. I checked by cutting one in the middle and then grilling the following batches for the same period of time.
Serve hot as suggested above. The cevapcici can be reheated in the oven at 180 degrees Celsius/ 350 degrees Fahrenheit for about 10 minutes or until heated through. Check one, if it is not hot enough, give the sausages a few more minutes.', '/static/fotos/53055.jpg'),
(53056, 'Croatian lamb peka', 'Beef', 'Croatian', 'Preheat oven to 200°C fan / 220°C / 425°F / Gas mark 7
If you have not bought diced lamb, cut your lamb shoulder or leg into large chunks and place to one side.
Chunks of chopped lamb of a red chopping board
Make oil marinade -
Mix 80ml of olive oil in a bowl with garlic puree, sundried tomato puree ,black pepper and salt.
olive oil, gia sundried tomato puree and gia garlic puree and black pepper mixed together in a silver bowl to make Croatian peka
Add potatoes and vegetables into a large lidded casserole dish.
Chopped up vegetables which consist of chopped up red onion, courgette, potatoes red peppers in a cast iron pan
Place diced lamb on top of the vegetables, pour the marinade and wine over the top.
Chunks of lamb covered in in a sundried tomato oil sauce which is on top of chopped red onion, aubergine, courgette and potatoes in a cast iron pan
Add the rosemary, thyme and sage, trying to keep the herbs on top.
So you can easily remove the herb stalks once cooked.
Chunks of lamb coated in a sundried tomato oil sauce and covered with thyme, rosemary and sage which is on top of chopped red onion, aubergine, courgette and potatoes in a cast iron pan
Place lid on the casserole dish and cook for 1hr 30 minute
If you do not have a lid cover very well with kitchen foil
Cast iron dish with lid on in the oven
Take the lid off, remove any thick herb stems. Stir in 2 tbsp of olive oil.
Cook for a further 20-30 mins.
Cooked Croatian Lamb Peka in a cast iron pan in the oven
Serve with fresh homemade bread to dip into the juices.', '/static/fotos/53056.jpg'),
(53057, 'Traditional Croatian Goulash', 'Beef', 'Croatian', 'Clean the meat from the veins if there are some and cut it into smaller pieces, 3 × 3 cm. Marinate the meat in the mustard and spices and let it sit in the refrigerator for one hour
Heat one tablespoon of pork fat or vegetable oil in a pot and fry the meat on all sides until it gets browned. Once the meat is cooked, transfer it to a plate and add another tablespoon of fat to the pot
Cut the onions very fine, peel the carrots and shred it using a grater. Cook the onions and carrots over low heat for 15 minutes. You can salt the vegetables a little to make them soften faster
Once the vegetables have browned and become slightly mushy, add the meat and bay leaves and garlic. Pour over with wine and simmer for 10-15 minutes to allow the alcohol to evaporate. Now is the right time to add 2/3 the amount of liquid
Cover the pot and cook over low heat for an hour, stirring occasionally. After the first hour, pour over the rest of the water or stock and cook for another 30-45 minutes
Allow the stew to cool slightly and serve it with a sprinkle of chopped parsley and few slices of fresh hot pepper if you like to spice it up a bit
Slice ​​some fresh bread, season the salad and simply enjoying these wonderful flavors', '/static/fotos/53057.jpg'),
(53058, 'Croatian Bean Stew', 'Beef', 'Croatian', 'Heat the oil in a pan. Add the chopped vegetables and sauté until tender. Take a pot, empty the beans together with the vegetables into it, put the sausages inside and cook for further 20 minutes on a low heat. Or, put it in an oven and bake it at a temperature of 180ºC/350ºF for 30 minutes. This dish is even better reheated the next day.', '/static/fotos/53058.jpg'),
(53059, 'Mushroom soup with buckwheat', 'Side', 'Croatian', 'Chop the onion and garlic, slice the mushrooms and wash the buckwheat. Heat the oil and lightly sauté the onion. Add the mushrooms and the garlic and continue to sauté. Add the salt, vegetable seasoning, buckwheat and the bay leaf and cover with water. Simmer gently and just before it is completely cooked, add pepper, sour cream mixed with flour, the chopped parsley and vinegar to taste.', '/static/fotos/53059.jpg'),
(53060, 'Burek', 'Side', 'Croatian', 'Fry the finely chopped onions and minced meat in oil. Add the salt and pepper. Grease a round baking tray and put a layer of pastry in it. Cover with a thin layer of filling and cover this with another layer of filo pastry which must be well coated in oil. Put another layer of filling and cover with pastry. When you have five or six layers, cover with filo pastry, bake at 200ºC/392ºF for half an hour and cut in quarters and serve.', '/static/fotos/53060.jpg'),
(53061, 'Fresh sardines', 'Side', 'Croatian', 'Wash the fish under the cold tap. Roll in the flour and deep fry in oil until crispy. Lay on kitchen towel to get rid of the excess oil and serve hot or cold with a slice of lemon.', '/static/fotos/53061.jpg'),
(53062, 'Walnut Roll Gužvara', 'Dessert', 'Croatian', 'Mix all the ingredients for the dough together and knead well. Cover the dough and put to rise until doubled in size which should take about 2 hours. Knock back the dough and knead lightly.

Divide the dough into two equal pieces; roll each piece into an oblong about 12 inches by 8 inches. Mix the filling ingredients together and divide between the dough, spreading over each piece. Roll up the oblongs as tightly as possible to give two 12 inch sausages. Place these side by side, touching each other, on a greased baking sheet. Cover and leave to rise for about 40 minutes. Heat oven to 200ºC (425ºF). Bake for 30-35 minutes until well risen and golden brown. Bread should sound hollow when the base is tapped.

Remove from oven and brush the hot bread top with milk. Sift with a generous covering of icing sugar.', '/static/fotos/53062.jpg'),
(53063, 'Chivito uruguayo', 'Beef', 'Uruguayan', 'Crush the meat so that it is finite and we put it on a griddle to brown. Put the eggs, bacon and ham to fry.
Cut the bread in half, put the beef brisket, the fried eggs, the bacon, the ham, the mozzarella, the tomato and the lettuce. Cover with the other half of the bread and serve.', '/static/fotos/53063.jpg'),
(53064, 'Fettuccine Alfredo', 'Pasta', 'Italian', 'Cook pasta according to package instructions in a large pot of boiling water and salt. Add heavy cream and butter to a large skillet over medium heat until the cream bubbles and the butter melts. Whisk in parmesan and add seasoning (salt and black pepper). Let the sauce thicken slightly and then add the pasta and toss until coated in sauce. Garnish with parsley, and it''s ready.', '/static/fotos/53064.jpg'),
(53065, 'Sushi', 'Seafood', 'Japanese', 'STEP 1
TO MAKE SUSHI ROLLS: Pat out some rice. Lay a nori sheet on the mat, shiny-side down. Dip your hands in the vinegared water, then pat handfuls of rice on top in a 1cm thick layer, leaving the furthest edge from you clear.

STEP 2
Spread over some Japanese mayonnaise. Use a spoon to spread out a thin layer of mayonnaise down the middle of the rice.

STEP 3
Add the filling. Get your child to top the mayonnaise with a line of their favourite fillings – here we’ve used tuna and cucumber.

STEP 4
Roll it up. Lift the edge of the mat over the rice, applying a little pressure to keep everything in a tight roll.

STEP 5
Stick down the sides like a stamp. When you get to the edge without any rice, brush with a little water and continue to roll into a tight roll.

STEP 6
Wrap in cling film. Remove the mat and roll tightly in cling film before a grown-up cuts the sushi into thick slices, then unravel the cling film.

STEP 7
TO MAKE PRESSED SUSHI: Layer over some smoked salmon. Line a loaf tin with cling film, then place a thin layer of smoked salmon inside on top of the cling film.

STEP 8
Cover with rice and press down. Press about 3cm of rice over the fish, fold the cling film over and press down as much as you can, using another tin if you have one.

STEP 9
Tip it out like a sandcastle. Turn block of sushi onto a chopping board. Get a grown-up to cut into fingers, then remove the cling film.

STEP 10
TO MAKE SUSHI BALLS: Choose your topping. Get a small square of cling film and place a topping, like half a prawn or a small piece of smoked salmon, on it. Use damp hands to roll walnut-sized balls of rice and place on the topping.

STEP 11
Make into tight balls. Bring the corners of the cling film together and tighten into balls by twisting it up, then unwrap and serve.', '/static/fotos/53065.jpg'),
(53067, 'Stuffed Bell Peppers with Quinoa and Black Beans', 'Vegetarian', 'Mexican', '1. Preheat your oven to 375°F (190°C). Lightly grease a 9x13-inch baking dish or a similar-sized casserole dish.
2. Place the bell pepper halves in the prepared baking dish, cut side up. Bake for 15-20 minutes, or until slightly softened.
3. While the bell peppers are baking, prepare the filling. In a large skillet, heat the olive oil over medium heat. Add the chopped onion, and cook for 3-4 minutes, until softened. Add the garlic, and cook for another 1 minute, until fragrant.
4. Stir in the cooked quinoa, black beans, corn, diced tomatoes, ground cumin, chili powder, smoked paprika, salt, and pepper. Cook for 5-7 minutes, until heated through. Remove the skillet from heat, and stir in 1 cup of the shredded cheese, if using.
5. Remove the bell peppers from the oven, and carefully stuff each pepper half with the quinoa and black bean mixture. Top the stuffed peppers with the remaining 1/2 cup of shredded cheese, if using.
6. Return the stuffed peppers to the oven, and bake for another 15-20 minutes, until the cheese is melted and the peppers are tender.
7. Remove from the oven, and allow the stuffed peppers to cool for 5 minutes before serving. Garnish with fresh chopped cilantro.', '/static/fotos/53067.jpg'),
(53068, 'Beef Mechado', 'Beef', 'Filipino', '0.	Make the beef tenderloin marinade by combining soy sauce, vinegar, ginger, garlic, sesame oil, olive oil, sugar, salt, and ground black pepper in a large bowl. Mix well.
1.	Add the cubed beef tenderloin to the bowl with the beef tenderloin marinade. Gently toss to coat the beef. Let it stay for 1 hour.
2.	Using a metal or bamboo skewer, assemble the beef kebob by skewering the vegetables and marinated beef tenderloin.
3.	Heat-up the grill and start grilling the beef kebobs for 3 minutes per side. This will give you a medium beef that is juicy and tender on the inside. Add more time if you want your beef well done, but it will be less tender.
4.	Transfer to a serving plate. Serve with Saffron rice.
5.	Share and enjoy!
', '/static/fotos/53068.jpg'),
(53069, 'Bistek', 'Beef', 'Filipino', '0.	Marinate beef in soy sauce, lemon (or calamansi), and ground black pepper for at least 1 hour. Note: marinate overnight for best result
1.	Heat the cooking oil in a pan then pan-fry half of the onions until the texture becomes soft. Set aside
2.	Drain the marinade from the beef. Set it aside. Pan-fry the beef on the same pan where the onions were fried for 1 minute per side. Remove from the pan. Set aside
3.	Add more oil if needed. Saute garlic and remaining raw onions until onion softens.
4.	Pour the remaining marinade and water. Bring to a boil.
5.	Add beef. Cover the pan and simmer until the meat is tender. Note: Add water as needed.
6.	Season with ground black pepper and salt as needed. Top with pan-fried onions.
7.	Transfer to a serving plate. Serve hot. Share and Enjoy!
', '/static/fotos/53069.jpg'),
(53070, 'Beef Caldereta', 'Beef', 'Filipino', '0.	Heat oil in a cooking pot. Saute onion and garlic until onion softens
1.	Add beef. Saute until the outer part turns light brown.
2.	Add soy sauce. Pour tomato sauce and water. Let boil.
3.	Add Knorr Beef Cube. Cover the pressure cooker. Cook for 30 minutes.
4.	Pan-fry carrot and potato until it browns. Set aside.
5.	Add chili pepper, liver spread and peanut butter. Stir.
6.	Add bell peppers, fried potato and carrot. Cover the pot. Continue cooking for 5 to 7 minutes.
7.	Season with salt and ground black pepper. Serve.
', '/static/fotos/53070.jpg'),
(53071, 'Beef Asado', 'Beef', 'Filipino', '0.	Combine beef, crushed peppercorn, soy sauce, vinegar, dried bay leaves, lemon, and tomato sauce. Mix well. Marinate beef for at least 30 minutes.
1.	Put the marinated beef in a cooking pot along with remaining marinade. Add water. Let boil.
2.	Add Knorr Beef Cube. Stir. Cover the pot and cook for 40 minutes in low heat.
3.	Turn the beef over. Add tomato paste. Continue cooking until beef tenderizes. Set aside.
4.	Heat oil in a pan. Fry the potato until it browns. Turn over and continue frying the opposite side. Remove from the pan and place on a clean plate. Do the same with the carrots.
5.	Save 3 tablespoons of cooking oil from the pan where the potato was fried. Saute onion and garlic until onion softens.
6.	Pour-in the sauce from the beef stew. Let boil. Add the beef. Cook for 2 minutes.
7.	Add butter and let it melt. Continue cooking until the sauce reduces to half.', '/static/fotos/53071.jpg'),
(53072, 'Crispy Eggplant', 'Vegetarian', 'Filipino', 'Slice eggplant into 1 cm (0.4-inch) slices. Place them in a bowl and sprinkle them with salt. allow them to sit for 30 minutes to render some of their liquid and bitterness.
2. After 30 minutes wash eggplant slices from salt and pat dry with a kitchen towel.
3. In a large bowl/plate place breadcrumbs and sesame seeds. In another bowl beat 2 eggs with pinch salt and pepper.
4. Heal oil in a large skillet over high heat.
5. Dip eggplant slices in egg, then in crumbs, and place in hot oil. Fry 2 to 3 minutes on each side, or until golden brown. Drain on a paper towel. 
', '/static/fotos/53072.jpg'),
(53073, 'Eggplant Adobo', 'Vegetarian', 'Filipino', '1.	Slice 1 lb. small Japanese or Italian eggplant (about 3) into quarters lengthwise, then cut crosswise into 2"-wide pieces. Place in a medium bowl. Add 1 Tbsp. sugar, 1 tsp. Diamond Crystal or ½ tsp. Morton kosher salt, and ½ tsp. freshly ground black pepper. Toss to evenly coat eggplant and let sit at room temperature at least 20 minutes and up to 2 hours.
2.	Peel and thinly slice 8 garlic cloves. Add 3 Tbsp. vegetable oil and half of garlic to a medium Dutch oven or other heavy pot. Cook over medium-high heat, stirring constantly with a wooden spoon, until light golden and crisp, about 5 minutes. Using a slotted spoon, transfer garlic chips to a plate; season lightly with salt.
3. Place 4 oz. ground pork in same pot and break up into small pieces with wooden spoon. Season with ¼ tsp. Diamond Crystal or Morton kosher salt and cook, undisturbed, until deeply browned underneath, about 5 minutes. Using a slotted spoon, transfer to another plate, leaving fat behind in the pot.
4. Place eggplant on a clean kitchen towel and blot away any moisture the salt has drawn out.
5. Working in batches and adding more oil if needed, cook eggplant in the same pot until lightly browned, about 3 minutes per side. Transfer to a plate with pork.
6. Pour 1½ cups of water into the pot and scrape up browned bits from the bottom with a wooden spoon. Add remaining garlic, 3 Tbsp. coconut vinegar or unseasoned rice vinegar, 2 Tbsp. soy sauce, 2 bay leaves, 1 tsp. freshly ground black pepper, and remaining 1 Tbsp. sugar. Bring to a simmer, then return pork and eggplant to pot. Reduce heat to medium-low, partially cover, and simmer until eggplant is tender and silky and sauce is reduced by half, 20–25 minutes. Taste and season with more salt and pepper and add a little more sugar if needed.
7. Top with garlic chips and serve with cooked white rice.
', '/static/fotos/53073.jpg'),
(53074, 'Grilled eggplant with coconut milk', 'Vegetarian', 'Filipino', '.  Prepare the eggplants for grilling by pricking them all over with a fork.  This is so it won’t burst during the grilling process as the natural water in it heats up.
2.  Grill the eggplants, turning them over frequently to ensure even cooking.  Grill until the skins are dark brown, even black and the eggplant is soft when you touch it.
3.  Soak the grilled eggplant in a bowl of water to cool it down.  Peel the skin off the eggplant.  Place the whole eggplants in a shallow dish (my mom actually cuts the eggplant into small, bite-sized pieces).
 4.  In a small mixing bowl, mix together the coconut milk or cream, lemon powder, salt and hot pepper.  Mix until the lemon powder and salt dissolve.  Taste, then adjust the amount of lemon powder, salt and hot pepper to your liking.  Pour the mixture over the eggplant.  Sprinkle the green onions over the eggplant and coconut milk.  Stir gently to combine. 
', '/static/fotos/53074.jpg'),
(53075, 'Tortang Talong', 'Vegetarian', 'Filipino', '0.	Grill the eggplant until the color of skin turns almost black
1.	Let the eggplant cool for a while then peel off the skin. Set aside.
2.	Crack the eggs and place in a bowl
3.	Add salt and beat
4.	Place the eggplant on a flat surface and flatten using a fork.
5.	Dip the flattened eggplant in the beaten egg mixture
6.	Heat the pan and pour the cooking oil
7.	Fry the eggplant (that was dipped in the beaten mixture). Make sure that both sides are cooked. Frying time will take you about 3 to 4 minutes per side on medium heat. 
', '/static/fotos/53075.jpg'),
(53076, 'Bread omelette', 'Breakfast', 'India', 'Make and enjoy', '/static/fotos/53076.jpg'),
(53077, 'Cabbage Soup (Shchi)', 'Vegetarian', 'Russian', 'Add the butter to a large Dutch oven or other heavy-duty pot over medium heat. When the butter has melted, add the onion and sauté until translucent.
Add the cabbage, carrot, and celery. Sauté until the vegetables begin to soften, stirring frequently, about 3 minutes.
Add the bay leaf and vegetable stock and bring to a boil over high heat. Reduce the heat to low and simmer, covered, until the vegetables are crisp-tender, about 15 minutes.
Add the potatoes and bring it back to a boil over high heat. Reduce the heat to low and simmer, covered, until the potatoes are tender, about 10 minutes.
Add the tomatoes (or undrained canned tomatoes) and bring the soup back to a boil over high heat. Reduce the heat to low and simmer, uncovered, for 5 minutes. Season to taste with salt and pepper.
emove and discard the bay leaf from the pot.
Serve topped with fresh sour cream and fresh dill.', '/static/fotos/53077.jpg'),
(53078, 'Beetroot Soup (Borscht)', 'Vegetarian', 'Ukrainian', 'Chop the beetroot, add water and stock cube and cook for 15mins. Add the other ingredients and boil until soft. Finally add the beans and cook for 5mins. Serve in the soup pot.', '/static/fotos/53078.jpg'),
(53079, 'Fish Soup (Ukha)', 'Seafood', 'Russian', 'In a medium pot, heat the olive oil over medium-high heat. Add the onions and cook, stirring occasionally until the onions start to caramelize. Add the carrots and cook until the carrots start to soften, about 4 more minutes.
Add the stock, water, potatoes, bay leaves, and black peppercorns. Season with salt and bring to a boil. Reduce heat, cover and cook for 10 minutes. Add the millet and cook for 15 more minutes until millet and potatoes are cooked.
Gently add the fish cubes. Stir and bring the soup to a simmer. The fish will cook through very fast, so make sure to not overcook them. They are done when the flesh is opaque and flakes easily.
Garnish the soup with chopped fresh dill or parsley before serving.', '/static/fotos/53079.jpg'),
(53080, 'Blini Pancakes', 'Side', 'Russian', 'In a large bowl, whisk together 1/2 cup buckwheat flour, 2/3 cup all-purpose flour, 1/2 teaspoon salt, and 1 teaspoon yeast.

Make a well in the center and pour in 1 cup warm milk, whisking until the batter is smooth.

Cover the bowl and let the batter rise until doubled, about 1 hour.

Enrich and Rest the Batter
Stir 2 tablespoons melted butter and 1 egg yolk into the batter.

In a separate bowl, whisk 1 egg white until stiff, but not dry.

Fold the whisked egg white into the batter.

Cover the bowl and let the batter stand 20 minutes.

Pan-Fry the Blini
Heat butter in a large nonstick skillet over medium heat.

Drop quarter-sized dollops of batter into the pan, being careful not to overcrowd the pan. Cook for about 1 minute or until bubbles form.

Turn and cook for about 30 additional seconds.

Remove the finished blini onto a plate and cover them with a clean kitchen towel to keep warm. Add more butter to the pan and repeat the frying process with the remaining batter.', '/static/fotos/53080.jpg'),
(53081, 'Potato Salad (Olivier Salad)', 'Vegetarian', 'Russian', 'Cut the potatoes and carrots into small uniform cubes.
Place them in a large pot and fill with water.
Add salt and vinegar. Bring it to a boil over medium high heat, and then reduce the heat to medium and continue to cook until the potatoes are cooked through, about 15 minutes. Drain the potatoes and let it cool to room temperature.
Meanwhile, cut the sausage and pickles into small cubes, and chop the green onions.
Cut the hard-boiled eggs into small cubes as well.
If using fresh dill, chop them as well.
In a large bowl, combine potatoes, carrots, sausage, pickles, peas and green onions.
Add mayo and dill and mix until well combined.
Salt and pepper to taste. Cover with a plastic wrap and refrigerate for at least 1 hour before serving.', '/static/fotos/53081.jpg'),
(53082, 'Strawberries Romanoff', 'Dessert', 'Russian', 'In a medium bowl, combine hulled and quartered strawberries, 4 Tbsp sugar and 4 Tbsp liqueur, stir to combine then cover and refrigerate at least 1 hour and up to 2 hours, stirring once or twice.

Two photos of cut strawberries in a bowl with one having sugar being added to the bowl Two photos of cut up strawberries for Strawberry Romanoff 

Just before serving, in a large mixing bowl, combine 1 cup cold heavy cream and 1/4 cup powdered sugar, and beat with an electric mixer until stiff peaks form. Using a spatula, fold in 1/4 cup sour cream just until well blended.

To serve, stir strawberries then divide between 6 serving glasses or bowls. You can spoon a little syrup over the berries if you like. You can also use this syrup to soak a cake. Spoon cream over strawberries, dividing evenly. You can also use an ice cream scoop with trigger release for a nice rounded puff of cream. Serve right away or chill and enjoy within 2 hours of assembly.

', '/static/fotos/53082.jpg'),
(53083, 'Lamb Pilaf (Plov)', 'Lamb', 'Russian', 'Place the raisins and prunes into a small bowl and pour over enough water to cover. Add lemon juice and let soak for at least 1 hour. Drain. Roughly chop the prunes.

Meanwhile, heat the butter in a large pan, add the onion, and cook for 5 minutes. Add cubed lamb, ground lamb, and crushed garlic cloves. Fry for 5 minutes, stirring constantly until browned.

Pour 2/3 cup (150 milliliters) of stock into the pan. Bring to a boil, then lower the heat, cover, and simmer for 1 hour, or until the lamb is tender.

Add the remaining stock and bring to a boil. Add rinsed long-grain white rice and a large pinch of saffron. Stir, then cover, and simmer for 15 minutes, or until the rice is tender.

Add the drained raisins, drained chopped prunes, and salt and pepper to taste. Heat through for a few minutes, then turn out onto a warmed serving dish and garnish with sprigs of flat-leaf parsley.', '/static/fotos/53083.jpg'),
(53086, 'Migas', 'Miscellaneous', 'Spanish', 'Crumble the bread into small pieces. Sprinkle with cold water, cover with a damp cloth and leave for 30 minutes.
Heat 2 tsp of olive oil in a deep pan. Add the garlic cloves separated, skins on; just make a small cut with a knife to open them and keep frying for 5 minutes. Set the garlic aside.
In the same oil, where we fried everything, simmer the bread, stirring constantly for 15 minutes and add a grinding of black pepper.
Add the garlic, continue stirring for about 20 minutes. It will be ready when the bread is soft and golden.', '/static/fotos/53086.jpg'),
(53089, 'Syrian Bread', 'Miscellaneous', 'Syrian', 'Place ingredients in the pan of the bread machine in the order recommended by the manufacturer. Select Dough cycle; press Start.

When the Dough cycle is almost complete, preheat the oven to 475 degrees F (245 degrees C).

Turn dough out onto a lightly floured surface. Divide into eight equal pieces and form into rounds. Cover the rounds with a damp cloth and let rest.

Roll dough into thin flat circles, about 8 inches in diameter. Cook two at a time on preheated baking sheets or a baking stone until puffed up and golden brown, about 5 minutes. Repeat for remaining loaves.', '/static/fotos/53089.jpg'),
(53091, 'Falafel Pita Sandwich with Tahini Sauce', 'Vegetarian', 'Syrian', 'Preheat the oven to 450 degrees F (230 degrees C). Place falafel on a baking sheet.

Bake in the preheated oven until heated through, 8 to 10 minutes.

While falafel bake, whisk tahini, water, lemon juice, garlic, and paprika together in a bowl.

Cut about 1 inch from the top of each pita to form a pocket. Add 2 falafel to each pita with equal amounts lettuce, tomato, cucumber, pickle, and red onion. Drizzle each with about 1 tablespoon tahini sauce and some harissa.', '/static/fotos/53091.jpg'),
(53092, 'Fasoliyyeh Bi Z-Zayt (Syrian Green Beans with Olive Oil)', 'Vegan', 'Syrian', 'Place the green beans into a large pot, and drizzle with olive oil. Season with salt to taste, and put the lid on the pot. Cook over medium-high heat, stirring occasionally, until beans are cooked to your desired doneness. Syrians like it cooked until the green beans are turning brownish in color. The idea is not to saute them, but to let them steam in the moisture released by the ice crystals.

Add cilantro and garlic to the beans, and continue to cook just until the cilantro has started to wilt. Eat as a main course by scooping up with warm pita bread or serve as a side dish.', '/static/fotos/53092.jpg'),
(53093, 'Syrian Spaghetti', 'Pasta', 'Syrian', 'Preheat oven to 350 degrees F (175 degrees C). Grease a 9x13 inch baking dish.

Bring a large pot of lightly salted water to a boil. Add spaghetti and cook for 8 to 10 minutes or until al dente; drain and stir in tomato sauce, tomato paste, cinnamon, oil, salt and pepper. Transfer to prepared dish.

Bake in preheated oven for 1 hour, or until top is crunchy.', '/static/fotos/53093.jpg'),
(53094, 'Baba Ghanoush', 'Side', 'Syrian', 'Preheat an outdoor grill for medium-high heat and lightly oil the grate. Prick the surface of the skin of eggplants several times with the tip of a knife.

Place eggplants directly on grill. Turn frequently with tongs while skin chars. Cook until eggplants have collapsed and are very soft, 25 to 30 minutes. Transfer to a bowl and cover tightly with aluminum foil and allow to cool, about 15 minutes.

When eggplants are cool enough to handle, split them in half and scrape flesh into a colander placed over a bowl. Drain 5 or 10 minutes.

Transfer eggplant to mixing bowl. Add crushed garlic and salt; mash until creamy but with a little texture, about 5 minutes. Whisk in lemon juice, tahini, olive oil, and cayenne pepper. Stir in yogurt.

Cover bowl with plastic wrap and refrigerate until completely chilled. Stir in mint and parsley, and taste to adjust seasonings before serving.', '/static/fotos/53094.jpg'),
(53095, 'Syrian Rice with Meat', 'Miscellaneous', 'Syrian', 'Heat 1/4 cup butter in a large saucepan over medium-high heat. Add ground beef and season with salt, allspice, cinnamon, and black pepper. Cook and stir until beef is browned and crumbly, 7 to 10 minutes.

Stir chicken broth and rice into beef in the saucepan; bring to a boil. Reduce heat to low, cover, and cook until liquid is absorbed, about 20 minutes.

Meanwhile, melt 2 tablespoons butter in a small skillet over medium heat. Cook and stir pine nuts in hot butter until lightly browned, 3 to 5 minutes.

Mix pine nuts into beef-rice mixture before serving.', '/static/fotos/53095.jpg'),
(53096, 'Corned Beef Hash', 'Beef', 'British', 'Sauté the onions:
Heat butter in a large skillet (preferably cast iron) on medium heat. Add the onion and cook a few minutes, until translucent.

Add the potatoes and corned beef:
Mix in the chopped corned beef and potatoes. Spread out evenly over the pan. Increase the heat to high or medium high and press down on the mixture with a metal spatula.


Cook until browned and then flip:
Do not stir the potatoes and corned beef, but let them brown. If you hear them sizzling, this is good.

Use a metal spatula to peek underneath and see if they are browning. If nicely browned, use the spatula to flip sections over in the pan so that they brown on the other side. Press down again with the spatula.

If there is too much sticking, you can add a little more butter to the pan. Continue to cook in this manner until the potatoes and the corned beef are nicely browned.

Stir in the parsley and season:
Remove from heat, stir in chopped parsley. Add plenty of freshly ground black pepper, and add salt to taste.', '/static/fotos/53096.jpg'),
(53097, 'Yorkshire Puddings', 'Miscellaneous', 'British', 'step 1
Heat oven to 230C/fan 210C/gas 8.

step 2
Drizzle a little sunflower oil evenly into two 4-hole Yorkshire pudding tins or two 12-hole non-stick muffin tins and place in the oven to heat through.

step 3
To make the batter, tip 140g plain flour into a bowl and beat in 4 eggs until smooth.

step 4
Gradually add 200ml milk and carry on beating until the mix is completely lump-free. Season with salt and pepper.

step 5
Pour the batter into a jug, then remove the hot tins from the oven. Carefully and evenly pour the batter into the holes.

step 6
Place the tins back in the oven and leave undisturbed for 20-25 mins until the puddings have puffed up and browned.

step 7
Serve immediately. You can now cool them and freeze for up to 1 month.', '/static/fotos/53097.jpg'),
(53098, 'Cumberland Pie', 'Beef', 'British', 'step 1
Heat oven to 160C/140C fan/gas 3. Soften the celery, onion, carrots, bay and 1 thyme sprig in a casserole with 1 tbsp oil and the butter for 10 mins. Stir in the flour, followed by the purée, Worcestershire sauce and stock cubes.

step 2
Gradually stir in 600ml hot water, then tip in the beef and bring to a gentle simmer. Cover and cook in the oven for 2 hrs 30 mins, then uncover and cook for 30 mins -1 hr more until the meat is really tender and sauce thickened.

step 3
Meanwhile, cook potatoes in a pan of boiling water until they’re not done but about ¾ of the way there.

step 4
Transfer meat to a baking dish. Slice spuds into 1cm thick rounds and gently toss with seasoning, the remaining oil and thyme leaves. Layer on the beef, scattering with the cheese as you layer. You can cover and chill the pie now for 1 day, or freeze for up to 3 months.

step 5
Increase oven to 200C/180C fan/gas 6 and bake for 30-40 mins until golden and crispy, and sauce bubbling if the dish went in cold. Serve with peas.', '/static/fotos/53098.jpg'),
(53099, 'Aussie Burgers', 'Beef', 'Australian', 'step 1
Make the burgers: Tip the meat into a bowl and sprinkle over 1 tsp salt and a good grinding of black pepper.Work with wet hands to mix in the seasoning. Divide into four with your hands and shape into burgers. (It can be frozen at this stage.)

step 2
Sort out your ingredients: Slice the beetroot and split the naan breads.

step 3
Toast the naans: Heat a griddle pan or barbecue. Griddle the naans on both sides until lightly toasted and set aside. Add the burgers to the grill or barbecue and cook for 2-3 minutes, then turn and cook the other side for a further 2-3 minutes.

step 4
Assemble the dish: Set half a toasted naan on each serving plate and put a pile of rocket on each. Top with a burger, then a few slices of beetroot and a dollop of soured cream. Sprinkle with salt and freshly ground black pepper and serve immediately with a big green salad and chips. A glass of red wine wouldn’t go amiss, either.', '/static/fotos/53099.jpg'),
(53100, 'Blueberry & lemon friands', 'Dessert', 'Australian', 'step 1
Preheat the oven to fan 180C/conventional 200C/gas 6. Generously butter six non-stick friand or muffin tins. Melt the butter and set aside to cool.

step 2
Sift the icing sugar and flour into a bowl. Add the almonds and mix everything between your fingers.

step 3
Whisk the egg whites in another bowl until they form a light, floppy foam. Make a well in the centre of the dry ingredients, tip in the egg whites and lemon rind, then lightly stir in the butter to form a soft batter.

step 4
Divide the batter among the tins, a large serving spoon is perfect for this job. Sprinkle a handful of blueberries over each cake and bake for 15-20 minutes until just firm to the touch and golden brown.

step 5
Cool in the tins for 5 minutes, then turn out and cool on a wire rack. To serve, dust lightly with icing sugar.', '/static/fotos/53100.jpg'),
(53101, 'Chocolate Coconut Squares', 'Dessert', 'Australian', 'step 1
Heat oven to 180C/fan 160C/gas 4. Butter and line the base of a 20cm square baking tin. Beat together the butter and sugar until pale and creamy, then beat in the eggs. Add 1 tbsp of the flour if the mix starts to curdle.

step 2
Sieve in the flour, baking powder and cocoa and fold in with a metal spoon. Stir in the milk. Scrape mix into the tin and level the top. Bake for 18-20 mins or until the cake springs back when pressed. Allow to cool in the tin.

step 3
To make the icing, put the chocolate, butter and 4 tbsp water in a pan and gently heat until melted. Allow to cool slightly, then beat in the icing sugar.

step 4
Remove cake from tin and peel away paper. Cut into 16 squares. Dip the squares into the icing, then roll in the coconut. Allow to set on cooling rack.', '/static/fotos/53101.jpg'),
(53102, 'Squid, chickpea & chorizo salad', 'Seafood', 'Australian', 'step 1
Cook the peppers whole under a grill, on a barbecue or griddle, until completely charred. Place the peppers in a bowl, cover with a plate until cool enough to handle, then peel, deseed and finely slice. In a large bowl mix the peppers and any juices with the chickpeas, parsley, chilli and garlic. Set aside.

step 2
Heat a large frying pan until smoking. Working quickly and carefully, add a splash of oil to the pan, then the squid. Stir-fry for about 30 secs. Scatter the chorizo over the squid, continue to cook for 30 secs more, then tip into the bowl with the peppers. Season everything with salt and pepper, then dress with the remaining oil, lemon juice and lemon zest. Mix together, pile onto a platter and let everyone help themselves.', '/static/fotos/53102.jpg'),
(53103, 'Barramundi with Moroccan spices', 'Seafood', 'Australian', 'step 1
Tip all the dressing ingredients into a food processor with a pinch of salt and blitz to a dressing. Slash the fish three times on each side, coat with half of the dressing, then set aside to marinate for about 30 mins.

step 2
Heat oven to 220C/fan 200C/gas 7. Place the fish on a roasting tray, then cook in the oven for 20 mins until the flesh is firm and the eyes have turned white. Serve the fish with the rest of the dressing and steamed couscous or rice.

step 3
KNOW HOW: HOW TO COOK IT: Cooking barramundi on the bone, as we have done here, has its advantages – it will stay more moist during cooking, and some would say that the flavour is enhanced, too. If you want to take out the bones they are easy to locate and less likely to be lodged in the fillet if the fish is cooked whole. Fillets can be simply pan-fried or grilled. If you like trout, you will really enjoy the flavour of barramundi, which lends itself to similar ingredients and cooking methods – citrus flavours are particularly good, as are garlic and wild mushrooms. Simply roasting the fish with some fresh herbs, olive oil and seasoning is delicious, and in the summer months you could barbecue it, too. One thing that you mustn’t miss are the cheeks or ‘pearls’ of the fish, these are simply lovely, moist and really sweet – well worth leaving the head on for!', '/static/fotos/53103.jpg'),
(53104, 'Lamingtons', 'Dessert', 'Australian', 'step 1
Heat the oven to 200C/180C fan/gas 6. Butter and line a 20 x 30cm rectangle tin.

step 2
Beat the butter and sugar in a free-standing mixer until pale and fluffy. Add the eggs one at a time and beat well. Beat through the flour, milk and salt until fully combined, then spoon into the tin. Bake in the oven for 25 mins or until golden and firm to the touch. Set aside to cool completely.

step 3
Slice the sponge horizontally to create two halves. Trim the edges to make perfect corners. Cut the sponge into 18 squares. Lightly whip the cream with the icing sugar until it reaches soft peaks. Spread a little of the jam on half of the sponge squares then pipe or spread over a little of the cream. Sandwich each one with a second square of sponge then set aside in the fridge to chill.

step 4
To make the icing, whisk together the melted butter and milk in a bowl. Sieve the cocoa powder and icing sugar together in a seperate bowl. Gradually add the cocoa and sugar to the butter and milk mixture, whisking continuously to ensure there are no lumps. If it gets lumpy, whizz with a hand blender until smooth.

step 5
Divide the coconut between three shallow bowls (this keeps it from getting coated in too much chocolate whilst you’re dipping).

step 6
Dip each lamington in the icing until completely covered. Roll in the coconut and set on a wire rack. Repeat with the remaining sponges. Chill for a minimum of 1 hr.', '/static/fotos/53104.jpg'),
(53105, 'Spiced smoky barbecued chicken', 'Chicken', 'Australian', 'step 1
Make the marinade. Smash the garlic with a little salt using a pestle and mortar. Add the lemon zest and juice, the spice mix, chilli, oil and a good grinding of black pepper. Mix to a paste. This can be done in a mini food processor.

step 2
Toss the chicken in the marinade and set aside while you light the barbecue. When the barbecue’s hot, lay the bunches of herbs on the grid and put the chicken, skin side up, on top. Close the lid, if your barbecue has one, and cook the chicken on the smouldering herbs for about 10 minutes until the meat starts to colour. Turn the chicken and continue to cook for a further 20-30 minutes, turning as necessary, until it is slightly charred from the burnt herbs and cooked through to the bone.', '/static/fotos/53105.jpg'),
(53106, 'Warm roast asparagus salad', 'Pork', 'Australian', 'step 1
Preheat the oven to 200C/Gas 6/fan 180C. Snap off the woody ends of the asparagus and discard. Arrange the asparagus in a single layer in a baking tray with sides. Cut the tomatoes in half widthways, nestle them in with the asparagus, season with sea salt and pepper and drizzle with olive oil. Roll each bacon rasher into a tight roll (if large, first cut in half crosswise), and arrange in the tray. Drizzle the bacon rolls with the honey and bake for 20 minutes until the tomatoes are soft and the bacon is crisp.

step 2
In the meantime, boil the potatoes until tender. Whisk the vinegar, olive oil, mustard, some sea salt and pepper in a large bowl until blended. Toss the rocket or spinach leaves in half of the dressing, and arrange on a large serving platter.

step 3
Drain the potatoes and cut in half. Gently toss them in the rest of the dressing, and arrange on the platter with the asparagus. Tuck in the tomatoes and bacon.', '/static/fotos/53106.jpg'),
(53107, 'Avocado dip with new potatoes', 'Vegetarian', 'Australian', 'step 1
Whizz half the avocado flesh with the yogurt, lime and lemon juice and seasoning. Dice the remaining avocado, then gently stir into the whizzed mix with most of the lime zest. Cover, then chill until ready to serve.

step 2
Boil potatoes for 6 mins, then drain well and toss with olive oil, chilli powder and cumin seeds. Now set aside until half an hour before your guests arrive.

step 3
Heat oven to 200C/180C fan/gas 6, then roast potatoes for about 30 mins, shaking the tray halfway, until golden and tender. Transfer the dip to one or two bowls, scatter with the remaining lime zest and serve with the hot potatoes, and tortilla chips for dipping.', '/static/fotos/53107.jpg'),
(53108, 'Quick salt & pepper squid', 'Seafood', 'Australian', 'step 1
Ask the fishmonger to clean the squid; little ones often come ready-cleaned. Using kitchen scissors, cut open the body and open out. Wash well, then pat dry. If you have a large squid, cut the body into four portions, roughly square. Small squid can just be opened up.

step 2
Using the tip of a very sharp knife, score the top in a neat criss-cross. Brush with oil and set aside while you heat the barbecue or griddle until ready to cook.

step 3
Mix together 2 tsp sea salt, Chinese five-spice and 1 tsp freshly ground black pepper. Sprinkle on both sides of the squid just before cooking, according to taste. You may not need it all. Heat the griddle pan to hot and cook about 1 min each side, until it starts to curl. Remove with tongs to a serving plate and drizzle with a little sesame oil. To serve, garnish with coriander leaves and serve with small bowls of sweet chilli sauce to dip into.', '/static/fotos/53108.jpg'),
(53109, 'Mini chilli beef pies', 'Beef', 'Australian', 'step 1
To make chilli, heat oil in a pan and fry onion for 5 mins until soft. Add spices; fry for 1 min. Stir in beef and cook for a few mins. Add tomato purée, stock and cinnamon. Give it a stir, bring to the boil, then simmer for 15-20 mins until very little liquid is left. Add beans 5 mins before the end of cooking. Check seasoning and cool.

step 2
Heat oven to 200C/fan 180C/gas 6. Using a 7cm pastry cutter, stamp out 12 circles from the pastry. Use to line a 12-hole mini muffin tray, prick the base of the pastry with a fork, and bake for 10 mins. Remove from oven and cool on a wire tray. Repeat with remaining pastry.

step 3
Meanwhile, cook the potato in boiling water until tender. Drain, mash with soured cream and seasoning, then stir through chives. Spoon 1-2 tsp of chilli mix into the pastry cases and top with a tsp of mash. Ruffle mash with a fork; return to the oven for 15 mins or until golden.', '/static/fotos/53109.jpg'),
(53110, 'Sticky Chicken', 'Chicken', 'Australian', 'step 1
Make 3 slashes on each of the drumsticks. Mix together the soy, honey, oil, tomato purée and mustard. Pour this mixture over the chicken and coat thoroughly. Leave to marinate for 30 mins at room temperature or overnight in the fridge. Heat oven to 200C/fan 180C/gas 6.

step 2
Tip the chicken into a shallow roasting tray and cook for 35 mins, turning occasionally, until the chicken is tender and glistening with the marinade.', '/static/fotos/53110.jpg'),
(53111, 'Anzac biscuits', 'Dessert', 'Australian', 'step 1
Heat oven to 180C/fan 160C/gas 4. Put the oats, coconut, flour and sugar in a bowl. Melt the butter in a small pan and stir in the golden syrup. Add the bicarbonate of soda to 2 tbsp boiling water, then stir into the golden syrup and butter mixture.

step 2
Make a well in the middle of the dry ingredients and pour in the butter and golden syrup mixture. Stir gently to incorporate the dry ingredients.

step 3
Put dessertspoonfuls of the mixture on to buttered baking sheets, about 2.5cm/1in apart to allow room for spreading. Bake in batches for 8-10 mins until golden. Transfer to a wire rack to cool.', '/static/fotos/53111.jpg'),
(53112, 'Kenyan Beef Curry', 'Beef', 'Kenyan', 'Bring the 4 cups of water to a boil in a Dutch oven or soup pot. Add the beef, garlic, and ginger, and stir well. Bring to a gentle simmer, cover, and cook, stirring occasionally, for 20 minutes. If you get any foamy scum on the top, not to worry, simply spoon it away or stir it back in.
Remove from the heat, and drain, but reserve the excess water for later.
Return the pot or Dutch oven to medium heat with the 2 tablespoons of cooking oil. Once the oil is shimmering, add the onions and cook, stirring occasionally, until softened, 5 to 7 minutes.
Add the tomatoes to the onions, and continue cooking, stirring occasionally, until the tomatoes are falling apart, 3 to 5 minutes.
Add the drained beef to the tomato and onion mixture, and stir well. Continue cooking over medium heat for 5 minutes, stirring occasionally.
Add the paprika, pepper, curry powder, tomato paste, and salt to taste, and stir well.
Add back the excess water that was used for cooking the beef, along with enough extra water to cover. Bring to a boil, reduce heat, and simmer, uncovered, stirring occasionally, for about 1 hour, or until the meat is tender and the sauce is thickened. Add additional water if your beef curry begins to dry and stick, or if would like your curry to have more of a soupy consistency.
When the beef curry is ready, remove from the heat, give it a taste, and adjust the seasonings as desired. Garnish with fresh chilis and cilantro.', '/static/fotos/53112.jpg'),
(53113, 'Sukuma Wiki', 'Vegetarian', 'Kenyan', 'Heat the 2 tablespoons of oil in a large skillet or pot over medium heat until shimmering. Add the onions and cook, stirring occasionally, until softened, 5 to 7 minutes.
Add the shredded kale to the onions and mix well. Turn the heat to medium-low, cover and cook for 5 minutes.
After 5 minutes, remove the lid, add salt to taste, and stir in the cream. Continue cooking for another 5 minutes, uncovered, stirring occasionally. The cream will thicken slightly, making for a deliciously rich creamed kale and onions. Yumm!
Serve it up with your favorite Kenyan stew, and a side of ugali!', '/static/fotos/53113.jpg'),
(53114, 'Ugali – Kenyan cornmeal', 'Breakfast', 'Kenyan', 'Bring the water to a boil in a medium saucepan.
Reduce the heat to low, and stirring constantly with a whisk, slowly add the cornmeal to the boiling water. The ugali will begin to thicken quite quickly.
Continue cooking on low heat, stirring constantly with a sturdy wooden spoon, until the ugali begins to pull away from the sides of the pan, hold together, and takes on the aroma of roasted corn. Turn it out immediately onto a serving plate. If you would like, using a spoon or spatula, quickly shape it into a thick disk or round.
The ugali will continue to firm as it cools and will be thick enough to cut with a knife (similar to firm polenta).', '/static/fotos/53114.jpg'),
(53115, 'Red onion pickle', 'Vegan', 'Norway', 'Peel the onions, cut them in half from top to bottom and finely slice into half-moon pieces. Put in a colander placed over a bowl and sprinkle with salt, lightly turning over the onion pieces with your hands so the surfaces are all covered. Set aside for an hour or so to brine.

Meanwhile put the vinegar, 50ml/2fl oz water and the sugar in a saucepan. Bring to a simmer, stirring to help the sugar dissolve, and cook for a couple of minutes. Set aside.

Pack the onions into the sterilised jars, sprinkling in a little pepper as you go. Cover with the warm vinegar and finish by tucking a couple of bay leaves down the side of the jars. Seal. The onions are best kept in the fridge and used within to 4 weeks.', '/static/fotos/53115.jpg'),
(53116, 'Cinnamon buns', 'Dessert', 'Norway', 'In a small saucepan heat the butter, milk and salt until the butter is melted. Allow the mixture to cool until it is lukewarm.

In a large bowl, stir together the flours, yeast, cardamom and sugar until combined.

Make a well in the centre and crack in the eggs. Pour in the lukewarm milk mixture and stir everything together to form a sticky dough. You may have to use your hands as the dough becomes stiffer.

Oil the work surface with a teaspoon of olive oil. Turn the dough out onto the oiled surface and knead vigorously for 5–8 minutes, using a plastic scraper as needed to prise the dough from the work surface. Don’t be tempted to add flour, as this will make the buns dry and tough. Keep kneading until the dough is considerably less sticky, smoother and more elastic.

Shape into a ball, and put into a large, greased bowl. Cover the bowl with a clean tea towel and set aside in a warm place to prove for an hour, or until doubled in size.

Meanwhile, for the filling and topping, mix the softened butter in a bowl with half the sugar and 1 tablespoon cinnamon. Use a fork to mix the sugar and spice into the butter until it is completely combined.

Mix the remaining sugar and cinnamon in a separate bowl and set aside.

When the dough has risen, turn out onto a floured work surface and gently roll out into a 36x24cm/14x9½in rectangle. Spread the cinnamon-sugar-butter evenly over the dough with a table or palette knife.

With the longest edge closest to you, roll the dough up into a cylinder. Cut into 12 even slices.

Place each slice onto a flattened out paper cupcake case on a baking tray, or into a greased muffin tin. (Baking in a muffin tin will make your cinnamon buns taller and domed.)

Cover with a clean tea towel and set aside to prove again for 30–45 minutes, or until risen.

Preheat the oven to 200C/180C Fan/Gas 6.

Brush the tops of the buns with beaten egg and dust liberally with the cinnamon sugar. Bake for 12 minutes until the buns are dark golden-brown. Enjoy warm with a cup of coffee.', '/static/fotos/53116.jpg'),
(53117, 'Nordic smørrebrød with asparagus and horseradish cream', 'Vegetarian', 'Norway', 'To make the horseradish cream, mix the crème fraîche, grated horseradish, lemon juice, salt and white pepper in a bowl. Refrigerate until serving.

To make the crispy shallots, heat some vegetable oil in a frying pan over a medium heat. Add the sliced shallots and fry until golden brown and crispy.

Remove with a slotted spoon and drain on a plate lined with kitchen paper. Season with a pinch of salt.

To make the open sandwich, bring a large saucepan of salted water to the boil, then blanch half of the asparagus (four white and four green) until tender-crisp, about 2–3 minutes.

Add ice to a bowl of cold water. Use a slotted spoon to remove the asparagus from the boiling water and immediately transfer to the iced water to stop cooking. Thinly slice the remaining asparagus lengthwise to serve raw.

Pre-heat the grill until hot. Spread the rye bread with butter and grill until golden and crisp.

To serve, place the grilled bread slices on serving plates. Arrange both the blanched and raw asparagus on the bread. Drizzle with horseradish cream, then sprinkle grated cheese over the top. Garnish with the crispy shallots and some fresh dill to finish.', '/static/fotos/53117.jpg'),
(53118, 'Rømmegrøt – Norwegian Sour Cream Porridge', 'Breakfast', 'Norway', '▢
Cook the sour cream in a covered saucepan on medium heat for about 5 minutes.
▢
Turn down the heat and add half of the flour and stir well with a whisk. Once the flour is fully incorporated, let the mixture continue to cook, stirring occasionally, until fat starts to release. Use a spoon to gather as much of the fat as you can in a small bowl, saving for later. (Don''t worry if you can''t get any fat – in that case you can add butter later.)
▢
Whisk in the rest of the flour and then slowly add the milk, whisking constantly to avoid lumps. Let the porridge continue to cook on low heat for 5 minutes and then add salt.
▢
Serve with sugar, cinnamon, and the fat from the porridge. If you''re using lower fat sour cream you can top the rømmegrøt with some butter instead.', '/static/fotos/53118.jpg'),
(53119, 'Tall Skoleboller', 'Dessert', 'Norway', '▢
Heat the milk until it''s lukewarm. Add the yeast and dissolve.
▢
Add the sugar, cardamom, vanilla, and about 2/3 of the flour.
▢
Mix the dough together either by hand or in a mixer with a dough hook, slowly adding the rest of the flour. You might need a bit more or less flour to form dough that isn''t too sticky to knead. When the dough forms a nice ball, add the softened butter and continue to knead the dough for about ten minutes.
▢
Roll the dough into a cylinder and cut into six equal parts. Roll each piece into a round bun and set them in a greased muffin/cake tin. Cover and let rise until doubled in size (about an hour).', '/static/fotos/53119.jpg'),
(53121, 'Norwegian Potato Lefse', 'Side', 'Norway', 'Boil the potatoes. Peel the potatoes while still warm and run them through a potato ricer twice.
▢
Let the potatoes cool in an uncovered bowl in the fridge.
▢
Stir the salt, sugar, melted butter, and cream into the riced potatoes.
▢
Slowly add the flour and knead by hand until you get a good consistency. Don''t add more flour than necessary! Roll the dough into a long sausage and divide into about 7 or 8 pieces if using an 18 inch griddle. If using a smaller griddle or frying pan, divide the dough into 10 – 12 pieces.
▢
Roll each piece into a ball and then press into a flat circle, using the edges of your hands to form the dough into a nice circle shape without any cracks. This is important, otherwise you won''t get round lefser.
▢
Heat up your griddle on medium/high heat.
▢
Flour your rolling surface and roll the lefse dough into a large circle slightly smaller than your griddle or frying pan. Begin rolling with a smooth rolling pin, then switch to a corrugated rolling pin as the lefse gets thinner. Don''t use too much flour, as then the edges can become hard.
▢
Roll the lefse onto your lefse stick and then gently unroll it onto your griddle. After a minute or two check the underside of the lefse for brown spots and then use the lefse stick to flip the lefse and cook on the other side.
▢
Use the lefse stick to remove the lefse from the griddle and place it in a folded damp sheet or tablecloth.', '/static/fotos/53121.jpg'),
(53122, 'Fiskesuppe (Creamy Norwegian Fish Soup)', 'Seafood', 'Norway', '▢
Cut the fish fillets in cubes or strips. Crush or chop the garlic. Rinse the vegetables and cut into thin strips.
▢
Heat the butter in a pot and add the garlic. Once the garlic starts to turn golden add the flour, whisking well.
▢
Add the fish stock and continue to whisk until there are no lumps.
▢
Add the vegetables and milk and bring to a boil. Cook for about 10 minutes.
▢
Add the crème fraîche (or sour cream). Bring the soup back to a simmer and once the soup begins to bubble again turn off the heat. Keep the soup on the burner and add the fish. Let the fish cook in the hot soup for 5 minutes. If using shrimp, add right before serving.
▢
Sprinkle with chives (or dill or parsley) before serving.', '/static/fotos/53122.jpg'),
(53123, 'Fårikål (Norwegian National Dish)', 'Lamb', 'Norway', '▢
Cut the lamb into large pieces.
▢
Slice the cabbage into large wedges, keeping the core attached.
▢
Add a layer of lamb pieces to the bottom of a large pot, fatty side down. Sprinkle with peppercorns and salt. Add a layer of cabbage wedges on top. Repeat with more layers of lamb, peppercorns, and cabbage, ending with cabbage on top.
▢
Optional: Sprinkle a couple of tablespoons on top of the lamb for a thicker stew.
▢
Add water to the pot and bring to a boil. Cover and reduce heat. Cook on low heat for 2 – 3 hours, until the lamb gently falls away from the bone.
▢
Serve with boiled potatoes and fresh parsley, covering generously with the fårikål broth.', '/static/fotos/53123.jpg'),
(53124, 'Raspeballer (Norwegian Potato Dumplings)', 'Pork', 'Norway', 'Raspeballer & (Optional) Salted Meat
▢
If you''re making pork knuckle, cook it in simmering water for about 3 hours, until the meat falls from the bone. Remove the pork and save the broth to cook the raspeballer.
▢
Boil the boiled potatoes and peel once cooled. Also peel the raw potatoes, and then grate them or run them through a food processor. Use a paper towel to remove some of the moisture from the grated potatoes.
▢
Mash the boiled potatoes in a potato ricer or with a masher. Make sure there are no lumps. Add the grated raw potatoes to the mashed potatoes in a large mixing bowl and stir together. Add the barley flour, all purpose flour, and salt and mix together with your hands until the mixture is fully blended.
▢
You can cook the raspeballer in either vegetable or beef broth, or if you''re making pork knuckle, cook them in the broth from the pork knuckle. Bring the broth to a very light simmer – you don''t want it to fully boil because then the raspeballer might break apart.
▢
Use a tablespoon dipped in cold water to shape each raspeball in your hand. Try to make them as smooth as possible and then gently drop them into the simmering broth. Dip the tablespoon in a bowl of cold water between each raspeball.
▢
Let the raspeballer simmer for about 30 minutes. If you''re making smoked sausage, you can heat the sausage in the same pot with the raspeballer. Top with fresh chopped parsley.

Mashed Rutabaga
▢
Peel the rutabaga and carrots and cut into small pieces. Boil in water for about 30 minutes, or until tender. Then drain the water, add the cream/milk, butter and nutmeg and mash until smooth.
▢
Serve alongside the raspeballer and meat.', '/static/fotos/53124.jpg'),
(53125, 'Karbonader (Lean Beef Patties) with Caramelized Onions', 'Beef', 'Norway', 'Grate half an onion and set aside. Slice the rest of the onions and fry in butter on low/medium heat until caramelized.
▢
In a bowl, mix together ground beef, grated onion, salt, pepper, nutmeg, potato/corn starch, and water.
▢
Form into a sausage and cut 6 patties. Using a knife make a light grid pattern in each patty.
▢
Brown both sides of the karbonader in butter on high heat, then turn down to low heat and fry for another 2 – 3 minutes.
▢
Serve the karbonader and onions with potatoes, stewed peas, and brown sauce for dinner, or on a slice of bread for lunch or a snack.', '/static/fotos/53125.jpg'),
(53126, 'Brun Lapskaus (Norwegian Beef Vegetable Stew)', 'Beef', 'Norway', '▢
Heat olive oil in a large pot. Cut beef into 1 inch (2.5 cm) cubes and brown in oil.
▢
Dice the onion and add to browning beef. Add the stock and bring to a boil, then lower the heat, cover, and let simmer for about 30 minutes.
▢
Peel and cut the rutabaga and celery root into 1 inch (2.5 cm) cubes. Add to the pot, cover, and continue simmering for another 30 minutes.
▢
Peel and chop the rest of the vegetables into 1 inch (2.5 cm) cubes and add to the pot. Slice the leek into rings. Cover and continue simmering for about 20 minutes. Stir as little as possible.
▢
Top with fresh parsley.', '/static/fotos/53126.jpg'),
(53127, 'Authentic Norwegian Kransekake', 'Dessert', 'Norway', 'Grind almonds in an almond grinder or food processor.
▢
Mix almonds and powdered sugar together in a large mixing bowl. Add three of the egg whites and knead the dough together with your hands until it comes together in a ball. Wrap in cling film and leave in the fridge for at least an hour, preferably until the next day.
▢
Grease the kransekake forms thoroughly and coat with semolina, flour, or bread crumbs.
▢
Preheat oven to 210°C (410°F) top and bottom heat. Divide the dough into six sections.
▢
Slowly add the remaining egg white to the dough and knead it until you can roll it into long sausages about as thick as your index finger. Fill the forms with the dough sausages, pinching the ends together to make rings.
▢
Set the forms on a baking sheet and back in the middle of the oven for about 10 – 12 minutes, until the tops are golden brown.', '/static/fotos/53127.jpg'),
(53128, 'Kvæfjord Cake “Verdens Beste” (World’s Best Cake)', 'Dessert', 'Norway', 'Vanilla custard
▢
Separate the egg yolks and set aside the whites to use in the meringue.
▢
Whisk together the egg yolks, cornstarch and sugar in a bowl.
▢
Heat the cream and milk in a saucepan. Split open the vanilla pod and add the beans to the saucepan. Once the milk begins to bubble pour about half of it into the bowl with the egg mixture, whisking constantly. Then return the saucepan to the heat and pour the egg mixture back into the saucepan with remaining milk, whisking constantly. Once the mixture thickens lower the heat and continue whisking for about 30 seconds.
▢
Pour the custard into a clean bowl and cover with plastic wrap, placing the plastic directly on the top layer of the custard. Chill in the fridge.
Cake
▢
Mix together butter and sugar until light and fluffy. Add egg yolks one at a time, setting aside the egg whites for the meringue. Add the flour mixed with baking powder. Stir in the milk, beating until smooth (you can use an electric mixer if you prefer).
▢
Preheat oven to 320°F (160°C). Cover a baking sheet with baking paper and spread out the batter into a large, even rectangle.
Meringue topping
▢
Whisk together the egg whites and sugar until you get glossy, stiff peaks. The meringue should hold its form – if it still melts continue whisking.
▢
Spread out the meringue on top of the cake batter. Use a spatula to form light waves with the meringue. Sprinkle almonds on top of the meringue. Bake for about 30 minutes, until the meringue and almonds are golden.
Cream filling
▢
Whisk the cream into stiff peaks. Carefully fold in the vanilla custard.
Assembly
▢
Once the cake has cooled, cut it in half. You can use scissors for this, or a knife on a cutting board, slicing through the baking paper as well.
▢
Place half of the cake on a serving platter with the meringue side down and peel off the baking paper.
▢
Spread the cream filling across the cake. Then carefully remove the other half of the cake from the baking paper and place it over the cream filling, meringue side up.
▢
Serve with fresh berries.

', '/static/fotos/53128.jpg'),
(53129, 'Norwegian Krumkake', 'Dessert', 'Norway', '▢
Whisk the egg and sugar until the mixture thickens.
▢
Melt the butter and let it cool slightly, then add the butter to the egg mixture.
▢
Mix in spices and then slowly add the flour while stirring to avoid lumps. 
▢
Let the batter rest for at least 30 minutes. This improves the texture of the krumkaker.
▢
Spoon about one heaping tablespoon of batter onto iron and bake. If the batter is too thick, add some water to it.
▢
While still hot, shape the krumkake with a wooden krumkake roller or over a cup (if using a cup, make them a bit thicker). The krumkaker harden quickly, so you can just let them sit on the roller/cup until the next krumkake is ready to be shaped. 
▢
After completely cooled, store the krumkaker in a metal or glass tin lined with paper towels at the bottom. You can also freeze them!', '/static/fotos/53129.jpg'),
(53130, 'Suksessterte (Norwegian almond “success cake”)', 'Dessert', 'Norway', 'Almond base
▢
Preheat oven to 345°F (175°C) and grease cake form (I use a 27 cm spring form) – you can line the bottom with baking paper if you like.
▢
Grind almonds in an almond grinder or food processor. I like to keep them a bit coarse.
▢
Gently whisk the eggs and sugar together until combined (no longer). Stir in the ground almonds, flour, and baking powder.
▢
Pour batter into cake form and bake for about 45 – 50 minutes, monitoring to make sure the top doesn''t burn.
Yellow egg cream
▢
Add egg yolks, heavy cream, sugar, and vanilla to a saucepan. Heat over low/medium heat while stirring constantly until the mixture thickens – about 15 minutes. Turn up the heat if the mixture doesn''t thicken, but be careful not to boil.
▢
Let the mixture cool to room temperature and then add the butter. You can use an electric mixer for a fluffy egg cream.
Assembly
▢
Wait for the cake to cool completely before removing from form and frosting.', '/static/fotos/53130.jpg'),
(53131, 'Fyrstekake – Norwegian Prince Cake', 'Dessert', 'Norway', 'Crust
▢
Mix together sugar, vanilla and butter until light and fluffy. Mix in the egg yolks. Add in the flour and baking powder and knead with hands until the dough is smooth.
▢
Pack the dough in plastic wrap and chill in refrigerator for at least 30 minutes.

Almond filling
▢
Run the almonds and sugar together in a food processor until the almonds are finely ground (you can decide for yourself how coarse or fine you want them).
▢
Stir in the butter, egg, cognac and/or almond extract (if using).
Assembly
▢
Line the bottom of your cake form with baking paper and grease the sides of the form.
▢
Preheat oven to 350°F (175°C).
▢
Cut 2/3 of the crust dough into slices and press down into the cake form. Cover the bottom of the cake form with the dough and bring the dough 2-3 cm (1 inch) up the sides of the form, pressing until even.
▢
Scoop the almond filling on top of the crust, spreading it evenly across the cake form.
▢
Roll out of the rest of the dough and slice into long strips. Lay the strips of dough across the cake in a grid. Don''t worry of the strips break – simply press them back together on the cake.
▢
Gently brush the dough with egg wash.
▢
Bake for about 45 minutes. The top of the cake should be golden brown while the almond filling will remain soft.', '/static/fotos/53131.jpg'),
(53132, 'Mazariner – Scandinavian Almond Tartlets', 'Dessert', 'Norway', 'Shells
▢
Combine the flour and powdered sugar in a food processor. Add the butter and pulse until it''s evenly distributed. Add the egg and pulse until the dough comes together.
▢
Roll out the dough on a floured surface. Cut the dough in circles with a large mug. Press the circles down into a greased muffin pan. Put the pan of shells in the fridge while you prepare the almond filling.
Almond filling
▢
Preheat oven to 355°F (180°C).
▢
Whisk the egg and powdered sugar together until thick and airy. Melt the butter and stir it into the egg mixture. Stir in the vanilla, flour, and almond extract. Stir in the almond flour.
▢
Pipe or spoon the almond filling onto the shells, filling the shells about 3/4 full.
▢
Bake the mazariner for 20 – 25 minutes, until light golden brown. Cool on a wire rack.
Glaze
▢
Mix together the powdered sugar and liquid until you get a spreadable glaze. Spread the glaze on top of the mazariner and if you wish, decorate with sprinkles, or anything you like.', '/static/fotos/53132.jpg'),
(53133, 'Asado', 'Beef', 'Argentina', 'Prepare the Fire: Start a wood fire in your grill and let it burn down to coals.
Season the Meat: Generously salt the beef cuts.
Grill the Meat: Place the beef on the grill, starting with the thickest cuts farthest from the coals. Add chorizo and morcilla after the beef has been cooking for a while.
Cook to Perfection: Cook the meat, turning occasionally, until it reaches your desired doneness. Typically, ribs may take up to 2 hours; thinner cuts will cook faster.
Rest and Serve: Let the meat rest for about 10 minutes before slicing. Serve with chimichurri sauce and grilled vegetables.
Pro Tips:

Use a mix of wood and charcoal for a consistent heat source. Wood adds flavor, while charcoal maintains temperature.
Season the meat just before grilling to ensure it retains its moisture and flavor.
Serving Suggestions:

Serve with a side of chimichurri sauce, a fresh tomato salad, and crusty bread. Pair with a robust Malbec wine to complement the rich flavors of the meat.', '/static/fotos/53133.jpg'),
(53134, 'Empanadas', 'Beef', 'Argentina', 'Make the Dough: Mix flour and salt in a large bowl. Add butter, using your fingers to blend into a crumbly texture. Gradually add water, mixing until a dough forms. Wrap and chill for 30 minutes.
Prepare the Filling: Cook onions in a pan until translucent. Add ground beef, cooking until browned. Stir in spices, then remove from heat. Once cooled, mix in eggs and olives.
Assemble: Roll out the dough and cut into circles. Place a spoonful of filling in each, fold over, and seal the edges.
Cook: Bake at 200°C (400°F) for 20-25 minutes, or until golden.
Pro Tips:

For a flakier crust, incorporate a tablespoon of vinegar into the dough mixture. This helps prevent gluten formation.
Seal the edges of the empanadas with a fork to ensure they do not open during baking or frying.', '/static/fotos/53134.jpg'),
(53135, 'Milanesa', 'Beef', 'Argentina', 'Season the Cutlets: Salt and pepper the cutlets.
Bread the Cutlets: Dip each cutlet in egg, then coat with a mixture of breadcrumbs, parsley, and garlic.
Fry: Heat oil in a large pan over medium heat. Fry the cutlets until golden and cooked through, about 3-4 minutes per side.
Serve: Serve hot with lemon wedges or a side salad.
Pro Tips:

For an extra crispy crust, use panko breadcrumbs mixed with finely grated Parmesan cheese.
Gently pound the cutlets to an even thickness for uniform cooking.', '/static/fotos/53135.jpg'),
(53136, 'Choripán', 'Pork', 'Argentina', 'Grill the Chorizos: Cook the chorizos on a grill or pan until fully cooked, about 10-15 minutes.
Prepare the Rolls: Slice the rolls and toast them lightly on the grill or in a pan.
Assemble: Slice each chorizo lengthwise and place in a roll. Top with a generous amount of chimichurri sauce.
Serve: Enjoy immediately while hot.
Pro Tips:

Grill the chorizo slowly on medium heat to prevent the skin from bursting and to ensure it cooks evenly throughout.
Toast the bread on the grill to absorb some of the chorizo''s flavors.', '/static/fotos/53136.jpg'),
(53137, 'Dulce de Leche', 'Dessert', 'Argentina', 'Combine Ingredients: In a large, heavy-bottomed pot, mix the milk, sugar, and baking soda. Cook over low heat, stirring constantly to prevent burning.
Thicken: Continue to cook, stirring frequently, until the mixture becomes thick and caramel-colored, about 1-2 hours.
Flavor: Stir in the vanilla extract.
Cool: Let the dulce de leche cool, then transfer to a jar. It will thicken further as it cools.
Pro Tips:

Stir continuously and keep the heat low to prevent the milk from burning and sticking to the bottom of the pan.
A drop of vanilla extract added at the end of cooking enhances the flavor.', '/static/fotos/53137.jpg'),
(53138, 'Alfajores', 'Dessert', 'Argentina', 'Make the Dough: Cream butter and sugar. Add egg yolks and lemon zest. Gradually mix in flour and cornstarch to form a dough. Chill for 1 hour.
Bake the Cookies: Roll out the dough, cut into circles, and bake at 180°C (350°F) for 12-15 minutes. Let cool.
Assemble: Spread dulce de leche on one cookie, then sandwich with another. Roll the edges in coconut flakes.
Pro Tips:

Chill the dough before rolling it out to make it easier to handle and to prevent the cookies from spreading too much while baking.
Dip the alfajores in melted chocolate and let them set on a wire rack for an extra decadent treat.', '/static/fotos/53138.jpg'),
(53139, 'Fainá', 'Side', 'Argentina', 'Prepare the Batter: Whisk together chickpea flour, water, salt, and pepper. Let sit for at least 4 hours.
Bake: Preheat the oven to 220°C (430°F). Pour olive oil into a round baking dish and heat in the oven. Pour in the batter and bake for 25-30 minutes, until golden.
Serve: Slice and serve hot, optionally with black pepper on top.
Pro Tips:

Let the batter rest for at least 2 hours, or overnight in the refrigerator, to ensure the chickpea flour fully hydrates and the flavors meld.
For a crispy edge, preheat the baking pan with oil in the oven before adding the batter.', '/static/fotos/53139.jpg'),
(53140, 'Matambre a la Pizza', 'Beef', 'Argentina', 'Prepare the Steak: Season the steak with salt and pepper. Grill one side until half-cooked.
Add Toppings: Spread tomato sauce over the cooked side, then add cheese, oregano, and olives.
Finish Grilling: Grill until the cheese is melted and bubbly.
Serve: Slice and serve hot.
Pro Tips:

Tenderize the matambre by scoring it lightly on both sides. This helps it cook more evenly and absorb the flavors.
Precook the matambre on the grill before adding the toppings to ensure it''s fully cooked without burning the cheese.', '/static/fotos/53140.jpg'),
(53141, 'Carbonada Criolla', 'Beef', 'Argentina', 'Brown the Beef: In a large pot, brown the beef cubes. Remove and set aside.
Sauté Vegetables: In the same pot, cook the onion until translucent. Add carrots, potatoes, and pumpkin, cooking for a few minutes.
Simmer: Return the beef to the pot. Add broth and dried apricots. Season with salt and pepper. Simmer for 1-2 hours, until the beef is tender.
Serve: Enjoy hot, with a crusty piece of bread.
Pro Tips:

Brown the beef in batches to ensure it gets a good sear, which adds depth to the stew''s flavor.
Adding the fruits towards the end of cooking preserves their texture and adds a subtle sweetness to the dish.', '/static/fotos/53141.jpg'),
(53142, 'Spiced tortilla', 'Vegetarian', 'Spanish', 'step 1
Heat the oil in a large frying pan. Fry the onion and half the chilli for 5 mins until softened. Tip in the spices, fry for 1 min more, then add the cherry tomatoes, potatoes and coriander stalks to the pan. Season the eggs well, pour over the top of the veg and leave to cook gently for 8-10 mins until almost set.

step 2
Heat the grill and flash the tortilla underneath for 1-2 mins until the top is set. Scatter the coriander leaves and remaining chilli over the top, slice into wedges and serve with a green salad.', '/static/fotos/53142.jpg'),
(53143, 'Easy Spanish chicken', 'Chicken', 'Spanish', 'step 1
Heat the oven to 200C/180C fan/gas 6. Heat the olive oil in a large ovenproof frying pan over a medium heat and fry the onion, chorizo and peppers along with a pinch of salt and pepper for 15 mins until the veg has softened and the chorizo has released its oils. Add the paprika and garlic, and cook for another few minutes until fragrant.

step 2
Tip in the chopped tomatoes, olives and butter beans, stir to combine and season. Nestle in the chicken thighs and season well. Transfer to the oven and bake for 40 mins until the chicken skin is crisp and the meat cooked through and tender. Scatter with the parsley and serve.

Watch after ad (0.04):
3 Budget Egg Ideas

', '/static/fotos/53143.jpg'),
(53144, 'Gambas al ajillo', 'Seafood', 'Spanish', 'step 1
Peel the prawns, leaving the tails intact, and, using a cocktail stick, remove the digestive tracts. Or, if you are using a frying pan rather than a terracotta pot, you can cook the prawns in their shells. Season with a little sea salt.

step 2
Put the garlic, olive oil and chillies in a flameproof terracotta pot or frying pan and set over a high heat. When the garlic starts to turn golden, add the prawns and cook for 1-2 mins on each side until just pink. Sprinkle over the chopped parsley and some freshly cracked black pepper, and serve immediately. If using a terracotta pot, you can take that straight to the table, but be careful with it as the oil and terracotta will remain hot for several minutes.', '/static/fotos/53144.jpg'),
(53145, 'Jamon & wild garlic croquetas', 'Pork', 'Spanish', 'step 1
Wash the wild garlic leaves well in a colander, then pour over boiling water from the kettle until just wilted. Immediately rinse under cold running water, then squeeze out the excess water and finely chop.

step 2
Warm the milk in a pan over a low heat until just steaming. Heat the oil or butter in a second pan and, once warm or melted, stir in the flour for a couple of minutes until it starts to brown a little. Gradually add the warm milk, a little at a time, until you have a thick, silky sauce. Bubble for a minute or two, stirring to make sure all the flour has cooked out. Season.

step 3
Add the manchego, jamón and wild garlic to the pan, and beat to combine. Tip out onto a lightly oiled baking tray or plate, spread out then cover and chill for at least 1 hr. Will keep chilled for up to 24 hrs.

step 4
Lightly oil your hands and shape the mixture into 18-20 even-sized balls. Arrange on a baking tray and freeze for 30 mins to firm up.

step 5
Beat the egg in a shallow dish with a little seasoning. Tip the panko into a second dish. Dip each of the croquetas in the egg, then turn to coat in the breadcrumbs. At this point, the raw croquetas can be frozen for up to three months. Pour the oil into a large, deep pan ensuring it is no more than a third full and heat to 170C, or until a cube of bread browns lightly in 30 seconds. Fry the croquetas in batches for 2-3 mins until deeply golden. To cook from frozen, fry at 160C for a few minutes longer until they’re piping hot inside. Remove to a sheet of kitchen paper using a slotted spoon and leave to drain. Serve warm with a glass of sherry.', '/static/fotos/53145.jpg'),
(53146, 'Locro', 'Miscellaneous', 'Argentina', 'Soak: Soak corn and beans overnight in water.
Cook Meats: In a large pot, brown the beef and pork. Add onions and spices, cooking until translucent.
Simmer the Stew: Add soaked corn and beans, pumpkin, potato, and enough water to cover. Simmer for 2-3 hours, until thick.
Serve: Enjoy hot, with bread on the side.
Pro Tips:

Toasting the corn slightly before adding it to the stew enhances its flavor.
Add a spoonful of paprika or a dash of cumin for an extra layer of warmth and complexity', '/static/fotos/53146.jpg'),
(53147, 'Arroz con gambas y calamar', 'Seafood', 'Spanish', 'step 1
Peel and devein most of the prawns (a fishmonger should be able to do this for you), keeping a few whole for decoration, if you like. Heat the olive oil in a large frying pan or shallow flameproof casserole over a medium-low heat and fry the onion for 5 mins until softened. Add the bay leaf, saffron, rice and tomato purée, and cook for 1-2 mins more, stirring.

step 2
Pour in the wine and bubble for 1-2 mins, then pour in the seafood stock and 150ml water. Cook for 5 mins, then add the squid, season well and stir to combine. Bring to the boil, then cover and reduce the heat to a gentle simmer. Cook for 12 mins more, adding a little more water if the mixture starts to look dry.

step 3
Uncover the pan and stir through the peeled prawns, then arrange any whole prawns on top of the rice mixture. Cover again and simmer for a further 5-6 mins until the prawns are pink and cooked through. Leave to stand for a couple of minutes before serving from the pan.', '/static/fotos/53147.jpg'),
(53148, 'Crema Catalana', 'Dessert', 'Spanish', 'step 1
Put the milk, cream, cinnamon stick and all the citrus zest in a saucepan set over a medium heat. Cook, stirring often, until the milk is just steaming but not boiling, about 3-5 mins. Remove from the heat, cover with a plate and leave to infuse for at least 30 mins.

step 2
When the cream mixture has infused, whisk the egg yolks, sugar and cornflour together in a separate bowl for 3-5 mins, or until light and pale in colour. Pour the infused milk through a sieve into the egg mixture, whisking continuously. Return the mixture to the saucepan.

step 3
Put the saucepan over a medium-high heat and whisk for around 10-12 mins. The mixture should start thickening to a custard-like consistency – you can tell it’s ready by dipping a wooden spoon in the mixture, then running a finger through the mixture on the back of the spoon. If the line holds, it''s ready. Sieve the mixture into a jug to remove any froth.

step 4
Divide the custard between six 150ml ramekins or small terracotta dishes, then leave to cool for 1 hr at room temperature until set with a slight wobble. Chill overnight.

step 5
Just before serving, sprinkle 1 tbsp caster sugar over the top of each ramekin and caramelise using a kitchen blowtorch. Alternatively, slide the ramekins under a hot grill until the sugar turns golden and starts to bubble. Serve straightaway.', '/static/fotos/53148.jpg'),
(53149, 'Ensaimada', 'Dessert', 'Spanish', 'step 1
Pour 230ml lukewarm water into a bowl and add the yeast. Leave to stand for 3 mins, then add the caster sugar, eggs, flour and 1 tsp sea salt flakes. Mix together to form a dough, then knead for 10 mins in stand mixer using a dough hook (or 15 mins by hand) until the dough is elastic enough to be almost see-through when stretched. Cover and set aside to rest for 30 mins, then cut into four equal pieces. Transfer to a baking tray lined with baking parchment. Leave to rest for another 30 mins.

step 2
Oil the work surface and a rolling pin with vegetable oil. Working with one portion of dough at a time, flatten it against the surface using the palm of your hand, then roll it out into a thin rectangle, about 30 x 50cm. Let it rest for 2 mins while you spread a quarter of the lard over the top. (If you want to fill your pastry with sobrasada de Mallorca, mix 50g lard with the sobrasada, and spread this over the dough instead.) Pull one corner of the flattened dough and stretch it out as far as it will go without breaking. Repeat every 10cm or so around the dough rectangle in every direction until it reaches about 50 x 70cm.

step 3
Cut a strip from each of the shorter sides and lay these beside each other along one of the longer sides of the rectangle; this is what we call the heart of the ensaimada. From there, begin rolling the dough until you have a long pastry snake. Repeat with the remaining portions of dough.

step 4
Take the first roll of dough and stretch it until it is over a metre long. Then, roll it up into a spiral, leaving 1cm between each turn of the spiral so the dough can expand. Flatten a little and transfer to a baking sheet lined with baking parchment. Repeat with the remaining dough. Leave to rise in a warm place for at least 12 hrs, or ideally 24 hrs.

step 5
Heat the oven to 200C/180C fan/gas 6. Put the ensaimadas in the top third of the oven and immediately reduce the temperature to 180C/160C fan/gas 4. Bake for 18 mins until dark golden. Leave to cool on a wire rack. To fill your ensaimada with whipped cream, slice and open, then spread over the cream and close. Dust with a generous amount of icing sugar, if you like and cut into pieces to serve.

', '/static/fotos/53149.jpg'),
(53150, 'Padron peppers', 'Vegan', 'Spanish', 'step 1
Heat the olive oil in a large frying pan over a high heat, or if using an air-fryer, heat to 205C for 3 mins. Fry the peppers, stirring frequently, for 5 mins until blistered and wilted. The peppers should be soft and slightly charred.

step 2
Transfer the peppers to a serving plate and season with some sea salt. Serve with dips or as part of a tapas spread, if you like.', '/static/fotos/53150.jpg'),
(53151, 'Paella', 'Seafood', 'Spanish', 'step 1
Heat 1 tbsp of the oil in a wide, shallow pan. Add the prawn heads and parsley stalks and sizzle until the heads turn pink, then mash with a potato masher. Pour over the sherry or wine and 300ml water, season with salt and simmer for 10 mins to make a stock, mashing the prawn heads as they cook.

step 2
Scatter the mussels into the pan, cover the pan loosely with a lid or tea towel, then put over a high heat for 3-4 mins until the mussels just open. Stir to release the mussel juices, then pour the contents of the pan into a colander set over a large bowl containing the saffron. Let the saffron steep in the stock – you will need 700ml in total, so top up with water if needed and give everything a good stir. Pick the mussels out from the colander, then set aside.

step 3
Wipe out the pan and add the rest of the olive oil. Sizzle the chorizo until it releases its oil, then add the onion and garlic and cook until softened. Add the squid and turn over until it turns white. Add the tomatoes and cook down for a minute, then pour over most of the stock, give everything a good stir and bring to the boil. Scatter the rice over the stock, stir well once, then boil vigorously for 5 mins. Reduce the heat to the lowest setting and slowly simmer for 10 mins without stirring until the rice has absorbed most of the liquid.

step 4
Tuck the prawn tails into the rice and simmer for 5 mins, turning them over until cooked through. Stir through the mussels and broad beans or peas. Taste the rice – if it is still a little raw but the pan is dry, add a splash more stock and continue to cook; if it’s too soupy, then increase the heat to cook off the last of the stock.

step 5
Once the rice is just cooked, turn off the heat and cover with a tea towel for a few minutes. Scatter over the parsley leaves and lemon zest, then season with smoked salt if you like. Stir everything once, then serve straight from the pan, with lemon wedges on the side.', '/static/fotos/53151.jpg'),
(53152, 'Pan-fried hake, white bean & chorizo broth', 'Seafood', 'Spanish', 'step 1
Drain the beans, then tip into a large pan with 2 litres of water. Simmer with the whole garlic cloves, bay leaves and thyme for 30 mins or until cooked and tender. Remove from the heat and set aside.

step 2
Meanwhile, heat 2 tbsp oil in a frying pan. Fry the bread with the remaining garlic clove. When golden and crisp, scoop out and drain on kitchen paper. Add the chorizo to the pan, fry until crisp, tip out and keep warm with the bread.

step 3
Add another 2 tbsp oil and the onion to the pan, and cook for 5 mins until softened. Stir in the paprika. Drain the beans and add to the onions with the chicken stock and 2 tsp salt. Cook for 5-10 mins. Stir through the parsley and keep warm.

step 4
Season the hake and heat the remaining 2 tbsp oil in the frying pan. Put the hake, skin-side down, in the pan and cook for 3-5 mins over a mediumhigh heat to crisp up the skin. Flip the fish over and cook for a further 3-5 mins until cooked through. Spoon the white bean mix into bowls, place the hake on top and finish with the fried bread, chorizo and a little more thyme.', '/static/fotos/53152.jpg'),
(53153, 'Churros', 'Dessert', 'Spanish', 'step 1
Boil the kettle, then measure 300ml boiling water into a jug and add the melted butter and vanilla extract. Sift the flour and baking powder into a big mixing bowl with a big pinch of salt. Make a well in the centre, then pour in the contents of the jug and very quickly beat into the flour with a wooden spoon until lump-free. Rest for 10-15 mins while you make the sauce.

step 2
Put all the sauce ingredients into a pan and gently melt together, stirring occasionally until you have a smooth shiny sauce. Keep warm on a low heat.

step 3
Fill a large deep saucepan one-third full of oil. Cooking with hot oil can be dangerous – before you start, read up on how to deep-fry safely to avoid accidents in the kitchen. Heat until a cube of bread browns in 45 seconds to 1 min. Cover a tray with kitchen paper and mix the caster sugar and cinnamon together.

step 4
Fit a star nozzle to a piping bag – 1.5-2cm wide is a good size. Fill with the rested dough, then pipe 2-3 strips directly into the pan, snipping off each dough strip with a pair of kitchen scissors. Fry until golden brown and crisp. Be very careful here – if air bubbles form in the churros they can explode, especially if the oil overheats or you use old flour. Cooking with hot oil can be dangerous – before you start, read up on how to deep-fry safely to avoid accidents in the kitchen. Keep children out of the kitchen and protect yourself by wearing long sleeves and eye protection, and keeping your face away from the pan.

step 5
Once the churros are crisp and golden brown, remove them from the oil with a slotted spoon and drain on the kitchen paper-lined tray. Carry on cooking the rest of the dough in batches, sprinkling the cooked churros with some cinnamon sugar as you go. When you’ve cooked all the churros, toss with any remaining cinnamon sugar and serve with the chocolate sauce, for dipping.
To see a video of how to prepare churros, take a look at our churros ice cream sandwich recipe.', '/static/fotos/53153.jpg'),
(53154, 'Clam, chorizo & white bean stew', 'Seafood', 'Spanish', 'step 1
Fry the chorizo in a large frying pan with a lid, over a medium heat until it is starting to crisp up and release its oil. Add the onion and cook for 5 mins until starting to soften. Then add the garlic and finely chopped parsley, and fry for 1 min more.

step 2
Pour on the stock and tomatoes. Bring to the boil, reduce the heat, then add the beans and sherry vinegar. Simmer for 10 mins until the liquid is slightly reduced.

step 3
Scatter over the clams, cover with the lid and steam for 2-4 mins, shaking the pan occasionally until the clams are open. Have a little taste before seasoning, as the clams can be quite salty. Then scatter over the chopped parsley. Eat with lots of crusty bread.', '/static/fotos/53154.jpg'),
(53155, 'Spanish chicken pie', 'Chicken', 'Spanish', 'step 1
Heat oven to 200C/fan 180C/gas 6. Boil the potatoes for 15-20 mins until tender. Drain, return to the pan, then mash with some seasoning and 2 tsp of the paprika.

step 2
Meanwhile, heat the oil in a large pan, then fry the onions and garlic for a few mins until softened. Stir in the remaining paprika for 1 min, add the tomatoes , then, bring to a simmer. Tip into a large ovenproof dish, then stir in the chicken, peppers, olives and some seasoning.

step 3
Spoon over the mash, then bake for 15 mins until the mash is golden on top and the sauce is bubbling.', '/static/fotos/53155.jpg'),
(53156, 'Arroz al horno (baked rice)', 'Pork', 'Spanish', 'step 1
Heat oven to 200C/180C/gas 6. Heat half the oil in a deep frying or sauté pan (or shallow casserole dish) measuring around 30cm in diameter. Over a high heat, colour the pork belly slices on each side in several batches, then transfer to a bowl. Add the remaining oil to the pan and lower the heat to medium, then add the black pudding and bacon and fry all over for several mins. Remove with a slotted spoon. Fry the onion and peppers for around 10 mins until soft and pale gold, then add the tomato and cook until soft. Add the garlic, smoked paprika and chilli flakes and cook for another 2 mins, then put the pork, black pudding and bacon back in the pan. Add the beans, stock and whichever herb you''re using, and bring everything to the boil.

step 2
Sprinkle the rice around the pork belly, pushing it underneath the stock. Let the stock come to the boil again, season well, then transfer to the oven (leave it uncovered). Cook for 20 mins without stirring, then check to see how the rice is doing. The rice should be tender and the stock absorbed. If it’s not ready, put back in the oven for another 5 mins, then check again. Taste for seasoning.

step 3
Squeeze lemon juice over the top and drizzle over some extra virgin olive oil just before serving, if you like.', '/static/fotos/53156.jpg'),
(53157, 'Chorizo & soft-boiled egg salad', 'Pork', 'Spanish', 'step 1
Cook the potatoes in a large pan of boiling salted water for 12 mins, adding the eggs after 6 mins, and the beans for the final 2 mins. Drain everything and cool the eggs under cold running water.

step 2
Meanwhile fry chorizo slices for 1-2 mins, until beginning to crisp. Remove from the pan with a slotted spoon and set aside, leaving the oil from the chorizo in the pan. Add the garlic to the pan and cook gently for 1 min.

step 3
Remove the pan from the heat, stir in the vinegar and parsley, then toss with the potatoes, beans, chorizo and seasoning. Shell the eggs, cut into quarters and add to the salad.', '/static/fotos/53157.jpg'),
(53158, 'Air fryer patatas bravas', 'Vegetarian', 'Spanish', 'step 1
Soak the potatoes in just-boiled water for 30 mins, then drain and leave to air-dry for 5 mins. Heat the air fryer to 200C. Tip the potatoes into a bowl and drizzle over 1 tbsp of the oil and add 1/2 tsp each of salt and freshly ground black pepper. Mix to coat the potatoes all over, then tip into the air fryer basket and cook for 20-30 mins until crisp and golden.

step 2
Meanwhile, heat the remaining oil in a small pan over a medium-low heat and fry the onion for 8-10 mins until softened but not golden. Stir in the garlic and cook for a minute before adding the paprika and cooking for 30 seconds more. Stir in the tomato purée, cook for 1 min, then tip in the chopped tomatoes. Cook for 5-10 mins over a medium heat until thickened slightly.

step 3
Once the potatoes are cooked, tip out onto a platter and pour over the tomato sauce. Sprinkle with the basil leaves, then serve.', '/static/fotos/53158.jpg'),
(53159, 'Chorizo, potato & cheese omelette', 'Pork', 'Spanish', 'step 1
Cook the potato in boiling water for 8-10 mins or until tender. Drain and allow to steam-dry. Heat oil in an omelette pan, add chorizo and cook for 2 mins. Add the potato and cook for a further 5 mins until the potato starts to crisp. Spoon pan contents out, wipe pan and cook a 2 or 3-egg omelette in the same pan. When almost cooked, scatter with the chorizo and potato, parsley and cheese. Fold the omelette in the pan and cook for 1 min more to melt the cheese.', '/static/fotos/53159.jpg'),
(53160, 'Pisto con huevos', 'Vegetarian', 'Spanish', 'step 1
Heat the oil in a large flameproof casserole dish or a cast-iron skillet over a low heat. Add the onions and a sprinkle of salt, cover and cook gently for 15 mins, stirring occasionally. Add the garlic and cook for another 2 mins.

step 2
Next, throw in the peppers and cook over a medium heat, covered, for about 5 mins, stirring every so often, until the peppers are just tender.

step 3
Mix in the oregano, thyme, bay leaves, some black pepper and a little salt, if needed. Tip in the courgettes and aubergine, combine thoroughly, and cook over a medium heat, covered, for 10 mins. Stir in the tomatoes, cover and cook for 20 mins, stirring occasionally.

step 4
Carefully crack the eggs over the pisto – try not to break the yolks. Cook in the sauce on a medium heat for 5-6 mins until the eggs are cooked through but still a little soft, then scatter with parsley before serving', '/static/fotos/53160.jpg'),
(53161, 'Chicken & chorizo rice pot', 'Chicken', 'Spanish', 'step 1
Heat the oil in a large flameproof casserole dish and brown the chicken pieces on all sides – you may have to do this in batches. Remove from the dish and put to one side.

step 2
Lower the heat, add the onion and pepper, and gently cook for 10 mins until softened. Add the garlic and chorizo, and cook for a further 2 mins until the chorizo has released some of its oils into the dish. Stir in the tomato purée and cook for 1 min more.

step 3
Return the chicken pieces to the dish along with the thyme, white wine and stock. Bring the liquid to a boil, cover the dish with a tight-fitting lid and lower the heat. Cook for 30 mins.

step 4
Tip in the rice and stir everything together. Cover, set over a low heat and cook for a further 15 mins, or until the rice is cooked and has absorbed most of the cooking liquid. Remove from the heat and leave the dish to sit for 10 mins to absorb any remaining liquid. Season to taste and scatter with parsley to serve.', '/static/fotos/53161.jpg'),
(53162, 'Pollo en pepitoria', 'Chicken', 'Spanish', 'step 1
Put the saffron in a small bowl with 75ml of just-boiled water. Stir and set aside. Heat 2 tbsp of the oil in a broad, shallow casserole dish. Cook the garlic until pale gold in colour, then add the blanched almonds and bread, and continue to fry until everything is golden. Tip into a food processor with some salt and pepper and the parsley, and whizz together.

step 2
Heat 2 more tbsp of the oil in the pan and brown the chicken all over, seasoning as you cook. Put in a bowl and set aside.

step 3
Remove all but about 2 tbsp of chicken fat from the pan and cook the onion, carrot and celery until golden. Add the sherry, stirring to dislodge any brown bits that have stuck to the pan. Pour in the stock and the saffron (with its water), and bring to the boil, then turn the heat down to a simmer. Add the spices and bay leaves, and put the chicken back in the pan with any juices. Season and gently cook the chicken for about 40 mins with the lid on.

step 4
Transfer the chicken to a bowl again, leaving the sauce in the pan, and cover with foil to keep warm. Remove the yolks from the eggs and roughly chop the whites. Mash the egg yolks in a small bowl and gradually mix in a couple of tbsp of the sauce. Bring the remaining sauce to the boil to reduce a bit (you want it to just coat the chicken), then turn the heat down. Remove the bay and cinnamon stick. Add the egg yolks and cook for a few mins until the mixture has thickened. Stir in the almond mixture that you made earlier (this will thicken the sauce, too). Put the chicken back in the pan and heat it for about 3 mins, spooning the sauce over it. Season to taste.

step 5
Scatter over the extra parsley, the almonds pieces and the chopped egg whites (if you’re going to use them). You can serve this straight from the dish with some rice, if you like.', '/static/fotos/53162.jpg'),
(53163, 'Spanish fig & almond balls', 'Dessert', 'Spanish', 'step 1
Whizz the almonds in a food processor until most are finely chopped, then tip into a large bowl. Roughly chop the figs, then whizz to a smooth sticky paste. Scrape onto the almonds then, using your hands, mix together well with the dried fruit, brandy, honey and cloves.

step 2
Divide the mixture into 6 and roll into balls. Tip the sesame seeds onto a tray, then roll the balls in them until covered. Cover the tray loosely with a clean tea towel, then leave the fig balls to dry for a week before packaging. Will keep in a cool place for 2 months.', '/static/fotos/53163.jpg'),
(53164, 'Spanish Chicken', 'Chicken', 'Spanish', 'step 1
Heat oven to 190C/170C fan/gas 5. Put all the ingredients into a large, wide ovenproof dish. Mix everything together with your hands and season.

step 2
Bake for 45 mins, stirring the onions after 20 mins, until the chicken is golden and the onions tender. Serve with rice.', '/static/fotos/53164.jpg'),
(53165, 'Torrijas with sherry', 'Breakfast', 'Spanish', 'step 1
In a wide, shallow bowl, beat the eggs with the cream, milk, golden caster sugar and sherry. Cut each slice of bread in two and dip them into the egg mix, turning to make sure they get a good coating on either side. Soak bread in egg mixture for 10 mins to absorb the liquid (carefully turn them over from time to time and make sure they don’t get too soggy).

step 2
Heat 1½ tbsp olive oil in a large frying pan and cook the bread for about 3 mins on each side until dark golden and crisp on the edge. Keep the slices warm in a low oven as you cook the rest.

step 3
Divide the torrijas between plates and dust with the icing sugar. Serve with crème fraîche or Greek yogurt on the side.', '/static/fotos/53165.jpg'),
(53166, 'Chickpea, chorizo & spinach stew', 'Pork', 'Spanish', 'step 1
Heat the oil in a large pan, then gently fry the onion for 3-4 mins until it begins to soften. Stir in the carrot, celery, thyme and bay leaves. Season, then cook for 2-3 mins, stirring occasionally. Add the garlic, chorizo, cinnamon and smoked paprika. Gently fry until the vegetables soften and the chorizo starts to release its oils and crisp up.

step 2
Stir in the chickpeas, vinegar and 150ml water, then bring to a simmer for 1-2 mins until the chickpeas have heated up. Add the spinach, then stir through the chickpeas until it wilts a little. Remove from the heat, season to taste, then serve warm with crusty bread.', '/static/fotos/53166.jpg'),
(53167, 'Seafood rice', 'Seafood', 'Spanish', 'step 1
Heat the oil in a deep frying pan, then soften the leek for 5 mins without browning. Add the chorizo and fry until it releases its oils. Stir in the turmeric and rice until coated by the oils, then pour in the stock. Bring to the boil, then simmer for 15 mins, stirring occasionally.

step 2
Tip in the peas and cook for 5 mins, then stir in the seafood to heat through for a final 1-2 mins cooking or until rice is cooked. Check for seasoning and serve immediately with lemon wedges.', '/static/fotos/53167.jpg'),
(53168, 'Chorizo & chickpea soup', 'Pork', 'Spanish', 'step 1
Put a medium pan on the heat and tip in the tomatoes, followed by a can of water. While the tomatoes are heating, quickly chop the chorizo into chunky pieces (removing any skin) and shred the cabbage.

step 2
Pile the chorizo and cabbage into the pan with the chilli flakes and chickpeas, then crumble in the stock cube. Stir well, cover and leave to bubble over a high heat for 6 mins or until the cabbage is just tender. Ladle into bowls and eat with crusty or garlic bread.', '/static/fotos/53168.jpg'),
(53169, 'Ajo blanco', 'Starter', 'Spanish', 'step 1
Tip the bread into a bowl and pour over 350ml water. Leave to soak for 10 mins.

step 2
Blend the ingredients together with 350ml water and 1 tsp salt.

step 3
Let the soup cool in the fridge for 1 hr or so, then serve with a drizzle of oil and some black pepper.', '/static/fotos/53169.jpg'),
(53170, 'Chocolate churros with chocolate & salted caramel sauce', 'Dessert', 'Spanish', 'step 1
To make the sauce, tip the sugar and butter into a saucepan and bring to a simmer until the sugar has melted, then stir in the cream and simmer until you have a smooth sauce, about 2-3 mins. Remove from the heat, stir through a pinch of sea salt and the chocolate, and continue to stir for 2-3 mins, or until it has completely melted. Keep warm or leave to cool for reheating later. For the coating, mix the sugar with the cinnamon and a small pinch of fine sea salt and set aside.

step 2
For the churros, tip the flour, cocoa, baking powder and a large pinch of salt into a bowl. Add the vanilla extract and melted butter, then carefully pour in 250-300ml boiling water and whisk to make a smooth, very thick batter. Leave to cool for a few minutes, then scrape the mixture into a piping bag fitted with a medium star nozzle.

step 3
Tip sunflower oil into a deep-fat fryer following the manufacturer’s instructions, or a heavy-based pan, ensuring it is no more than a third full. Heat to 170C, or until a cube of bread dropped in browns in 30 seconds. Pipe 12-15cm lengths of dough into the oil, snipping off the end of each one with a pair of scissors as you go. Pipe four or five at a time and cook for around 4 mins, or until golden and crisp, turning them with tongs or a slotted spoon as they cook. Remove from the oil and place on a wire rack. Repeat with the rest of the dough. Leave to cool if reheating later, otherwise roll the churros in the cinnamon sugar and serve immediately with the warm chocolate sauce and ice cream. To reheat the churros, put on a tray and bake for 5-8 mins, then roll in the sugar coating. Meanwhile, warm the sauce in a pan and serve alongside for dipping.', '/static/fotos/53170.jpg'),
(53171, 'Salt cod tortilla', 'Seafood', 'Spanish', 'step 1
Heat half the oil in a frying pan, and sauté the onion over a medium heat until soft and pale gold – this will take about 8 mins. Remove from the pan, set aside, and add the potatoes to the pan. Cook until they are tender but not falling apart, carefully turning every so often. Cover the pan some of the time to help the slices cook through. Add the onions back to the pan along with the garlic and cook for another 4 mins. Tip into a bowl with the eggs, parsley and some seasoning and mix together. Leave to sit for half an hour.

step 2
Meanwhile, put the cod in a saucepan and cover with water. Bring up to a simmer. Remove from the heat, cover and leave for 10 mins. Drain, leave to cool and remove the skin and any bones. Break into large flakes and add to the potato and egg mixture.

step 3
Heat the rest of the oil in a non-stick frying pan. Pour in the tortilla mix and cook over a medium-low heat until it is just set and coming away from the sides of the pan. You might need to cover it to help the centre set. Be careful not to overcook it. Put a spatula underneath the tortilla every so often to make sure it isn’t sticking. Slide the tortilla onto a plate, then put the pan on top and flip the tortilla into it, uncooked side-down. Cook over a low heat until golden, or grill until just set. Leave to cool a little before serving.', '/static/fotos/53171.jpg'),
(53172, 'Patatas bravas', 'Vegetarian', 'Spanish', 'step 1
Heat the oil in a pan and fry the onion for about 5 mins until softened. Add the garlic, chopped tomatoes, tomato purée, sweet paprika, chilli powder, sugar and a pinch of salt, then bring to the boil, stirring occasionally. Lower to a simmer and cook for 10 mins until pulpy. Can be kept chilled for up to 24 hrs.

step 2
Heat oven to 200C/180C fan/gas 6. Pat the potatoes dry with kitchen paper, then tip into a roasting tin and toss in the olive oil and some seasoning. Roast for 40-50 mins until crisp and golden. Tip the potatoes into serving dishes and spoon over the tomato sauce. Sprinkle with some fresh parsley to serve.', '/static/fotos/53172.jpg'),
(53173, 'Quick gazpacho', 'Starter', 'Spanish', 'step 1
In a blender (or with a stick blender), whizz together the passata, red pepper, chilli, garlic, sherry vinegar and lime juice until smooth. Season to taste, then serve with ice cubes', '/static/fotos/53173.jpg'),
(53174, 'Prawns with Romesco sauce', 'Seafood', 'Spanish', 'step 1
Prepare ahead - halve the pepper lengthways and remove the seeds and stalk. Line a grill pan with foil and put the pepper halves, skin side up, on the grill pan with the whole garlic cloves, chilli and tomato. Grill for 2 minutes, turn the tomato, then grill for a further 2 minutes. Remove the tomato with a large spoon, then peel, quarter and remove the seeds. Then chop the tomato roughly.

step 2
Continue grilling the pepper, chilli and garlic for 4-5 minutes, until the pepper and chilli skins have blackened and the garlic is starting to soften (the garlic skin will start to split when it is ready). When cool enough to handle, peel and halve the chilli, and scrape out and discard the seeds. Peel the pepper and roughly chop both the pepper and chilli.

step 3
Spread nuts over the foil and grill until toasted. Finely chop the nuts and parsley in a food processor. Tip into a small bowl.

step 4
Heat 3 tablespoons of oil in a frying pan, add the pepper, garlic and chilli and fry for 3 minutes. Tear up the bread and add to the pan, turning it in the oil until lightly browned. Pulse in food processor with the tomatoes, salt, vinegar and oil until roughly chopped. Tip into a bowl. Leave to cool and store in fridge for up to 3 days.

step 5
On the day add the nuts and parsley to the sauce and mix. Serve in a small bowl on a plate with the peeled prawns. Supply cocktail sticks for spearing the prawns.', '/static/fotos/53174.jpg'),
(53175, 'Spanish-style slow-cooked lamb shoulder & beans', 'Lamb', 'Spanish', 'step 1
To make the spice mix, combine all of the ingredients together with a large pinch of salt. Slash the lamb shoulder all over with a sharp knife and rub in. If you have the time, marinate for up to 24 hrs, but this is not essential.

step 2
Heat the oven to 150C/130C fan/gas 2. Heat the oil in a large flameproof casserole dish or roasting tin over a medium-high heat, add the onions, carrots and garlic and sizzle for 5 mins until the onions and carrots are softened. Pour over the stock, then bring to the boil. Nestle the lamb in the pan and cover, then transfer to the oven and roast for 2 hrs.

step 3
Uncover and transfer the lamb to a plate using tongs. Stir the beans, peppers and olives through the stock in the pan, sit the lamb back on top and return to the oven, uncovered, for 1 hr 30 mins until the lamb is cooked through. Transfer the lamb to a board and shred using two forks. Stir the parsley through the braised beans before serving.', '/static/fotos/53175.jpg'),
(53176, 'Spanish tomato bread with jamón Serrano', 'Pork', 'Spanish', 'step 1
Mix together the chopped tomatoes, garlic clove, olive oil, salt and pepper. Keep in the fridge until needed.

step 2
To serve, toast 20 slices of baguette. Spoon a little tomato topping on to each piece of toast. Tear 5-6 slices of jamón Serrano into pieces and put one piece on each slice of bread.', '/static/fotos/53176.jpg'),
(53177, 'Spaghetti with Spanish flavours', 'Pork', 'Spanish', 'step 1
Put a pan of water on over a high heat to boil. Meanwhile, snip the chorizo into strips with scissors, and chop the parsley and peppers (check for stray seeds first).

step 2
When the water is boiling briskly, add the spaghetti with a good measure of salt, stir and return to the boil. Cook for 3 minutes.

step 3
In a large frying pan, heat the oil, add the chorizo and peppers and plenty of black pepper. Cook for a minute or so, until heated through and the juices are stained red from the paprika in the chorizo. Scoop half a mugful of pasta water from the pan, drain the remainder and tip the spaghetti into the frying pan.

step 4
Add the parsley and parmesan, toss well and splash in the pasta water, to moisten. Hand round extra parmesan at the table.', '/static/fotos/53177.jpg'),
(53178, 'Fried calamari', 'Seafood', 'Spanish', 'step 1
Cut the squid into rings about ½cm thick. Tip the flour into a freezer bag and season well. Add the capers, then give everything a good shake to mix together. Tip the squid into the bag, then shake again until all the rings are well coated. Mix together the garlic and mayonnaise, then place in a serving bowl.

step 2
Pour some oil into a large pan until it comes about 7cm up the sides, but the pan is no more than a third full. Place over a medium heat and let the oil warm up. To test that the oil is ready, place a small piece of bread in the pan – it should sizzle when it touches the oil.

step 3
Remove a handful of squid from the flour and shake off any excess. Gently drop into the oil, then cook for about 3 mins until crisp. Remove with a slotted spoon and place on kitchen paper. Repeat with the remaining squid. Serve straight away with the mayonnaise and lemon wedges.', '/static/fotos/53178.jpg'),
(53179, 'Ham croquetas', 'Pork', 'Spanish', 'step 1
To make the filling, heat the olive oil in a pan until it starts to shimmer. Add the leek and sauté until soft but not coloured. Stir in the ham with a wooden spoon, fry for 1 min, then stir in the flour and fry over a medium heat, stirring occasionally, until the mixture is golden but not burnt – this will take about 5 mins.

step 2
Meanwhile, combine the stock and milk in a small pan and heat until steaming but not boiling. Season with a few scrapes of nutmeg. Gradually add the liquid, a few tbsp at a time, stirring constantly.

step 3
Once you’ve incorporated all the milk stock, continue to cook the filling over a medium heat for about 10 mins or until it thickens and leaves the sides of the pan when you stir it.

step 4
Season with black pepper, taste and adjust the salt if necessary – the ham can be very salty to start with. The filling is now done: it has to be really thick because you don’t want the croquetas to turn into pancakes.

step 5
Smooth the mixture onto a baking tray (30 x 20cm is fine). Once it has stopped steaming, cover with cling film to stop it drying out. Leave to cool before putting it in the fridge for 1 hr.

step 6
When you''re ready for the next stage, line up three bowls: the first filled with the flour, the second with beaten egg and the third with breadcrumbs. Take the ham mixture out of the fridge. Put a little bit of olive oil on your hands to make it easier to roll the croquetas.

step 7
Roll a spoonful of the mixture between your palms. The size and shape of the croquetas is up to you, but the easiest is a walnut-sized ball. Then begin coating as follows.

step 8
Dunk the croquetas into the flour – you want a dusting – followed by the egg, then the breadcrumbs. Put them on a tray and, when you’ve used up all the mixture, place in the fridge for 30 mins.

step 9
If you have a deep-fat fryer, heat the oil to 180C and fry for a couple of mins. If not, heat the oil in a deep, heavy-bottomed saucepan until it starts to shimmer. Then add 5-6 croquetas at a time and fry until golden all over. Once cooked, drain on kitchen paper and eat straight away.', '/static/fotos/53179.jpg'),
(53180, 'Garlicky prawns with sherry', 'Seafood', 'Spanish', 'step 1
Heat the olive oil in a large frying pan. Tip in the garlic slices and cook for a few secs. Then stir through the prawns and cook for a couple of mins until they start to turn pink.

step 2
Pour over the sherry and cook for a few mins more, just until the prawns are cooked through. Sprinkle with parsley before serving.', '/static/fotos/53180.jpg'),
(53181, 'Spanish beans with chicken & chorizo', 'Chicken', 'Spanish', 'step 1
Soak the beans for at least 4 hrs or overnight in a large bowl with plenty of water to cover. Next day, rinse and drain, then put in a large heavy based pan with the onion, paprika, herb bundle and chicken. Pour over enough water or stock to cover, bring to the boil, then reduce the heat, cover and simmer for 45 mins.

step 2
Remove the chicken to a plate, then add the potatoes and chorizo to the pan. Continue cooking for 30 mins until the beans and potatoes are tender.

step 3
Discard the skin and bones from the chicken and tear into large chunks. Return the chicken to the pan with the spinach and simmer for 5 mins.', '/static/fotos/53181.jpg'),
(53182, 'Spanish seafood rice', 'Seafood', 'Spanish', 'step 1
Heat the oil in a large saucepan and soften the onion for 6-7 mins. Add the pepper and garlic, cook for 2 mins more, then stir in the paella rice and cook for 1 min, stirring to coat.

step 2
Pour in the stock, add the saffron and bring to the boil. Cook, uncovered, at a gentle bubble, for 20 mins, stirring occasionally until the rice is tender.

step 3
Stir in the seafood and lemon juice and cook for 2 mins or until piping hot and completely cooked through. Serve in warm bowls scattered with the parsley.', '/static/fotos/53182.jpg'),
(53183, 'Spanish meatballs with clams, chorizo & squid', 'Miscellaneous', 'Spanish', 'step 1
Melt the butter in a heavy-based casserole, then soften the shallots for 5 mins. Add the paprika and crushed garlic and cook for 1 min until the paprika becomes fragrant. Splash in the sherry, then pour the whole lot into a bowl with the breadcrumbs. Season and cool.

step 2
Add the pork mince and the egg yolk to the bowl, then beat well. Shape into 18 small meatballs. Wipe the pan, put on a medium-high heat, then add the oil. Fry the meatballs for 5 mins, just to colour, then lift onto a plate, but keep the oil in the pan. Sizzle the chorizo with the sliced garlic. Add the squid and fry to give a little colour. Now tip in the white wine and bring to the boil, scraping the bottom. Stir in the pulped tomatoes, bring to the boil, then add the meatballs and the clams. Cover and cook for 5 mins until the clam shells open. Discard any that stay shut. Sprinkle with the chopped parsley, drizzle with the extra virgin oil, then serve with crusty bread.', '/static/fotos/53183.jpg'),
(53184, 'Spanish rice & prawn one-pot', 'Seafood', 'Spanish', 'step 1
Boil the kettle. In a non-stick frying or shallow pan with a lid, fry the onion, peppers, chorizo and garlic in the oil over a high heat for 3 mins. Stir in the rice and chopped tomatoes with 500ml boiling water, cover, then cook over a high heat for 12 mins.

step 2
Uncover, then stir – the rice should be almost tender. Stir in the prawns, with a splash more water if the rice is looking dry, then cook for another min until the prawns are just pink and rice tender.', '/static/fotos/53184.jpg'),
(53185, 'Chorizo & tomato salad', 'Pork', 'Spanish', 'step 1
Put the tomatoes in a bowl with the onion and thyme. Season, then drizzle with the vinegar and oil. Let the flavours mingle while you cook the chorizo.

step 2
In a hot, dry pan, fry the chorizo slices until browned on both sides. Serve the tomatoes with the fried chorizo, drizzled with a little oil from the pan.', '/static/fotos/53185.jpg'),
(53186, 'Chicken with saffron, raisins & pine nuts', 'Chicken', 'Spanish', 'step 1
Heat a large frying pan on a high heat and season the chicken. Add the olive oil to the pan, then the chicken. Brown for about 5 mins on each side, remove onto a plate, then set aside.

step 2
Lower the heat to medium. In the remaining fat, fry the onions for 3 mins, then add the garlic and saffron. Cook for 3-4 mins more. Add the sherry, then simmer for 3-5 mins until syrupy.

step 3
Put the chicken leg pieces back into the pan, tip in the stock, thyme and raisins, cover, then gently cook on a low heat for 20 mins. Add the breast meat and any juices left on the plate. Simmer for 10 mins more until cooked through and the sauce in the pan has reduced.

step 4
While the chicken is cooking, heat oven to 200C/180C fan/gas 6. Scatter the pine nuts over a baking sheet, then roast for 10 mins until golden and toasted. Once the chicken has cooked through, season to taste, scatter with pine nuts and parsley, then serve with rice.', '/static/fotos/53186.jpg'),
(53187, 'Šúĺlance s Makom', 'Dessert', 'Slovakia', '1. Prepare the Potatoes

Boil the potatoes with their skins on until tender.
Let them cool completely (preferably overnight), then peel and mash them finely.
2. Make the Dough

In a bowl, combine mashed potatoes, flour, semolina, and salt.
Knead the mixture until you get a smooth, non-sticky dough.
3. Shape the Šúĺlance

Divide the dough into portions and roll each into a thin rope (about 1.5 cm in diameter).
Cut into 3 cm-long pieces and roll between your palms to shape small dumplings.
4. Cook the Dumplings

Bring a pot of salted water to a boil.
Drop in the dumplings in batches and cook until they float to the surface (about 2-3 minutes).
Drain and transfer to a bowl.
5. Prepare the Topping

In a separate bowl, mix ground poppy seeds and powdered sugar.
Melt the butter and keep it ready.
6. Assemble the Dish

Drizzle the cooked dumplings with melted butter.
Toss them in the poppy seed-sugar mixture until evenly coated.
7. Serve and Enjoy

Serve warm, optionally with a dusting of extra powdered sugar or a drizzle of honey.', '/static/fotos/53187.jpg'),
(53188, 'Fašírky', 'Pork', 'Slovakia', '1. Prepare the Bread Mixture
Soak the bread slices in milk or water until soft.
Squeeze out excess liquid and mash into small crumbs.
2. Mix the Ingredients
In a large bowl, combine ground meat, chopped onions, garlic, soaked bread, egg, and seasonings.
Mix well until evenly combined.
3. Shape the Meat Patties
Take portions of the mixture and shape them into palm-sized patties.
Flatten slightly to help with even cooking.
4. Coat the Patties
Lightly dust each patty with flour.
Dip into beaten egg, then coat with breadcrumbs for a crispy finish.
5. Fry the Fašírky
Heat vegetable oil in a pan over medium heat.
Fry the patties for 4-5 minutes per side until golden brown and fully cooked.
Transfer to a paper towel-lined plate to drain excess oil.
6. Serve and Enjoy
Serve Fašírky hot with mashed potatoes, cabbage salad, or fresh bread.
Enjoy with mustard, pickles, or garlic sauce for extra flavor.', '/static/fotos/53188.jpg'),
(53189, 'Zemiakové Placky', 'Side', 'Slovakia', '1. Prepare the Potatoes
Start by peeling and finely grating the potatoes. To ensure extra crispiness, use a clean kitchen towel to squeeze out as much moisture as possible.

2. Mix the Ingredients
In a large mixing bowl, combine the grated potatoes, chopped onion, minced garlic, eggs, flour, marjoram, salt, and black pepper. Stir well until the mixture forms a thick, consistent batter.

3. Heat the Oil
In a large frying pan, heat a generous amount of oil over medium heat. The oil should be hot but not smoking.

4. Fry the Pancakes
Spoon portions of the batter into the pan, flattening each into a thin pancake. Fry until golden brown and crispy on one side, then flip and cook the other side until equally golden and crispy.

5. Drain & Serve
Transfer the cooked pancakes onto a plate lined with paper towels to remove excess oil. Serve immediately while hot, with sour cream, garlic dip, or as a side dish.', '/static/fotos/53189.jpg'),
(53190, 'Bryndzové Halušky', 'Pork', 'Slovakia', '1. Prepare the Dough
Grate the potatoes finely using a hand grater or food processor. Place the grated potatoes in a bowl and mix them with flour, egg, and salt until a sticky dough forms. The consistency should be thick but pliable.

2. Cook the Dumplings
Bring a large pot of salted water to a boil. Using a halušky maker (similar to a spaetzle maker), press the dough directly into the boiling water. If you don’t have one, use a tilted cutting board and a knife to scrape small pieces of dough into the water.

Let the dumplings cook until they float to the surface, usually within 2-3 minutes. Scoop them out with a slotted spoon and set aside in a large bowl.

3. Prepare the Toppings
Chop the bacon into small pieces and fry in a skillet over medium heat until crispy. If using a bryndza substitute, mix crumbled feta with a dollop of sour cream to mimic the tangy flavour of traditional Slovak sheep cheese.

4. Assemble the Dish
Toss the cooked dumplings with the bryndza cheese (or substitute) until they’re well-coated and creamy. Top with the crispy bacon and its drippings. Garnish with chopped chives or parsley for an extra touch of colour and flavour.', '/static/fotos/53190.jpg'),
(53191, 'Pad Thai', 'Seafood', 'Thai', 'step 1
Put the noodles in a large heatproof bowl, pour boiling water over them and leave for 4 minutes, then drain and refresh under cold running water.

step 2
Put the lime juice, cayenne, sugar and fish sauce in a bowl and mix well. Have all the other ingredients ready by the cooker.

step 3
Heat the oil and fry the prawns until warmed through. Add the spring onions and noodles and toss around. Tip in the lime juice mixture, then stir in the beansprouts and half the peanuts and coriander. Cook for 1 minute until everything is heated through.

step 4
Pile into a large dish, scatter with the rest of the peanuts and coriander, and serve with lime wedges and sweet chilli sauce.', '/static/fotos/53191.jpg'),
(53192, 'Panang chicken curry (kaeng panang gai)', 'Chicken', 'Thai', 'step 1
First, make the curry paste. Use a pestle and mortar to pound together the dried and fresh chillies, shrimp paste, garlic, galangal, lemongrass, lime zest, white pepper, coriander, cumin, nutmeg and peanuts, plus 1 tsp salt. You should have a rough paste. Alternatively, add all the ingredients to a food processor along with 2-3 tbsp of coconut milk and pulse until you have a paste. Store in a lidded jar in the fridge. Will keep for up to two weeks.

step 2
Add 2-3 tbsp of the thick part of the coconut milk into a saucepan over a medium-high heat. When the coconut milk starts bubbling, add 1-2 tbsp of the curry paste and stir well for about 1 min, until fragrant.

step 3
Stir in the chicken and let it cook for about 3-4 mins until beginning to brown all over. Follow with the French beans and stir well.

step 4
Season with the fish sauce and sugar, then add the rest of coconut milk. Mix well, add half the makrut lime leaves and simmer for 3-5 mins until the chicken is cooked through. Taste and add more sugar or fish sauce if necessary – it should be salty and nutty, and the sweetness should come through. Add the Thai basil leaves, give it a quick mix and take off the heat. Serve with steamed jasmine rice, garnished with the sliced chilli and the rest of the makrut lime leaves.', '/static/fotos/53192.jpg'),
(53193, 'Drunken noodles (pad kee mao)', 'Beef', 'Thai', 'step 1
Prepare the noodles following pack instructions, then drain and set aside. Combine all the ingredients for the sauce in a small bowl or jug, and set aside.

step 2
Heat the oil in a large wok or frying pan over a high heat and stir-fry the garlic and chilli for 20 seconds until just starting to turn golden. Add the steak and stir-fry for 1 minute until seared and starting to brown. Add the broccoli and stir-fry for another minute, then tip in the noodles and add the sauce. Stir-fry for another 1-2 mins until well combined and piping hot.

step 3
Stir through the basil and turn off the heat. Serve immediately to avoid overcooking.', '/static/fotos/53193.jpg'),
(53194, 'Tom yum soup with prawns', 'Seafood', 'Thai', 'step 1
Pour 1.3 litres water into a large saucepan over a high heat. Add the onion, tomato, chilli, galangal, lemongrass, prawn heads and chicken stock cube. Stir and bring to a boil, then reduce the heat to medium and simmer for 20 mins until the liquid has reduced.

step 2
Carefully strain the hot broth into a large heatproof bowl or jug, then discard the prawn heads. Return the strained veg and herb mixture to the saucepan and pour over the broth. Stir through the mushrooms and lime leaves, then cook for 3 mins until the mushrooms are tender.

step 3
Add 1 tbsp sugar, the fish sauce, lime juice, coconut milk and prawns. Bring to the boil and cook until the prawns are cooked through, about 1-2 mins. Remove from the heat. Remove the lemongrass, then stir in the Thai chilli jam, if using. Scatter over the coriander to finish, if you like, and serve.', '/static/fotos/53194.jpg'),
(53195, 'Thai curry noodle soup', 'Seafood', 'Thai', 'step 1
Heat the oil in a saucepan over a medium heat and cook the curry paste for 1 min before adding the stir-fry veg and prawns. Cook for 3 mins until the prawns are mostly pink, then add the coconut milk, veg stock and noodles.

step 2
Bring to the boil, then reduce the heat to a simmer and cook for 5 mins until the noodles are cooked through and the veg is tender but still has a bite. Divide between two bowls and sprinkle over the herbs, chilli and spring onion.', '/static/fotos/53195.jpg'),
(53196, 'Tom yum (hot & sour) soup with prawns', 'Seafood', 'Thai', 'step 1
Bring the stock to a boil in a medium-sized saucepan. Add the lemongrass, galangal, coriander roots and lime leaves, then simmer for 2 mins.

step 2
Add the prawns, fish sauce, chillies and lime juice, then return to the boil. Taste and adjust the seasoning with either more lime juice or fish sauce, then garnish with coriander leaves and serve.', '/static/fotos/53196.jpg'),
(53197, 'Thai pork & peanut curry', 'Pork', 'Thai', 'step 1
Heat the oil in a large saucepan or flameproof casserole. Add the spring onions and coriander stalks and cook for 1 min. Add the pork slices and cook for 5 mins until starting to brown.

step 2
Stir in the curry paste and peanut butter. After 30 secs, add the sugar, soy and coconut milk, plus ½ can of water. Mix well, put a lid on and leave to simmer for 15 mins, stirring occasionally.

step 3
Remove the lid, add the baby corn and increase the heat. Bubble for 3 mins until the corn is cooked and the sauce has thickened a little. Stir in the lime juice and check the seasoning. Can now be frozen for up to 2 months. To cook from frozen: thoroughly defrost, then heat in a pan on the hob until curry is hot all the way through. Serve scattered with the coriander leaves and rice.', '/static/fotos/53197.jpg'),
(53198, 'Thai fried rice with prawns & peas', 'Seafood', 'Thai', 'step 1
Heat 1 tbsp of the oil in a wok, add the onion, garlic and chilli, and cook for 2-3 mins until golden. Add the prawns and cook for 1 min. Tip in the rice and peas, and keep tossing until very hot. Add the soy and fish sauce, then stir through the chopped coriander. Keep warm while you fry the eggs.

step 2
Heat the remaining oil in a frying pan and fry the eggs with some seasoning. Divide the fried rice mix between 4 bowls and top each with a fried egg. Serve scattered with coriander, with chilli sauce, if you like.', '/static/fotos/53198.jpg'),
(53199, 'Thai beef stir-fry', 'Beef', 'Thai', 'step 1
Heat a wok or large frying pan until smoking hot. Pour in the oil and swirl around the pan, then tip in the beef strips and chilli. Cook, stirring all the time, until the meat is lightly browned, about 3 mins, then pour over the oyster sauce. Cook until heated through and the sauce coats the meat. stir in the basil leaves and serve with plain rice.', '/static/fotos/53199.jpg'),
(53200, 'Prawn stir-fry', 'Seafood', 'Thai', 'step 1
Put the prawns in a bowl. Put the chilli, garlic, coriander stalks (snip these up using scissors first) and caster sugar in a spice grinder or small food processor and whizz together. Add half of the lime juice and the fish sauce, then pour this over the prawns.

step 2
Heat 1 tbsp oil in a wok, add the ginger and spring onions and fry for 1 min. Add the red pepper and fry for 1 min, until the pepper starts to soften. Add the water chestnuts and bean sprouts, and toss together until the bean sprouts start to wilt. Add the soy sauce and a really good grind of black pepper, then tip the lot into a serving dish.

step 3
Heat the remaining oil in the wok and add the prawns, lifting them out of their juices. Toss for 1-2 mins until they turn pink, add the marinade and swirl the wok quickly, then tip the lot onto the veg. Snip over the coriander leaves and sprinkle on the remaining lime. Serves over noodles with extra lime for squeezing over.', '/static/fotos/53200.jpg'),
(53201, 'Stir-fried chicken with chillies & basil', 'Chicken', 'Thai', 'Heat a wok or large frying pan until it is very hot, then add 1 tbsp of the oil. When it is very hot, add the chicken and stir-fry over a high heat for 8-10 minutes, until browned all over. Using a slotted spoon, take the chicken from the pan and set aside.

step 2
Reheat the wok and add the remaining oil. Toss in the garlic and shallots and stir fry for 3 minutes, until golden brown.

step 3
Return the chicken to the wok and add the chillies, fish sauce, dark soy sauce and sugar. Stir fry over a high heat for a further 8-10 minutes or until the chicken is cooked through. Stir in the basil leaves and serve at once.', '/static/fotos/53201.jpg'),
(53202, 'Thai-style steamed fish', 'Seafood', 'Thai', 'step 1
Nestle the fish fillets side by side on a large square of foil and scatter the ginger, garlic, chilli and lime zest over them. Drizzle the lime juice on top and then scatter the pieces of pak choi around and on top of the fish. Pour the soy sauce over the pak choi and loosely seal the foil to make a package, making sure you leave space at the top for the steam to circulate as the fish cooks.

step 2
Steam for 15 minutes. (If you haven’t got a steamer, put the parcel on a heatproof plate over a pan of gently simmering water, cover with a lid and steam.)', '/static/fotos/53202.jpg'),
(53203, 'Thai rice noodle salad', 'Vegetarian', 'Thai', 'step 1
Place the noodles and beansprouts in a heatproof bowl and cover with boiling water. Leave for 4 mins, or until the noodles are tender. Drain, then cool under cold running water and drain again. Return to the bowl.

step 2
Stir together the lime zest and juice, fish or soy sauce and sugar. Stir into the noodles with the red onion and lettuce.

step 3
To make with mince, heat a little oil in a non-stick frying pan and stir-fry 500g minced pork, a small knob of grated ginger and pinch cayenne pepper or chilli powder for 10 mins, until the mince is browned and cooked through. Mix into the noodles, divide between four bowls and serve warm.

step 4
To make with steak, make the rice noodle salad. Heat 1 tsp sunflower oil in a frying pan. Tip 2 tbsp sesame seeds onto a plate. Rub 1 tsp oil into 4 x 175g sirloin steaks and press into sesame seeds. Fry for 5 mins for medium rare, turning halfway. Leave to rest for 5 mins, then thinly slice. Toss 1 deseeded and shredded red chilli, and a handful mint leaves into noodles. Top with steak to serve.', '/static/fotos/53203.jpg'),
(53204, 'Red curry chicken kebabs', 'Chicken', 'Thai', 'step 1
Fire up the barbecue or heat a griddle pan to high. Tip chicken, curry paste and coconut milk into a bowl, then mix well until the chicken is evenly coated. Thread vegetables and chicken onto skewers. Cook the skewers on the barbecue or griddle for 5-8 mins, turning every so often, until the chicken is cooked through and charred. Serve with herby rice, salad and a lime half to squeeze over.', '/static/fotos/53204.jpg'),
(53205, 'Thai prawn curry', 'Seafood', 'Thai', 'step 1
Heat the oil in a medium saucepan. Tip in the onion and ginger, then cook for a few mins until softened. Stir in the curry paste, then cook for 1 min more. Pour over the chopped tomatoes and coconut cream. Bring to the boil, then leave to simmer for 5 mins, adding a little boiling water if the mixture gets too thick.

step 2
Tip in the prawns, then cook for 5-10 mins more, depending on how large they are. Serve alongside some plain rice and sprinkle with a little chopped coriander, if you like.', '/static/fotos/53205.jpg'),
(53206, 'Thai chicken cakes with sweet chilli sauce', 'Chicken', 'Thai', 'step 1
Toss the chicken, garlic, ginger, onion, coriander and chilli into a food processor and season well. Blitz until the chicken is finely ground and everything is well mixed. Use your hands to shape six small cakes.

step 2
Heat the oil in a frying pan, then fry the cakes over a medium heat for about 6-8 mins, turning once. Serve hot, with sweet chilli sauce, lime wedges, coriander, shredded spring onion and red chilli.', '/static/fotos/53206.jpg'),
(53207, 'Tom kha gai', 'Chicken', 'Thai', 'step 1
Pour the chicken stock and coconut milk into a large saucepan set over a medium heat. Tip in the galangal, lemongrass and lime leaves, and bring to a gentle simmer, around 6-8 mins. Keeping at a gentle simmer, add the chicken. Cook for 8-10 mins until tender and cooked through.

step 2
Stir in the mushrooms and chillies, and simmer for a further 3-5 mins until everything is cooked through. Sprinkle in the sugar and 3 tbsp each of the fish sauce and lime juice. Taste and add the remaining if required.

step 3
Remove the galangal, lemongrass and lime leaves before serving using a slotted spoon. Ladle into bowls and serve with coriander leaves sprinkled over and steamed rice on the side. Will keep chilled for up to three days. Leave to cool first.', '/static/fotos/53207.jpg'),
(53208, 'Thai coconut & veg broth', 'Vegetarian', 'Thai', 'step 1
Place the curry paste in a large saucepan or wok with the oil. Fry for 1 min until fragrant. Tip in the vegetable stock, coconut milk and brown sugar. Simmer for 3 mins.

step 2
Add the noodles, carrots and Chinese leaf and simmer for 4-6 mins, until all are tender. Mix in beansprouts and tomatoes. Add lime juice to taste and some extra seasoning, if you like. Spoon into bowls and sprinkle with spring onions and coriander.', '/static/fotos/53208.jpg'),
(53209, 'Spicy Thai prawn noodles', 'Seafood', 'Thai', 'step 1
Cook the noodles following the pack instructions, drain and set aside for later. Heat the oil in a large frying pan and pour in the beaten egg. Swirl around the pan to make a thin omelette, cook for 1-2 mins, then flip over and cook the other side for 1 min. Tip out and slice into thin strips.

step 2
Add the chilli and ginger to the pan, fry for 1-2 mins then tip in the noodles, prawns and egg. Splash in the soy sauce and stir-fry for 1 min more. Throw in the chopped herbs and pour over the lime juice and zest, then sprinkle over the chopped peanuts and serve.', '/static/fotos/53209.jpg'),
(53210, 'Thai pumpkin soup', 'Vegetarian', 'Thai', 'step 1
Heat oven to 200C/180C fan/gas 6. Toss the pumpkin or squash in a roasting tin with half the oil and seasoning, then roast for 30 mins until golden and tender.

step 2
Meanwhile, put the remaining oil in a pan with the onion, ginger and lemongrass. Gently cook for 8-10 mins until softened. Stir in the curry paste for 1 min, followed by the roasted pumpkin, all but 3 tbsp of the coconut milk and the stock. Bring to a simmer, cook for 5 mins, then fish out the lemongrass. Cool for a few mins, then whizz until smooth with a hand blender, or in a large blender in batches. Return to the pan to heat through, seasoning with salt, pepper, lime juice and sugar, if it needs it. Serve drizzled with the remaining coconut milk and scattered with chilli, if you like.', '/static/fotos/53210.jpg'),
(53211, 'Lemongrass beef stew with noodles', 'Beef', 'Thai', 'step 1
Put the ginger, garlic, lemongrass, coriander and 1 chilli in a food processor, then pulse until puréed. Heat the oil in a pan over a low heat. Add the purée and cook for 5 mins. Stir in the beef, soy, five-spice, sugar and stock. Put on a lid and bring to the boil, then lower heat and simmer for 1 hr 15 mins. Remove the lid and cook for a further 15 mins until the beef is tender.

step 2
Just before serving, prepare noodles following pack instructions. Drain well, then divide between 2 bowls and spoon over the beef stew. Serve sprinkled with the remaining chilli and coriander leaves, with lime wedges for squeezing over.', '/static/fotos/53211.jpg'),
(53212, 'Thai drumsticks', 'Chicken', 'Thai', 'step 1
Heat oven to 200C/180C fan/gas 6 and line a baking tray with foil. Mix the chilli sauce with the orange zest and juice, garlic, curry paste and ¼ tsp salt. Add the chicken and coat really well.

step 2
Arrange the drumsticks on the foil, spaced apart. Coat the chicken with any marinade left in the bowl, then roast for 35-40 mins until tender. Wrap in foil or pack into a food container.', '/static/fotos/53212.jpg'),
(53213, 'Thai-style fish broth with greens', 'Seafood', 'Thai', 'step 1
Cook the noodles following pack instructions. Refresh in cold water and drain well.

step 2
Put the stock in a large saucepan and stir in the curry paste, lime leaves, fish sauce and 250ml cold water. Bring to a simmer and cook for 5 mins.

step 3
Cut the fish into roughly 3cm cubes and add to the pan. Return to a simmer, then cook for 2 mins uncovered.

step 4
Stir in the noodles, prawns and pak choi, and simmer for 2-3 mins or until the fish and prawns are just cooked. Serve in bowls scattered with coriander.', '/static/fotos/53213.jpg'),
(53214, 'Thai green chicken soup', 'Chicken', 'Thai', 'step 1
Heat the oil in your largest pan, add the onion and fry for 3 mins to soften. Add the chicken and garlic, and cook until the chicken changes colour.

step 2
Add the curry paste, coconut milk, stock, lime leaves and fish sauce, then simmer for 12 mins. Add the chopped onion tops, green beans and bamboo shoots and cook for 4-6 mins, until the beans are just tender.

step 3
Meanwhile, put the lime juice and basil in a narrow jug and blitz with a hand blender to make a smooth green paste. Pour into the soup with the sliced spring onion and heat through. Serve with lime wedges for a light lunch or supper or as a make-ahead starter.', '/static/fotos/53214.jpg'),
(53215, 'Shakshouka', 'Miscellaneous', 'Saudi Arabian', '1
First, pan fry the black pepper and garlic over a dry medium heat until fragrant.
2
Add a good amount of extra virgin olive oil and infuse for a minute.
3
Once the oil heats up, add the tomatoes and salt, and cover with a lid. Simmer for 5 minutes.
4
Remove the lid and mash the tomatoes. Reduce until you reach the desired consistency of choice.
5
Make craters for the eggs and lower the heat. Carefully crack the eggs into the craters, making sure it touches the pan and not the tomato sauce.
6
Cover the eggs and leave it for 5 minutes without lifting the lid.
7
Remove from the heat and let the residual heat steam the eggs for 1-2 minutes.
8
Serve with flatbread. Enjoy!', '/static/fotos/53215.jpg'),
(53216, 'Knafeh', 'Dessert', 'Saudi Arabian', '1
Take kanfhe in a bowl and roughly cut them. Pour melted butter, yellow food color and mix well with your hands.
In a separate bowl mix milk, cream cheese, sugar, cornstarch well.
2
Turn on the flame and boil the liquid, when it gets thick turn off the flame let it cool down a little bit.
Add mozzarella in it and mix it well.
Now make a base with half of the kanfhe in a dish, gently press it to level the dough well.
Pour the cheese mixture on the top and level it with a spoon.
3
Cover it with the other half of the kanfhe.
Put the dish in a preheated oven at 200 degree for about 20-25 minutes.
It''s ready when kunafa is golden and crunchy in the surface.
4
Boil water in a pan and dissolve sugar in it for 4–5 minutes. OR cook it until slightly thicken and keep on stirring. Add lemon juice with rose water, mix well.
Evenly pour the syrup over the kunafa as soon as it comes out of the oven.
Your kunafa is ready to serve.', '/static/fotos/53216.jpg'),
(53217, 'Shawarma chuck roast wrap', 'Beef', 'Saudi Arabian', '1
In a dutch oven or slow cooker, add all the spices, beef broth and lemon juice. Stir to combine..
2
Add the beef and turn to coat, spoon some sauce over the top.
3
Cover and cook on low for 8-10 hours.
4
After cooking, remove beef and use two forks to shred. Discard any excess fat.
5
Skim fat off of the top of the liquid remaining.
6
Mix shredded beef into sauce. Keep warm until you are ready to serve.
7
Build wrap by spreading garlic sauce on the pita. Top with beef and add garnishes to your liking.
8
Fold it burrito style.
9
Heat a grill pan and grill the wrap.', '/static/fotos/53217.jpg'),
(53218, 'Chicken Shawarma with homemade garlic herb yoghurt sauce', 'Chicken', 'Saudi Arabian', '1
Start by cutting your chicken up into reasonably small slices. Grab your ziplock bag and dump the freshly sliced chicken inside.
2
Add garlic, coriander, cumin, cardomom, cayenne pepper, paprika, salt, pepper, lemon juice and olive oil to the bag. Close the bag and mix thoroughly. Place in fridge for 10-12 hours (shorter is fine but longer is better).
3
Once ready to cook, heat your fry pan to medium-high and add a tiny bit of olive oil. Fry one side of all of your flatbreads until slightly toasty. Remove from pan, add enough oil to coat the fry pan. Put crumble fries into air fryer on 180 for 15 minutes shaking occasionally.
4
The pan should be pretty hot by now, add the chicken in 2 batches (unless you have a big fry pan) to avoid overcrowding. The chicken should get a nice sear and darker colour which is perfect. Cook for a further 5-8 minutes or until cooked through. Repeat with next chicken batch.
5
While chicken is cooking, place your Greek yoghurt into a bowl. Combine garlic, finely chopped mint and parsley, squeeze or so of lemon and cumin. Combine and add salt to taste. In a small bowl, combine 1tsp garlic powder, paprika, cumin, onion powder, oregano, dried parsley, cayenne pepper (optional) mix and leave aside for fries.
6
Season fries immediately once cooked and add salt to taste. Once the chicken is complete, serve immediately by laying out your flatbread, spreading the sauce evenly over the bread, add lettuce, onion, tomato, fries, chicken, feta and more sauce on top. Serve immediately.', '/static/fotos/53218.jpg'),
(53219, 'Shakshuka Feta Cheese', 'Miscellaneous', 'Saudi Arabian', '1
In a pan heat the oil medium to high heat, with a tablespoon of olive oil
2
Add the chopped vegetables as onions, garlic, celery and red pepper. Stir all together for 5 mins.
3
Add the cumin powder and salt and pepper and the tomato sauce and let it cook for another 7 mins.
4
Add the eggs, cover and leave to coo for 8 mins. Add the fresh spinach and feta cheese at the end.
5
Serve with fresh bread.', '/static/fotos/53219.jpg'),
(53220, 'kabse', 'Chicken', 'Saudi Arabian', '1
Caramelize the chicken with olive oil then add a maggi cube and boil it for around 30 minutes.
2
In another pot, add all the veggies and caramelize them till they are soft.
3
Once everything is done, add the rice, raisins & spices to the veggies and add 2 and a half cups of water for the rice to cook.
4
Once the rice is done put everything in the oven.', '/static/fotos/53220.jpg'),
(53221, 'Mamoul (Eid biscuits)', 'Dessert', 'Saudi Arabian', '1
Mix butter with sugar until creamy.
2
Add oil flour and semolina and mix.
3
Add warm milk and don''t knead too much
4
Cover and leave aside for an hour or less until you prepare the filling
5
For the dates filling, fry some sesame in a pan then add butter. Add the dates paste and mixed well with sesame and butter. Then add a little bit of water until it''s mushy. Be careful don''t make it too mushy.
6
Take it of the pan, put in a plate until it''s cool. Then start to shape balls that weigh 15 gm.
7
Refrigerate for 1/2 an hour.
8
Get back to the dough and shape it as balls that weigh 30 gm.
9
Take the date filling out of the fridge and start to stuff each dough ball with dates ball.
Then use the mamoul mould to give it this shape.
10
In a preheated oven 180 degrees, put it for 20 minutes until golden from below and little bit golden from above.', '/static/fotos/53221.jpg'),
(53222, 'Vegetarian Shakshuka', 'Vegetarian', 'Saudi Arabian', '1
Fry onion and pepper together on medium heat until onion is soft
2
Add garlic granules, cook for a minute
3
Add chopped tomatoes and remaining spices, stir well
4
Simmer for about 20 minutes
5
Make indents for in the sauce and crack an egg into each one
6
Once egg whites are cooked through, garnish and serve with toast', '/static/fotos/53222.jpg'),
(53223, 'Mutabbaq', 'Miscellaneous', 'Saudi Arabian', '1
Heat the frying pan and add in some oil. Fry the mashed garlic and ginger first and then add in the minced meat and all seasoning. When the meat is cooked, set aside to cool down.
2
Get another big bowl. Add in egg, chopped tomato, chopped spring onion and minced meat.
3
Get one 2 sheets of filo pastry or 1 sheet spring roll wrap. Brush it with some butter and then put some filling in the middle. Fold the pastry and brush more butter on the seal part.
4
Heat a frying pan and add in some oil to cook the parcel until its both sides and 4 edges all turn into golden brown. (Or brush melted butter all over the parcel and bake it in 180°C oven for 10-15 minutes)
5
Enjoy 

', '/static/fotos/53223.jpg'),
(53224, 'Pistachio Kunafa Chocolate Cake and Cupcakes', 'Dessert', 'Saudi Arabian', '1
For Chocolate Cake:Ready all the ingredients. Powder the oreo biscuits, pinch salt and mix warm milk as needed and make a cake batter. Add in baking powder and vinegar and mix.
2
Grease a loose bottomed tin. Pour a 1cm thick layer of the batter.
3
Bake in a preheated oven @160°C for 7-8 minutes or until the knife comes out clean. Cool on wire rack.
4
For Homemade Pistachio Paste:Ready all the pistachio paste ingredients. Slightly melt white chocolate on a double boiler.(else the mixer blade may break) Coarsely powder the pistachio in mixer. Add in condensed milk.
5
Add in slightly warmed and slightly melted white chocolate and milk as required and crush to a smooth paste.(Green food colour can be add. I haven''t.)
6
For Kunafa: In a kadhaai take ghee and roast the sevaiiya on slow gas. Keep stirring until a pleasant roasted aroma releases. Cool it. Add in the Homemade pistachio paste.Mix well.
7
Lip smacking Kunafa is ready. Spread a 2 cm layer on the cooled chocolate cake.
8
Melt dark chocolate and strained malai and prepare the chocolate ganache. Cool and pour on the Kunafa layer.
9
Garnish Pistachio Kunafa Chocolate Cake with chopped pistachio and silver balls. Keep in fridge for 2-3 hours. Then unmould the Kunafa Cake.
10
I also prepared Kunafa cupcakes. Cut and enjoy. The cake looked so pretty that we could either save it or have it!! ☺
11
Cross sectional view of the Pistachio Kunafa Chocolate Cake.
12
Enjoy with a new sweet delicacy this festive season with family and friends. ', '/static/fotos/53224.jpg'),
(53225, 'Yemeni Lahsa (Elite Shakshuka)', 'Breakfast', 'Saudi Arabian', '1
First, On medium heat, heat the olive oil and add the diced onion until it wethers. Next, add the tomatoes and cook for another 4-5 min. Lastly, add the all spice, salt, and cracked pepper.
2
Add the eggs and mix throughly for 2 minutes and cover to cook 5-6 minutes until top is solidified. Lastly, spread the liquid cheese and have it covered for a minute.
3
I served mine Mediterranean style with hash-browns, Egyptian fava beans, Turkish salami and olives, cheese wedges, and greek feta.', '/static/fotos/53225.jpg'),
(53226, 'Shawarma bread', 'Side', 'Saudi Arabian', '1
Sieve flour and add baking powder,salt,sugar,oil nd mix together
2
Add water nd knead the dough for like 10mins
3
Cover the mixture and allow it to rise
4
After it rised transfer it to a work surface and form a round (you can use a plate or pot''s lid)
5
Heat ur pan and put it
6
It''ll start puffing then you turn it
7
And lastly put it in in a warm place, then you''ll see it has pocket', '/static/fotos/53226.jpg'),
(53227, 'Rice paper dumplings', 'Pork', 'Vietnamese', 'step 1
Tip the cabbage into a food processor and blitz until finely chopped. Season with ½ tsp salt, toss well and set aside for 15 mins. Tip into a clean tea towel and squeeze out as much water as you can. Tip into a bowl with the carrot, mushrooms, pork mince, garlic, ginger, soy sauce, sesame oil and spring onions. Season with black pepper. Scrunch everything together using your hands, mixing well until everything is combined.

step 2
Soak the spring roll sheets for a couple of seconds in a shallow dish of warm water, then transfer to an oiled chopping board. Working with one sheet at a time, spoon 1 heaped tbsp of the filling into the middle, then fold the bottom up and over the filling. Fold down the top of the sheet, then the sides to fully encase and make a neat square. If the dumpling feels a little fragile, soak another sheet and wrap it again. Repeat with the remaining sheets and filling, transferring the dumplings to an oiled plate as you go.

step 3
Heat the oil in a large, non-stick frying pan (ensuring it is no more than a third full) over a medium-high heat and fry the dumplings for 3-5 mins until golden brown. Use a slotted spoon or spider to turn them, then cover with a lid and cook for another 3-4 mins until golden. Remove the lid and cook for 1-2 mins.

step 4
Meanwhile, combine all the dipping sauce ingredients in small bowl. Serve the dumplings with the dipping sauce on the side.', '/static/fotos/53227.jpg'),
(53228, 'Vietnamese caramel trout', 'Seafood', 'Vietnamese', 'step 1
Put the sugar in a large shallow pan, along with a small splash of water. Heat gently, swirling the pan, until the sugar has dissolved. Increase the heat and bubble the syrup until it turns a dark amber colour. Add the fish sauce, most of the chilli and ginger, then splash in 1 tbsp water to dilute. Boil again until syrupy, then add the fish fillets, skin-side down, and the bok choi, cut-side down.

step 2
Cover the pan with a lid and simmer for 4-5 mins until the fish is cooked and the bok choi has wilted. Turn off the heat, squeeze over the lemon and scatter with the remaining chilli, ginger and the coriander sprigs. Serve with rice.', '/static/fotos/53228.jpg'),
(53229, 'Steak & Vietnamese noodle salad', 'Beef', 'Vietnamese', 'step 1
Mix all the ingredients for the dressing together in a bowl with 1 tbsp water until the sugar has dissolved.

step 2
Cook the noodles following pack instructions, then plunge into a bowl of cold water to cool completely. Drain the noodles, then add the carrot, cabbage, spring onion and dressing, and toss to combine.

step 3
Heat the oil in a frying pan over a high heat. Season the steak, then cook to your liking; 2-3 mins on each side for medium rare. Leave to rest for 5 mins, then slice. Divide the salad and steak slices between bowls and scatter over some coriander to serve.', '/static/fotos/53229.jpg'),
(53230, 'Purple sprouting broccoli tempura with nuoc cham', 'Miscellaneous', 'Vietnamese', 'step 1
For the nuoc cham, whisk together all of the ingredients with 5 tbsp hot water in a small bowl. Set aside while you make the tempura.

step 2
Whisk the cornflour, plain flour, sesame seeds (if using) and a large pinch of salt together. Fill a large, deep pan no more than a third full with the vegetable oil and heat until it reaches 180C or a cube of bread dropped in browns in 20 seconds.

step 3
Quickly whisk the soda water into the flour mixture, being careful not to overmix, then dunk in the broccoli using tongs. Carefully lower into the hot oil and cook for 2-3 mins until crisp. Drain on kitchen paper, then serve with the nuoc cham on the side for dipping.', '/static/fotos/53230.jpg'),
(53231, 'Vietnamese lamb shanks with sweet potatoes', 'Lamb', 'Vietnamese', 'step 1
Heat oven to 160C/140C fan/gas 3. Heat 1 tbsp oil in a heavy-bottomed casserole, season the shanks, then brown them 2 at a time on all sides, adding the remaining oil for the second batch. Remove the lamb and add the onions. Fry them quite briskly, about 30 secs, add the ginger, garlic and chopped chilli, then turn the heat down and cook for 1 min. Add 1 tbsp sugar, stir, then add the star anise, lemongrass, stock, purée and seasoning. Bring to the boil.

step 2
Cover and cook in the oven for 1½ hrs, then add the sweet potatoes and cook for 1 hr more. The lamb should be completely tender and almost falling off the bones. Stir in the fish sauce, lime juice and 1 tsp sugar to just lift the flavour, then scatter with the mint, basil and the sliced chilli to serve.', '/static/fotos/53231.jpg'),
(53232, 'Vietnamese chicken salad', 'Chicken', 'Vietnamese', 'step 1
To make the dressing, whisk all the ingredients together in a large serving bowl. Cook the noodles following pack instructions, then drain and add to the bowl with the dressing.

step 2
Peel the carrot into long strips using a vegetable peeler. Do the same for the cucumber, until you reach the seeds (discard them). Add the carrot and cucumber to the noodle mixture along with the shredded chicken, radishes, red onion and mint. Toss well to coat in the dressing, scatter over the peanuts and serve.', '/static/fotos/53232.jpg'),
(53233, 'Salt & pepper squid', 'Seafood', 'Vietnamese', 'step 1
To make the dipping sauce, mix all the ingredients in a small bowl until the sugar has dissolved, then set aside. Mix the cornflour and plain flour with both peppers and 2 tsp sea salt in a large bowl, then set aside. Line a tray with kitchen paper and make sure you have more salt to sprinkle with.

step 2
Heat about 7cm of oil to 180C in a deep fryer, wok or deep pan. If you don’t have a thermometer, you can test it with a cube of bread – it should brown in 20 secs. Coat the squid well with the flour mix and fry in batches for about 2 mins each or until crisp. Use a slotted spoon to lift out the squid, then drain on the kitchen paper and sprinkle with a little more salt. Serve the squid scattered with the spring onion and chilli, with the dipping sauce on the side.', '/static/fotos/53233.jpg'),
(53234, 'Salmon noodle soup', 'Seafood', 'Vietnamese', 'step 1
Pour the stock into a large pan, bring to the boil, then stir in the curry paste. Add the noodles and cook for 8 mins. Tip in the mushrooms and corn and cook for 2 mins more.

step 2
Add the salmon to the pan and cook for 3 mins or until cooked through. Remove from the heat and stir in the lime juice, soy sauce and a pinch of sugar. Ladle into 4 bowls and sprinkle over the coriander just before you serve.', '/static/fotos/53234.jpg'),
(53235, 'Vietnamese-style caramel pork', 'Pork', 'Vietnamese', 'step 1
Heat 1 tbsp of the oil in a wok over a high heat and stir-fry the pork in batches until browned all over. Remove with a slotted spoon and set aside.

step 2
Turn the heat right down and add the remaining oil, then stir in the shallots, ginger and chilli. Cook over a low heat for a couple of mins until just starting to soften. Add the sugar, fish sauce and 200ml water to the pan and stir everything together. Bring to the boil, stirring, so that the sugar dissolves, then return the pork to the pan. Bubble vigorously for 8-10 mins until the sauce thickens to coat the meat and become glossy. Taste and stir in a little more fish sauce, if needed, along with the chilli sauce. Sprinkle with the spring onions and serve with steamed rice and pak choi.', '/static/fotos/53235.jpg'),
(53236, 'Vietnamese-style veggie hotpot', 'Vegetarian', 'Vietnamese', 'step 1
Heat the oil in a medium-size, lidded saucepan. Add the ginger and garlic, then stir-fry for about 5 mins. Add the squash, soy sauce, sugar and stock. Cover, then simmer for 10 mins. Remove the lid, add the green beans, then cook for 3 mins more until the squash and beans are tender. Stir the spring onions through at the last minute, then sprinkle with coriander and serve with rice.', '/static/fotos/53236.jpg'),
(53237, 'Vietnamese pork salad', 'Pork', 'Vietnamese', 'step 1
The day before: make the dressing. Put the sugar and lime juice in a pan with 1 tbsp water and bring to the boil to dissolve the sugar. Add the chilli and coriander and stir well, then pulse in a blender until smooth. Tip into a bowl, then stir in the sesame oil, fish sauce, soy sauce and sesame seeds to make a dressing. Cover and chill until needed.

step 2
Two hours before serving: heat a griddle pan. Preheat the oven to 200C/gas 6/fan 180C. Brush the pork with oil and griddle on all sides for a few minutes until seared. Transfer to a baking tray and put in the oven for about 10-12 minutes until cooked through. Cool, thinly slice against the grain of the meat. Tip into a bowl and pour over half the dressing.

step 3
To serve: toss the remaining salad ingredients in a bowl with the remaining dressing. Pile on to a platter, top with the pork slices and spoon over any juices.', '/static/fotos/53237.jpg'),
(53238, 'Beef pho', 'Beef', 'Vietnamese', 'step 1
Tip the beef stock along with 500ml of water into a large saucepan. Sit the onion and ginger in a frying pan over a high heat and char on all sides, around 3-5 mins (you can also do this under your grill). Once charred, add to the beef stock. In the same pan, toast the spices for 2-3 mins and once they begin to smell fragrant, add them to the beef stock as well. Bring the stock to the boil, then turn to a simmer and cook for 30mins before straining.

step 2
Meanwhile, cut the fat from the steak and wrap in cling film, then put into the freezer for 15 mins – this will make your steak really easy to slice! Slice it thinly, then cover with cling film again and pop into the fridge.

step 3
Taste the beef stock and use the palm sugar, fish sauce and soy to season. Cook the noodles according to package instructions and split between two bowls, topping each with the sliced beef. Bring the stock to the boil and then pour into the bowls (the heat will cook the beef). Top each with the spring onions, chilli slices and herbs. Serve with the lime wedges to squeeze over.', '/static/fotos/53238.jpg'),
(53239, 'Bang bang prawn salad', 'Seafood', 'Vietnamese', 'step 1
Cook the noodles following pack instructions, then rinse under cold water and drain thoroughly. In a small saucepan melt together the peanut butter, coconut milk, sweet chilli sauce and half the spring onions, adding 1-2 tbsp of water to loosen the mixture to a drizzling consistency.

step 2
Mix the noodles, cucumber and beansprouts in a serving dish. Top with the prawns, drizzle over the peanut sauce and scatter over the remaining spring onions.', '/static/fotos/53239.jpg'),
(53240, 'Tofu, greens & cashew stir-fry', 'Vegetarian', 'Vietnamese', 'step 1
Heat the oil in a non-stick wok. Add the broccoli, then fry on a high heat for 5 mins or until just tender, adding a little water if it begins to catch. Add the garlic and chilli, fry for 1 min, then toss through the spring onions, soya beans, pak choi and tofu. Stir-fry for 2-3 mins. Add the hoisin, soy and nuts to warm through.', '/static/fotos/53240.jpg'),
(53241, 'Vietnamese veg parcels', 'Vegetarian', 'Vietnamese', 'step 1
Soak the rice fl our pancakes according to pack instructions or in boiling water for 30 secs. Remove and cool on kitchen paper. Soak the rice noodles according to pack instructions, then drain and cut them into 2cm strips.

step 2
Lay a rice pancake on a board and arrange some rice noodles, chicken, vegetables and herb leaves about a third of the way up, leaving a 1cm edge at the side. Fold the sides over the vegetables and then roll up lengthways to make a cigar. Store in the fridge, covered with moist kitchen paper for up to 1 day.

step 3
Mix together the ingredients for the dipping sauce and put into a bowl. To serve, arrange the rolls on a plate along with the leaves and herbs. To eat, wrap each roll in a piece of lettuce with a herb sprig and dunk into the sauce.', '/static/fotos/53241.jpg'),
(53242, 'Barbecue pork buns', 'Pork', 'Vietnamese', 'step 1
Heat the oven to 200C/fan 180C/gas. Mix the sugar into the bread mix in a large bowl, then add water as instructed on the pack. Bring the dough together with a wooden spoon, then knead on a lightly floured surface for 5 mins until smooth. Put into a large bowl, cover with oiled cling film then leave in a warm place until doubled in size.

step 2
Meanwhile, heat the oil in a pan, then fry the bacon until crisp, about 5 mins. Add the ginger and garlic and fry for 1 min until soft, then tip in the soy, honey and tomato purée and stir well. Can be made up to 3 days ahead.

step 3
Turn out the dough and knead briefly, then pull into 12 even-sized balls. Flatten with your hands, then put a teaspoon-size blob of the filling in the middle. Draw the dough up and pinch it closed like a purse, then turn the bun over and sit it on a large baking sheet. Cover with oiled cling film and leave to rise for about 30 mins until the dough feels pillowy. Brush with egg and bake for 20 mins until golden. Serve warm with dipping sauce. Can be frozen after second rise for up to 1 month or baked up to a day ahead and re-warmed.', '/static/fotos/53242.jpg'),
(53243, 'Vietnamese prawn spiralized rolls', 'Seafood', 'Vietnamese', 'step 1
Mix all the ingredients for the dipping sauce along with 50ml water in a bowl and set aside to allow the sugar to dissolve and flavour to infuse.

step 2
To assemble the rolls, fill a wide bowl with warm water and grab a clean damp tea towel to work on. Dip a rice paper wrapper into the water for a few seconds until it softens then carefully place onto the tea towel.

step 3
Put a few mint and coriander leaves in the centre of the wrapper then top with two prawns and a small handful of the spiralized veg, which may need to be cut up if the spirals are too long.

step 4
Fold the sides of the wrapper into the centre, over the filling, then fold in the edges, so that the filling is completely encased, then tightly roll. Repeat until all of the wrappers and filling have been used. To serve, slice on a diagonal and eat with the dipping sauce.', '/static/fotos/53243.jpg'),
(53244, 'Prawn & noodle salad with crispy shallots', 'Seafood', 'Vietnamese', 'step 1
For the crispy shallots, heat 5cm of oil until hot in a wok. You will know the oil is hot enough when one piece of shallot sizzles as soon as it’s dropped in. Toss the shallot slices with flour, shake off excess and fry in the oil until golden. They fry quickly, about 1 min. Drain on kitchen paper, sprinkle with salt and set aside.

step 2
To make the dressing, mix the lime juice, sugar, fish sauce and garlic and set aside. In a large mixing bowl, pour boiling water over the noodles. Leave them for 2 mins or until they are just cooked, then rinse under cold water. Drain well, shaking the sieve numerous times to get out the excess water, then place back in the bowl. Add prawns, onion, chilli, cucumber and herbs. Pour the dressing over, mix, then sprinkle with the shallots and peanuts.', '/static/fotos/53244.jpg'),
(53245, 'Noodle bowl salad', 'Seafood', 'Vietnamese', 'step 1
Drop the noodles into a large bowl, then pour over enough boiling water to cover. Tip in the sliced sugar snaps and leave for 4 minutes. Drain in a colander, put under cold running water to cool off, then drain again. Tip into a bowl and toss in the sesame oil.

step 2
Mix the dressing ingredients. Pile spring onions, coriander and salmon onto the noodles, pour over the dressing and toss everything together. Serve with a pretzel or bread roll.', '/static/fotos/53245.jpg'),
(53246, 'Tangy carrot, cabbage & onion salad', 'Vegetarian', 'Vietnamese', 'step 1
Tip the carrots, cabbage and onions into a bowl. Make the dressing by stirring the ingredients together until the sugar has dissolved. Pour over salad, tossing the vegetables in the dressing. Add the herbs, toss again, then scatter over the peanuts.', '/static/fotos/53246.jpg'),
(53247, 'Sea bass with sizzled ginger, chilli & spring onions', 'Seafood', 'Vietnamese', 'step 1
Season 6 sea bass fillets with salt and pepper, then slash the skin 3 times.

step 2
Heat a heavy-based frying pan and add 1 tbsp sunflower oil.

step 3
Once hot, fry the sea bass fillets, skin-side down, for 5 mins or until the skin is very crisp and golden. The fish will be almost cooked through.

step 4
Turn over, cook for another 30 seconds - 1 minute, then transfer to a serving plate and keep warm. You’ll need to fry the sea bass fillets in 2 batches.

step 5
Heat 2 tbsp sunflower oil, then fry the large knob of peeled ginger, cut into matchsticks, 3 thinly sliced garlic cloves and 3 thinly shredded red chillies for about 2 mins until golden.

step 6
Take off the heat and toss in the bunch of shredded spring onions. Splash the fish with 1 tbsp soy sauce and spoon over the contents of the pan.', '/static/fotos/53247.jpg'),
(53248, 'Salmon noodle wraps', 'Seafood', 'Vietnamese', 'step 1
Heat oven to 200C/fan 180C/gas 6. Put the noodles in a bowl and pour over enough boiling water to just cover them. Leave for 2 mins, until they are bendable, but not too soft, then drain well. Return to the bowl with the spring onions, petit pois, salt and pepper and a third of the butter. Mix well until the butter has melted.

step 2
Pile the noodles and vegetables onto two large squares of baking parchment, then sit the salmon on top. Slice the remaining butter and arrange over the top of the salmon. Bring the ends of the paper over the fish, fold them together to seal, then tuck the ends of the paper underneath so there are no gaps. Put the parcels on a baking sheet and bake for 15-20 mins. Transfer to dinner plates and serve without delay.', '/static/fotos/53248.jpg'),
(53249, 'Turkey Bánh mì', 'Miscellaneous', 'Vietnamese', 'step 1
To make the pickled slaw, tip the carrots and cabbage into a large bowl. In a small bowl, combine the ginger, rice vinegar, sugar and a few pinches of salt. Pour over the vegetables and toss together. Set aside for at least 15 mins.

step 2
Halve the baguettes lengthways and spread the pâté over the bottom half. Top with the pickled slaw, cucumber and turkey. Mix the mayonnaise with the chopped chilli and dollop over the top. Scatter over the mint leaves and sliced chilli. Sandwich together and dig in.', '/static/fotos/53249.jpg'),
(53250, 'Vegan banh mi', 'Vegan', 'Vietnamese', 'step 1
Put the shredded veg in a bowl and add the vinegar, sugar and 1 tsp salt. Toss everything together, then set aside to pickle quickly while you prepare the rest of the sandwich.

step 2
Heat oven to 180C/160C fan/gas 4. Cut the baguette into four, then slice each piece horizontally in half. Put the baguette pieces in the oven for 5 mins until lightly toasted and warm. Spread each piece with a layer of hummus, then top four pieces with the tempeh slices and pile the pickled veg on top. To serve, sprinkle over the herbs and squeeze over some hot sauce, then top with the other baguette pieces to make sandwiches.', '/static/fotos/53250.jpg'),
(53251, 'Turkish lahmacun', 'Beef', 'Vietnamese', 'step 1
Sift the flour into a large bowl, make a well in the middle and sprinkle in the yeast. Pour 125ml water over the yeast, then flick flour over the liquid to create a layer. Cover and leave to rise in a warm place for 15 mins until cracks appear on the surface of that layer.

step 2
Use your hands to mix in 250ml more water along with 1 tsp salt and knead the dough for about 10 mins until elastic and no longer sticky. Add a little more flour if you need to. Cover and leave to rise again in a warm place for 30 mins until doubled in size.

step 3
Heat the oven to as high as it will go (about 240C/220C fan/gas 9) and sprinkle one or two baking trays thinly with cornmeal.

step 4
Pour boiling water from the kettle over the tomatoes, leave to stand briefly, then drain and slip off the skins. Cut the tomatoes in half, cut out the stalks, scoop out the seeds and discard, then chop the flesh.

step 5
Halve the chillies lengthways, cut out the stalks, seeds and white inner membrane, then rinse. Cut lengthwise into fine strips, then crosswise into fine dice.

step 6
Put the tomatoes, chillies, spring onions, finely chopped parsley, beef mince, spices, 1 tsp salt and ½ tsp freshly ground black pepper into a bowl and mix well.

step 7
Take the dough and knead it briefly, then divide into four pieces and shape each into a ball. Roll each ball into a thin circle, place on the prepared baking trays. Spread with a thin layer of the meat mixture.

step 8
Bake each flatbread for 10-15 mins until the edges begin to darken. After removing from the oven, sprinkle the lahmacun with the roughly chopped parsley and sliced onion, then squeeze over a few drops of lemon juice. Serve straightaway.', '/static/fotos/53251.jpg'),
(53252, 'Turkish rice (vermicelli rice)', 'Miscellaneous', 'Turkish', 'step 1
Pour the rice into a very large bowl under cold running water and carefully drain the water out of the bowl through a sieve. Repeat a few times until the water in the bowl is clear, then fill the bowl up with cold water and leave rice to soak for 10 mins while you cook the vermicelli.

step 2
Put the oil into a medium pan over medium heat. Add the vermicelli and stir continuously until the strands turn a rich golden brown, 2-3 mins. Remove from the heat, stir through the butter until it melts and allow the vermicelli to cool for 1-2 mins.

step 3
Drain the rice thoroughly through a sieve. Add the rice to the pan and stir well. Pour the hot stock into the pan, sprinkle in ½ tsp salt, stir well then return the pan to the hob over a high heat. Bring to the boil, then reduce the heat to the lowest it will go, put the lid on the pan and simmer for 7-9 mins. Remove the pan from the heat, cover with a couple of sheets of kitchen paper or a light tea towel and the pan lid, and let the rice sit in the pan for 10 mins. Fluff up with a fork before serving.', '/static/fotos/53252.jpg'),
(53253, 'Imam bayildi with BBQ lamb & tzatziki', 'Lamb', 'Turkish', 'step 1
Heat oven to 190C/170C fan/gas 5. Halve the aubergines lengthways and score the flesh side deeply, brush with a good layer of olive oil and put on a baking sheet. Roast for 20 mins or until the flesh is soft enough to scoop out.

step 2
Fry the onion in a little oil until soft, add the garlic and cinnamon and fry for 1 min. Once the aubergines are cool enough to handle, scoop out the centres. Roughly chop the flesh and add it to the onions. Halve the tomatoes, scoop the seeds and juice into a sieve set over a bowl, then chop the flesh. Add the chopped tomatoes to the pan and cook everything for 10 mins until nice and soft. Add a little more oil if you need to. Stir in the parsley, leaving a little for scattering at the end.

step 3
Lay the aubergine halves in a baking dish and divide the tomato mixture between them. Pour over the juice from the tomatoes, drizzle with more olive oil and bake for 30 mins until the aubergines have collapsed.

step 4
Meanwhile, mix the tzatziki ingredients together and put in a small serving bowl.

step 5
Season the lamb with salt, black pepper and a pinch of paprika. Griddle, grill or barbecue for 3 mins on each side or until the fat is nicely browned, then put in a serving dish and squeeze over the lemon halves. Scatter the aubergines with parsley, then serve with the lamb and tzatziki.', '/static/fotos/53253.jpg'),
(53254, 'Ezme', 'Vegetarian', 'Turkish', 'step 1
Put the tomatoes and all of the peppers in a food processor and blitz until finely chopped. Tip out into a sieve, set over a bowl and leave to strain. Add the onions, garlic and parsley to the food processor and blitz until finely chopped, then set aside.

step 2
Add red pepper paste, tomato purée, pomegranate molasses, pul biber, sumac, dried mint and most of the extra virgin olive oil to a serving bowl and whisk well so everything comes together as a sauce. Tip in the blitzed onion mixture and the strained pepper mixture along with 1 tsp flaky sea salt . Stir well, then drizzle with the remaining extra virgin olive oil to serve.', '/static/fotos/53254.jpg'),
(53255, 'Grilled aubergines with spicy chickpeas & walnut sauce', 'Vegetarian', 'Turkish', 'step 1
Heat 2 tbsp oil in a pan, add the onion and fry until soft and lightly browned, about 10 mins. Add the chilli, ginger and spices and mix well. Stir in the chickpeas, tomatoes and 5 tbsp water, bring to the boil, then simmer for 10 mins. Add a little salt and pepper and the lemon juice.

step 2
Arrange the aubergines over a grill pan. Brush lightly with oil, sprinkle with salt and pepper, then grill until golden. Flip them over, brush again with oil, season and grill again until tender and golden.

step 3
Mix the yogurt with the garlic, most of the walnuts and coriander and a little salt and pepper. Arrange the aubergine slices over a warm platter and spoon over the chickpea mix. Drizzle with the walnut sauce and scatter with the remaining walnuts and coriander.', '/static/fotos/53255.jpg'),
(53256, 'Cacik', 'Side', 'Turkish', 'step 1
Put a sieve over a large bowl, line it with a thick sheet of non-dyed kitchen paper or a clean muslin cloth, and spoon in the yogurt. Cover with another sheet of kitchen paper and leave to strain in the fridge for a minimum of 12 hrs.

step 2
Add the lemon juice, most of the olive oil and the dried mint to a bowl and stir well for the dried mint to soften and soak up the juices. Mix in the strained yogurt, then pour away the strained yogurt liquid and leave that bowl to one side.

step 3
Halve the cucumber(s) lengthways and remove the seeds by running a teaspoon from the top to the bottom of the flesh, halve the cucumbers widthways to make them shorter and easier to handle, then coarsely grate each one into the bowl the yogurt was straining over. Using clean hands (or a clean muslin cloth), squeeze as much of the liquid out of the cucumber as possible.

step 4
Add the strained, grated cucumber, garlic and ¾ tsp flaky salt to the rest of the ingredients and mix well. Garnish with a drizzle of extra virgin olive oil and a sprinkling of dried mint.', '/static/fotos/53256.jpg'),
(53257, 'kofta burgers', 'Lamb', 'Turkish', 'step 1
Tip the mince into a large bowl (use a clean washing-up bowl if you don’t have anything big enough) with all the other burger ingredients and a good pinch of salt. Roll up your sleeves, get your hands into the mix and squelch everything together through your fingers until completely mixed. Pat the mix into 16 small burgers. These may now be frozen for up to 1 month or chilled up to a day ahead.

step 2
To cook, heat grill to its highest setting and lay the burgers in a single layer on a baking tray (you may need to do this in batches, depending on how big your tray is). Grill on the highest shelf for 5-6 mins on each side until browned and cooked through. Pile burgers onto a platter and serve with all the accompaniments, so everyone can construct their own sandwich.', '/static/fotos/53257.jpg'),
(53258, 'Hot cumin lamb wrap with crunchy slaw & spicy mayo', 'Lamb', 'Turkish', 'step 1
Heat a griddle pan. Rub the lamb steaks with the oil, cumin and some seasoning. Griddle for about 3-4 mins on each side or until cooked to your liking. Place to one side on a plate to rest.

step 2
In a large bowl, stir the sugar into the vinegar until dissolved. Add the carrots, spring onions, cabbage and some seasoning, and toss together.

step 3
Blitz the whole peppers and the mayo in a food processor. Add a heap of the salad to each flatbread. Slice the lamb, trimming off any excess fat and lay on top of the salad, drizzling with the resting juices. Spoon over the mayo and scatter with a few of the sliced peppers. Roll up and eat. If using pitta, split and stuff. Serve any extra salad on the side.', '/static/fotos/53258.jpg'),
(53259, 'Smoked aubergine purée', 'Side', 'Turkish', 'step 1
Heat grill to very hot. Slice the aubergines in half lengthways, then grill for 25 mins, turning occasionally, until soft – the skin will remain firm, but the flesh will soften. Lift the aubergines off the grill and leave until cool enough to handle.

step 2
Using a sharp knife, score the grilled flesh and scoop out the flesh with a spoon. Tip into a bowl and mash with a fork until you get a thick pulp. Beat in the lemon juice and garlic. Add the yogurt and dill, and season. Serve while still warm.', '/static/fotos/53259.jpg'),
(53260, 'Slow-roast lamb with cinnamon, fennel & citrus', 'Lamb', 'Turkish', 'step 1
Put the lamb into a large food bag with all the juice and marinate overnight.

step 2
The next day, take the lamb out of the fridge 1 hr before you want to cook it. Heat oven to 220C/200C fan/gas 7. Take the lamb out of the marinade (reserve remaining marinade) and pat dry. Rub with half the oil and roast for 15-20 mins until browned. Remove lamb and reduce oven to 160C/140C fan/gas 3.

step 3
Mix the zests, remaining oil, honey, spices and garlic with plenty of seasoning. Lay a large sheet of baking parchment on a large sheet of foil. Sit the lamb leg on top, rub all over with the paste and pull up the sides of the foil. Drizzle marinade into base, and scrunch foil to seal.

step 4
Roast for 4 hrs, until very tender. Rest, still wrapped, for 30 mins. Unwrap and serve with juices.', '/static/fotos/53260.jpg'),
(53261, 'Chicken wings with cumin, lemon & garlic', 'Chicken', 'Turkish', 'step 1
Using a pair of sharp kitchen scissors, cut each wing at the knuckle into two pieces. Mix the garlic, lemon zest and juice, cumin and oil with plenty of seasoning, then tip into a dish with the chicken wings and toss to coat. Cover and put in the fridge to marinate for at least 1 hr, or overnight if you have time.

step 2
Heat oven to 200C/180C fan/gas 6, or heat an outdoor barbecue. Bake the chicken wings on an oven tray for 45-50 mins until crisp, or barbecue for 20 mins, drizzling over the honey for the final 10 mins of each method. Serve on a platter with plenty of paper napkins. Fill small bowls with olives, pistachios or almonds, dates and pickled chillies and flatbreads to serve alongside, along with the dishes below.', '/static/fotos/53261.jpg'),
(53262, 'Adana kebab', 'Lamb', 'Turkish', 'step 1
Finely chop the peppers in a food processor, then tip them in a sieve and press into the sieve so that the peppers release all of their juices. Tip into a bowl along with the mince, red pepper paste, pul biber, 1½ tsp flaky sea salt, and 2 tbsp of the oil. Mix together, kneading well for at least 2-3 mins. If you need to, wet your hands with cold water to prevent the mixture from sticking. The mixture should be sticky when ready. Cover and chill for at least 2 hrs, or up to 12 hrs.

step 2
When ready to cook, heat the grill to high or an oven to 220C/200C fan/gas 6. Divide the mixture into 12 equal portions, around 85g each. If you’d like to skewer them, divide into 8 equal portions and roll into balls. Using wet hands, thread the balls onto the end of the skewers, massaging the mixture down the skewers in between the palms of your hands, until evenly distributed. Ensure that the mixture is fully wrapped tightly around the skewers without any exposed metal. Alternatively, lay them on a large baking tray lined with parchment paper if cooking in the oven, or foil if cooking under the grill. Shape into 20cm-long köfte. Wet your fingers with a little cold water and make indents all along the köfte for the traditional shape.

step 3
Gently brush each köfte with the remaining 1 tbsp oil and cook under the grill, on the top shelf for 10-12 mins, turning regularly, or cook in the oven for 16-18 mins, until crispy on the outside and juicy in the middle', '/static/fotos/53262.jpg'),
(53263, 'Turkish lamb pilau', 'Lamb', 'Turkish', 'step 1
Dry-fry the pine nuts or almonds in a large pan until lightly toasted, then tip onto a plate. Add the oil to the pan, then fry the onion and cinnamon together until starting to turn golden. Turn up the heat, stir in the lamb, fry until the meat changes colour, then tip in the rice and cook for 1 min, stirring all the time.

step 2
Pour in 500ml boiling water, crumble in the stock cube, add the apricots, then season to taste. Turn the heat down, cover and simmer for 12 mins until the rice is tender and the stock has been absorbed. Toss in the pine nuts and mint and serve.', '/static/fotos/53263.jpg'),
(53264, 'Smoky chicken skewers', 'Chicken', 'Turkish', 'step 1
You need 15 skewers: if wooden, soak in water for 10 mins. Cut chicken into 3cm pieces and place in a bowl. Add 1 tbsp olive oil, the spices, garlic and vinegar, toss well and season. You can do this up to a day before and refrigerate.

step 2
Thread 2-3 pieces on each skewer. Pour remaining oil in a frying pan or rub onto a griddle pan. Get the pan hot and sear the chicken for 3-4 mins on each side – you may have to do this in batches, keeping the cooked skewers warm in a low oven. Serve with smoky aïoli if you like.', '/static/fotos/53264.jpg'),
(53265, 'Chilli ginger lamb chops', 'Lamb', 'Turkish', 'step 1
Put the garlic in a bowl with the ginger, lemon juice, oil, spices and seasoning. Blitz with a hand blender until smooth, then use to coat the lamb chops on both sides. Leave to marinate in the fridge for a couple of hours or overnight.

step 2
Heat a barbecue until hot. Barbecue the chops over the coals for 3 mins on each side until cooked but still pink and juicy in the centre.', '/static/fotos/53265.jpg'),
(53266, 'Falafel', 'Vegetarian', 'Turkish', 'step 1
Heat 1 tbsp oil in a large pan, then fry the onion and garlic over a low heat for 5 mins until softened. Tip into a large mixing bowl with the chickpeas and spices, then mash together with a fork or potato masher until the chickpeas are totally broken down. Stir in the parsley or dried herbs, with seasoning to taste. Add the egg, then squish the mixture together with your hands.

step 2
Mould the mix into 6 balls, then flatten into patties. Heat the remaining oil in the pan, then fry the falafels on a medium heat for 3 mins on each side, until golden brown and firm. Serve hot or cold with couscous, pitta bread or salad.', '/static/fotos/53266.jpg'),
(53267, 'Aubergine couscous salad', 'Vegetarian', 'Turkish', 'step 1
Heat grill to high. Put the aubergine on a baking sheet, brush with oil and season. Grill for about 15 mins, turning and brushing with more oil halfway, until browned and softened.

step 2
Meanwhile, tip the couscous into a large bowl, pour over the stock, then cover and leave for 10 mins. Mix the tomatoes, mint, goat’s cheese and remaining oil together. Fluff the couscous up with a fork, then stir in the aubergines, tomato mixture and lemon juice.', '/static/fotos/53267.jpg'),
(53268, 'Roasted chicken with creamy walnut sauce', 'Chicken', 'Turkish', 'step 1
Heat oven to 200C/180C fan/gas 6. In a roasting tin, toss together the chicken, cumin, paprika, 1 tbsp olive oil and seasoning. Cook for 40 mins until the chicken is crisp and cooked through.

step 2
Meanwhile, tear up 1 pitta bread and place in a small bowl. Pour over a couple of tbsp chicken stock and leave to soak. Dry-fry the walnuts in a frying pan for about 3 mins until golden and toasted. Set aside. Heat the remaining oil in the pan and cook the onion and garlic until softened. Place the softened pitta bread, onion mixture and most of the nuts into a blender. Pour over the rest of the chicken stock and whizz together until a rough paste forms. Return the mixture to the pan. Add the cream and lemon juice, season and keep warm.

step 3
When the chicken is cooked, arrange on a platter. Stir the coriander through the sauce and spoon into a bowl. Roughly chop the remaining walnuts and scatter over the chicken. Toast the pittas, cut into wedges and serve alongside', '/static/fotos/53268.jpg'),
(53269, 'Hummus', 'Side', 'Turkish', 'step 1
Drain the chickpeas into a sieve set over a bowl or jug to catch the liquid. Tip the chickpeas, tahini, garlic and yogurt into a food processor or blender and whizz to smooth.

step 2
Whizz in a tbsp of the chickpea liquid at a time until you have a nice consistency, then scrape into a bowl.

step 3
Stir in a squeeze of lemon juice and season to taste.', '/static/fotos/53269.jpg'),
(53270, 'Turkish-style lamb', 'Lamb', 'Turkish', 'step 1
Heat grill to high. Season the lamb, then grill for 2 mins on each side until browned, but still very rare. Meanwhile, mix the seasoning, oregano and half of the mint into one of the tubs of yogurt, smother this over the lamb, then return to the grill for another 2-3 mins or until the yogurt is blistered and the meat is cooked to your liking.

step 2
Leave the meat to rest on a board for a few mins while you toast the pittas, shred the lettuce and thinly slice the red onion. Stir the rest of the mint into the second tub of yogurt. Thickly slice the meat and stuff into the pitta bread with the salad and minted yogurt. Squeeze over lemon juice before tucking in, if you like.', '/static/fotos/53270.jpg'),
(53271, 'Walnut, date & honey cake', 'Dessert', 'Turkish', 'step 1
Preheat the oven to 160C/Gas 3/fan oven 140C. Line the base and long sides of a 900g/2lb loaf tin with greaseproof paper, buttering the tin and paper.

step 2
Tip the flour, cinnamon, butter, sugar, 2 tablespoons of the honey and the eggs into a large mixing bowl. Mash the bananas and chop the dates (kitchen scissors are easiest for this) and add to the bowl. Beat the mixture for 2-3 minutes, using a wooden spoon or hand-held mixer, until well blended.

step 3
Spoon into the prepared tin and level the top. Scatter the walnut pieces over. Bake for 1 hour, then lightly press the top – it will feel firm if cooked. If not, bake for a further 10 minutes.

step 4
Cool for 15 minutes, then lift out of the tin using the paper. When cold, drizzle the remaining honey over. Cut into thick slices.', '/static/fotos/53271.jpg'),
(53272, 'Griddled flatbreads', 'Side', 'Turkish', 'step 1
Tip the flours into a food processor. Add the yeast, sugar and 1tsp salt, then mix well. Pour in 350ml warm water and the oil, then process to a soft dough. Mix for 1 min, then leave until doubled in size, about 1 hour.

step 2
Pulse the dough a couple of times just to knock out the air, then tip onto a floured surface. Cut the dough in half and roll out one half to a rectangle about 20 x 40cm. Trim the edges using a large sharp knife, then cut into eight 10cm squares. Line a large tray or two baking sheets with non-stick paper and arrange the bread rectangles over the tray in one layer. Repeat with the other half of the dough. Leave in a warm place for about 30 mins until the dough is just starting to rise.

step 3
Place bread directly onto the BBQ racks and cook for a couple of mins until they puff up, then flip over and cook on the other side. Tip into a basket and serve with the dips.', '/static/fotos/53272.jpg'),
(53273, 'Roast aubergine with goat''s cheese & toasted flatbread', 'Vegetarian', 'Turkish', 'step 1
Heat oven to 200C/180C fan/gas 6. Brush the aubergine slices with 1 tbsp of the oil, then season. Arrange on a baking tray or sheet and roast for 20 mins until browned, popping the tomatoes on the tray for the final 5 mins. Tear the flatbread into pieces and place on a separate baking sheet. Brown in the oven for 8 mins, or until crisp, then remove.

step 2
For the dressing, in a small bowl, mix the vinegar, mint, chopped shallots, chilli, remaining oil and some salt and pepper.

step 3
Scatter the aubergine slices, tomatoes, sliced shallot and crisp flatbread into a serving bowl. Pour over the dressing, sprinkle with the goat’s cheese and scatter over a little rocket.', '/static/fotos/53273.jpg'),
(53274, 'Griddled aubergines with sesame dressing', 'Vegetarian', 'Turkish', 'step 1
Brush each aubergine slice with some oil, then season. Heat a griddle pan or barbecue. When hot, griddle the aubergine slices for 2-3 mins on each side until golden brown and tender.

step 2
Mix the yogurt with the tahini, garlic, lemon juice and herbs, then season. Top the aubergines with the dressing and scatter over extra herb leaves.', '/static/fotos/53274.jpg'),
(53275, 'Sweet potato salad', 'Vegetarian', 'Turkish', 'step 1
Heat oven to 200C/180C fan/gas 6. Toss the sweet potato chunks with the olive oil and some seasoning, and spread on a baking parchment-lined baking sheet. Roast for 30 - 35 mins until tender and golden. Cool at room temperature.

step 2
When just about cool whisk together all the dressing ingredients with a little more seasoning and gently toss through the potato chunks – use your hands to avoid breaking them up.', '/static/fotos/53275.jpg'),
(53276, 'Apricot & Turkish delight mess', 'Dessert', 'Turkish', 'step 1
Place the mascarpone, yogurt, sugar and orange flower water into a large bowl and whisk until thickened. Fold the remaining ingredients through, then divide the mix between 2 dessert glasses or bowls and decorate with extra mint, if you like.', '/static/fotos/53276.jpg'),
(53277, 'Lamb & apricot meatballs', 'Lamb', 'Turkish', 'step 1
Heat 2 tsp oil in a pan and soften the onions for 5 mins. Add the garlic and spices and cook for a few mins more. Spoon half the onion mixture into a bowl and set aside to cool. Add the tomatoes, sugar and seasoning to the remaining onions in the pan and simmer for about 10 mins until reduced.

step 2
Meanwhile, add the mint, lamb, apricots and breadcrumbs to the cooled onions, season and mix well with your hands. Shape into little meatballs.

step 3
Heat the rest of the oil in a non-stick pan and fry the meatballs until golden (in batches if you need to). Stir in the sauce with a splash of water and gently cook everything for a few mins until the meatballs are cooked through. Serve with pitta bread and salad.', '/static/fotos/53277.jpg'),
(53278, 'Aubergine & hummus grills', 'Vegetarian', 'Turkish', 'step 1
Lay the aubergine out in one layer on a large baking sheet. Brush sparingly with vegetable oil, then season generously. Grill for 15 mins, turning twice and brushing with oil until the slices are softened and cooked through. Meanwhile, whizz the bread into crumbs. Add 2 tsp oil and whizz briefly again, to coat.

step 2
Spread a couple of tsps of hummus on top of each slice of aubergine. Tip the breadcrumbs onto a large plate, then press the hummus side of the aubergines into the crumbs to coat. Grill again, crumb-side up, for about 3 mins until golden.

step 3
Toss the walnuts, parsley and cherry tomatoes in a bowl, season, then add the lemon juice and olive oil and toss again. Serve the grills with the salad, a dollop more hummus and some pitta bread.', '/static/fotos/53278.jpg'),
(53279, 'Baklava with spiced nuts, ricotta & chocolate', 'Dessert', 'Turkish', 'step 1
First, make the syrup. Tip the sugar into a large saucepan with 650ml water. Stir over a low heat until the sugar has dissolved, then turn up the heat and bring to the boil. Reduce the heat to a simmer and cook for 15 mins, then squeeze in a few drops of lemon juice and simmer for a further 5 mins. Remove from the heat and leave to cool. Meanwhile, for assembling the baklava later, melt the butter in a small pan over a low heat for 5 mins, skimming and discarding any froth that rises to the surface.

step 2
For the filling, crush all of the nuts in a pestle and mortar, or blitz in a food processor – you want a mixture of finely ground nuts with a few chunky pieces. Tip into a bowl, stir through the spices and set aside.

step 3
In a separate bowl, mix the ricotta with the lemon and orange zests and vanilla. Heat the oven to 180C/160C fan/gas 4. Brush the bottom of a large baking tray (about 35 x 47cm) with some of the melted butter. Working with one sheet of filo at a time (covering the rest with a damp tea towel to prevent it drying out), lay the sheet out on a board so one of the short ends is facing you. Sprinkle 30g of the nut mixture evenly over the whole sheet, then spoon 1 tbsp of the ricotta mixture across the end closest to you. Fold this end over to enclose the filling, then lay a long, thin skewer next to the folded edge and roll the pastry around it to create a long roll. When it’s fully rolled up, it should be roughly the thickness of a chipolata sausage. While holding one end of the rolling pin or skewer, gently scrunch the filo roll like an accordion and carefully push it off the skewer and onto the prepared tray. Repeat with the rest of the filo and fillings – you should get about 12 rolls. Cut each roll into four to make 48 large baklava, or eight to make 96 mini.

step 4
Brush with the remaining melted butter. Bake for 20-25 mins until evenly golden, turning the tray around halfway through. While still hot, immediately pour over 5-6 ladlefuls of the syrup. You should hear the syrup sizzle as it hits the hot baklava. Set aside to cool and absorb.

step 5
Melt the dark chocolate in a heatproof bowl set over a pan of simmering water, ensuring the bowl doesn’t touch the water, or in the microwave in short bursts. Drizzle this over the cooled baklava and sprinkle with the ground pistachios.', '/static/fotos/53279.jpg'),
(53280, 'Poulet Roti a l''Algerienne (Algerian Roast Chicken)', 'Chicken', 'Algerian', 'Preheat oven to 350 degrees F (175 degrees C).

Mix water, onion, olive oil, balsamic vinegar, Dijon mustard, garlic, black pepper, cayenne pepper, and salt together in a roasting dish. Add chicken; turn until well coated with mixture.

Bake in the preheated oven until an instant-read thermometer inserted into the thickest part of the thigh, near the bone, reads 165 degrees F (74 degrees C), about 1 hour 30 minutes.', '/static/fotos/53280.jpg'),
(53281, 'Algerian Kefta (Meatballs)', 'Beef', 'Algerian', 'Combine ground beef with 1/2 of the minced garlic and 1 tablespoon chopped onion in a large bowl. Mix with your hands until fully incorporated. Shape meat mixture into 1 1/2-inch oblong patties; you should have 12 to 14 meatballs.

Heat a large skillet over medium-high heat. Brown patties in batches in the hot skillet until crispy on both sides and no longer pink in the center, about 10 minutes. Set meatballs aside in a rimmed serving dish.

Reduce heat to medium and stir remaining chopped onion into drippings in the skillet. Season with salt and pepper. Cook, stirring constantly, until onion has softened and turned translucent, about 5 minutes. Stir in remaining garlic and cook for 30 seconds. Stir in Roma tomatoes, dried parsley, and ras el hanout. Pour in water. Cook until tomatoes are soft, about 5 minutes.

Pour tomato sauce over meatballs to serve.', '/static/fotos/53281.jpg'),
(53282, 'Algerian Carrots', 'Side', 'Algerian', 'Place a steamer insert into a saucepan, and fill with 1 1/2 cups of water, or just below the bottom of the steamer. Cover, and bring the water to a boil over high heat. Add the sliced carrots, reduce the heat to medium, and cover the pan again. Steam until tender but not mushy, 4 to 6 minutes depending on the thickness of the slices. Reserve 1/2 cup of the cooking liquid.

Heat the olive oil in a skillet over medium heat. Reduce the heat to low and stir in the salt, pepper, cinnamon, cumin, garlic, and thyme. Cook the spices and garlic, stirring frequently, until fragrant, about 10 minutes. Add the 1/2 cup reserved cooking liquid and the bay leaf, cover, and simmer for 20 minutes.

Stir in the carrots, tossing well to coat with the spice mixture, and cook until heated through, about 2 to 3 minutes. Sprinkle with lemon juice and remove the bay leaf before serving.', '/static/fotos/53282.jpg'),
(53283, 'Chtitha Batata (Algerian Potato Stew)', 'Vegetarian', 'Algerian', 'Combine garlic, chile pepper, cumin, paprika, black pepper, cayenne, and salt in a mortar; grind with a pestle until it forms a paste. Add olive oil and mix dersa well.

Heat a large saucepan over medium heat and stir-fry dersa until fragrant, 2 to 4 minutes. Add potato halves and stir to combine with the dersa. Stir in tomato paste. Pour in enough water to just cover the potatoes and bring to a boil. Reduce heat and simmer until potatoes are tender, about 40 minutes.

Ladle potatoes into a serving bowl. Spoon any remaining sauce over the potatoes.', '/static/fotos/53283.jpg'),
(53284, 'Algerian Bouzgene Berber Bread with Roasted Pepper Sauce', 'Side', 'Algerian', 'Preheat your oven''s broiler. Place red bell peppers and tomatoes on a baking sheet, and roast under the broiler for about 8 minutes, turning occasionally. This should blacken the skin and help it peel off more easily. Cool, then scrape the skins off of the tomatoes and peppers, and place them in a large bowl. Remove cores and seeds from the bell peppers.

Heat 1 tablespoon of olive oil in a skillet over medium heat. Add the jalapenos and garlic, and cook until tender, stirring frequently. Remove from heat, and transfer the garlic and jalapeno to the bowl with the tomatoes and red peppers. Using two sharp steak knives (one in each hand), cut up the tomatoes and peppers to a coarse and soupy consistency. Stir, and set sauce aside.

Place the semolina in a large bowl, and stir in salt and 4 tablespoons of olive oil. Gradually add water while mixing and squeezing with your hand until the dough holds together without being sticky or dry, and molds easily with the hand. Divide into 6 pieces and form into balls.

For each round, heat 1 tablespoon of olive oil in a large heavy skillet over medium heat. Roll out dough one round at a time, to no thicker than 1/4 inch. Fry in the hot skillet until dark brown spots appear on the surface, and they are crispy. Remove from the skillet, and wrap in a clean towel while preparing the remaining flat breads.

To eat the bread and sauce, break off pieces of the bread, and scoop them into the sauce. It will slide off, but just keep reaching in!', '/static/fotos/53284.jpg'),
(53285, 'Dziriat (Algerian Almond Tarts)', 'Dessert', 'Algerian', 'Prepare the almonds the day before. Bring 6 cups of water to a boil. Remove from heat, and add the almonds. Let the almonds soak in water for about 5 minutes, then drain and peel. Spread the almonds on baking sheets, and bake at 200 degrees F(95 degrees C) until completely dry and toasted. This takes several hours, and needs to be prepared ahead. Be careful not to burn the nuts, as this will give a bitter taste to the filling.

Combine 1 cup sugar and 1 cup water in a saucepan, and bring to a boil. Add 1 teaspoon lemon juice, reduce heat to low, and let it simmer until syrupy, about 30 to 40 minutes. Stir in orange blossom water, and remove from heat. Set sugar syrup aside.

Combine flour and salt in a large mixing bowl. Make a hole in the center, and pour oil, egg, 1/2 teaspoon lemon juice, and 1 tablespoon orange blossom water into the center. Mix with fingers until the dough resembles coarse crumbs. Gradually sprinkle with warm water while mixing until the dough becomes soft and pliable. Divide into 4 equal portions. Cover dough with a wet cloth, and set aside.

In a food processor, finely grind the almonds. Measure 3 cups of the finely ground almonds into a mixing bowl, and stir together with 1 cup sugar, baking powder, vanilla powder, lemon zest, and 2 tablespoons orange flower water. Mix in three eggs one at a time, stirring constantly; mix until you get a sticky, paste-like mixture.

Sprinkle cornstarch on the rolling surface to prevent sticking. Roll each portion of dough very thinly, 1 to 2 millimeters (1/16 inch). Cut the rolled dough into circles of about 10 centimeters (4 inches) in diameter each. Lightly wipe the surface of each circle with cornstarch, and fit into a tart mold, cornstarch side down to prevent sticking. Gently press the dough onto the sides and bottom of the mold, and trim extra dough from around the rim. Fill three quarters of each mold with the almond filling.

Bake on the top shelf at 350 degrees F (175 degrees C) for 20 to 25 minutes, or until the surface of the tart is golden and the dough is firm. Remove the tarts from the molds as soon as they come out of the oven. Dip each tart in the sugar syrup while still hot. Stick a pine nut into the middle of each tart for decoration. Place on a wire rack to drain.', '/static/fotos/53285.jpg'),
(53286, 'Khobz el Dar (Algerian Semolina Bread)', 'Side', 'Algerian', 'Mix 1/2 cup plus 2 tablespoons semolina, 2 tablespoons sesame seeds, sugar, yeast, and salt together in a large bowl. Whisk in oil, egg, and egg white. Stir in warm milk slowly until a liquid dough forms.

Cover the bowl with a plate or plastic wrap; let stand at room temperature until frothy, about 1 hour.

Stir in 2 3/4 cups flour with a wooden spoon until a sticky dough forms. Cover again and allow to rest for 30 minutes.

Line a baking sheet with parchment paper or a baking mat.

Sprinkle 1 tablespoon flour over the dough and your hands. Mix dough, adding flour as needed, 1 tablespoon at a time, until it pulls away from the sides of the bowl. Shape into a round loaf and place on the prepared baking sheet. Cover loosely with a towel and let rise for 1 hour in a warm place until loaf doubles in volume.

Preheat oven to 400 degrees F (200 degrees C).

Beat egg yolk and water in a bowl with a fork; brush over the entire surface of the loaf. Sprinkle 1 tablespoon sesame seeds on top.

Bake in the preheated oven until loaf is golden brown, about 20 to 25 minutes.', '/static/fotos/53286.jpg'),
(53287, 'Tajine de Poulet aux Carottes et Patates Douces (Chicken and Sweet Potato Tagine)', 'Chicken', 'Algerian', 'Combine onions, celery, cilantro, and parsley in a large pot. Stir in turmeric, cumin, paprika, ginger, cayenne pepper, salt, and pepper. Place chicken thighs on top. Drizzle olive oil over chicken. Cover and simmer over low heat until chicken is tender, about 40 minutes.

Place raisins in a small bowl and cover with hot water; let soak for 10 minutes. Drain.

Preheat oven to 400 degrees F (200 degrees C).

Transfer chicken mixture into an oven-safe tagine or casserole dish. Add sweet potato and carrots. Cover with lid or aluminum foil.

Bake in the preheated oven until sweet potato is soft, about 40 minutes. Add drained raisins and prunes. Continue baking, covered, until raisins and prunes are heated through, about 10 minutes.', '/static/fotos/53287.jpg'),
(53288, 'Algerian Flafla (Bell Pepper Salad)', 'Vegetarian', 'Algerian', 'Preheat an oven to 450 degrees F (230 degrees C). Place the whole peppers on aluminum foil. Bake until the skin is spotted black and the peppers are soft, 30 to 45 minutes, turning the peppers once if necessary.

Remove peppers from the oven and set aside to cool for 10 minutes. Peel off the skin and remove the stem and seeds. Chop the roasted peppers into half-inch pieces.

Heat the olive oil in a skillet over medium heat. Stir in the onion and cook, stirring frequently, until the onion has softened and turned translucent, about 5 minutes. Add the garlic, salt, and pepper; stir in the chopped peppers and tomato. Cook over medium heat, stirring occasionally, until the tomato is soft and the mixture is well incorporated, about 5 minutes.', '/static/fotos/53288.jpg'),
(53289, 'Chorba Hamra bel Frik (Algerian Lamb, Tomato, and Freekeh Soup)', 'Lamb', 'Algerian', 'Place freekeh in a small bowl and cover with cold water. Set aside.

Combine lamb, onion, black pepper, paprika, cinnamon, and salt in a pot. Stir in oil, 1/2 the cilantro, 1/2 the mint, and celery stalk until combined. Simmer over low heat for 15 minutes. Stir in chickpeas; pour in just enough water to cover, and return to a simmer. Stir in zucchini, carrot, and tomato paste.

Set a steamer over the pot; add tomatoes. Cover and steam tomatoes until soft, about 5 minutes. Crush tomatoes using a wooden spoon, so pulp drips into soup. Remove the steamer and discard leftover tomato peels.

Add potato to soup and just enough water to cover. Simmer until potato is soft, about 10 minutes.

Drain freekeh and add to soup. Simmer until soft, about 15 minutes. Remove celery stalk and discard. Sprinkle soup with remaining 1/2 cilantro and remaining 1/2 mint before serving.', '/static/fotos/53289.jpg'),
(53290, 'Cheese Borek', 'Side', 'Algerian', 'In a medium bowl, whisk together egg, parsley, garlic and crushed red pepper. Mix in Gouda and Emmentaler.

One sheet at a time, place phyllo dough on a flat surface and brush with about 1 tablespoon butter. Cut lengthwise into 4 strips. Place a rounded teaspoon of the egg mixture at one end of each strip. Fold corner of strip over the filling, forming a triangular fold. Continue folding the length of the strip in triangular folds to form a small stuffed triangle. Repeat with remaining phyllo dough.

Preheat oven to 350 degrees F (175 degrees C). Lightly butter a large baking sheet.

Arrange stuffed phyllo triangles in a single layer on the prepared baking sheet. Bake in the preheated oven 30 minutes, or until lightly browned. Serve warm', '/static/fotos/53290.jpg'),
(53291, 'Cornes de Gazelle (Gazelle Horns)', 'Dessert', 'Algerian', 'Preheat oven to 300 degrees F (150 degrees C). Line a baking sheet with parchment paper. Spread almonds over the baking sheet.

Bake in the preheated oven until almonds are fragrant and roasted, 20 to 25 minutes.

Prepare pastry dough while almonds are roasting. Combine flour, 1/2 cup plus 1 tablespoon butter, and salt in a bowl and rub together until the mixture resembles breadcrumbs. Add egg, oil, and 1 1/2 tablespoons orange blossom water; knead everything into a smooth pastry dough. Add a little water, 1 teaspoon at a time, if dough is too dry. Shape pastry dough into a ball, wrap in plastic wrap, and set aside for 30 minutes.

Remove almonds from oven and cool slightly, about 5 minutes. Place almonds in the bowl of a food processor; process until finely and evenly ground. Add 3/4 cup plus 1 tablespoon sugar, cinnamon, egg, and 1 tablespoon orange blossom water in that order to the food processor, pulsing after each addition until mixture is evenly combined and resembles a paste.

Remove small walnut-sized portions of filling with greased hands. Roll them into small logs with thin ends. Set aside.

Preheat oven to 325 degrees F (165 degrees C). Line a baking sheet with parchment paper.

Roll out half of the pastry dough on a lightly floured surface until very thin. Place one of the almond paste logs on the edge of the pastry, fold pastry over the filling, covering it completely, and seal the edges. Mold with your fingers into a crescent shape. Using a pastry cutter, cut around the crescent, and transfer to the prepared baking sheet. Repeat with remaining dough and filling.

Bake in the preheated oven until gazelle horns are lightly golden and baked through, about 20 minutes. They should not get too dark. Let cool slightly, about 3 minutes.

Heat honey in a small saucepan over low-medium heat. Remove from heat and stir in 1 tablespoon orange blossom water. Dip gazelle horns into the honey and place on a serving plate. Sprinkle with crushed pistachios.', '/static/fotos/53291.jpg'),
(53292, 'Piernik (Polish gingerbread)', 'Dessert', 'Polish', 'Heat oven to 160C/140C fan/gas 3. Grease and line the base and sides of a deep 20cm cake tin with baking parchment. Put the honey, sugar and butter in a medium saucepan and cook over a medium heat until fully melted. Remove from the heat and allow to cool. Put the flour and spices in a large bowl and mix everything together.

step 2
Once the liquid ingredients have cooled, whisk in the eggs. Pour over the dry ingredients, whisking them together to form a smooth batter – be careful not to overmix as this can lead to a dry cake. Pour into the prepared tin and bake for 50-55 mins or until risen and a skewer inserted into the middle of the cake comes out clean. Allow the cake to cool in the pan for 20 mins before turning out onto a wire rack to cool completely.

step 3
Once cooled, use a large serrated knife to slice the cake into 3 layers. Spread the jam across the 2 bottom cake layers, then reassemble the cake and set aside while you make the glaze. Put the cream, chocolate and honey in a medium pan and cook over a low-medium heat until the chocolate is melted and you have a smooth, pourable mixture. Put the cake on a wire rack set over a parchment-lined baking tray and pour over the glaze, making sure to cover the entire cake. Use a fish slice to carefully transfer the cake to a serving plate and allow the glaze to set. To decorate, dust with a little edible gold powder, if you like. Uniced, this cake will keep for up to 5 days. Once iced, enjoy within 3 days – just keep in the fridge, but remove before serving and eat at room temperature.', '/static/fotos/53292.jpg'),
(53293, 'Pistachio cake', 'Dessert', 'Polish', 'Heat the oven to 180C/160C fan/gas 4. Butter and line a 23cm springform cake tin. Tip 150g of the pistachios into a food processor and blitz until finely ground. Tip into a bowl and mix in the flour, baking powder and pinch of salt. Beat the butter and sugar in a separate bowl until fluffy and pale, around 5 mins. Crack in the eggs one at a time, beating well for 1 min after each addition, until they have all been added. Beat in the vanilla, then fold in the flour mixture gently. Carefully spoon into the prepared tin and bake for 35-40 mins until a skewer inserted into the middle comes out clean. Set aside to cool completely on a wire rack in the tin.

step 2
Meanwhile, sift the icing sugar into a bowl, then tip in the mascarpone, double cream and pistachio paste. Beat until well combined, then set aside in the fridge for 20-30 mins to thicken to a spooning consistency.

step 3
Cut the cooled cake in half horizontally using a serrated knife, so you have two layers. Put the bottom layer on a plate or cake stand and spread over a generous spoonful of the pistachio cream. Top with a generous handful of the raspberries so the cake is covered. Top with the other sponge half, then cover the top and sides of the cake with the remaining cream. Scatter over the last of the raspberries, the remaining pistachios and the lime zest to serve. Will keep chilled in an airtight container for two days.', '/static/fotos/53293.jpg'),
(53294, 'Zapiekanki', 'Pork', 'Polish', 'step 1
Heat the oven to 200C/180C fan/gas 6. Bake the baguettes on a baking tray for 8-10 mins, then leave to cool.

step 2
Heat 2 tsp of the butter and 1 tsp of the oil in a pan over a low heat and cook the chopped onion for 5 mins until soft. Stir in the mushrooms, turn the heat to medium and cook for 5-10 mins more until the veg is soft and the mushroom liquid has evaporated. Stir in the garlic and cook for 1-2 mins until soft. Season, then stir in the mayonnaise and remove from the heat.

step 3
Halve the baguettes lengthways, then return to the baking tray, cut-side up and spread over the mushroom mixture, then sprinkle over the cheddar, ham, kabanos and mozzarella. Bake for 8-10 mins, or until the cheese has melted and turned golden.

step 4
Meanwhile, heat the remaining butter and oil in a pan over a medium heat and fry the sliced onions for 5 mins until golden and soft. Remove from the heat and set aside. Once the pizzas are cooked, top with the caramelised onions, dill pickles (if using), the chives and a zig-zag drizzle of ketchup.', '/static/fotos/53294.jpg'),
(53295, 'Polish chocolate & walnut cake', 'Dessert', 'Polish', 'Heat the oven to 170C/150C fan/gas 3½. Line a 30 x 22cm shallow baking tin with baking parchment. Sift the flour and mix it with cocoa, then set aside. Beat the egg whites until stiff, then add the sugar to them in small batches. Add the egg yolks, one by one, whisking constantly. Tip in the flour mixture and gently fold everything together with a spatula. Pour the prepared batter into the lined tin and bake for 35 mins. Cool for 5 mins, remove from the tin and re-line the tin with baking parchment.

step 2
To make the meringue, whisk the whites until stiff, then gradually whisk in the sugar, one tablespoon at a time. When you have a stiff and shiny meringue, fold in the finely chopped walnuts, flour and startch. Spread the mixture into the re-lined tin and cook for 40 mins on the same heat. Remove from the oven and leave to cool.

step 3
For the chocolate glaze, heat the cream over low heat, then remove from the heat, pour the chopped chocolate into it and mix it until it melts and becomes shiny.

step 4
Cut the cooled chocolate sponge cake and meringue into two layers. Put the nut meringue on top of the bottom layer of sponge and sprinkle on some of the reserved walnuts. Add another layer of meringue and then the upper layer of chocolate sponge cake and cover the top with chocolate glaze. Decorate with walnuts. Put the finished cake in the fridge for 1-2 hrs before serving.', '/static/fotos/53295.jpg'),
(53296, 'Sauerkraut pierogi', 'Vegetarian', 'Polish', 'step 1
First, make the crispy shallots. Heat the oil in a saucepan to 180C (a cube of bread will turn golden in 15 secs). Toss the shallots in a little flour and deep-fry for 1 min or until light golden and crispy. Drain on kitchen paper. Can be made up to two days before and kept in an airtight container.

step 2
To make the filling, heat the oil in a medium non-stick frying pan and gently fry the shallots for 10 mins until starting to turn golden.

step 3
Add the sauerkraut and cabbage, and cook for 5-10 mins until the cabbage has softened. Taste and add a little salt if under-seasoned, or sugar if stringent. Scrape into a bowl and leave to cool completely.

step 4
To make the dough, mix the eggs and oil with 125ml water, then gradually add in the flour, mixing well with your hands. Knead it on a well-floured surface until the dough stops sticking to your hands. You should end up with firm, elastic dough. Wrap it in cling film and rest in the fridge for at least 30 mins, or overnight.

step 5
Flour your work surface generously. Roll out the dough to a 40cm circle or until the dough is as thick as £1 coin.

step 6
Using a 9cm cookie cutter, cut out discs in the dough – you should end up with about 25 discs. Do not throw away the off-cuts – we throw them in with the pierogi when boiling to minimise any waste.

step 7
Have a well-floured tray ready. Put 1 tsp of the filling into the centre of each disc. In your hand, fold in half around the filling and seal to create half-moon shapes. Put them on the floured tray, making sure they don’t touch each other.

step 8
Bring a large saucepan of salted water to the boil and carefully lower the pierogi in. Boil them for 2 mins or until they float to the top.

step 9
Drain and serve with a knob of butter and some soured cream. Finish by sprinkling the crispy shallots on top to serve.', '/static/fotos/53296.jpg'),
(53297, 'Pomegranate salad', 'Vegetarian', 'Polish', 'step 1
Combine the olive oil, lemon juice, honey and thyme leaves in a large bowl. Season well, then tip in the lettuce, tomatoes, spring onions and chilli, and toss to combine.

step 2
Scoop out the pomegranate seeds over a bowl and remove any white membrane. Arrange the dressed salad on a platter, then scatter over the pomegranate seeds and feta.', '/static/fotos/53297.jpg'),
(53298, 'Polish doughnuts (Pączki)', 'Dessert', 'Polish', 'step 1
To make the leaven, mix the yeast with the sugar and flour, and stir in the warm milk. Set aside in a warm place for 30 minutes.

step 2
For the dough, put egg yolks into a heatproof bowl and add the sugar and vanilla sugar. Set the bowl over a pan of simmering water and whisk until smooth and thick.

step 3
Sift the flour into the bowl of a stand mixer, add the beaten yolks and the warm cream, mix thoroughly, then add a pinch of salt and the leaven. Bring together to make a dough and knead for 10 minutes (or 15-20 if doing this by hand).

step 4
When the dough stops sticking to your hands, pour in the cooled melted butter and knead for a few more minutes. Cover with a cloth and leave in a warm place to rise for at least 1 hr-1 hr 30 mins.

step 5
Mix the jam with the ground almonds and spoon into a piping bag or jam syringe. Divide the dough into 16 pieces and shape them into doughnuts. Cover and leave to rise for 30 mins.

step 6
Fill a deep pan or a deep fat fryer one third full of oil or melted lard and heat it until it is 180C – if you don’t have a thermometer, drop in a small chunk of bread. The oil is ready when it browns in about 30 secs. Add the doughnuts and fry, turning them once for about 1-2 mins on each side (a thin lighter ring should form in the middle). After removing, drain the doughnuts of excess fat on some kitchen paper.', '/static/fotos/53298.jpg'),
(53299, 'Polish patties (kotlety)', 'Side', 'Polish', 'step 1
Soak the bread roll in the milk so it softens completely. Meanwhile, fry the onion in the oil for around 8 mins or until soft and golden. Add the fried onion to the beef mince along with the egg, garlic, marjoram and some seasoning. Squeeze the excess milk from the bread roll and add it to the mince mixture. Mix everything together and season well.

step 2
Divide the meat into 8 patties. Tip the dried breadcrumbs into a shallow bowl and coat the patties in it, all over. Heat some oil in a deep frying pan and fry the patties in batches on both sides until browned and cooked through, about 6-7 mins on each side.', '/static/fotos/53299.jpg'),
(53300, 'Bigos (Polish hunter''s stew)', 'Beef', 'Polish', 'step 1
Put the cabbage in a heavy casserole dish, add the stock and cook over a low heat for about 50 mins, until tender.

step 2
Cut the soaked mushrooms into strips and save the soaking water. Heat the lard and fry the sausages and bacon, then scoop out, leaving the fat in the pan. Fry the onion in the same pan for 5-8 mins until lightly browned.

step 3
Add the mushrooms and their liquid along with all the cooked meat, onions and prunes, then cover and cook for 20 mins. Add the spices, red wine and tomato purée and bring to a simmer, then cover and cook for 1 hr. Season well and leave to cool. Will keep covered and chilled for up to two days. Bigos improves in flavour over a couple of days. Leave to cool first. Reheat until piping hot before serving.', '/static/fotos/53300.jpg'),
(53301, 'Pork & sauerkraut goulash', 'Pork', 'Polish', 'step 1
Heat the lard in a saucepan over a medium heat and fry the finely chopped onion until golden, around 5-8 mins. Tip in the cumin and pork, and fry for 10 mins all over until browned. Add the garlic, season well and scatter over the flour. Cook for about a minute, then add the paprika and cook for 1 min more.

step 2
Pour in half of the stock, add the bay leaves, and simmer with the lid on over a low heat for 30 mins.

step 3
Add the sauerkraut, remaining stock and a drizzle of the sauerkraut pickling juices. Simmer with the lid for 30 mins, stirring occasionally, until the meat is tender. Stir in the cream and simmer for 5 mins to combine the flavours. Season to taste, the serve garnished with a spoonful of soured cream.

This recipe has been provided by Apetit Online and not been re-tested by us.', '/static/fotos/53301.jpg'),
(53302, 'Slow-roasted ham with lemon, garlic & sage', 'Pork', 'Polish', 'step 1
Heat the oven to 200C/180C fan/gas 6. Bash the garlic, sage, lemon zest, salt and pepper together using a pestle and mortar until the mixture becomes a paste. Stir in the oil, then spread the mixture over the pork shoulder, avoiding the skin on top. Score the skin using a sharp knife, then rub a large pinch of salt into the skin. Tie the pork together using kitchen string.

step 2
Line a large baking tray with a double layer of foil and put the pork on top, skin-side up. Bring the sides of the foil up around the pork to create a parcel, then pour the wine into the tray around the sides. Transfer to the oven and reduce the temperature to 140C/120C fan/gas 1. Roast for 4-5 hrs, or until a meat thermometer inserted into the thickest part of the pork reads 70C.

step 3
Turn the oven up to 240C/220C fan/gas 9. Carefully spoon the pork roasting juices from the pan into a saucepan and cook over a medium heat for 10-15 mins, or until reduced by a third. Season to taste.

step 4
Meanwhile, arrange the foil around the meat so only the skin is exposed, then return to the oven for 10-15 mins until the skin is puffed up and browned all over. Leave to rest for 20 mins before slicing. Serve with the sauce drizzled over.', '/static/fotos/53302.jpg'),
(53303, 'Raspberry mousse', 'Dessert', 'Polish', 'step 1
Put the gelatine leaves in a bowl, cover with warm water and leave to soak for 5 mins. Drain and squeeze out any excess water.

step 2
Tip the raspberries into a pan over a medium-low heat along with the sugar and lemon juice. Cook for 5-6 mins until the berries have completely broken down. Push the mixture through a sieve set over a bowl, discarding the seeds. Stir in the gelatine leaves until dissolved (if they don’t dissolve, pour the mixture into a clean saucepan and heat gently until dissolved). Set aside to cool for 15 mins.

step 3
Whip the cream to soft peaks using an electric whisk, then gently fold this into the raspberry mixture. Spoon into the ramekins or moulds and chill overnight, or for at least 6 hrs. Serve with raspberries scattered over the top.', '/static/fotos/53303.jpg'),
(53304, 'Mini bundt cakes', 'Dessert', 'Polish', 'step 1
Heat the oven to 180C/160C fan/gas 4. Melt 25g butter and generously brush into the holes of a mini bundt tins. Tip a little flour into each hole and shake to coat, then tip out the excess. Beat the butter, caster sugar and a pinch of salt together using an electric whisk. Add the eggs, one at a time, beating well after each addition. Combine the flour and baking powder in a separate bowl, then sift this into the wet ingredients and stir until smooth. Combine the cocoa powder and milk in a small bowl until smooth.

step 2
Spoon 1 tbsp of the plain batter into each hole of the bundt tin. Mix the remaining plain batter with the cocoa powder mixture, then divide this between the holes. Bake for 15-18 mins, or until a skewer inserted into the cakes comes out clean. Leave to cool in the tin for 5 mins, then turn out onto a wire rack and leave to cool completely. Dust with icing sugar to serve.

step 3
Pour 1 tablespoon of light batter into each mold. Mix the remaining batter with the stirred cocoa mixture and then fill the molds with a tablespoon.

step 4
Bake the mini Bundt cakes in the preheated oven for 15-18 minutes , depending on the size of the molds. After 15 minutes of baking time, use a toothpick to test with a skewer and, if necessary, bake for another 3 minutes. Let the mini Bundt cakes cool down completely in the tin. Then carefully remove from the mold. Dust with some icing sugar and serve. Enjoy your meal!', '/static/fotos/53304.jpg'),
(53305, 'Braised stuffed cabbage', 'Vegetarian', 'Polish', 'step 1
Heat oven to 180C/fan 160C/gas 4. Remove the tough central stalk from the cabbage leaves. Bring a large pan of salted water to the boil, add the cabbage, then cook for just 1-2 mins until the leaves are starting to wilt. Drain and refresh under cold running water. Drain well, then pat dry with a tea towel.

step 2
Heat the oil in a pan, add the onion, then fry for 5 mins until slightly browned. Add the rosemary and celery, then cook for 8 mins more. Stir in the rice, then cook for a min or so until the grains are glistening. Remove from the heat, stir in the chestnuts and cranberries, then season.

step 3
Spoon a little stuffing onto a cabbage leaf, roll up and fold in the sides to enclose the filling. Put in a single layer in a large, oiled, shallow ovenproof dish with the join underneath. Fill the remaining leaves in the same way. Mix the stock, vinegar and honey, then pour over the cabbage. Cover the dish tightly with foil, bake for 1 hr, uncover, then cook for a further 15 mins.', '/static/fotos/53305.jpg'),
(53306, 'Pork rib bortsch', 'Pork', 'Polish', 'step 1
Cut the meat into large pieces, put in your largest saucepan and cover with 5 litres water. Bring to the boil over a high heat, skimming away any foam that rises to the surface. Add the bay leaves. Season. Turn the heat down to a simmer and cook for 1 hr, or until the meat is soft and falls off the bone. Add the beans if using dried.

step 2
Turn the heat up. Bring back to the boil, then reduce the heat and simmer for another 20 mins – the beans should still be slightly raw. Add the carrots, onions, garlic and pepper. Stir well, then add the chillies, if using. Cook for 15 mins more.

step 3
Stir in the beetroot and cook for 10 mins before adding the potatoes. After 15 mins, add the tomato purée to taste and beans, if using canned, and bring to the boil. Cook for 5 mins, add the cabbage and cook for 5 mins more. Season, then garnish with the parsley and dill. Turn off the heat and leave to stand for 5 mins. Serve with soured cream on the side.', '/static/fotos/53306.jpg'),
(53307, 'Beetroot & red cabbage sauerkraut', 'Vegetarian', 'Polish', 'step 1
Tip all the ingredients into a large bowl, add 1-1½ tsp freshly ground black pepper, then scrunch it all together with your hands for 5 mins. You might want to wear gloves to avoid staining your skin with the beetroot juices.

step 2
Press the veg down in the bowl with your hands, then cover the surface and up the side of the bowl with a large sheet of compostable cling film or something reusable like a beeswax wrap. Now place another similar-sized bowl on top. Press down hard and add anything heavy (packs of rice or cans work well) to weigh it down so the juices rise to cover the surface. Cover again.

step 3
Leave to ferment at room temperature for at least five days, but for maximum flavour, leave for one-five weeks (until the bubbling subsides).

step 4
Check the sauerkraut. After a few days, you will see bubbles that have built up as it ferments. Give it a stir, then cover and weigh it down again as before. The cabbage will become increasingly sour the longer it’s fermented, so taste it now and again. When you like the flavour, transfer it to sterilised jars and keep chilled. Will keep chilled for up to six months.', '/static/fotos/53307.jpg'),
(53308, 'Rye bread', 'Side', 'Polish', 'step 1
Tip the flours, yeast and salt into a bowl. In a jug, mix the honey with 250ml warm water, pour the liquid into the bowl and mix to form a dough. Rye flour can be quite dry and absorbs lots of water, if the dough looks too dry add more warm water until you have a soft dough Tip out onto your work surface and knead for 10 mins until smooth. Rye contains less gluten than white flour so the dough will not feel as springy as a conventional white loaf.

step 2
Place the dough in a well oiled bowl, cover with cling film and leave to rise in a warm place for 1-2 hrs, or until roughly doubled in size. Dust a 2lb/900g loaf tin with flour.

step 3
Tip the dough back onto your work surface and knead briefly to knock out any air bubbles. If using caraway seeds work these in to the dough. Shape into a smooth oval loaf and pop into your tin. Cover the tin with oiled cling film and leave to rise somewhere warm for a further 1 – 1.5 hr, or until doubled in size.

step 4
Heat oven to 220C/200C fan/gas 7. Remove the cling film and dust the surface of the loaf with rye flour. Slash a few incisions on an angle then bake for 30 mins until dark brown and hollow sounding when tapped. Transfer to a wire cooling rack and leave to cool for at least 20 mins before serving', '/static/fotos/53308.jpg'),
(53309, 'Cucumber & fennel salad', 'Vegetarian', 'Polish', 'step 1
Put cucumber in a sieve. Sprinkle with 1 tsp salt and the sugar, then leave for 10 mins. Add fennel.

step 2
Mix soured cream, lemon juice, vinegar and dill, then season with black pepper and add to fennel mix.', '/static/fotos/53309.jpg'),
(53310, 'Challah', 'Side', 'Polish', 'step 1
Combine the yeast, a pinch of the sugar and a couple tablespoons of lukewarm water in a small bowl. Stir to dissolve the yeast, then leave for 10 mins until foamy.

step 2
Meanwhile, combine the flour, the remaining sugar and 2 tsp fine salt in a large bowl. Make a well in the centre, then add half the beaten egg, the yeast mixture and the oil. Pour in 200ml lukewarm water (it should feel slightly warm to the touch) and stir with a spoon, then mix using one hand, keeping the other clean while you bring the dough together. If there are a lot of very dry bits, gradually add a little water to just bring it together – you don''t want it to get too wet and sticky. The dough should be moist, but not soggy.

step 3
Once the dough has come together, turn it out onto a lightly floured surface. Knead using both hands for 10 mins until smooth and a bit springy. If it gets very sticky, add a very small amount of flour – as little as possible. A dough scraper is useful if the dough is sticking to the work surface. Stretch the sides of the dough down and pull together to form a ball. Lightly oil a bowl, then lightly roll the dough ball around the bowl so it''s coated in the oil. Cover with a clean tea towel and leave in a warm place for 1 hr, or until dough has doubled in size.

step 4
Line a baking sheet with baking parchment. Turn the dough out onto a clean work surface and divide into three equal pieces, weighing for accuracy, if you like. Roll each piece into a long sausage shape about 25cm long, tapering them slightly at both ends. Lay the pieces out in front of you, parallel to one another with a couple centimetres between each. Bring the sausages together at the top end, then plait them down the length, tucking in the ends when you reach the bottom. Carefully transfer the loaf to the prepared baking sheet and loosely cover with a clean tea towel. Leave to rise until puffy and billowy, about 40 mins.

step 5
Meanwhile, heat the oven to 200C/180C fan/gas 6. Gently brush the rest of the beaten egg all over the challah, getting it into all the crevices, and sprinkle with the poppy or sesame seeds, if using. Bake on a middle shelf of the oven for 25-30 mins, until the loaf is golden brown underneath and sounds hollow when tapped. Check after about 15 mins – if the top of the loaf has started to get too dark, cover it with foil. Leave to cool on a wire rack, then serve.', '/static/fotos/53310.jpg'),
(53311, 'Borsch', 'Beef', 'Ukrainian', 'step 1
To make the stock, put the meat, whole onion, bay leaf and 2 litres of lightly salted cold water in a large saucepan. Cook over a very low heat for 1 hr 30 mins or until the beef shin is soft and falls apart easily – this can take up to 3 hrs. Skim off the scum with a spoon from time to time. Break up any larger pieces of beef into the broth, remove the whole onion and discard.

step 2
Add the potatoes to the borscht, season well with salt and pepper and cook for 10-15 mins until tender. Meanwhile, heat the sunflower oil in a large, deep frying pan. Add the diced onion and carrot, and cook over a medium heat, stirring, until the carrot is soft and is about to start caramelising.

step 3
Add the beetroot and cook for around 5 mins, stirring occasionally. Add the red pepper, if using, and cook for another 2 mins, then add the tomatoes and prunes, stir, then increase the heat and boil to reduce slightly, before adding everything to the borscht.

step 4
Add the shredded cabbage and the kidney beans, and cook for 7-10 mins or until tender. Serve with a dollop of sour cream or crème fraîche, lots of chopped dill and some crusty bread.', '/static/fotos/53311.jpg'),
(53312, 'Tangy cabbage slaw', 'Vegetarian', 'Ukrainian', 'step 1
Whisk together mayonnaise, lemon zest and juice, vinegar, mustard and celery salt in a small bowl, then season generously.

step 2
Add cabbage, carrots, onion and celery. Mix well and refrigerate. Can be made up to 1 day ahead.', '/static/fotos/53312.jpg'),
(53313, 'Beetroot latkes', 'Vegetarian', 'Ukrainian', 'step 1
Heat the oven to 180C/160C fan/gas 4. Make the latkes by combining all of the ingredients.

step 2
Heat the oil in a large non-stick pan. Spoon in the mixture to make six round latkes. Fry for 4-5 mins on each side, then transfer to a baking sheet and bake for 10 mins.

step 3
Combine the yogurt and mint in a small bowl. Toss the salad leaves and tomatoes together, then serve the latkes with the mint yogurt and salad.', '/static/fotos/53313.jpg'),
(53314, 'Sauerkraut pierogii', 'Vegetarian', 'Ukrainian', 'step 1
First, make the crispy shallots. Heat the oil in a saucepan to 180C (a cube of bread will turn golden in 15 secs). Toss the shallots in a little flour and deep-fry for 1 min or until light golden and crispy. Drain on kitchen paper. Can be made up to two days before and kept in an airtight container.

step 2
To make the filling, heat the oil in a medium non-stick frying pan and gently fry the shallots for 10 mins until starting to turn golden.

step 3
Add the sauerkraut and cabbage, and cook for 5-10 mins until the cabbage has softened. Taste and add a little salt if under-seasoned, or sugar if stringent. Scrape into a bowl and leave to cool completely.

step 4
To make the dough, mix the eggs and oil with 125ml water, then gradually add in the flour, mixing well with your hands. Knead it on a well-floured surface until the dough stops sticking to your hands. You should end up with firm, elastic dough. Wrap it in cling film and rest in the fridge for at least 30 mins, or overnight.

step 5
Flour your work surface generously. Roll out the dough to a 40cm circle or until the dough is as thick as £1 coin.

step 6
Using a 9cm cookie cutter, cut out discs in the dough – you should end up with about 25 discs. Do not throw away the off-cuts – we throw them in with the pierogi when boiling to minimise any waste.

step 7
Have a well-floured tray ready. Put 1 tsp of the filling into the centre of each disc. In your hand, fold in half around the filling and seal to create half-moon shapes. Put them on the floured tray, making sure they don’t touch each other.

step 8
Bring a large saucepan of salted water to the boil and carefully lower the pierogi in. Boil them for 2 mins or until they float to the top.

step 9
Drain and serve with a knob of butter and some soured cream. Finish by sprinkling the crispy shallots on top to serve.', '/static/fotos/53314.jpg'),
(53315, 'Rosemary braised red cabbage with kabanos', 'Pork', 'Ukrainian', 'step 1
Halve the cabbage, remove the tough stem and thinly slice. Place in a large pan with all the other ingredients apart from the sausages, then mix in 300ml water and some salt and pepper.

step 2
Bring to a simmer, then reduce the heat, cover with a well-fitting lid and gently cook for 1½ hrs, stirring frequently. If too dry, you can add a little more water.

step 3
Add the kabanos to the cabbage mixture, place a lid on the pan and gently simmer for 20 mins. Remove the lid and cook for a further 10 mins. Serve alongside some simple mash or boiled potatoes.', '/static/fotos/53315.jpg'),
(53316, 'Beetroot pancakes', 'Dessert', 'Ukrainian', 'step 1
Put the beetroot in a jug with the milk and blend with a stick blender until smooth. Pour into a bowl with the rest of the pancake ingredients and whisk until smooth and vibrant purple.

step 2
Put a small knob of butter in a large non-stick frying pan and heat over a medium-low heat until melted and foamy. Now create 3 or 4 pancakes each made from 2 tbsp of the batter. Cook for 2-3 mins then flip over and cook for a further minute until cooked through. Repeat with any remaining batter. Heat oven to lowest setting and keep the pancakes warm in there until needed.

step 3
Serve with your favourite pancake toppings or make a simple compote by simmering frozen berries in with 1 tbsp blackcurrant jam until bubbling and syrupy (about 5-10 mins). In a small bowl stir together the remaining jam and the yogurt. Stack the cooked pancakes with the yogurt and pour the warm berry compote over the top.', '/static/fotos/53316.jpg'),
(53317, 'Beef Empanadas', 'Beef', 'Uruguayan', 'For the dough place lard, warm water and salt in a large kneading bowl and stir. Add flour and oregano and either knead five miutes by hand or with the kneading function of your machine. Let rest covered for at least half an hour or overnight in the fridge.

2
For the filling place tomatoes for about 30 seconds in boiling water, then cool with cold water and peel of skin and cut into cubes. Press garlic through garlic press, cut onions into cubes. Simmer garlic and onions in some olive oil until translucent. Take out onions and garlic and brown the meat at high heat from all sides. Season with all herbs and add the onions, garlic and tomatoes. Let simmer for a few minutes, add salt, pepper and additional spices to taste. You can prepare the meat the night before, chill in fridge if doing so. Boil eggs and also cut into cubes and mix with prepared meat.

3
Cut dough into half and roll out one half thinnly on floured surface. Cut out circles about 12-15cm in diameter. Mine have a diameter of 12.5 cm. Place about 2-4 teaspoons of filling on one circle, put a bit of water all around the edges and fold over the other half so that you get half moons. Be sure to seal the edges with a fork. Repeat until you have no dough and filling left.

4
Meanwhile preheat oven to 200 degrees Celsius. Brush empanadas with egg wash and bake about 8 empanadas on a baking sheet lined with parchment paper for about 25min or until golden. Serve warm with chimichurri sauce.', '/static/fotos/53317.jpg'),
(53318, 'Torta de fiambre', 'Pork', 'Uruguayan', 'Line the bottom of a springform of 20-2cm (8-9inches) with parchment paper, I usually leave some overhang as the batter is very liquid and may spill a bit. Preheat oven to 220 degrees Celsius.

2
Grate the cheese and take out the ham.

3
Mix all remaining ingredients in a large bowl for about one to two minutes.

4
Pour half the batter into the prepared pan, it is going to be very liquid. Then place ham and cheese on top and pour the remaining batter on top.

5
Bake for about 20-25 minutes or until top is golden. Wait for a few minutes before releasing from the pan and enjoy either hot or cold with some fresh herbs.', '/static/fotos/53318.jpg'),
(53319, 'Chivito sandwich', 'Beef', 'Uruguayan', 'For the brioche buns heat the milk with the butter and molasses until the butter has melted. Add the cold water and egg to this mix.

2
In a large bowl place flour, salt and yeast and mix. Then add the milk and water mix and stir with a wooden spoon until combined. You don''t have to knead the dough, it is perfectly fine to do this by hand with a wooden spoon, this doesn''t need to be very thorough. Cover with a damp towel and stick in the fridge overnight.

3
The next morning knead dough on a generously floured surface for a little and cut into eight equal pieces. Shape these into balls and place on a baking sheet lined with parchment paper. Cover again with damp towel and let rise for about an hour or until double in size.

4
Heat oven to 220 degrees Celsius. Brush the buns with either milk, heavy cream or egg wash and sprinkle with sesame seeds, if desired. Bake for about 15-20min or until golden. Let cool.

5
For the toppings chop the onions and sauté in a bit of butter, let caramelize, this may take ten to 15 minutes, stir occasionally. Rub the steaks with a bit of garlic and then grill or fry the steaks, the bacon, and eggs with salt and pepper, toast the buns after having cut in half. Spread mustard on one bun half, layer each chivito with steak, a slice of ham, a slice of cheese, one bacon stripe, a tomato slice, and some lettuce. Place fried egg on top and sprinkle generously with chimichurri and some onions right before serving.', '/static/fotos/53319.jpg'),
(53320, 'Chocolate alfajores', 'Dessert', 'Uruguayan', 'For the cookies cream the butter with the sugar for a few minutes. Then add the egg and honey and mix well. Add flour, cornstarch, cocoa, baking soda and baking powder and mix until you get a dough. Wrap in plastic wrap and chill for at least half an hour or overnight.

2
Line two baking sheets with parchment paper, preheat oven to 200 degrees Celsius.

3
Divide dough into two parts, put one part back in the fridge before using. Roll out second part to about 2 millimeters and cut out round cookies with 5-6 centimeters in diameter. This can be done with a cookie cutter or glass. You should get 30 cookies in total or even more, I get about 40. Bake one baking sheet at the time for about 8-10min. Let cookies cool.

4
For the filling look for two cookies of the same size and place about one teaspoon of dulce de leche onto the bottom one before sandwiching together.

5
Chop semi-sweet chocolate and melt with butter and orange zest on low heat. Dunk each sandwich cookie into the chocolate and let cool off on parchment paper before serving.', '/static/fotos/53320.jpg'),
(53321, 'Vanilla alfajores', 'Dessert', 'Uruguayan', 'For the sandwich cookie cream the soft butter for about a minute, then add the sugar and cream for another two minutes. Incorporate the egg fully before mixing in the egg yolk. Once everything is nicely combined, add all remaining ingredients and mix one more time. Form dough into a ball and wrap in plastic wrap. Chill for at least half an hour or overnight.

2
Preheat oven to 180 degrees Celsius and line two baking sheets with parchment paper.

3
Divide dough in half, put one back in the fridge and roll out the other thickly on a lightly floured surface. Cut out cookies with either the bottom of a glass or a cookie cutter around 6cm in diameter. Repeat with all the dough.

4
Bake for about 8-10min, the cookies will look very pale. Let cool off before filling half with each a teaspoon of dulce de leche. Place other half of cookies on top and roll the sides of each cookie in the coconut flakes (it helps if the dulce de leche was pressed down to the sides of the cookie). Enjoy.', '/static/fotos/53321.jpg'),
(53322, 'Flan', 'Dessert', 'Uruguayan', 'For the caramel place 100 grams of sugar in a frying pan without any fat and melt on medium heat. Try not to stir with a spoon, but swirl the pan itself. Let melt until you have an amber color and sugar is fully melted. Fill the bottom of four flan containers with it. Caramel will harden immediately, so you need to be fast. My containers yield about 120 milliliters each.

2
Preheat oven to 150 degrees Celsius and look for a casserole or container all your four flan containers fit into.

3
Heat milk with 45 grams of sugar and the cut and scraped out vanilla pod. The milk does not need to boil, just needs to be heated. Take out vanilla pod after a few minutes. Meanwhile stir the egg yolks and eggs gently, try not to incorporate any air in it. Them pour milk-mix into egg-mix and again only stir very gently. Pour into prepared flan containers and place these into your casserole or container. Boil water and pour the water into the large casserole. Be sure not to touch the flan mixture. Place on middle rack in the oven and let bake for about 35-40 minutes. An inserted toothpick should come out clean.

4
Let cool inside the container for an hour before transferring to the fridge. Chill overnight. The next day gently release the rim and then turn upside down on a plate. Serve with some dulce de leche on the side.', '/static/fotos/53322.jpg'),
(53323, 'Postre Chajá', 'Dessert', 'Uruguayan', 'For the sponge cake preheat oven to 180 degrees Celsius and prepare either one or two 20cm/8 inch cake pan(s). Line bottom with parchment paper. Then divide the eggs into egg white and egg yolks. Use a bigger bowl for the egg yolks. If you have a glass or metal bowl, use that one for the egg whites. Be sure that bowl is free of fat/grease and that your mixer was properly cleaned. First beat the egg whites on medium speed with a pinch of salt until soft peaks form. Set aside. Without cleaning our mixer, beat the egg yolks with the sugar. Beat until the color becomes much paler and you have a creamy consistency. This usually takes several minutes.

2
Gently pour one third of the egg whites on top of the mixed egg yolks and sift the flour and cornstarch on top. Don''t skip this step. It is important that the flour mix was sifted. Gently mix all ingredients with a spatula. Try to incorperate the flour mix and egg whites without losing volume. Add the last two thirds of beaten egg whites and gently fold the mixture. Don''t overmix. Put batter into the prepared cake pans and immediately bake. Don''t let the batter sit for too long as it will quickly lose volume. Bake for 35 minutes if using one springform or 25 minutes if using two. Let cool a little before gently getting them out of the form. Tip: if making the day before, wrap in cling wrap, it is much easier to cut in half once cold.

3
For the meringue beat egg white until soft peaks form, add pinch of salt and continue beating on high while adding the sugar. Beat for at least three more minutes until glossy and shiny. Pipe small stars or other shapes with the meringue on a baking sheet lined with parchment paper. Dry for about 45min at 100 degrees Celsius in the oven. Keep in airtight container until further use.

4
For the filling beat heavy cream, vanilla extract and sugar until stiff peaks form, slice peaches in thin slices. Cut cake in four layers, this is much easier done once the cake layers are cold. Brush cake layer with some of the peach juice left, then pipe thin layer of whipped cream around the edges, place the peach slices in the middle on first layer on cake, on the second layer only spread the dulce de leche. Repeat layer with brushed peach juice, whipped cream and peaches for the third and final layer. Be sure to reserve enough peach slices for the top. Spread thin layer of whipped cream on the sides of the cake and pipe on some roses around the edges if desired. Heat the peach juice and mix the cornstarch with a bit of water until you see no lumps. Once juice is hot, add the cornstarch and stir until glaze thickenes. Pour over peaches of the top layer cake. Crush the meringue and pat around the sides. Serve immediately.

', '/static/fotos/53323.jpg'),
(53324, 'Chocolate empanadas', 'Dessert', 'Uruguayan', 'For the filling place the can in a large pot and cover completely with water. Boil for two and a half hours, occassionally adding water. Let cool before opening. For further tips, please check here.

2
For the dough combine the flour, cocoa powder, and salt in a large bowl. Add the cold butter in small pieces and rub into crumbs with your fingers Add the egg and work into a dough. You may have to add milk, a tablespoon at a time if it still is to dry. Wrap and chill for at least half an hour or overnight.

3
Line a baking sheeet with parchment paper and preheat the oven to 180 degrees Celsius.

4
Roll out the dough on a lightly floured surface, it should be thin. Cut out circles of 12cm either with a cookie cutter or with a smaller plate/dish. Put two to three teaspoons of the dulce de leche in the middle of each circle. Brush the edges with milk, I do this with my pinkie. Fold each circle in half so that you have a half moon and press down the edges with a fork. You can also turn the edges about half a centimeter inwards every centimeter or so to create a pattern.

5
Place the prepared empanadas on the baking sheet and brush with egg wash. Bake for about 20-25min.

6
Towards the end of the baking time, melt the remaining butter and mix the sugar and cinnamon in a small bowl. Once you take the empanadas out, immediately brush with the butter and sprinkle with the sugar mix. Empanadas can be enjoyed either still warm or cold. If eating warm, be careful not to burn yourself with hot filling!', '/static/fotos/53324.jpg'),
(53325, 'Venezuelan Arepas', 'Side', 'Venezuela', 'Preheat oven to 410° F.
Pour the water into a large bowl. Make sure it is room temperature.
Add the salt. Blend well with a mixer, fork or spatula to make sure it dissolves well.
While you continue to beat the mixture, slowly add the corn meal—a little bit at a time.
Once all the flour is added, keep mixing until the corn meal, water and salt are thoroughly blended and dissolved.
Set aside the masa in its bowl. Let it rest for 5 minutes so that the flour is thoroughly hydrated. This type of corn flour does not have any gluten, so it doesn’t need to be kneaded. The masa should be smooth, firm yet malleable.
While waiting for the 5 minutes’ rest, heat your budare (or comal, griddle, cast-iron pan or non-stick pan) over medium heat. Coat with a little bit of the oil.
Fill a small bowl with water to wet your hands to make the arepas.
Take about 2 Tbsp of the masa in your damp hands. The masa should fit easily in your palm so that it is easy to shape into a small ball.

Cross your hands, so that one is on top of the other, with the masa ball between them. Rotate your right hand in a circle, so that you are at the same time both pressing the masa into a flat disc and keeping its round shape.
arepa making
The last step in shaping your arepa is to quickly pass and lightly press the masa disc from one hand to the other until it is about ¾ of an inch thick and 4 inches wide. Smooth the edges with your fingertips (quickly dip them into the water bowl first) so that they stay as round as possible and without cracks.
arepa making
Place your arepas in batches on the preheated surface of your budare griddle or nonstick pan. Let each side turn golden, about 4 to 5 minutes per side. Check them often so that they don’t burn.
Once they are nicely browned on both sides, place the arepas on a baking sheet in your preheated oven for 10 minutes. They should be somewhat puffy, so that if you tap an arepa lightly on top, it will sound like you are tapping an empty box.
Serve arepas hot, whether you stuff with them with your choice of fillings or serve solo to accompany your favorite Venezuelan guiso or stew.', '/static/fotos/53325.jpg'),
(53326, 'Venezuelan Sancocho', 'Beef', 'Venezuela', 'Add hind shank, 1 halved small onion, halved bell pepper, 4 whole garlic cloves, the dark green leaves of the leek, and stock to a large stockpot. Cook for 45-60 minutes until the meat is fork-tender. NOTE: the meat can take a bit longer to be fork-tender; that is okay, just add more cooking time if necessary.
When the meat is tender, remove the big pieces of vegetables and bones. Discard.
Add diced onion, 2 minced garlic, mini sweet peppers, sliced leeks (light green part), scallions, yucca, and corn; Mix and simmer covered over medium heat for 5- 8 minutes, until the yucca is starting to soften. NOTE: the yuca can take a bit longer to start softening; that is okay, just add more cooking time if necessary.
Add yautia, white yam, and butternut squash. Mix to combine. Simmer covered over medium heat for 5 – 6 minutes, until all the root vegetables are tender. NOTE: Do not cook too much, or they will fall apart.
Taste and add salt to your taste, if necessary. Add cilantro and the remaining 2 minced garlic cloves. Mix and let simmer for 2 more minutes.
Serve hot in large soup bowls, dividing the meat and vegetables evenly. Add a squish of lime juice and/or hot sauce, if desired. Serve along with arepas and or casabe (cassava bread).', '/static/fotos/53326.jpg'),
(53327, 'Venezuelan Coconut Chicken', 'Chicken', 'Venezuela', 'Cut the chicken up into bite size pieces. Peel and cut the onions, mince the garlic.
Assemble the rest of the ingredients and you are ready to start cooking.
Make the Dish
Heat up a fry pan over medium heat. Add the oil and when hot, sauté the onion until translucent. Remove from pan and transfer to a blender or food processor.
Add tomatoes, garlic, turmeric, cumin, sugar, ginger paste, coconut milk, water and blend smooth.
In the same pan you cooked the onion, add the chicken and brown all sides. This should take about 3 minutes.
Add the blender ingredients and bay leaves to the pan, bring to a simmer and cook until the chicken is white inside and the liquid is creamy. (15 to 20 minutes)
Remove the bay leaves and serve with white rice.', '/static/fotos/53327.jpg'),
(53328, 'Venezuelan Shredded Beef', 'Beef', 'Venezuela', 'Season beef with salt, pepper and minced garlic
Chop 1 onion in 4 big wedges
Place in the beef pressure cooker with the 4 wedges of onion and the stock
Pressure cook for 20 minutes
Release the pressure and open the lid
Remove the beef and SAVE 2 cups of stock in another container
With 2 forks, shred the beef. Beef should be tender enough to so easily. If not, cook for another 10 minutes
Press the saute button of the Instant pot. Add the olive oil
When the machine beeps, add the sliced onion, pepper and tomatoes. Cook until tender
Add the shredded beef back in the pot and mix
Pour in 1 1/2 cups of the saved stock, the Worcestershire sauce, tomato paste, ketchup and cumin. Mix
If sauce seems to dry, add a tad more of stock
Season with salt and pepper
Serve!', '/static/fotos/53328.jpg'),
(53329, 'Arepa pelua', 'Beef', 'Venezuela', 'Cook the meat: Place the flank steak in a pot with broth or water and salt. Cook over low heat for about 2 hours, until tender and easy to shred.
Shred the meat: Once cooked, drain and shred the meat using two forks.
Prepare the vegetables: Sauté chopped onion, bell pepper, and garlic in a little oil. Add cumin, oregano, paprika, and salt. Stir in the meat and cook for a few minutes until the flavors are well combined.
Make the dough: In a bowl, mix the cornmeal with warm water and salt until a soft dough forms. Let it rest for 5 minutes.
Form the arepas: Divide the dough into 6 portions, shape into balls, and flatten into thick discs.
Cook: Cook the arepas on a griddle or skillet over medium heat for 2–3 minutes on each side until golden. You can then bake them for a few minutes if you prefer them crispier.
Fill: Slice the arepas open on one side, fill with the hot shredded beef, and top with grated cheese.', '/static/fotos/53329.jpg'),
(53330, 'Cassava pizza', 'Pork', 'Venezuela', 'Preheat the oven to 200ºC.
Cut the bacon or chorizo into medium pieces and the paprika into strips.
Spread a little tomato sauce and mozzarella cheese on each portion of cassava.
Add the bacon or chorizo, corn, turkey ham, some olives and paprika.
Bake for 7 to 10 minutes.
Remove from the oven and enjoy.', '/static/fotos/53330.jpg'),
(53331, 'Oatmeal pancakes', 'Breakfast', 'Venezuela', 'Place all the ingredients in the glass and beat.
Let the mixture stand for 10 minutes.
Grease a hot frying pan with a little butter and pour a little of the mixture.
When it starts to bubble on the surface, turn over with a spatula. Cook over medium-low heat so that they do not burn.
Finally, add the caramel and strawberries.', '/static/fotos/53331.jpg'),
(53332, 'Venezuelan turnovers', 'Side', 'Venezuela', 'Season meat with Adobo. In skillet, heat oil on medium high. Cook meat until pink is gone. Stir in onion, pepper, garlic, alcaparras, tomato sauce and Sazón. Cook, stirring often until most of the liquid has evaporated (about 20 minutes). Cool.
Prepared dough should be moist and should hold together, but it should not stick to your fingers. Start with about ½ cup of dough and roll into a ball between palms of your hands. Working on a sheet of non-stick parchment paper, form the ball into a 5-inch circle about ⅛ inch thick. Place a generous tbsp. of filling on one half of circle and using parchment paper close dough over to form a semi-circle. To seal and trim edges of the empanada, press lip of inverted bowl over semi-circle shaped patty. Repeat for all the Empanadas.
In large skillet on medium high, heat ½ inch of oil until hot but not smoking. Cook empanadas in batches, turning once or twice until lightly browned. Drain on paper towel. Do not over crowd skillet or let oil get too hot.', '/static/fotos/53332.jpg'),
(53333, 'Passion fruit mousse', 'Dessert', 'Venezuela', 'Add gelatin and ¼ cup room-temperature water to small bowl; let sit until gelatin softens, about 5 minutes. In medium saucepan over medium-high heat, stir together passion fruit pulp, sugar and gelatin mixture. Cook, stirring occasionally, until mixture is thoroughly combined and smooth (mixture should not come to a boil). Remove from heat; cool completely. Stir in condensed milk.
Meanwhile, in clean mixing bowl, using electric mixer, beat egg whites until stiff (peaks of egg whites will not droop, and egg whites will not move when bowl is tilted).
Stir 1/3 egg whites into cooled passion fruit mixture until combined. Using spatula, gently fold in remaining egg whites until combined. Divide mousse evenly among clear glass serving cups; cover. Refrigerate mousse until well chilled, at least 2 hrs.
Serve chilled. Garnish with mint, if desired.', '/static/fotos/53333.jpg'),
(53334, 'Arepa Pabellón', 'Beef', 'Venezuela', 'Prepare the meat in a skillet and add salt and pepper to taste, heat the beans over medium heat in a pan, fry or grill the ripe plantains as indicated on its package and cut the tomato into small cubes. Reserve these ingredients until filling. 
Preheat the grill or pan and grill the arepa, putting it once on each side until they are golden brown. 
With the help of a knife, open it by the edge through the middle, creating a space to fill it with the ripe plantain, the beans, meat and chopped tomato. 
Serve with a little pico de gallo or guacamole dip sauce. ', '/static/fotos/53334.jpg'),
(53335, 'Jiggs Dinner', 'Beef', 'Canadian', 'The night before, break salt beef into big chunks and soak in water overnight, at least 8-10 hours. Put split peas into a bowl and cover with water to soak overnight.
Drain the salt beef and place it into a large stockpot. Cover with fresh water, at least 6-7 litres. Place the split peas into a pease pudding canvas bag or triple layer of cheesecloth and tie, making sure to leave room for peas to expand inside the bag.
Put the bag inside the pot, tying the strings to the outside handle so it doesn''t stick to the bottom of the pot with the salt beef. Bring to a boil, then lower the heat and simmer for 2 hours.
Remove the peas pudding bag and empty contents into a bowl, mixing with butter and pepper for taste. Set aside.
Add your cabbage to the pot and boil for 20 more minutes. Then add turnip, carrots and potatoes then boil for 20 more, or until vegetables are tender.
Remove salt beef and vegetables from the pot and put them on a platter.
Use the cooking liquid in two ways; as a pot liquor which some people like to drink or reduce it to make a jus or gravy to pour over the meal.', '/static/fotos/53335.jpg'),
(53336, 'Molasses Baked Beans', 'Vegetarian', 'Canadian', 'Place the dried beans into a Dutch oven with 6 cups (1.5 L) of water. Soak overnight.
Drain and pour beans back into the pot with enough water to cover the beans by a couple of inches, cook for 30 minutes until they are tender but still firm. Drain beans, making sure to reserve cooking liquid, set aside.
Preheat the oven to 325 °F (160 °C). While the oven is preheating, cook pork over medium-high heat in the Dutch Oven until fat is rendered and pork is beginning to brown, then add the onion cooking until tender.
Add the beans back to the pot, along with molasses, brown sugar, apple cider vinegar, ground mustard, salt and pepper and 3 cups (750 mL) of reserved bean water.
Bake uncovered for 3 to 5 hours until the beans are tender, and the sauce has thickened, and the edges of the pot get sticky.
(Note: if beans get dry, add another cup of water.)', '/static/fotos/53336.jpg'),
(53337, 'Saskatoon Pie', 'Dessert', 'Canadian', 'To make the pastry, place the flour and salt in a large bowl. Mix well. Add the cubes of butter and shortening and mix them in (I like to use my hands to mix the fat into the flour, but you can use a pastry blender) just until it looks like coarse oatmeal with some pea-sized bits remaining. Place the egg in a 2-cup measure and beat it with a fork. Beat in the vinegar and just enough ice-cold water to bring it to the 1-cup mark. Stir this into the flour mixture, just until the dough clings together. I like to use my hands for this part as well, but a wooden spoon would also work. Try not to overmix it.
On a lightly floured surface, gather the dough into a ball and divide it into 5 evenly sized portions. Shape each portion into a disc and wrap tightly in plastic. Chill 2 of these discs for 1 hour. Freeze the other 3 in a resealable freezer bag for future use. The pastry keeps well in the freezer for up to 2 months.
Preheat the oven to 350°F. Place the rack in the lower third of the oven. Line a baking sheet with aluminum foil to catch drippings.
On a lightly floured surface, roll out 1 disc of pastry into a 12-inch circle, or thereabouts. Place it in the bottom of a 9-inch pie plate, with the pastry overhanging the edges of the pie plate.
To make the filling, place the saskatoon berries in a large bowl and stir in the 1/2 cup sugar and the cornstarch until well combined. Pour the berry mixture into the bottom of the pie. Dot with the butter. On a lightly floured surface, roll out the pastry in another 12-inch circle for the top crust. Use a ruler to guide you when cutting the pastry into 6 wide, long strips to keep the edges straight. Save the 2 end pieces in case you need to do any patching. I like wide strips, but if you like a thinner look, feel free to cut thin strips of pastry. Weave the pastry strips, going over and under, making sure they connect with the edges of the pie crust. Fold over the edges of the bottom crust, tucking in the lattice ends. This will help to trap the juices and give a rustic look.
If you prefer a cleaner, tidier look, you can trim the overhanging pieces and crimp the edges with a fork. Brush the top of the pie with the egg wash. Sprinkle with the remaining Tbsp sugar. Place the pie on the prepared baking sheet and bake it for about 90 – 100 minutes, until it’s golden brown and bubbling. Remove the pie from the oven and place it on a wire rack to cool.
Serve the pie warm or at room temperature with whipped cream or ice cream. Makes 6 servings. This keeps well if covered with plastic and refrigerated for up to 4 days.', '/static/fotos/53337.jpg'),
(53338, 'Date squares', 'Dessert', 'Canadian', 'Preheat oven to 350°F (180°C). Grease an 8-inch (20 cm) square baking pan.
To make the date filing: Combine the dates and water in a medium saucepan over high heat and bring to a boil. Reduce heat to low and simmer gently, stirring occasionally until the mixture thickens, around 6 to 8 minutes. Remove from heat, stir in vanilla and let cool. Set aside.
Combine rolled oats, flour, sugar, baking soda and salt in a food processor. Pulse 3 times (careful not to overmix, you don’t want the mixture to be powdery, just combined). Add butter and pulse again until the mixture is crumbly in pea-sized clumps. Transfer to a mixing bowl to thoroughly mix in the butter.
Spread half of the oat mixture on the bottom of the prepared baking pan, pressing down to make a flat, equal bottom later. Add the date mixture over the crust and then spread evenly. Layer with the remaining oat mixture and press down to flatten the top layer.
Bake in the centre of the oven until the top is golden brown, 30 to 35 minutes. Let cool completely in the pan before cutting and serving. Date Squares keep well, covered in the refrigerator for up to a week, and frozen for 2 to 3 months.', '/static/fotos/53338.jpg'),
(53339, 'Jam jam cookies', 'Dessert', 'Canadian', 'Preheat the oven to 350 °F (180 °C) and line a large baking sheet with parchment paper.
In a stand mixer with the paddle attachment, cream the butter, white sugar and egg until combined, then add the molasses and vanilla and mix until smooth.
Once combined, add the baking soda water mixture and mix for another minute to combine.
Combine dry ingredients; mix baking powder, cinnamon, flour and salt in a separate bowl then add to the wet ingredients a little at a time, mixing on low until fully combined and scraping down the sides to ensure everything is incorporated. The dough should be easily shaped.
Portion dough with a small spoon, roll them into balls and place them on the lined cookie sheet, press them into flat discs using a floured glass or your moistened palm.
Place cookies on parchment-lined baking sheets and bake for 10-12 mins. Remove from the oven and let them cool for at least 10 minutes.
Once cooled the cookie sandwiches by spreading at least two teaspoons of your favourite jam between the two cookies. Repeat and enjoy with a cup of tea.', '/static/fotos/53339.jpg'),
(53340, 'Hodge Podge', 'Vegetarian', 'Canadian', 'First, cook your vegetables. Bring a large pot of salted water to boil. Par-cook carrots and potatoes for five minutes until carrots and potatoes are fork tender, then blanch the peas and beans for about a minute in the same pot. Strain vegetables and set aside.
In a heavy-bottomed pot or Dutch oven, melt butter over medium heat, add vegetables, and cook to warm through.
Add milk and cream and bring the soup to a boil. Turn the heat down to low and season with salt and pepper.
Add dill and chives and let simmer for at least 10 minutes. Serve warm.', '/static/fotos/53340.jpg'),
(53341, 'Flapper Pie', 'Dessert', 'Canadian', 'Preheat the oven to 350˚F.
Mix all the crust ingredients (graham cracker crumbs, melted butter, granulated sugar and ground cinnamon) in a medium bowl. Set aside about 2 Tbsp (30 mL) for later and press the mixture into a 9-inch deep-dish pie plate in the bottom and up the sides. Bake crust for 10 minutes, it will only brown slightly.
Combine the vanilla custard filling ingredients (milk, granulated sugar, cornstarch, egg yolks, vanilla extract and salt together) and cook on medium heat, stirring constantly, until it bubbles and thickens to the texture of pudding. Set aside to cool while you make the meringue topping.
In the bowl of a stand mixer fitted with the beater attachment or in a large bowl using an electric mixer beat the meringue ingredients (egg whites, granulated sugar, cream of tartar) together until it holds stiff and glossy peaks.
To assemble the pie, pour the filling into the crust and top with a thick layer of the meringue, making little spikes that will brown on top. Sprinkle the reserved crumb over the top and place it into the preheated oven.
Bake until the meringue browns, around 10 minutes, making sure to watch it carefully.
Chill in the fridge and eat within a few hours of baking. This pie is best eaten the same day as the meringue will soften and liquify.', '/static/fotos/53341.jpg'),
(53342, 'Figgy Duff', 'Dessert', 'Canadian', 'In a medium bowl, whisk together flour, brown sugar, baking powder, and spices.
Add raisins and stir well, making sure to coat the raisins in the flour mixture.
Add melted butter, molasses and water and mix with a wooden spoon. Form a ball with the spoon or your hands and put the dough ball in a cotton pudding bag. Tie the bag, leaving at least 1 inch of room to allow the pudding to expand while cooking.
Boil pudding for 1.5 hours. (In NL, this is typically done in the pot along with Jiggs Dinner, but it can be done independently.)
When the duff is firm, remove it from the boiling water and let it cool slightly before removing it from the pudding bag.
Slice pudding like a cake and serve with the warm sauce of your choice: rum butter sauce, warmed molasses or Molasses Coady sauce (1 cup (250 mL) molasses, 1/4 cup (60 mL) butter, 1/4 cup (60 mL) water) is common in Newfoundland.
', '/static/fotos/53342.jpg'),
(53343, 'Classic Tourtière', 'Beef', 'Canadian', 'Heat oil on medium-high heat in a large sauté pan or skillet, then sauté the onion and garlic until softened, about 5 minutes. Add the ground beef, pork, and spices and cook until the meat is browned.
Add the beef broth and bring it up to a simmer then reduce heat to medium low. Add the grated potato and stir it in. Cook until liquid is almost absorbed, about 15 min. Remove the bay leaves and add salt to taste. Remove the pan from the heat and let the mixture cool completely — it bakes best if the filling is chilled.
Preheat the oven to 375 °F (190 °C). On a lightly floured surface, roll out one disc of the pie dough to less than the 1/4-inch thickness and line the 9-inch pie plate. Fill this with the cooled tourtière mixture and spread out evenly. Roll out the remaining dough to the same thickness, cut a hole in the centre (for steam to escape) and place on top of the filling. Trim the dough to 1/2-inch beyond the edge of the pie plate and pinch the edges of the crust together. Brush the crust with the egg wash.
Bake tourtière for about 45 minutes or until the pastry is a rich golden brown. Let cool for 15 minutes before slicing to serve.
Serves: 8-10 (makes 2 9-inch pies)', '/static/fotos/53343.jpg'),
(53344, 'Jamaican Sweet Potato Pudding', 'Dessert', 'Jamaican', 'Preheat oven to 350°F (175°C). Grease and line a 9-inch round pan or loaf pan with parchment paper.
Place your cut sweet potatoes in the bowl of a food processor and process until finely grated. In a small bowl, toss raisins in 2 teaspoons flour from the ½ cup. Set aside.
In a large bowl, combine grated sweet potatoes, light brown sugar, all-purpose flour, vanilla extract, allspice, cinnamon, nutmeg, ginger, and salt. Stir in 1½ cups of coconut milk until a batter forms. Fold in the raisins that were tossed in the flour.
Pour the batter into the prepared pan and smooth the top. Bake uncovered for 1 hour 30 minutes, until mostly set but still slightly soft in the center', '/static/fotos/53344.jpg'),
(53345, 'Jamaican Curry Chicken Recipe', 'Chicken', 'Jamaican', 'Equipment

Dutch Oven

Instructions
 
Add chicken thighs, all-purpose seasoning, 1 tablespoon of curry powder, onion, green onions, green pepper, garlic cloves, scotch bonnet pepper (if using), and thyme to a large bowl and combine, making sure all chicken pieces are covered with the seasoning. Cover and refrigerate for at least 1 hour or up to overnight.
One the chicken is done marinating, remove onions, peppers, and garlic cloves from chicken and set aside.
Heat olive oil in a large heavy bottom pot over medium heat. Add remaining curry powder and stir, cooking for about 20-30 seconds. Add onions, green pepper, garlic cloves, thyme, and scotch bonnet pepper (if using) to pot and stir until onions have softened, about 3-5 minutes. If your onions and peppers are looking dry, add about 1 tablespoon of water.
Add chicken and ¼ cup of water to the pot. Cover and reduce heat to medium low. Cook, stirring occasionally, for 30-35 minutes.
When there is about 15 minutes remaining, stir in potato and continue to cook covered.
Once chicken is cooked and potatoes are softened, remove from heat. Salt and pepper to taste.', '/static/fotos/53345.jpg'),
(53346, 'Grape Nut Ice Cream', 'Dessert', 'Jamaican', 'In a large bowl, use an electric mixer to whip the cold heavy cream until stiff peaks form. Gently fold in the sweetened condensed milk and vanilla extract until well combined.
Fold in the cereal and stir until evenly distributed throughout the mixture.
Pour the mixture into a freezer-safe container (such as a loaf pan). Lay plastic wrap on top of the ice cream to avoid freezer burn. Cover the container and freeze for at least 6 hours or until solid.
Once frozen, let the ice cream sit at room temperature for a few minutes to soften slightly before scooping and serving.', '/static/fotos/53346.jpg'),
(53347, 'No-Churn Rum Raisin Ice Cream', 'Dessert', 'Jamaican', 'Heat the rum in a small saucepan over medium heat until warm (do not boil). Remove from heat and stir in the raisins and vanilla extract. Let the mixture sit for at least 30 minutes. After soaking, drain off the extra rum, but keep ¼ cup of the rum and reserve it to mix into your ice cream base.
In a large bowl, whisk together the sweetened condensed milk, dark brown sugar, cinnamon, allspice, salt, and reserved rum (¼ cup). Stir until the brown sugar is fully dissolved.
In a separate bowl, whip the cold heavy cream with an electric mixer until stiff peaks form.
Gently fold the whipped cream into the condensed milk mixture until fully combined, being careful not to deflate the cream. Fold in the drained rum-soaked raisins to distribute them evenly.
Pour the mixture into a loaf pan or freezer-safe container. Smooth the top and cover with plastic wrap or an airtight lid. Freeze for at least 6 hours, or until firm.
Let the ice cream sit at room temperature for 5–10 minutes before scooping for the best texture.', '/static/fotos/53347.jpg'),
(53348, 'Jamaican Spice Bun Recipe', 'Dessert', 'Jamaican', 'Soak the craisins, raisins, and cherries in the 1 cup of beer. Set aside and allow to soak for 30 minutes.
Preheat the oven to 325 degrees Fahrenheit. Grease an 8x4 loaf pan. Set aside.
Combine all-purpose flour, baking powder, ground cinnamon, salt, in a large bowl and set aside.
In another bowl, combine brown sugar, egg, milk, honey, melted butter, molasses, browning, vanilla extract, and the beer that’s soaking the fruit. Do not pour the fruit in at this time, just the beer. Mix to combine.
Remove 2 tablespoon of flour from the flour mixture and toss the fruit in it. Set aside.
Make a well in the middle of the bowl of dry ingredients and pour in wet mixture, stirring until fully combined. And the fruits to the mixture and stir until incpororated.
Pour mixture into prepared loaf pan and bake in the preheated oven for 50-60 minutes or until a toothpick comes out clean.
Cool for 5 minutes in the pan and then move to a cooling rack to finish cooling. Serve with slices of cheddar cheese.', '/static/fotos/53348.jpg'),
(53349, 'Jamaican Pepper Shrimp', 'Seafood', 'Jamaican', '
In a medium bowl, combine shrimp with minced Scotch Bonnet peppers, all-purpose seasoning, ground annatto, and grounf allspice. Toss well to coat evenly and let marinate for 10 minutes.
Heat a large pan over medium heat. Add the shrimp stock and bring to a gentle simmer. Stir in the diced onion and garlic, cooking until softened and fragrant, about 2 minutes.
Add the seasoned shrimp and thyme sprigs, spreading the shrimp in the pan. Cover and cook for about 5–7 minutes, stirring occasionally, until the shrimp turn bright orange and are cooked through.
Add the white vinegar, stir, and cook for another minute. Taste; add salt to taste. Using a slotted spoon, transfer the shrimp to a plate. Serve hot with some cooking liquid drizzled on top.', '/static/fotos/53349.jpg'),
(53350, 'Corned Beef and Cabbage – Jamaican Style', 'Beef', 'Jamaican', 'Heat olive oil in a skillet or Dutch pot over medium-high heat. Add onion and green pepper and sauté for about 3-5 minutes.
Add garlic and stir for about 1 minute.
Add shredded cabbage and stir. Cook for about about 3-5 minutes, stirring often until softened.
Add corned beef, Roma tomatoes, and thyme and stir. Add ketchup and scotch bonnet pepper sauce and stir. Reduce heat and cook on medium for about 3-5 minutes, until the corned beef is heated through. Remove from heat.
Serve with white rice, bread, or on its own.', '/static/fotos/53350.jpg'),
(53351, 'Jamaican Banana Fritters', 'Dessert', 'Jamaican', 'Mash bananas with fork in bowl.
Add brown sugar, vanilla, extract, cinnamon, nutmeg and a pinch of salt. Sift in flour and stir with spoon until fully combined.
Add oil to a 10 inch skillet over medium-high heat. Once oil is hot, drop banana fritter batter in oil by the spoonful. Once one side is golden and bubbles appear on the top, flip fritter and cook until the other side is browned as well.
Remove fritters and drain on paper towels. Enjoy', '/static/fotos/53351.jpg'),
(53352, 'Jamaican Instant Pot Rice and Beans', 'Vegetarian', 'Jamaican', 'Instructions
 
Set Instant Pot to "Sauté." Once Hot, add olive oil. Then add yellow onion and stir until softened, about 3 minutes. Add garlic and green onions and stir for about 30 more seconds.
Press “Cancel” on the Instant Pot. Add rice, coconut milk, water, salt, allspice, and black pepper and stir.
Pour undrained kidney beans on top of the rice mixture. Do not stir. Lay sprigs of thyme on top. Cover the Instant Pot, ensuring the valve is set to “Sealing.”
Press “Manual” or “Pressure Cook” on the Instant Pot and set for High pressure for 6 minutes.
Once the pressure cooking time is done, allow it to natural release for 10 minutes, then quick release any remaining pressure by moving valve to "Venting"
Open lid and remove thyme sprigs. Fluff rice with fork and Enjoy!

Stove Top Instructions
Heat olive oil in a large pot over medium heat. Add yellow onion and stir until softened, about 3 minutes. Add garlic and green onions and stir for about 30 more seconds.
Add rice, undrained kidney beans, coconut milk, water, salt, allspice, and black pepper and stir until combined. Lay thyme on top. Bring mixture to a simmer.
Cover with a lid and reduce heat to low. Allow to cook for 18 minutes over low heat, then remove from heat. Leave the lid on for an additional 5 minutes.
Open the lid and remove the thyme. Fluff rice with fork. Enjoy.', '/static/fotos/53352.jpg'),
(53353, 'Jamaican Boiled Dumplings', 'Side', 'Jamaican', 'Instructions
 
In a large pot, bring water and salt to a boil to boil the dumplings.
In a large mixing bowl, combine the all-purpose flour and salt, stirring to distribute the salt evenly throughout the flour. Gradually add water to the flour mixture, mixing with your hands until a dough forms.
Divide the dough into equal-sized pieces, rolling each into a smooth ball. Flatten each ball slightly with the palm of your hand to form a round, circular dumpling. It should look like a thick disk.
Carefully drop the dumplings into the boiling water, one at a time, ensuring that they don''t stick together. You can use a wooden spoon to stir the dumplings in the water.
Boil the dumplings for 15-20 minutes, or until they are cooked through and have risen to the surface of the water. Stir occasionally to prevent sticking.
Use a slotted spoon to remove the cooked dumplings from the pot, allowing any excess water to drain.
Serve with your favorite recipes.', '/static/fotos/53353.jpg'),
(53354, 'Jamaican Curry Goat', 'Goat', 'Jamaican', 'Equipment

6QT Pressure cooker

Instructions
 
Rinse goat meat with vinegar and water.
Season goat meat with 1 ½ tablespoon curry powder, all-purpose seasoning, ground ginger, allspice, onion, garlic cloves, and thyme. Marinate for at least 4 hours or up to overnight.
Remove onion and garlic from goat and set aside.
Set an electric pressure cooker, like an Instant Pot, on high sauté and add oil. Add goat meat and brown, about 2-3 minutes per side. Remove goat from insert and add 1 tablespoon oil and remaining curry powder and sauté for about 10 seconds. Then add onions and garlic and sauté until softened. About 4 minutes. If the onions look dry, add a little water and continue to sauté.
Add goat and water to the pressure cooker and cover the pressure cooker. Cook for 40 minutes on high pressure. Allow to naturally release for 10 minutes, then release the remaining pressure.
Once all the pressure has been released, open the pressure cooker. Place on sauté for 10-15 minutes, add potatoes and a whole scotch bonnet pepper. Cook until potatoes have softened. Remove scotch bonnet pepper.', '/static/fotos/53354.jpg'),
(53355, 'Jamaican Festival (Sweet Dumpling)', 'Side', 'Jamaican', 'Heat a heavy bottom pot of oil that has at least 3 inches of oil in it or use a deep fryer if you have one. Turn the heat over medium heat until the temperature reaches 350 degrees Fahrenheit.
Add the all-purpose flour, cornmeal, granulated sugar, baking powder, and salt to a large bowl and stir to combine.
Add the vanilla extract and milk and stir until the dough comes together. Then use your hands to lightly form the mixture into a ball.
Pinch off pieces of dough and roll them into long oval shapes. Make about 12 dumplings.
Once the oil has reached the temperature of 350 degrees Fahrenheit, fry the dough on all sides, until golden brown. This should take about 4-6 minutes.
Remove dough and drain off any excess grease. Serve and enjoy.', '/static/fotos/53355.jpg'),
(53356, 'Jamaican Fried Dumplings', 'Side', 'Jamaican', 'Add flour, baking powder, and salt in a large bowl and stir to combine. Pour in the milk and stir until combined. Then roll the mixture into a ball and lightly knead until it comes together.
Break off about 10 pieces of dough and form them into balls. Set them aside.
In a 10-inch skillet, heat enough oil over medium heat to fry the dumplings, until the oil is about 350 degrees.
Once the dumplings are browned on one side, flip them and cook until both sides are browned, about 2-3 minutes each.
Once done, remove the dumplings from the oil and place them on paper towels or a cooling rack to drain off any excess oil.
Serve and enjoy.
', '/static/fotos/53356.jpg'),
(53357, 'Jamaican Rice and Peas', 'Vegetarian', 'Jamaican', 'Equipment
Dutch oven

Add rice, coconut milk, kidney beans, water, kosher salt, allspice, and black pepper to a large pot and stir until combined. Lay green onions, thyme and Scotch bonnet pepper on top. Bring mixture to a boil.
Once boiling, reduce heat to low and cover with a lid. Allow to cook covered for 18 minutes over low heat, then remove from heat. Leave the lid on for an additional 5 minutes.
Open the lid and remove the green onion, Scotch bonnet pepper, and thyme. Fluff the rice and peas with a fork. Serve and enjoy.', '/static/fotos/53357.jpg'),
(53358, 'Chicken Mandi', 'Chicken', 'India', '1. Clean and cut the chicken; marinate briefly with salt, turmeric and a little oil.
2. Rinse and soak basmati rice 20–30 minutes.
3. In a large pot, heat ghee/oil. Fry chopped onion until golden. Add minced garlic and green chillies and fry 1–2 min.
4. Add whole spices (cardamom, cloves, cinnamon, bay leaves) and ground spices (coriander, cumin). Stir until fragrant.
5. Add chicken pieces, brown lightly and add enough water/chicken stock to cover. Simmer until chicken is nearly cooked.
6. Remove chicken; measure remaining liquid and add soaked rice. Bring to a boil, then reduce heat, cover and cook rice until almost done.
7. Return the chicken to the rice pot on top, cover tightly and steam on low for 10–15 min so flavors meld.
8. (Optional) For authentic smoky aroma: heat a small charcoal until red hot, place it on a small foil cup in the centre of the pot, add a tsp of butter/oil on the coal then cover immediately to trap smoke for 5–10 minutes. Remove coal.
9. Garnish with fried onions, chopped coriander and serve with chutney or raita.
', '/static/fotos/53358.jpg'),
(53359, 'Beef Mandi', 'Beef', 'India', '1. Wash the beef and cut into large pieces. Season lightly with salt and turmeric.
2. Heat ghee/oil in a large pot. Add sliced onions and sauté until light golden.
3. Add garlic, green chilies, and tomato; cook until softened.
4. Add the mandi spice mix: coriander, cumin, black pepper, cinnamon, cardamom, cloves, and bay leaves.
5. Add beef pieces and stir on medium heat until the meat is well coated with spices.
6. Pour in water or beef stock. Cover and simmer until beef is tender (about 1.5–2 hours depending on cut).
7. Remove beef carefully and set aside. Strain and measure the broth.
8. Add washed, soaked basmati rice to the broth (usually 1 cup rice = 1.5–2 cups liquid). Adjust seasoning and bring to a boil.
9. Lower heat, cover, and cook the rice until fluffy.
10. Place the beef pieces over the rice and steam on low heat for 10 minutes so flavors combine.
11. Optional: For smoky flavor, place a small hot charcoal on foil in the pot, add 1 tsp butter/oil, immediately cover for 5 minutes. Remove coal before serving.
12. Fluff rice and serve beef mandi with salad or chutney.
', '/static/fotos/53359.jpg'),
(53360, 'Caribbean Tamarind balls', 'Dessert', 'Jamaican', 'Add tamarind pulp and 1 cup granulated sugar to a bowl and mash together with a spoon or fork. Take small amounts of the tamarind and sugar mix and shape them into small balls by rolling them in your hands. Make them the size of a marble or slightly bigger, as you like.
Add the remaining sugar to a flat surface, like a plate or a sheet pan. Roll the tamarind balls in granulated sugar until they''re well-coated.
You can eat the tamarind balls immediately, or you can let them set for a few hours or overnight. Allowing them to set will give them a firmer texture and more crystallized sugar coating. Enjoy.', '/static/fotos/53360.jpg'),
(53361, 'Callaloo and SaltFish', 'Side', 'Jamaican', 'Soak salted fish in water overnight. Next, heat salted fish in water on stove until water boils. You should see a foam on top. Remove from heat and drain. Set aside and shred salted fish once it cools.
Cook bacon in skillet over medium heat until crispy. Remove bacon from heat and drain the majority of the bacon grease, leaving about 1 tablespoon in the skillet. 
Add yellow onion, green onion, scotch bonnet pepper, and garlic to the skillet and stir. Cook for about 2 minutes or until onions soften. Add salted fish to skillet and stir. Cook for about a minute. 
Next, add callaloo, roma tomatoes, thyme, and black pepper. Stir to combine and cook until heated through, about 2 minutes.
Enjoy ', '/static/fotos/53361.jpg'),
(53362, 'Jamaican Curry Shrimp Recipe', 'Seafood', 'Jamaican', 'Season shrimp with 1 Tablespoon of curry powder and all-purpose seasoning and set aside for about 10 minutes while you prepare the other ingredients like chopping your onions, peppers, and garlic.
Heat 2 Tablespoons of olive oil in a large skillet over medium heat. Add sliced yellow onion, red bell pepper, green bell pepper, scotch bonnet pepper, if using, and chopped garlic and stir for 5 minutes, until peppers are slightly softened.
Add 1.5 Tablespoons of curry powder to the skillet and stir for an additional minute.
Then add coconut milk, seasoned shrimp, ketchup, and thyme, making sure the shrimp is covered in the sauce.
Allow the sauce to come to a simmer and continue to cook over medium heat, stirring occasionally and flipping the shrimp halfway, until the shrimp is fully cooked on both sides. This should take about 5-6 minutes. Salt and pepper to taste.', '/static/fotos/53362.jpg'),
(53363, 'Jamaican Cornmeal Porridge', 'Breakfast', 'Jamaican', 'Add 2 ½ cups water, 1 can coconut milk to a 4 QT heavy bottomed pot. Bring to a boil over medium-high heat.
Meanwhile, add 1 cup cornmeal and 1 ½ cup water to a large mixing cup and whisk until smooth.
Once the pot begins to boil, whisk in cornmeal mixture and continue to whisk for about 1 minute, ensuring there are no lumps. Reduce heat to low and cover with a tight fitting lid.
Cook over low heat for 15-20 minutes, stirring occasionally. When there is about 5 minutes left, stir in vanilla extract, cinnamon, nutmeg, and all-spice. Remove from heat and sweeten with condensed milk.
Serve and enjoy.', '/static/fotos/53363.jpg'),
(53364, 'Jamaican Steamed Cabbage', 'Side', 'Jamaican', 'Add all the ingredients to a large pan over medium heat and cover with a lid.
Cook on medium heat for 10 minutes, stirring occasionally.
After 10 minutes, reduce the heat to low and continue to cook for an additional 5 minutes, until the cabbage is soft and tender. Remove from the heat and remove the stalks of thyme before serving.', '/static/fotos/53364.jpg'),
(53365, 'Chinese Orange Chicken', 'Chicken', 'Chinese', 'Make the orange sauce:
Whisk together sauce ingredients in a medium bowl. Set aside.


Prep the chicken:
Cut chicken into about 1-inch cubes. Whisk eggs with salt and black pepper in a bowl and add chicken. Stir together.

In a separate bowl, whisk together flour and cornstarch. Remove chicken from eggs with a slotted spoon or tongs, letting excess egg drain off, then transfer to cornstarch mixture and coat well.


Fry the chicken:
Add oil to a large 10- to 12-inch skillet. Heat over medium-high heat until it reaches 350°F. If you don’t have a thermometer, you can also test the temperature by sprinkling in some flour. If the oil is hot enough, it should fizzle immediately.

Once oil is hot, fry the chicken in two batches. The oil might not completely cover the chicken—that’s okay. Cook for 3 to 4 minutes. Flip the chicken pieces and cook until the chicken is cooked through, about 3 to 4 more minutes. Total cook time is about 6 to 8 minutes.

Remove fried chicken cubes and transfer to a plate lined with paper towels, so the chicken can drain. Repeat until all the chicken is cooked.


Simmer the chicken in the sauce:
Once chicken is done, pour out hot oil and wipe pan clean. Add a fresh tablespoon of oil along with chopped garlic and shallot. Cook for a minute and then add the sauce. Simmer the sauce until it starts to thicken.

Once the sauce is lightly bubbling, add fried chicken and toss together to coat. The sauce should continue to thicken and stick to the chicken. Let simmer for a minute or two more. Serve orange chicken over cooked white rice, garnished with sesame seeds and fresh scallions.

Did you love this recipe? Let us know with a rating and review!


LEFTOVERS! The orange chicken keeps well in the fridge for 5 days. Reheat in a skillet with a splash of water over low heat. Freeze the orange chicken for up to 3 months, but be sure to thaw it before reheating so the chicken doesn’t clump together.', '/static/fotos/53365.jpg'),
(53366, 'Beef and Broccoli Stir-Fry', 'Beef', 'Chinese', 'Marinate the beef:
Stir together the beef marinade ingredients (1 teaspoon soy sauce, 1 teaspoon Chinese rice wine, 1/2 teaspoon cornstarch, 1/8 teaspoon black pepper) in a medium bowl.

Add the beef slices and stir until coated. Let stand for 10 minutes.

Prepare the sauce:
Stir together the sauce ingredients (2 tablespoons oyster sauce, 1 teaspoon Chinese rice wine, 1 teaspoon soy sauce, 1/4 cup chicken broth) in a small bowl. Set aside.

Blanch or steam the broccoli:
Bring a pot of water to a boil. Add the broccoli and cook until crisp-tender, about 2 minutes. Drain thoroughly.

Stir-fry the beef:
Heat a large frying pan or wok over high heat until a bead of water sizzles and instantly evaporates upon contact. Add the cooking oil and swirl to coat.

Add the beef and immediately spread it out all over the surface of the wok or pan in a single layer (preferably not touching).

Let the beef fry undisturbed for 1 minute. Flip the beef slices over, add the garlic to the pan, and fry for an additional 30 seconds to 1 minute until no longer pink.

Add the sauce, cornstarch, and broccoli:
Pour in the sauce and the cornstarch slurry (1 teaspoon cornstarch dissolved in 1 tablespoon of water). Stir until the sauce boils and thickens, about 30 seconds. Stir in the broccoli.

Serve immediately, with steamed rice or on its own.', '/static/fotos/53366.jpg'),
(53367, 'Chicken Fried Rice', 'Chicken', 'Chinese', 'Fried rice is best made with leftover rice that''s at least a day old. Otherwise it becomes gummy in the skillet.
If you don’t have any leftover rice from the night before, cook a batch of rice and spread it on a large baking sheet or several large plates. Let the rice dry out for about 1 to 2 hours before using it for fried rice.

Rice sticks to the pan very easily, so make sure to use a wok or pan that doesn’t have a sticky surface. I usually cook stir-fries in my seasoned carbon steel wok, but cast iron or nonstick pans work well, too. You might need to add a little more oil if things aren’t releasing easily.

Prepare the chicken:
Chop the chicken into small 1/4-inch to 1/2-inch cubes. Sprinkle 1/2 teaspoon of salt over the chicken and mix to combine. Set the chicken aside for about 10 minutes (I usually use this time to chop all the vegetables).

Scramble the egg:
Heat a wok or large sauté pan over medium-high heat. Swirl in a tablespoon of oil and add the whisked eggs. Use a spatula to quickly scramble the eggs, breaking the curds into smaller pieces as they come together. Transfer the eggs to a plate.

Cook the chicken:
Add another tablespoon of oil in the wok or pan. Add the chicken and cook for 4 to 5 minutes, stirring occasionally. Turn off the heat and transfer the cooked chicken to a plate.

Using your spatula, scrape off any chicken bits that are still stuck to the wok so they don''t burn during the next step. You can also use paper towels to wipe down your wok or pan.

Cook the vegetables:
Swirl 1 tablespoon of oil into the wok over medium-high heat. Add the diced onions and cook them for 1 minute, until they start to soften. Mix in the minced garlic and ginger and cook until fragrant, about 30 seconds. Add the diced carrots and cook for 2 minutes, stirring frequently. Add 1/2 teaspoon salt and the peas, and stir to incorporate.

Cook the rice:
Add the rice to the wok or pan on top of the vegetables and stir to combine. Using the back of your spatula, smash any large chunks of rice to break them apart. Add the white and green parts of the sliced scallions (save the dark green parts) and five-spice powder. Stir to incorporate. If the rice starts to stick to the pan, stir in a little more oil.

Drizzle the soy sauce and sesame oil over the rice and stir to incorporate. Stir in the cooked chicken, scrambled eggs, and the dark parts of the scallions. Stir briefly to bring it together, and cook for another 1 to 2 minutes.

Serve:
Taste, and add more soy sauce if necessary. Serve immediately.', '/static/fotos/53367.jpg'),
(53368, 'Singapore Noodles with Shrimp', 'Seafood', 'Chinese', 'For the sweet onion, look for Vidalia, OSO Sweet, or Walla Walla. The super-sweet varieties are more suited to this stir-fry because at the end of cooking, the onion still has a slight crunch.

Make the sauce:
In a bowl, combine the sesame oil, soy sauce, and rice vinegar.

Cook the rice noodles:
Bring a large saucepan of water to a boil, add the noodles, and use tongs to turn them so they are submerged. Cook for 2 minutes, or until they are tender but still have some bite (they will cook a little more once you add them to the skillet).

Drain, rinse with cold water, and use scissors to snip the noodles several times to break them up into shorter lengths.

Scramble the eggs:
In a small bowl whisk together the eggs. Heat the skillet or Dutch oven over medium heat. Add 1 tablespoon of the peanut or canola oil. Add the eggs and scramble them for 2 minutes, or until they form large, soft curds. Transfer them from the pan to a plate or bowl.

Cook the vegetables:
Add 1 tablespoon of the remaining oil to the pan. When it is hot, add the ginger, garlic, carrots, jalapeño, onion, and salt. Cook, stirring constantly, for 2 minutes or until the vegetables start to soften.

Add the remaining ingredients:
Sprinkle the vegetable mixture with the remaining 1 tablespoon peanut or canola oil. When the oil is hot, add the ham, cabbage, scallions, red pepper, and curry powder to the pan. Cook, stirring constantly, for 1 minute.

Add the shrimp and cook, stirring, for 3 more minutes or until the shrimp are bright pink and cooked through.

Add the noodles in batches:
Add the eggs, the sauce mixture, and half the noodles to the pan. Toss for 1 minute.

Add the remaining noodles and continue tossing for 1 minute more until they are thoroughly combined and the mixture is heated through.

Serve:
Taste for seasoning and add more salt or soy sauce, if you like. Sprinkle with cilantro leaves and serve.', '/static/fotos/53368.jpg'),
(53369, 'Silken Tofu with Sesame Soy Sauce', 'Vegetarian', 'Chinese', 'Prepare the tofu: 
Drain the tofu and gently remove it from its packaging onto a large plate. Carefully slice the tofu into 1/2-inch slabs widthwise. With the palm of your hands, gently push the sliced tofu sidewise so that they fan out over the plate.

Garnish with toppings and serve:
Drizzle the soy sauce and sesame sauce on top. Then garnish it with scallions and sesame seeds, and serve.

Tightly cover leftovers and refrigerate for up to 2 days. You can enjoy it cold straight out of the fridge or you can reheat it by microwaving in 30-second increments until warmed through', '/static/fotos/53369.jpg'),
(53370, 'Egg Foo Young', 'Seafood', 'Chinese', 'Make the gravy:
In a small saucepan, add the beef stock, soy sauce, Shaoxing wine, oyster sauce, and white pepper powder over medium heat. Whisk together and bring to a simmer. 

Combine the cornstarch and water in a small bowl and whisk to dissolve. Add to the saucepan and whisk until the gravy thickens and coats the back of the spoon, 2 to 3 minutes. Cover the saucepan with a lid and keep it warm on the lowest possible heat.

Make the egg foo young batter:
In a medium bowl, whisk together the cornstarch and water until dissolved. Add the eggs, salt, and sugar. Whisk until well combined and there are no more egg white clumps. 

Add the green onion, bean sprouts, and shrimp. Stir until everything is evenly coated.

Fry the egg foo young:
Add the vegetable oil to a large wok; it should reach about 2 inches up the sides. Heat the oil over medium-high heat to 350°F, or until vigorous bubbles form around an inserted wooden chopstick. 

With a ladle, gently and slowly add 1/4 of the omelet batter. Egg foo young should immediately bubble and puff up like magic. Fry until golden brown and crispy on each side, about 2 minutes per side. If there are any light spots, use a ladle to gently baste it with hot oil.

Tip
Egg foo young can be a bit tricky to flip. The easiest method is to put a tool in each hand (a spider, slotted spoon, tongs, and large chopsticks are all good candidates) and gently coax the omelet over, pulling up on one side and pushing down and around on the other.

Remove the omelet and place it on a paper towel-lined baking sheet. Let it cool for 5 minutes. Meanwhile, repeat with the remaining batter to make 4 omelets. If needed, add more oil to the pan between batches.

Serve and enjoy:
Plate each egg foo young over a bed of rice. Spoon the warm gravy over the top and serve immediately. ', '/static/fotos/53370.jpg'),
(53371, 'Sichuan Style Stir-Fried Chinese Long Beans', 'Vegetarian', 'Chinese', 'Chinese long beans can be found in both green and purple varieties. Both have similar flavors and textures, and either kind can be used for this recipe.
If you don''t have a wok, use a sturdy, large sauté pan that has at least a two-inch lip.', '/static/fotos/53371.jpg'),
(53372, 'Chinese Tomato Egg Stir Fry', 'Vegetarian', 'Chinese', 'You can use chicken broth in place of the chicken bouillon powder. Add 1/4 cup of broth followed by 2 teaspoons of cornstarch dissolved in 1 tablespoPrepare the tomatoes:
Slice the tomatoes in half. Remove the tough stem from each half that connects to the vine. Cut each half into equal thirds (you’ll get 6 slices from each tomato).

Make the soft scrambled eggs:
In a cold, 8 to 10-inch nonstick skillet, add the vegetable oil and beaten eggs. Turn the heat to medium. Once a thin layer of eggs is just beginning to cook on the bottom, push the eggs in one direction to create layers of scrambled eggs.

Cook, gently stirring the whole time, until the scramble eggs are mostly set but still slightly wet and shiny, 2 to 5 minutes. Remove the eggs to a plate and, if needed, wipe out the pan.

Stir-fry the tomatoes and seasonings:
Add the sesame oil to the pan followed by the tomatoes and stir-fry over medium heat until the tomatoes are softened but not mushy, about 3 minutes. Add the chicken bouillon powder, sugar, and white pepper. Toss until combined and the sugar and bouillon have dissolved, about 1 minute.

Add eggs, stir-fry, and garnish:
Add the eggs back to the pan with the tomatoes. Stir-fry for about 2 minutes to heat through and combine. Taste, adding salt only if needed. Sprinkle with the green onions and serve with steamed rice.on of water, plus salt to taste.', '/static/fotos/53372.jpg'),
(53373, 'Air Fryer Egg Rolls', 'Side', 'Chinese', 'Alternative Pan Fry Method: If you don’t have access to an air fryer, you can make these egg rolls using a traditional pan fry method. Add enough oil to a medium skillet with high walls so the oil is about 1/2 inch up the side of the skillet. Heat oil on medium high heat until it reaches 350°F. Add egg rolls and fry for 3 to 4 minutes, flip, and fry for another 3 to 4 minutes until golden brown. Remove and let them drain and cool on a few paper towels.

Cook the filling:
In a large skillet over medium heat, add the olive oil along with the ground pork or chicken. Break apart the meat with a spatula or wooden spoon as it cooks. Cook until the meat is cooked through, 6 to 8 minutes.

Add garlic, ginger, carrot, scallions, and cabbage. Continue to cook until cabbage wilts down and is soft, another 3 to 4 minutes, stirring regularly. Season the filling with soy sauce and rice wine vinegar, and take off the heat to cool. (This filling can be made in advance.)

Assemble the egg rolls:
Place a single egg roll wrapper on a dry surface with one point of the square facing you (like a diamond). Place about 1/4 cup of the egg roll filling mixture in the middle of the wrapper.

Dip your fingers in water and run around the edges of the wrapper. Then fold the edges of the wrapper over the center and start rolling the egg roll away from you to form a tight cylinder. Place on a plate and repeat until you are out of filling. You should get at least a dozen egg rolls.

Air fry the egg rolls:
Place the egg rolls in the basket of your air fryer. Spray or brush them lightly with oil. Add as many as you can without stacking the egg rolls, making sure they don’t touch. Air needs to circulate around them. Brush the egg rolls lightly with oil.

Place the basket in the air fryer and turn the air fryer to 350°F. Cook for 6 to 7 minutes, then flip the egg rolls, spray or brush with oil a second time on the bottom side, and cook for another 4 to 5 minutes.

Finished egg rolls should be golden brown and crispy! Serve immediately.', '/static/fotos/53373.jpg'),
(53374, 'Sichuan Eggplant', 'Vegetarian', 'Chinese', 'This recipe calls for asian eggplants, or Japanese eggplants. They are long and thin compared to a European or globe eggplant, and much more tender and delicate. If you can''t find them you can substitute globe eggplant, but the dish is really best with the asian eggplant.

*A lot of grocery stores have Asian ingredient aisles now. You should be able to find chili-bean paste, a mixture of preserved chilies mixed with mashed soybeans, there or at any Asian market. (Do not confuse with black bean paste or chili-garlic paste.)

**Sichuan peppercorns are available at some stores and online for quite cheap. They aren''t spicy like other peppers but rather have a citrusy flavor and induce a tingly, numbing sensation like a carbonated drink.

Prep eggplant, chili sauce, cornstarch slurry, vinegar and scallions:
Begin your mise en place. Quarter the eggplant lengthwise and chop into large batons and set aside.

In a small bowl, mix together the chicken stock, sugar, and soy sauce and set it aside.

In a second bowl, mix together the chili bean paste, garlic, ginger, and sichuan peppercorns and set it aside.

In a third bowl, mix together the cornstarch with a tablespoon of water and set it aside.

Lastly, in a fourth bowl, mix together the scallions and vinegar and set it aside.

Sauté eggplant:
Place the oil in a wok or large sauté pan over medium-high heat until the oil is almost smoking. Add the eggplant and sauté, allowing it to sit for a few seconds each time you move it to allow it to brown and blister. If the eggplant absorbs all the oil and some pieces don''t get any then add a little more oil.

Add the chili bean paste, garlic, ginger, and sichuan peppercorns and sauté:
until fragrant, about 30 seconds.

Add the chicken stock mixture:
turn the heat to medium-low and simmer for 90 seconds.

Add the cornstarch mixture:
and stir together until the sauce thickens a bit.

Add the scallions and vinegar:
and cook for 15 seconds to diffuse their harsh flavors a bit.

Garnish with cilantro and serve.', '/static/fotos/53374.jpg'),
(53375, 'Shrimp With Snow Peas', 'Seafood', 'Chinese', 'You can also use sugar snap peas for this recipe. Save prep time by prepping the peas, ginger, and garlic while the shrimp is marinating.

Marinate the shrimp:
Mix all marinade ingredients in a large bowl, then add the shrimp. Toss to coat. Let sit for 15 to 20 minutes while you prep the peas, ginger, and garlic.

Stir-fry the ginger and garlic:
Heat a wok or large sauté pan over high heat for 1 minute. Add the peanut oil and let it get hot, about 30 seconds. Add the ginger and garlic and toss to combine. Stir-fry for about 30 seconds.

Add the shrimp, snow peas, soy sauce, stock:
Add the shrimp and all the marinade to the pan (scrape out all the marinade with a rubber spatula). Add the snow peas, soy sauce and chicken stock. Stir-fry until the shrimp turns pink, about 2 minutes.

Add the scallions and finish with sesame oil:
Add the scallions and stir-fry 1 more minute. Turn off the heat and add the sesame oil. Toss to combine once more and serve with steamed rice.', '/static/fotos/53375.jpg'),
(53376, 'Sweet and Sour Chicken', 'Chicken', 'Chinese', 'Coat the chicken with egg white:
In a bowl, combine the chicken with the egg white, 1/2 teaspoon kosher salt, and cornstarch. Stir to coat the chicken evenly. Let sit for 15 minutes at room temperature or up to overnight in the refrigerator.

Make the sweet and sour sauce:
Whisk together the pineapple juice, vinegar, ketchup, 1/2 teaspoon kosher salt, and brown sugar.

Stir-fry the chicken over high heat:
Heat a large frying pan or wok over high heat until a bead of water instantly sizzles and evaporates. Pour in 1 tablespoon of cooking oil and swirl to coat. It''s important that the pan is very hot.

Add the chicken and spread the pieces out in one layer. Let the chicken fry untouched for 1 minute, until the bottoms are browned.

Flip and fry the other side for 1 minute. The chicken should still be pinkish in the middle. Dish out the chicken onto a clean plate, leaving as much oil in the pan as possible.

Stir-fry the bell pepper and ginger:
Reduce the heat to medium and add the remaining 1 teaspoon of cooking oil. Let the oil heat up before adding the bell pepper chunks and ginger. Fry for 1 minute.

Add the pineapple, sauce, and then, the chicken:
Add the pineapple chunks and the sweet and sour sauce. Turn up the heat to high. When the sauce is simmering, add the chicken pieces back in.

Let simmer for 1 to 2 minutes, until the chicken is cooked through. Timing depends on how thick you''ve cut your chicken. The best way to tell if the chicken is done is to take a piece out and cut into it. If it''s pink, add another minute to the cooking.

Adjust the seasoning and serve:
Taste the sauce and add more brown sugar or vinegar to suit your tastes, if you’d like.

Serve hot with steamed white or brown rice.', '/static/fotos/53376.jpg'),
(53377, 'Napa Cabbage with Dried Shrimp', 'Seafood', 'Chinese', 'Dried shrimp gives this Chinese dish a punch of salty umami flavor. You can find it at an Asian grocery store in the frozen or refrigerated section. Look for small-sized dried shrimp, about a 1/4-inch in size. If you use medium or large dried shrimp, hydrate the shrimp with more water (1 cup for medium-sized shrimp, 1 1/4 cup for large) and for longer time (45 to 60 minutes), then chop it up into smaller 1/4-inch chunks. To make this recipe vegetarian, omit the dried shrimp and use four or five dried shiitake mushrooms, rehydrated, and sliced thin.

Rehydrate the dried shrimp:
Place the dried shrimp in a small bowl and pour the boiling water over it. Cover with a small plate and let sit for 30 minutes so the shrimp can rehydrate. The shrimp will be lighter in color and plump up slightly.

Prep the cabbage:
Meanwhile, split the napa cabbage in half lengthwise. Rinse the cabbage and shake it dry. Cut out the core of the cabbage and discard.

Set out two large bowls. Cut the remaining cabbage into 1-inch pieces, putting the thicker white pieces at the bottom of the cabbage into one bowl and the top thinner leafy green pieces into the other bowl.

Drain the shrimp:
Once the shrimp has rehydrated, drain it and discard the liquid.

Cook the shrimp and cabbage:
In a large wok or skillet over high heat add the peanut oil, swirling it around to coat the pan.

Heat until the oil looks shimmering hot, then carefully add the scallions, ginger, and rehydrated shrimp, paying specially attention as the wet ingredients may cause the hot oil to splatter. Toss with a spatula until the scallions are bright green and the entire mixture is fragrant, about 1 minute.

Add the thicker white part of the napa cabbage to the pan and lower the heat to medium high. Continue to cook and stir for 3 to 4 minutes, or until the edges of the cabbage pieces start to look slightly translucent but the center of the cabbage pieces are still opaque white.

Reduce the heat to medium low and add the leafy green pieces of cabbage into the pan. Cook until the leaves are wilted, about 2 minutes.

Make a cornstarch slurry:
In a small bowl, combine the soy sauce, cold water, and cornstarch, stirring to make a slurry. Then pour over the cabbage and continue to cook and stir until a sauce has thickened slightly to the consistency of whole milk.

Season the stir fry:
Season the stir fry with salt and pepper, then taste and add more salt and pepper if you wish. The cabbage will be translucent and silky looking, with specks of dried shrimp all over.', '/static/fotos/53377.jpg'),
(53378, 'Sesame Cucumber Salad', 'Side', 'Chinese', 'Prep the cucumbers:
Peel the cucumbers. Cut them into quarters, lengthwise. (If the seeds are bitter, scrape out the seeds and discard.) Cut the cucumbers again, crosswise, into 1/2-inch thick pieces.

Toss the salad:
Place cucumbers into a serving bowl. Sprinkle with salt. Toss with sesame oil, seasoned rice vinegar, basil (if using), and chili flakes. Sprinkle with toasted sesame seeds if using.', '/static/fotos/53378.jpg'),
(53379, 'Dutch poffertjes (mini pancakes)', 'Breakfast', 'Netherlands', 'Mix the dry yeast with some of the luke warm milk en stir until dissolved.
Place buckwheat and the flour together in a bowl and make a small circle in the middle. Add the yeast mixture into it. Add the milk and stir until you have a smooth batter.
Add the eggs, salt and vanille sugar and stir through. Leave to stand and rise for about 45 minutes.
Heat the poffertjespan and add a bit of butter into each hole. Fill halfway with batter and first bake one side until you can see the top dry out a little. Turn the poffertjes around with a small fork and bake the other side until cooked and golden brown.
Serve the poffertjes with butter and icing sugar', '/static/fotos/53379.jpg'),
(53380, 'Apple cake', 'Dessert', 'Netherlands', 'Preheat the oven to 180°C. (350˚F) Grease a cake pan and line it with baking paper.
In a large bowl, break the four eggs with the sugar and beat until they have tripled in volume and become fluffy.
Sift the self-rising baking flour and add it to your egg mixture. Fold this over, preserving as much air as possible. Add the melted (and slightly cooled) butter and mix until combined.
Add cinnamon, pinch of salt and vanilla extract.
Add the diced apple to the batter and gently fold them into the batter so that the apple pieces are evenly distributed. You can roll the apple pieces through some more cinnamon.
Pour the batter into the prepared cake pan and smooth the top with a spatula.
Place the apple slices on top of the batter and press lightly. Sprinkle optionally with some almond shavings.
Bake the apple cake in the preheated oven for about 45-50 minutes, or until a wooden skewer comes out clean when inserted into the center of the cake.
Remove the cake from the oven and let it cool in the mold for a few minutes. Then carefully remove the cake from the mold and let cool completely on a wire rack.
Sprinkle the cooled apple cake with powdered sugar', '/static/fotos/53380.jpg'),
(53381, 'Gevulde speculaas', 'Dessert', 'Netherlands', 'Mix the self-rising flour, sugar, speculaas spice mix and salt. Add the butter and milk and knead into a firm ball of dough. Start with 6 tablespoons of milk, if the dough is too stiff you can add more milk.
Wrap the dough in plastic wrap and refrigerate overnight. You can process and bake it immediately, but the flavor will be much better if you let it rest.
Mix the almond paste with half of the beaten egg and knead well. This makes it easier to work with and gives it a better and tastier texture.
Take half of the dough and roll it out to 20 x 20 cm. Place in a baking pan lined with parchment paper. Spread the almond paste mixture evenly. Roll out the remaining dough and place on top of the almond paste.
Brush the top with the remaining beaten egg. Garnish with almonds and top with another layer of egg wash.
Bake the filled speculaas for 40 minutes at 180°C/350℉ (conventional oven) or until done.', '/static/fotos/53381.jpg'),
(53382, 'Dutch stroopwafel', 'Dessert', 'Netherlands', 'Combine milk and yeast in a bowl. Let stand for a moment to allow the yeast to dissolve.
In another bowl, combine flour, butter, sugar, egg, and salt. Pour in the yeast mixture and knead until smooth. Cover the bowl and let the dough rise for one hour.
When the dough is almost ready, make the stroop filling. Combine all the ingredients in a saucepan and stir until the butter is melted and the sugar is dissolved. Let it simmer for a while. The stroop will continue to thicken as it cools.
Shape the dough into balls weighing about 35 grams each. Make a total of 14. Turn your stroopwafel iron on the highest setting.
Place a ball of dough in the iron and close the iron. Don’t flatten the waffle too much; you should still be able to cut through it. Bake for 1-2 minutes until the waffle is nicely golden brown.
When the waffle is done, work quickly. Remove the waffle from the iron and immediately use a round cutter to cut out a nice circle of about 8 to 9 cm (3 to 3.5 inches).
Place the hot waffle on a cutting board and cut horizontally with a sharp knife. The stroopwafel is very hot, so use an oven mitt to hold it in place.
Take half a waffle and spread the (hot!) stroop on it. Place the other half on top, pressing gently if necessary, and place the waffle on a wire rack to cool. Repeat for all the balls.', '/static/fotos/53382.jpg'),
(53383, 'Ramen Noodles with Boiled Egg', 'Miscellaneous', 'Chinese', 'Boil: Bring water to a boil, gently add eggs, and cook for exactly 6½ to 7 minutes.
Ice Bath: Immediately transfer the eggs to a bowl of ice water for 3–5 minutes to stop cooking.
Marinate (Optional but recommended): Peel the eggs and marinate in a mix of 2 tbsp soy sauce, 2 tbsp mirin, 1 tsp sugar, and 4 tbsp water for at least 4 hours (or overnight).
Serve: Slice in half, letting the yolk flow into the broth', '/static/fotos/53383.jpg'),
(53385, 'Boterkoek (Dutch Butter Cake)', 'Dessert', 'Netherlands', 'Preheat the oven to 180°C/350˚F (conventional oven).

Place the softened butter and sugar in the bowl of a stand mixer and whisk until creamy.
Add the flour and salt and knead by hand until you have a smooth dough. Divide into two pieces.
Line the base of a square or round cake tin with baking parchment (not a springform tin) and place the first half of the pastry on top. Flatten with your fingers and a spoon.
Using a teaspoon, sprinkle dollops of dulce de leche over the base. Sprinkle with the chopped chocolate and cover with the second half of the pastry.
This is a bit trickier, but if you don’t get it right, don’t worry, it’ll be fine once it’s baked! Brush the pastry with the beaten egg.
Bake in the oven for about 30 minutes or until golden brown. It will be wobbly. That''s because butter cake only firms up when it cools.
Cut into small pieces when it has cooled completely!
Notes
Storing: Store in an airtight container outside of the fridge for about 2-3 days or in the fridge for 5 days. Freeze for up to three months.', '/static/fotos/53385.jpg'),
(53386, 'Dutch Apple Pie', 'Dessert', 'Netherlands', 'Add the flour, 150 gr of the sugar, pinch of salt and 1 egg yolk in the bowl of a food processor. Cut the butter into small cubes and add to the bowl. Turn this into a firm dough. Don''t over process, you do not want the dough to turn warm. Check if it sticks by pinching it between your fingers.
Turn out onto a piece of plastic wrap. Make a round ball of it by using your hands and roll it into the plastic. Place into the fridge for half an hour to cool.
Take a round baking tin of 22 cm diameter and cover this with baking paper. Brush the sides with butter.
Preheat the oven to 170˚C (340˚F)
Cut the apple into cubes and mix this with the raisins, the left over sugar and the cinnamon.
Place the cooled dough on a flat surface sprinkled with flour and roll out into a thin sheet. Place this into the baking tin and cover the bottom and the sides well. I usually just press it into the tin without rolling it out. I find that the easiest way but it is less smooth. Just do whatever works for you.
Make sure you keep 1/4 of the dough separate to form the strips on the top.

Once the bottom and sides are covered with the dough, take the rusks and crumble them over the bottom. You can use breadcrumbs for this as well. Shake it a bit so it is divided equally across the bottom.
Add the apple mixture and divide well over the tin. Rol out the rest of the dough and cut into strips. Place that over the top of the pie in a diamond shaped pattern. Brush the strokes and sides with the other egg yolk and place in the preaheated oven.
Bake the apple pie for about 1 hour or until golden and cooked through. Leave to cool in the tin and make sure the sides are loose before opening the tin.', '/static/fotos/53386.jpg'),
(53387, 'Dutch Spiced Breakfast Cake (Ontbijtkoek)', 'Dessert', 'Netherlands', 'Preheat the oven to 160˚C (320˚F) Line a cake pan with parchment paper and set aside.

Mix all the dry ingredients together in a large bowl. Place the milk in a small saucepan and heat it until it is almost boiling but not quite.
Pour the milk slowly into the dry ingredients while whisking. Don''t overmix! As soon as it is combined to a smooth batter you pour it into the cake pan. Sprinkle the pearl sugar over the top and bake it in the oven for about 1 hour.
Check after about 50 minutes how the cake is progressing. If a cake tester comes out clean the cake it cooked. If not let it cook for a little longer.', '/static/fotos/53387.jpg'),
(53388, 'Runner Bean Mash (Snijbonen Stamppot)', 'Side', 'Netherlands', 'Wash and chop the runner beans. Place in a saucepan with salted water and bring to a boil.
Cook the beans for about 10 minutes or until al dente. Drain and set aside.
Meanwhile, add the potatoes and cook until tender.
Heat a small skillet with a little butter and sauté the onion until translucent. Add the garlic and cook briefly. Add the runner beans to the pan and stir-fry for a few minutes.
Meanwhile, mash the potatoes with a masher. Add a knob of butter and a splash of milk. Add the bean mixture and grated cheese. Season with salt, pepper and mustard.
Fry the bacon and serve with the bean mash.', '/static/fotos/53388.jpg'),
(53389, 'Apple Potato Mash (Hete bliksem) ', 'Side', 'Netherlands', 'Clean and peel the potatoes and cut them into even size chunks. Boil them in salted water for about 10 min and then add the cleaned and chopped apples into the boiling water. Add the cinnamon stick as well. Leave to boil for another 10 minutes or until both apples and potatoes are to your liking. I like mine to be fairly chunky but that is a personal preference
In the mean time bake the streaky bacon in a dry frying pan until crispy and set aside to drain on paper towels.
Slice a few apple pieces and melt a little butter in a fryin pan. Add the apple slices to it and add a bit of maple syrup into the pan as well as some cinnamon. Let it simmer until the apple is soft.
Prepare a plate with one whisked egg and one plate with sesame seeds. Cut your cheese into the required size. The smaller it is, the easier it is too handle.
Dip the cheese into the egg and make sure it coats all sides. Then dip the cheese into the sesame seeds and make sure it is covered everywhere.
Heat a non stick frying pan on high until nice and hot. Put the cheese slice in and bake until the sesame seeds are brown. You have to do this rather quickly or the cheese will melt completely. Turn and bake the other side.
Drain the apples and potatoes and mash them together. Taste and add cinnamon and salt where needed. Remove the cinnamon stick before mashing', '/static/fotos/53389.jpg'),
(53391, 'Traditional Dutch rice tart (rijstevlaai)', 'Dessert', NULL, 'Heat the oven to 180°C. For the dough, mix flour and sugar in a bowl. Heat the 100 grams of milk to lukewarm and dissolve the yeast in it. Let stand for a while until it starts to bubble. Then add to the flour along with the coconut oil and mix into a smooth dough. Let rise for 30 minutes, covered, in a warm place.
Meanwhile, make the rice pudding by putting the rice with sugar, milk and vanilla extract in a saucepan. Add the cardamom, star anise and cinnamon. Bring to a boil and cook, stirring constantly. Take out the spices. In a small bowl, mix baking soda with lemon juice/apple vinegar. Stir well until baking soda is dissolved, then mix into the rice pudding.
Roll out the dough on a floured work surface (it is very sticky, but don’t stress it will be fine) and line the bottom and edges of a greased mold with it. Spread the rice pudding over the bottom and bake for about 25 to 30 minutes.', '/static/fotos/53391.jpg'),
(53392, 'Arnhemse meisjes', 'Dessert', NULL, 'Take your puff pastry from the freezer and defrost.
Sprinkle some flour on the kitchen counter. Stack the sheets of puff pastry on top of each other and roll them out with a rolling pin. You want those five sheets to end up being as thin as one sheet.

Using a round or oval form press into the puff pastry and try to be as economical doing that as possible. You want to have as many cookies as you can.
Mix the vanilla sugar with the cinnamon, cardemom and limezest in a little bowl
Remove the flour from the counter and sprinkle with a bit of the sugar mix.
Brush your puff pastry with a little bit of eggwash and than dip into the sugar mix and roll them softly to press the sugar in.
Put your sugary puff pastry on a baking sheet (greased or with baking paper) and leave the dough to rest for about 20 to 25 minutes. this will make the cookies even crisper.
Preheat the oven in the meantime to 180 C and put the baking tray in the oven.
bake the cookies golden brown in about 25 minutes and make sure the sugar is caramelised nicely
And voila, Girls from Arnhem with an Almeerse twist
Voila, Arnhemse Meisjes met een Almeerse twist.', '/static/fotos/53392.jpg'),
(53393, 'Dutch doughnuts', 'Dessert', NULL, 'Place the flour in a large bowl and add the yeast and sugar. If the milk is cold make sure to heat it to lukewarm. Mix your flour mixture bit by bit with the milk until you have a smooth batter. Add the salt and mix with a wooden spoon till the batter is smooth and liquidy.
Cover with a clean tea towel and leave in a warm spot for about an hour to rise.

Heat your deep fryer or add the oil to a large pot. The oil should be a t 180˚C (350˚F) for best results.
Before starting stir your batter through and scoop the batter with two spoons or with an ice cream scoop. Let it drop into the oil carefully. It is easiest to do this if you dip your spoons or scoop into the oil before dipping into the batter. That way it will slide of the spoons easily. Don''t over crowd the fryer to prevent the oil cooling down too quickly and everything sticking together. Once one side is golden brown it usually turns around to the other side automatically. If not help it along with two forks.
Take the balls out once golden brown and leave to drain on a piece of kitchen paper.', '/static/fotos/53393.jpg'),
(53394, 'Zeeuwse bolussen', 'Dessert', NULL, 'Place the dried yeast, milk and sugar in the bowl of your food processor. Mix and let stand for a few minutes until it begins to foam.
Then add the flour, egg, butter, salt, 1 tsp of cinnamon and cardamom and process until smooth.
Form the dough into a ball, cover the bowl and let it rise for 1 hour or until it has doubled in size.
Mix the caster sugar with 1 tablespoon of cinnamon, pour over the dough and roll it in.
Form 10 equal balls (about 75 grams each) and let them “sweat” for a while. The sugar will dissolve a little. When you roll them again later, the rest of the dough will absorb the sugar better.
Then roll the ball into a strand about 35-40 centimeters long while rolling through the powdered sugar.
Fold the strand around one end and tuck the other end under the bolus. Push something between the roll to secure the end.
Place on a baking sheet lined with a baking sheet, cover with plastic wrap and let them rise for ½-1 hour.
Meanwhile, preheat the oven to 250 degrees Celsius/480 Fahrenheit top and bottom heat
Bake the Zeeland Boluses for about 8 minutes until done. Be careful – if you bake them too long, they will get dry and you will want something sticky 😉 .
Let them cool out of the oven for 1 minute, then turn them over and let them cool further (on a wire rack if necessary). Enjoy!', '/static/fotos/53394.jpg'),
(53395, 'Slagroomtaart', 'Dessert', NULL, 'Beat the eggs, sugar and vanilla sugar until light and fluffy. I beat this in a stand mixer on medium-high speed for about 10 minutes.
Sift the flour and cornstarch and add to the mixture. Fold this gently into the mixture; you don’t want all the air you whipped in to disappear.
Pour the batter into a greased baking pan. Bake the cake base at 180°C/350°F (conventional oven) for 30 minutes. The cake is done when you press lightly on the top and it springs back. Allow the cake to cool in the pan for a few minutes before removing it to a cake rack.
Meanwhile, prepare the nougatine and jam according to the recipe if you haven’t already.
Let the cake cool completely before you cut it. If, like me, you used a 20 cm/8 inch spring form pan, cut the cake into three layers.', '/static/fotos/53395.jpg');

INSERT INTO meal_ingredients (meal_id, ingredient_id) VALUES
(52764, 161),
(52764, 163),
(52764, 211),
(52764, 302),
(52764, 461),
(52764, 496),
(52764, 593),
(52764, 816),
(52765, 134),
(52765, 198),
(52765, 266),
(52765, 677),
(52767, 7),
(52767, 92),
(52767, 117),
(52767, 145),
(52767, 188),
(52767, 290),
(52767, 296),
(52767, 350),
(52767, 556),
(52767, 591),
(52768, 7),
(52768, 74),
(52768, 92),
(52768, 117),
(52768, 230),
(52768, 290),
(52768, 297),
(52768, 350),
(52768, 643),
(52769, 212),
(52769, 234),
(52769, 304),
(52769, 320),
(52769, 336),
(52769, 386),
(52769, 431),
(52769, 754),
(52770, 244),
(52770, 315),
(52770, 382),
(52770, 421),
(52770, 481),
(52770, 496),
(52770, 499),
(52770, 519),
(52770, 699),
(52770, 756),
(52770, 758),
(52770, 828),
(52771, 37),
(52771, 163),
(52771, 315),
(52771, 393),
(52771, 496),
(52771, 521),
(52771, 536),
(52771, 599),
(52772, 84),
(52772, 86),
(52772, 134),
(52772, 201),
(52772, 358),
(52772, 461),
(52772, 696),
(52772, 709),
(52772, 801),
(52773, 496),
(52773, 638),
(52773, 639),
(52773, 662),
(52773, 696),
(52774, 131),
(52774, 152),
(52774, 225),
(52774, 256),
(52774, 315),
(52774, 508),
(52774, 530),
(52774, 618),
(52774, 696),
(52774, 718),
(52774, 801),
(52774, 815),
(52775, 112),
(52775, 193),
(52775, 293),
(52775, 347),
(52775, 420),
(52775, 483),
(52775, 497),
(52775, 698),
(52775, 701),
(52775, 787),
(52775, 799),
(52775, 836),
(52776, 92),
(52776, 264),
(52776, 293),
(52776, 339),
(52776, 458),
(52776, 555),
(52777, 25),
(52777, 269),
(52777, 272),
(52777, 300),
(52777, 345),
(52777, 477),
(52777, 537),
(52777, 641),
(52777, 763),
(52779, 37),
(52779, 92),
(52779, 126),
(52779, 256),
(52779, 264),
(52779, 293),
(52779, 380),
(52779, 458),
(52779, 520),
(52779, 559),
(52779, 641),
(52779, 815),
(52780, 27),
(52780, 134),
(52780, 138),
(52780, 209),
(52780, 496),
(52780, 499),
(52780, 519),
(52780, 533),
(52780, 574),
(52780, 701),
(52781, 112),
(52781, 117),
(52781, 120),
(52781, 124),
(52781, 138),
(52781, 301),
(52781, 414),
(52781, 496),
(52781, 504),
(52781, 666),
(52781, 770),
(52781, 816),
(52781, 821),
(52782, 39),
(52782, 117),
(52782, 162),
(52782, 172),
(52782, 177),
(52782, 193),
(52782, 276),
(52782, 315),
(52782, 324),
(52782, 415),
(52782, 425),
(52782, 496),
(52782, 497),
(52782, 574),
(52782, 758),
(52782, 797),
(52783, 13),
(52783, 38),
(52783, 117),
(52783, 163),
(52783, 276),
(52783, 277),
(52783, 315),
(52783, 392),
(52783, 496),
(52783, 497),
(52783, 535),
(52783, 553),
(52783, 607),
(52783, 623),
(52783, 691),
(52784, 14),
(52784, 83),
(52784, 112),
(52784, 115),
(52784, 144),
(52784, 172),
(52784, 180),
(52784, 193),
(52784, 213),
(52784, 229),
(52784, 244),
(52784, 315),
(52784, 423),
(52784, 496),
(52784, 497),
(52784, 653),
(52784, 689),
(52784, 703),
(52784, 801),
(52785, 40),
(52785, 163),
(52785, 170),
(52785, 214),
(52785, 314),
(52785, 323),
(52785, 324),
(52785, 344),
(52785, 485),
(52785, 602),
(52785, 641),
(52785, 718),
(52785, 759),
(52785, 768),
(52785, 801),
(52786, 159),
(52786, 464),
(52786, 528),
(52786, 531),
(52786, 783),
(52787, 159),
(52787, 189),
(52787, 374),
(52787, 464),
(52787, 783),
(52787, 809),
(52788, 165),
(52788, 224),
(52788, 334),
(52788, 500),
(52788, 628),
(52788, 643),
(52791, 236),
(52791, 325),
(52791, 457),
(52791, 465),
(52791, 712),
(52792, 76),
(52792, 92),
(52792, 172),
(52792, 236),
(52792, 264),
(52792, 458),
(52792, 492),
(52792, 718),
(52792, 721),
(52793, 56),
(52793, 63),
(52793, 92),
(52793, 226),
(52793, 236),
(52793, 264),
(52793, 388),
(52793, 455),
(52793, 458),
(52793, 480),
(52793, 657),
(52793, 783),
(52793, 801),
(52794, 9),
(52794, 31),
(52794, 97),
(52794, 179),
(52794, 292),
(52794, 657),
(52794, 781),
(52794, 801),
(52795, 131),
(52795, 149),
(52795, 195),
(52795, 205),
(52795, 214),
(52795, 278),
(52795, 314),
(52795, 315),
(52795, 327),
(52795, 344),
(52795, 497),
(52795, 641),
(52795, 758),
(52795, 769),
(52795, 790),
(52795, 835),
(52796, 72),
(52796, 82),
(52796, 92),
(52796, 131),
(52796, 315),
(52796, 374),
(52796, 458),
(52796, 481),
(52796, 496),
(52796, 497),
(52796, 520),
(52796, 522),
(52796, 537),
(52796, 603),
(52796, 641),
(52796, 703),
(52796, 816),
(52797, 280),
(52797, 372),
(52797, 424),
(52797, 465),
(52797, 496),
(52797, 537),
(52797, 544),
(52797, 627),
(52797, 641),
(52797, 687),
(52797, 702),
(52802, 118),
(52802, 232),
(52802, 236),
(52802, 295),
(52802, 399),
(52802, 423),
(52802, 424),
(52802, 492),
(52802, 496),
(52802, 522),
(52802, 556),
(52802, 576),
(52802, 658),
(52802, 812),
(52803, 46),
(52803, 263),
(52803, 268),
(52803, 293),
(52803, 481),
(52803, 496),
(52803, 518),
(52803, 580),
(52804, 48),
(52804, 127),
(52804, 574),
(52804, 790),
(52805, 39),
(52805, 40),
(52805, 58),
(52805, 110),
(52805, 114),
(52805, 170),
(52805, 172),
(52805, 178),
(52805, 214),
(52805, 311),
(52805, 315),
(52805, 323),
(52805, 326),
(52805, 405),
(52805, 411),
(52805, 465),
(52805, 499),
(52805, 600),
(52805, 636),
(52806, 140),
(52806, 149),
(52806, 314),
(52806, 317),
(52806, 324),
(52806, 342),
(52806, 357),
(52806, 429),
(52806, 517),
(52806, 601),
(52806, 768),
(52806, 790),
(52807, 19),
(52807, 194),
(52807, 315),
(52807, 344),
(52807, 495),
(52807, 497),
(52807, 600),
(52807, 641),
(52807, 758),
(52808, 40),
(52808, 110),
(52808, 173),
(52808, 178),
(52808, 193),
(52808, 315),
(52808, 324),
(52808, 342),
(52808, 411),
(52808, 441),
(52808, 497),
(52808, 517),
(52808, 724),
(52808, 756),
(52809, 110),
(52809, 173),
(52809, 178),
(52809, 213),
(52809, 315),
(52809, 324),
(52809, 440),
(52809, 495),
(52809, 537),
(52809, 598),
(52809, 718),
(52809, 739),
(52809, 768),
(52809, 799),
(52810, 40),
(52810, 92),
(52810, 112),
(52810, 121),
(52810, 138),
(52810, 251),
(52810, 275),
(52810, 293),
(52810, 315),
(52810, 426),
(52810, 448),
(52810, 496),
(52810, 497),
(52810, 503),
(52810, 522),
(52810, 758),
(52810, 786),
(52811, 102),
(52811, 103),
(52811, 112),
(52811, 121),
(52811, 315),
(52811, 404),
(52811, 496),
(52811, 497),
(52811, 519),
(52811, 601),
(52811, 631),
(52811, 748),
(52811, 801),
(52811, 822),
(52812, 41),
(52812, 44),
(52812, 50),
(52812, 112),
(52812, 315),
(52812, 483),
(52812, 497),
(52812, 574),
(52812, 631),
(52812, 641),
(52812, 748),
(52813, 4),
(52813, 37),
(52813, 61),
(52813, 86),
(52813, 122),
(52813, 131),
(52813, 144),
(52813, 262),
(52813, 293),
(52813, 319),
(52813, 448),
(52813, 495),
(52813, 498),
(52813, 504),
(52813, 517),
(52813, 637),
(52813, 641),
(52814, 37),
(52814, 131),
(52814, 184),
(52814, 315),
(52814, 343),
(52814, 433),
(52814, 574),
(52814, 613),
(52814, 718),
(52814, 724),
(52814, 745),
(52814, 746),
(52815, 40),
(52815, 112),
(52815, 121),
(52815, 299),
(52815, 315),
(52815, 496),
(52815, 497),
(52815, 641),
(52815, 748),
(52816, 14),
(52816, 41),
(52816, 83),
(52816, 112),
(52816, 121),
(52816, 258),
(52816, 315),
(52816, 496),
(52816, 497),
(52816, 522),
(52816, 537),
(52816, 544),
(52816, 631),
(52816, 641),
(52816, 801),
(52817, 128),
(52817, 143),
(52817, 258),
(52817, 342),
(52817, 357),
(52817, 372),
(52817, 496),
(52817, 522),
(52818, 125),
(52818, 133),
(52818, 138),
(52818, 270),
(52818, 315),
(52818, 374),
(52818, 439),
(52818, 496),
(52818, 497),
(52818, 522),
(52818, 602),
(52818, 641),
(52819, 20),
(52819, 98),
(52819, 119),
(52819, 294),
(52819, 315),
(52819, 424),
(52819, 438),
(52819, 640),
(52819, 694),
(52819, 702),
(52819, 790),
(52819, 811),
(52820, 40),
(52820, 79),
(52820, 111),
(52820, 133),
(52820, 138),
(52820, 216),
(52820, 256),
(52820, 314),
(52820, 315),
(52820, 380),
(52820, 499),
(52820, 556),
(52820, 696),
(52820, 724),
(52820, 790),
(52821, 184),
(52821, 193),
(52821, 287),
(52821, 408),
(52821, 433),
(52821, 496),
(52821, 598),
(52821, 616),
(52821, 747),
(52821, 793),
(52822, 128),
(52822, 264),
(52822, 381),
(52822, 458),
(52822, 556),
(52822, 647),
(52822, 790),
(52823, 18),
(52823, 61),
(52823, 92),
(52823, 408),
(52823, 424),
(52823, 497),
(52823, 519),
(52823, 613),
(52823, 639),
(52823, 792),
(52823, 816),
(52824, 43),
(52824, 82),
(52824, 112),
(52824, 264),
(52824, 458),
(52824, 556),
(52824, 574),
(52824, 724),
(52826, 4),
(52826, 12),
(52826, 32),
(52826, 41),
(52826, 43),
(52826, 69),
(52826, 164),
(52826, 173),
(52826, 178),
(52826, 213),
(52826, 220),
(52826, 315),
(52826, 496),
(52826, 499),
(52826, 504),
(52826, 559),
(52826, 755),
(52827, 43),
(52827, 86),
(52827, 146),
(52827, 173),
(52827, 182),
(52827, 287),
(52827, 397),
(52827, 433),
(52827, 452),
(52827, 497),
(52827, 531),
(52827, 574),
(52827, 740),
(52828, 123),
(52828, 212),
(52828, 260),
(52828, 287),
(52828, 315),
(52828, 465),
(52828, 496),
(52828, 531),
(52828, 537),
(52828, 564),
(52828, 619),
(52828, 696),
(52828, 718),
(52829, 61),
(52829, 76),
(52829, 92),
(52829, 119),
(52829, 125),
(52829, 187),
(52829, 319),
(52829, 374),
(52829, 410),
(52829, 439),
(52829, 474),
(52829, 484),
(52829, 556),
(52829, 820),
(52830, 20),
(52830, 134),
(52830, 213),
(52830, 315),
(52830, 341),
(52830, 348),
(52830, 370),
(52830, 394),
(52830, 458),
(52830, 611),
(52830, 676),
(52830, 689),
(52830, 694),
(52830, 796),
(52831, 131),
(52831, 315),
(52831, 324),
(52831, 339),
(52831, 424),
(52831, 573),
(52831, 638),
(52831, 696),
(52831, 790),
(52832, 27),
(52832, 41),
(52832, 75),
(52832, 92),
(52832, 129),
(52832, 134),
(52832, 136),
(52832, 138),
(52832, 140),
(52832, 315),
(52832, 496),
(52832, 522),
(52832, 556),
(52832, 607),
(52832, 631),
(52832, 666),
(52832, 748),
(52832, 756),
(52833, 92),
(52833, 106),
(52833, 107),
(52833, 206),
(52833, 230),
(52833, 236),
(52833, 390),
(52833, 577),
(52833, 653),
(52833, 752),
(52833, 783),
(52834, 46),
(52834, 50),
(52834, 92),
(52834, 209),
(52834, 268),
(52834, 315),
(52834, 481),
(52834, 496),
(52834, 499),
(52834, 522),
(52834, 556),
(52835, 92),
(52835, 176),
(52835, 197),
(52835, 281),
(52835, 492),
(52835, 520),
(52835, 522),
(52836, 26),
(52836, 288),
(52836, 315),
(52836, 424),
(52836, 473),
(52836, 482),
(52836, 496),
(52836, 499),
(52836, 517),
(52836, 522),
(52836, 576),
(52836, 636),
(52836, 758),
(52836, 794),
(52837, 60),
(52837, 315),
(52837, 496),
(52837, 497),
(52837, 519),
(52837, 543),
(52837, 598),
(52837, 699),
(52837, 756),
(52838, 41),
(52838, 139),
(52838, 163),
(52838, 172),
(52838, 252),
(52838, 315),
(52838, 458),
(52838, 496),
(52838, 499),
(52838, 510),
(52838, 520),
(52838, 556),
(52838, 607),
(52838, 631),
(52838, 718),
(52839, 38),
(52839, 76),
(52839, 117),
(52839, 128),
(52839, 305),
(52839, 317),
(52839, 408),
(52839, 431),
(52839, 433),
(52839, 436),
(52839, 496),
(52839, 598),
(52839, 719),
(52840, 27),
(52840, 40),
(52840, 92),
(52840, 174),
(52840, 236),
(52840, 458),
(52840, 497),
(52840, 522),
(52840, 556),
(52840, 574),
(52840, 748),
(52841, 40),
(52841, 112),
(52841, 121),
(52841, 163),
(52841, 496),
(52841, 499),
(52841, 523),
(52841, 574),
(52841, 718),
(52841, 756),
(52841, 793),
(52841, 815),
(52841, 820),
(52842, 82),
(52842, 92),
(52842, 121),
(52842, 423),
(52842, 497),
(52842, 574),
(52842, 588),
(52842, 708),
(52842, 792),
(52843, 16),
(52843, 94),
(52843, 112),
(52843, 172),
(52843, 203),
(52843, 213),
(52843, 315),
(52843, 324),
(52843, 380),
(52843, 413),
(52843, 496),
(52843, 497),
(52843, 522),
(52843, 636),
(52843, 793),
(52844, 27),
(52844, 38),
(52844, 112),
(52844, 121),
(52844, 163),
(52844, 209),
(52844, 315),
(52844, 380),
(52844, 420),
(52844, 460),
(52844, 477),
(52844, 496),
(52844, 497),
(52844, 520),
(52844, 756),
(52845, 35),
(52845, 79),
(52845, 103),
(52845, 264),
(52845, 315),
(52845, 496),
(52845, 497),
(52845, 522),
(52845, 756),
(52845, 766),
(52845, 828),
(52846, 92),
(52846, 131),
(52846, 139),
(52846, 481),
(52846, 484),
(52846, 492),
(52846, 497),
(52846, 556),
(52846, 574),
(52846, 733),
(52847, 76),
(52847, 79),
(52847, 82),
(52847, 112),
(52847, 277),
(52847, 315),
(52847, 335),
(52847, 371),
(52847, 495),
(52847, 497),
(52847, 522),
(52847, 564),
(52847, 609),
(52847, 631),
(52847, 756),
(52847, 792),
(52848, 63),
(52848, 93),
(52848, 268),
(52848, 647),
(52848, 757),
(52849, 38),
(52849, 103),
(52849, 117),
(52849, 163),
(52849, 315),
(52849, 451),
(52849, 458),
(52849, 476),
(52849, 492),
(52849, 496),
(52849, 519),
(52849, 609),
(52849, 622),
(52849, 701),
(52850, 133),
(52850, 138),
(52850, 143),
(52850, 193),
(52850, 203),
(52850, 237),
(52850, 324),
(52850, 372),
(52850, 496),
(52850, 497),
(52851, 134),
(52851, 138),
(52851, 193),
(52851, 315),
(52851, 324),
(52851, 342),
(52851, 528),
(52851, 598),
(52851, 724),
(52852, 105),
(52852, 264),
(52852, 496),
(52852, 574),
(52852, 601),
(52852, 609),
(52852, 701),
(52852, 724),
(52852, 763),
(52853, 20),
(52853, 34),
(52853, 97),
(52853, 380),
(52853, 425),
(52853, 653),
(52853, 781),
(52853, 801),
(52854, 66),
(52854, 264),
(52854, 293),
(52854, 458),
(52854, 590),
(52854, 718),
(52854, 724),
(52855, 31),
(52855, 34),
(52855, 264),
(52855, 495),
(52855, 534),
(52855, 590),
(52855, 783),
(52856, 92),
(52856, 206),
(52856, 219),
(52856, 222),
(52856, 264),
(52856, 390),
(52856, 432),
(52856, 446),
(52856, 534),
(52856, 556),
(52856, 783),
(52857, 92),
(52857, 117),
(52857, 172),
(52857, 264),
(52857, 390),
(52857, 458),
(52857, 492),
(52857, 556),
(52857, 582),
(52857, 641),
(52857, 672),
(52858, 92),
(52858, 117),
(52858, 206),
(52858, 264),
(52858, 425),
(52858, 556),
(52858, 694),
(52858, 718),
(52859, 92),
(52859, 189),
(52859, 230),
(52859, 236),
(52859, 263),
(52859, 390),
(52859, 433),
(52860, 180),
(52860, 221),
(52860, 264),
(52860, 432),
(52860, 459),
(52860, 556),
(52860, 590),
(52860, 643),
(52861, 92),
(52861, 236),
(52861, 321),
(52861, 334),
(52861, 432),
(52861, 458),
(52861, 527),
(52861, 528),
(52861, 529),
(52861, 622),
(52862, 66),
(52862, 92),
(52862, 117),
(52862, 172),
(52862, 197),
(52862, 458),
(52862, 480),
(52862, 500),
(52862, 526),
(52862, 657),
(52863, 112),
(52863, 121),
(52863, 202),
(52863, 213),
(52863, 315),
(52863, 430),
(52863, 497),
(52863, 517),
(52863, 588),
(52863, 602),
(52863, 748),
(52863, 754),
(52863, 793),
(52863, 833),
(52864, 79),
(52864, 123),
(52864, 130),
(52864, 315),
(52864, 420),
(52864, 481),
(52864, 631),
(52864, 637),
(52864, 696),
(52864, 762),
(52864, 816),
(52864, 825),
(52865, 193),
(52865, 213),
(52865, 314),
(52865, 324),
(52865, 344),
(52865, 486),
(52865, 516),
(52865, 533),
(52865, 724),
(52865, 754),
(52865, 768),
(52866, 94),
(52866, 315),
(52866, 436),
(52866, 496),
(52866, 637),
(52867, 163),
(52867, 406),
(52867, 468),
(52867, 626),
(52868, 39),
(52868, 163),
(52868, 193),
(52868, 213),
(52868, 314),
(52868, 315),
(52868, 324),
(52868, 406),
(52868, 497),
(52868, 517),
(52868, 790),
(52869, 202),
(52869, 315),
(52869, 343),
(52869, 404),
(52869, 424),
(52869, 430),
(52869, 496),
(52869, 601),
(52869, 737),
(52869, 833),
(52870, 20),
(52870, 143),
(52870, 193),
(52870, 198),
(52870, 372),
(52870, 433),
(52870, 496),
(52870, 517),
(52870, 601),
(52870, 609),
(52870, 694),
(52870, 758),
(52871, 95),
(52871, 117),
(52871, 466),
(52871, 497),
(52871, 664),
(52871, 671),
(52871, 696),
(52871, 702),
(52871, 771),
(52871, 828),
(52872, 29),
(52872, 92),
(52872, 264),
(52872, 315),
(52872, 496),
(52872, 497),
(52872, 522),
(52872, 574),
(52872, 798),
(52873, 31),
(52873, 40),
(52873, 43),
(52873, 50),
(52873, 92),
(52873, 112),
(52873, 121),
(52873, 315),
(52873, 423),
(52873, 496),
(52873, 499),
(52873, 522),
(52873, 556),
(52873, 607),
(52873, 717),
(52873, 726),
(52873, 748),
(52873, 801),
(52874, 43),
(52874, 50),
(52874, 92),
(52874, 112),
(52874, 263),
(52874, 343),
(52874, 483),
(52874, 497),
(52874, 537),
(52874, 556),
(52874, 580),
(52874, 588),
(52874, 607),
(52874, 641),
(52874, 748),
(52875, 92),
(52875, 133),
(52875, 138),
(52875, 188),
(52875, 236),
(52875, 296),
(52875, 315),
(52875, 369),
(52875, 423),
(52875, 458),
(52875, 537),
(52875, 556),
(52875, 653),
(52875, 816),
(52876, 50),
(52876, 263),
(52876, 460),
(52876, 481),
(52876, 497),
(52876, 556),
(52876, 672),
(52876, 756),
(52876, 790),
(52876, 828),
(52877, 112),
(52877, 264),
(52877, 293),
(52877, 417),
(52877, 497),
(52877, 574),
(52877, 672),
(52877, 790),
(52877, 792),
(52878, 27),
(52878, 40),
(52878, 43),
(52878, 50),
(52878, 92),
(52878, 197),
(52878, 264),
(52878, 315),
(52878, 496),
(52878, 509),
(52878, 556),
(52878, 641),
(52878, 666),
(52878, 711),
(52878, 748),
(52879, 60),
(52879, 92),
(52879, 112),
(52879, 121),
(52879, 131),
(52879, 138),
(52879, 236),
(52879, 263),
(52879, 317),
(52879, 366),
(52879, 522),
(52879, 574),
(52879, 666),
(52879, 750),
(52879, 756),
(52879, 816),
(52880, 193),
(52880, 213),
(52880, 263),
(52880, 317),
(52880, 344),
(52880, 415),
(52880, 419),
(52880, 458),
(52880, 492),
(52880, 537),
(52880, 556),
(52880, 588),
(52880, 601),
(52880, 602),
(52880, 641),
(52881, 43),
(52881, 50),
(52881, 262),
(52881, 263),
(52881, 412),
(52881, 499),
(52881, 537),
(52881, 556),
(52881, 580),
(52881, 641),
(52881, 790),
(52881, 828),
(52882, 92),
(52882, 118),
(52882, 264),
(52882, 367),
(52882, 423),
(52882, 458),
(52882, 522),
(52882, 556),
(52882, 574),
(52882, 639),
(52882, 688),
(52882, 816),
(52883, 31),
(52883, 56),
(52883, 63),
(52883, 92),
(52883, 236),
(52883, 264),
(52883, 458),
(52883, 480),
(52883, 657),
(52883, 783),
(52884, 41),
(52884, 92),
(52884, 112),
(52884, 138),
(52884, 411),
(52884, 412),
(52884, 499),
(52884, 556),
(52884, 574),
(52884, 828),
(52886, 117),
(52886, 215),
(52886, 217),
(52886, 424),
(52886, 458),
(52886, 500),
(52886, 641),
(52886, 657),
(52886, 717),
(52887, 41),
(52887, 193),
(52887, 216),
(52887, 264),
(52887, 458),
(52887, 497),
(52887, 522),
(52887, 613),
(52887, 688),
(52887, 790),
(52888, 4),
(52888, 92),
(52888, 172),
(52888, 215),
(52888, 264),
(52888, 324),
(52888, 424),
(52888, 469),
(52888, 480),
(52888, 556),
(52888, 718),
(52889, 64),
(52889, 76),
(52889, 117),
(52889, 590),
(52889, 610),
(52889, 712),
(52890, 92),
(52890, 217),
(52890, 458),
(52890, 591),
(52890, 657),
(52890, 717),
(52890, 781),
(52891, 31),
(52891, 64),
(52891, 92),
(52891, 117),
(52891, 236),
(52891, 373),
(52891, 424),
(52891, 425),
(52891, 465),
(52891, 556),
(52891, 718),
(52891, 835),
(52892, 79),
(52892, 92),
(52892, 264),
(52892, 334),
(52892, 429),
(52892, 556),
(52893, 64),
(52893, 73),
(52893, 92),
(52893, 117),
(52893, 172),
(52893, 226),
(52893, 388),
(52893, 556),
(52894, 7),
(52894, 11),
(52894, 16),
(52894, 31),
(52894, 92),
(52894, 117),
(52894, 264),
(52894, 390),
(52894, 450),
(52894, 548),
(52894, 657),
(52894, 783),
(52895, 27),
(52895, 62),
(52895, 76),
(52895, 264),
(52895, 481),
(52895, 647),
(52895, 758),
(52896, 27),
(52896, 30),
(52896, 62),
(52896, 76),
(52896, 264),
(52896, 481),
(52896, 647),
(52896, 758),
(52897, 56),
(52897, 92),
(52897, 112),
(52897, 117),
(52897, 172),
(52897, 206),
(52897, 264),
(52897, 556),
(52897, 641),
(52897, 718),
(52897, 790),
(52897, 800),
(52898, 86),
(52898, 92),
(52898, 117),
(52898, 172),
(52898, 241),
(52898, 264),
(52898, 458),
(52898, 641),
(52898, 790),
(52898, 813),
(52898, 830),
(52899, 11),
(52899, 17),
(52899, 31),
(52899, 92),
(52899, 117),
(52899, 241),
(52899, 264),
(52899, 328),
(52899, 350),
(52899, 458),
(52899, 480),
(52899, 500),
(52899, 556),
(52900, 92),
(52900, 117),
(52900, 264),
(52900, 424),
(52900, 458),
(52900, 469),
(52900, 657),
(52901, 31),
(52901, 92),
(52901, 117),
(52901, 241),
(52901, 264),
(52901, 458),
(52901, 657),
(52901, 783),
(52902, 63),
(52902, 86),
(52902, 92),
(52902, 256),
(52902, 334),
(52902, 358),
(52902, 458),
(52902, 493),
(52902, 657),
(52903, 50),
(52903, 76),
(52903, 92),
(52903, 118),
(52903, 251),
(52903, 317),
(52903, 496),
(52903, 497),
(52903, 556),
(52903, 718),
(52904, 27),
(52904, 40),
(52904, 49),
(52904, 71),
(52904, 110),
(52904, 120),
(52904, 123),
(52904, 129),
(52904, 317),
(52904, 335),
(52904, 496),
(52904, 607),
(52904, 631),
(52904, 748),
(52904, 756),
(52905, 92),
(52905, 117),
(52905, 221),
(52905, 236),
(52905, 262),
(52905, 263),
(52905, 390),
(52905, 683),
(52906, 92),
(52906, 125),
(52906, 209),
(52906, 256),
(52906, 263),
(52906, 419),
(52906, 423),
(52906, 492),
(52906, 556),
(52906, 641),
(52906, 801),
(52907, 40),
(52907, 252),
(52907, 315),
(52907, 653),
(52907, 748),
(52907, 816),
(52908, 19),
(52908, 37),
(52908, 202),
(52908, 317),
(52908, 496),
(52908, 497),
(52908, 609),
(52908, 718),
(52908, 754),
(52908, 833),
(52909, 73),
(52909, 92),
(52909, 117),
(52909, 209),
(52909, 556),
(52909, 580),
(52910, 73),
(52910, 110),
(52910, 209),
(52910, 219),
(52910, 390),
(52910, 580),
(52910, 608),
(52911, 37),
(52911, 103),
(52911, 202),
(52911, 317),
(52911, 343),
(52911, 423),
(52911, 519),
(52911, 588),
(52911, 758),
(52911, 792),
(52912, 41),
(52912, 92),
(52912, 118),
(52912, 119),
(52912, 236),
(52912, 264),
(52912, 268),
(52912, 331),
(52912, 458),
(52912, 519),
(52912, 556),
(52912, 701),
(52913, 80),
(52913, 92),
(52913, 117),
(52913, 264),
(52913, 458),
(52913, 556),
(52913, 578),
(52913, 830),
(52914, 496),
(52914, 499),
(52914, 574),
(52914, 748),
(52914, 792),
(52915, 92),
(52915, 118),
(52915, 158),
(52915, 264),
(52915, 519),
(52915, 522),
(52915, 742),
(52916, 75),
(52916, 92),
(52916, 110),
(52916, 117),
(52916, 172),
(52916, 532),
(52916, 580),
(52916, 706),
(52917, 117),
(52917, 236),
(52917, 263),
(52917, 781),
(52917, 809),
(52918, 40),
(52918, 76),
(52918, 163),
(52918, 251),
(52918, 275),
(52918, 288),
(52918, 315),
(52918, 372),
(52918, 482),
(52918, 496),
(52918, 497),
(52918, 500),
(52918, 574),
(52918, 576),
(52918, 706),
(52918, 748),
(52918, 756),
(52918, 811),
(52919, 92),
(52919, 236),
(52919, 275),
(52919, 315),
(52919, 458),
(52919, 520),
(52919, 574),
(52920, 60),
(52920, 136),
(52920, 139),
(52920, 481),
(52920, 496),
(52920, 522),
(52920, 523),
(52921, 37),
(52921, 158),
(52921, 202),
(52921, 206),
(52921, 264),
(52921, 317),
(52921, 458),
(52921, 496),
(52921, 519),
(52921, 598),
(52921, 602),
(52921, 627),
(52921, 702),
(52922, 75),
(52922, 112),
(52922, 163),
(52922, 236),
(52922, 251),
(52922, 275),
(52922, 288),
(52922, 496),
(52922, 497),
(52922, 517),
(52922, 576),
(52922, 749),
(52923, 92),
(52923, 264),
(52923, 480),
(52923, 587),
(52923, 672),
(52923, 683),
(52923, 783),
(52923, 800),
(52924, 11),
(52924, 92),
(52924, 117),
(52924, 180),
(52924, 217),
(52924, 218),
(52924, 221),
(52924, 227),
(52924, 230),
(52924, 236),
(52924, 256),
(52924, 390),
(52925, 41),
(52925, 76),
(52925, 112),
(52925, 121),
(52925, 307),
(52925, 369),
(52925, 499),
(52925, 533),
(52926, 4),
(52926, 172),
(52926, 256),
(52926, 317),
(52926, 462),
(52926, 492),
(52926, 497),
(52926, 574),
(52926, 672),
(52926, 724),
(52926, 792),
(52927, 40),
(52927, 44),
(52927, 61),
(52927, 122),
(52927, 178),
(52927, 193),
(52927, 232),
(52927, 268),
(52927, 315),
(52927, 497),
(52927, 517),
(52927, 603),
(52927, 641),
(52927, 718),
(52928, 92),
(52928, 172),
(52928, 264),
(52928, 293),
(52928, 424),
(52928, 458),
(52928, 495),
(52928, 641),
(52928, 718),
(52928, 801),
(52928, 830),
(52929, 31),
(52929, 256),
(52929, 293),
(52929, 390),
(52929, 458),
(52929, 495),
(52929, 641),
(52929, 718),
(52930, 92),
(52930, 208),
(52930, 458),
(52930, 460),
(52930, 497),
(52930, 517),
(52930, 522),
(52930, 537),
(52930, 574),
(52930, 641),
(52931, 86),
(52931, 92),
(52931, 264),
(52931, 458),
(52931, 556),
(52931, 641),
(52931, 783),
(52932, 31),
(52932, 86),
(52932, 92),
(52932, 264),
(52932, 293),
(52932, 446),
(52932, 458),
(52932, 683),
(52932, 718),
(52932, 783),
(52933, 61),
(52933, 92),
(52933, 133),
(52933, 138),
(52933, 499),
(52933, 574),
(52933, 641),
(52934, 39),
(52934, 41),
(52934, 60),
(52934, 92),
(52934, 131),
(52934, 138),
(52934, 164),
(52934, 251),
(52934, 315),
(52934, 429),
(52934, 496),
(52934, 517),
(52934, 537),
(52934, 601),
(52934, 602),
(52934, 641),
(52934, 723),
(52934, 748),
(52934, 756),
(52935, 46),
(52935, 50),
(52935, 75),
(52935, 92),
(52935, 104),
(52935, 123),
(52935, 158),
(52935, 231),
(52935, 315),
(52935, 374),
(52935, 481),
(52935, 522),
(52935, 537),
(52935, 641),
(52935, 736),
(52935, 828),
(52936, 1),
(52936, 216),
(52936, 386),
(52936, 399),
(52936, 496),
(52936, 497),
(52936, 517),
(52936, 537),
(52936, 602),
(52936, 641),
(52936, 642),
(52936, 657),
(52936, 717),
(52936, 758),
(52936, 833),
(52937, 4),
(52937, 39),
(52937, 86),
(52937, 140),
(52937, 184),
(52937, 315),
(52937, 324),
(52937, 406),
(52937, 433),
(52937, 497),
(52937, 598),
(52937, 696),
(52937, 702),
(52937, 748),
(52937, 790),
(52938, 4),
(52938, 61),
(52938, 92),
(52938, 216),
(52938, 256),
(52938, 315),
(52938, 460),
(52938, 499),
(52938, 556),
(52938, 602),
(52938, 641),
(52938, 748),
(52938, 755),
(52938, 790),
(52938, 801),
(52939, 27),
(52939, 34),
(52939, 315),
(52939, 404),
(52939, 497),
(52939, 517),
(52939, 602),
(52939, 748),
(52939, 754),
(52939, 790),
(52940, 4),
(52940, 112),
(52940, 131),
(52940, 184),
(52940, 201),
(52940, 317),
(52940, 433),
(52940, 499),
(52940, 602),
(52940, 696),
(52940, 748),
(52940, 754),
(52940, 790),
(52941, 4),
(52941, 43),
(52941, 61),
(52941, 112),
(52941, 184),
(52941, 317),
(52941, 406),
(52941, 497),
(52941, 556),
(52941, 574),
(52941, 602),
(52941, 702),
(52941, 748),
(52941, 801),
(52942, 21),
(52942, 61),
(52942, 202),
(52942, 275),
(52942, 307),
(52942, 424),
(52942, 497),
(52942, 512),
(52942, 517),
(52942, 522),
(52942, 602),
(52942, 636),
(52942, 641),
(52942, 792),
(52942, 816),
(52943, 81),
(52943, 197),
(52943, 301),
(52943, 315),
(52943, 324),
(52943, 497),
(52943, 506),
(52943, 651),
(52943, 696),
(52943, 702),
(52943, 790),
(52943, 801),
(52944, 4),
(52944, 40),
(52944, 112),
(52944, 315),
(52944, 324),
(52944, 433),
(52944, 444),
(52944, 497),
(52944, 537),
(52944, 602),
(52944, 606),
(52944, 651),
(52944, 718),
(52944, 748),
(52944, 790),
(52944, 828),
(52944, 833),
(52945, 86),
(52945, 131),
(52945, 149),
(52945, 197),
(52945, 317),
(52945, 531),
(52945, 620),
(52945, 638),
(52945, 664),
(52945, 696),
(52945, 702),
(52945, 801),
(52945, 802),
(52946, 86),
(52946, 117),
(52946, 146),
(52946, 197),
(52946, 317),
(52946, 324),
(52946, 531),
(52946, 576),
(52946, 696),
(52946, 724),
(52946, 756),
(52946, 802),
(52947, 201),
(52947, 235),
(52947, 279),
(52947, 315),
(52947, 324),
(52947, 460),
(52947, 496),
(52947, 537),
(52947, 641),
(52947, 650),
(52947, 664),
(52947, 681),
(52947, 696),
(52947, 702),
(52947, 753),
(52947, 801),
(52948, 112),
(52948, 121),
(52948, 317),
(52948, 324),
(52948, 495),
(52948, 564),
(52948, 664),
(52948, 696),
(52948, 702),
(52948, 801),
(52948, 826),
(52949, 193),
(52949, 256),
(52949, 564),
(52949, 641),
(52949, 696),
(52949, 707),
(52949, 718),
(52949, 756),
(52949, 799),
(52949, 801),
(52950, 43),
(52950, 112),
(52950, 121),
(52950, 192),
(52950, 262),
(52950, 315),
(52950, 324),
(52950, 346),
(52950, 386),
(52950, 481),
(52950, 495),
(52950, 497),
(52950, 508),
(52950, 537),
(52950, 641),
(52950, 664),
(52950, 696),
(52950, 707),
(52950, 718),
(52950, 801),
(52951, 31),
(52951, 133),
(52951, 138),
(52951, 253),
(52951, 256),
(52951, 315),
(52951, 319),
(52951, 324),
(52951, 332),
(52951, 380),
(52951, 498),
(52951, 556),
(52951, 620),
(52951, 641),
(52951, 664),
(52951, 696),
(52951, 702),
(52951, 707),
(52951, 801),
(52952, 42),
(52952, 43),
(52952, 256),
(52952, 324),
(52952, 461),
(52952, 481),
(52952, 490),
(52952, 495),
(52952, 497),
(52952, 508),
(52952, 537),
(52952, 641),
(52952, 664),
(52952, 696),
(52952, 707),
(52952, 718),
(52952, 801),
(52953, 42),
(52953, 192),
(52953, 201),
(52953, 256),
(52953, 324),
(52953, 461),
(52953, 495),
(52953, 497),
(52953, 508),
(52953, 537),
(52953, 576),
(52953, 618),
(52953, 664),
(52953, 696),
(52953, 702),
(52953, 718),
(52953, 799),
(52954, 138),
(52954, 201),
(52954, 386),
(52954, 481),
(52954, 537),
(52954, 564),
(52954, 641),
(52954, 664),
(52954, 696),
(52954, 702),
(52954, 718),
(52954, 753),
(52954, 799),
(52954, 801),
(52954, 827),
(52955, 138),
(52955, 201),
(52955, 481),
(52955, 533),
(52955, 537),
(52955, 641),
(52955, 664),
(52955, 702),
(52955, 718),
(52955, 801),
(52956, 131),
(52956, 193),
(52956, 324),
(52956, 325),
(52956, 537),
(52956, 613),
(52956, 641),
(52956, 702),
(52956, 801),
(52957, 64),
(52957, 206),
(52957, 293),
(52957, 580),
(52957, 590),
(52957, 712),
(52957, 718),
(52957, 783),
(52958, 256),
(52958, 528),
(52958, 718),
(52959, 60),
(52959, 128),
(52959, 275),
(52959, 424),
(52959, 496),
(52959, 522),
(52959, 639),
(52960, 20),
(52960, 212),
(52960, 380),
(52960, 433),
(52960, 465),
(52960, 496),
(52960, 639),
(52960, 701),
(52961, 172),
(52961, 223),
(52961, 264),
(52961, 293),
(52961, 390),
(52961, 429),
(52961, 622),
(52961, 718),
(52962, 92),
(52962, 256),
(52962, 264),
(52962, 267),
(52962, 425),
(52962, 690),
(52962, 774),
(52962, 817),
(52963, 117),
(52963, 128),
(52963, 193),
(52963, 264),
(52963, 280),
(52963, 315),
(52963, 496),
(52963, 598),
(52963, 601),
(52964, 39),
(52964, 40),
(52964, 92),
(52964, 110),
(52964, 138),
(52964, 173),
(52964, 264),
(52964, 424),
(52964, 497),
(52964, 522),
(52964, 688),
(52964, 768),
(52965, 4),
(52965, 27),
(52965, 317),
(52965, 446),
(52965, 496),
(52965, 522),
(52965, 537),
(52965, 574),
(52965, 641),
(52966, 92),
(52966, 449),
(52966, 459),
(52966, 615),
(52967, 264),
(52967, 458),
(52967, 657),
(52967, 718),
(52968, 194),
(52968, 197),
(52968, 330),
(52968, 344),
(52968, 497),
(52968, 641),
(52968, 758),
(52969, 144),
(52969, 213),
(52969, 264),
(52969, 315),
(52969, 346),
(52969, 496),
(52969, 497),
(52969, 517),
(52969, 602),
(52969, 641),
(52969, 758),
(52970, 31),
(52970, 117),
(52970, 264),
(52970, 293),
(52970, 496),
(52970, 500),
(52970, 783),
(52971, 264),
(52971, 346),
(52971, 496),
(52971, 499),
(52971, 537),
(52971, 574),
(52971, 582),
(52971, 589),
(52971, 641),
(52972, 138),
(52972, 143),
(52972, 213),
(52972, 315),
(52972, 372),
(52972, 415),
(52972, 425),
(52972, 439),
(52972, 497),
(52972, 537),
(52972, 641),
(52972, 701),
(52972, 756),
(52973, 143),
(52973, 213),
(52973, 315),
(52973, 372),
(52973, 433),
(52973, 496),
(52973, 497),
(52973, 537),
(52973, 641),
(52973, 792),
(52974, 92),
(52974, 411),
(52974, 424),
(52974, 496),
(52974, 497),
(52974, 522),
(52974, 636),
(52974, 801),
(52975, 17),
(52975, 212),
(52975, 264),
(52975, 284),
(52975, 386),
(52975, 425),
(52975, 496),
(52975, 701),
(52975, 702),
(52975, 758),
(52975, 763),
(52976, 11),
(52976, 114),
(52976, 263),
(52976, 390),
(52976, 501),
(52977, 61),
(52977, 112),
(52977, 213),
(52977, 430),
(52977, 465),
(52977, 497),
(52977, 517),
(52977, 603),
(52977, 653),
(52977, 748),
(52977, 756),
(52977, 792),
(52977, 801),
(52978, 92),
(52978, 126),
(52978, 497),
(52978, 574),
(52978, 599),
(52978, 602),
(52979, 43),
(52979, 50),
(52979, 79),
(52979, 92),
(52979, 264),
(52979, 293),
(52979, 492),
(52979, 497),
(52979, 522),
(52979, 537),
(52979, 641),
(52980, 40),
(52980, 92),
(52980, 404),
(52980, 458),
(52980, 492),
(52980, 537),
(52980, 574),
(52980, 641),
(52980, 647),
(52980, 666),
(52981, 112),
(52981, 120),
(52981, 121),
(52981, 423),
(52981, 497),
(52981, 533),
(52981, 564),
(52981, 574),
(52981, 647),
(52981, 793),
(52981, 801),
(52982, 27),
(52982, 61),
(52982, 263),
(52982, 535),
(52982, 641),
(52982, 699),
(52987, 27),
(52987, 76),
(52987, 92),
(52987, 161),
(52987, 244),
(52987, 476),
(52987, 641),
(52987, 694),
(52987, 754),
(52988, 11),
(52988, 74),
(52988, 75),
(52988, 79),
(52988, 92),
(52988, 101),
(52988, 264),
(52988, 480),
(52988, 492),
(52988, 556),
(52988, 587),
(52989, 165),
(52989, 217),
(52989, 221),
(52989, 226),
(52989, 236),
(52989, 290),
(52989, 338),
(52989, 451),
(52989, 500),
(52990, 31),
(52990, 92),
(52990, 101),
(52990, 215),
(52990, 264),
(52990, 328),
(52990, 350),
(52990, 424),
(52990, 471),
(52990, 480),
(52990, 534),
(52990, 556),
(52990, 587),
(52990, 630),
(52990, 669),
(52990, 783),
(52991, 92),
(52991, 117),
(52991, 256),
(52991, 390),
(52991, 463),
(52991, 556),
(52992, 76),
(52992, 92),
(52992, 112),
(52992, 315),
(52992, 319),
(52992, 352),
(52992, 574),
(52992, 650),
(52992, 696),
(52992, 718),
(52992, 790),
(52993, 32),
(52993, 82),
(52993, 92),
(52993, 133),
(52993, 138),
(52993, 315),
(52993, 380),
(52993, 496),
(52993, 574),
(52993, 790),
(52994, 15),
(52994, 92),
(52994, 138),
(52994, 315),
(52994, 424),
(52994, 564),
(52994, 574),
(52994, 718),
(52994, 790),
(52994, 836),
(52995, 35),
(52995, 76),
(52995, 315),
(52995, 386),
(52995, 433),
(52995, 537),
(52995, 564),
(52995, 574),
(52995, 601),
(52995, 641),
(52995, 718),
(52995, 755),
(52995, 790),
(52996, 50),
(52996, 92),
(52996, 112),
(52996, 134),
(52996, 476),
(52996, 497),
(52996, 537),
(52996, 574),
(52996, 641),
(52996, 694),
(52996, 718),
(52996, 790),
(52997, 112),
(52997, 212),
(52997, 317),
(52997, 352),
(52997, 433),
(52997, 497),
(52997, 613),
(52997, 696),
(52998, 44),
(52998, 95),
(52998, 112),
(52998, 687),
(52999, 95),
(52999, 138),
(52999, 317),
(52999, 392),
(52999, 404),
(52999, 497),
(52999, 537),
(52999, 641),
(52999, 671),
(53000, 41),
(53000, 83),
(53000, 158),
(53000, 201),
(53000, 251),
(53000, 315),
(53000, 410),
(53000, 481),
(53000, 496),
(53000, 497),
(53000, 522),
(53000, 574),
(53000, 631),
(53000, 637),
(53000, 643),
(53000, 687),
(53000, 696),
(53000, 756),
(53000, 792),
(53005, 92),
(53005, 172),
(53005, 201),
(53005, 293),
(53005, 425),
(53005, 458),
(53005, 612),
(53005, 641),
(53005, 712),
(53005, 718),
(53005, 774),
(53005, 801),
(53006, 19),
(53006, 43),
(53006, 256),
(53006, 342),
(53006, 519),
(53006, 574),
(53006, 754),
(53006, 756),
(53007, 11),
(53007, 92),
(53007, 230),
(53007, 264),
(53007, 309),
(53007, 342),
(53007, 380),
(53007, 424),
(53007, 451),
(53007, 500),
(53008, 138),
(53008, 162),
(53008, 172),
(53008, 232),
(53008, 317),
(53008, 411),
(53008, 465),
(53008, 496),
(53008, 497),
(53008, 613),
(53008, 718),
(53008, 756),
(53008, 758),
(53009, 232),
(53009, 315),
(53009, 413),
(53009, 424),
(53009, 496),
(53009, 552),
(53009, 653),
(53010, 90),
(53010, 91),
(53010, 193),
(53010, 212),
(53010, 213),
(53010, 315),
(53010, 342),
(53010, 415),
(53010, 465),
(53010, 496),
(53010, 517),
(53011, 60),
(53011, 92),
(53011, 133),
(53011, 280),
(53011, 315),
(53011, 424),
(53011, 465),
(53011, 496),
(53011, 584),
(53011, 598),
(53011, 601),
(53012, 93),
(53012, 162),
(53012, 172),
(53012, 244),
(53012, 317),
(53012, 496),
(53012, 497),
(53012, 718),
(53012, 756),
(53012, 758),
(53013, 126),
(53013, 233),
(53013, 319),
(53013, 389),
(53013, 454),
(53013, 460),
(53013, 483),
(53013, 496),
(53013, 497),
(53013, 498),
(53013, 517),
(53013, 537),
(53013, 663),
(53013, 817),
(53014, 37),
(53014, 61),
(53014, 476),
(53014, 496),
(53014, 504),
(53014, 523),
(53014, 556),
(53014, 641),
(53014, 718),
(53014, 801),
(53014, 830),
(53015, 67),
(53015, 92),
(53015, 104),
(53015, 264),
(53015, 293),
(53015, 458),
(53015, 641),
(53015, 673),
(53015, 718),
(53015, 781),
(53015, 801),
(53015, 830),
(53016, 61),
(53016, 119),
(53016, 122),
(53016, 133),
(53016, 256),
(53016, 293),
(53016, 319),
(53016, 390),
(53016, 458),
(53016, 496),
(53016, 517),
(53016, 541),
(53016, 641),
(53016, 663),
(53017, 44),
(53017, 92),
(53017, 256),
(53017, 264),
(53017, 293),
(53017, 497),
(53017, 537),
(53017, 641),
(53017, 726),
(53018, 27),
(53018, 37),
(53018, 40),
(53018, 50),
(53018, 95),
(53018, 109),
(53018, 229),
(53018, 293),
(53018, 315),
(53018, 386),
(53018, 407),
(53018, 448),
(53018, 481),
(53018, 497),
(53018, 517),
(53018, 564),
(53018, 607),
(53018, 646),
(53018, 756),
(53018, 828),
(53019, 31),
(53019, 92),
(53019, 161),
(53019, 264),
(53019, 293),
(53019, 574),
(53019, 641),
(53019, 646),
(53019, 694),
(53020, 4),
(53020, 40),
(53020, 95),
(53020, 112),
(53020, 121),
(53020, 136),
(53020, 178),
(53020, 232),
(53020, 423),
(53020, 499),
(53020, 522),
(53020, 537),
(53020, 641),
(53021, 61),
(53021, 92),
(53021, 95),
(53021, 315),
(53021, 352),
(53021, 364),
(53021, 497),
(53021, 613),
(53021, 641),
(53021, 756),
(53022, 92),
(53022, 264),
(53022, 293),
(53022, 458),
(53022, 641),
(53022, 718),
(53022, 801),
(53023, 4),
(53023, 40),
(53023, 375),
(53023, 496),
(53023, 497),
(53023, 537),
(53024, 31),
(53024, 92),
(53024, 206),
(53024, 263),
(53024, 293),
(53024, 395),
(53025, 81),
(53025, 213),
(53025, 317),
(53025, 429),
(53025, 496),
(53025, 522),
(53026, 31),
(53026, 81),
(53026, 119),
(53026, 213),
(53026, 293),
(53026, 317),
(53026, 522),
(53026, 702),
(53026, 790),
(53027, 83),
(53027, 143),
(53027, 193),
(53027, 439),
(53027, 497),
(53027, 613),
(53027, 641),
(53027, 790),
(53028, 110),
(53028, 119),
(53028, 140),
(53028, 193),
(53028, 213),
(53028, 317),
(53028, 342),
(53028, 425),
(53028, 431),
(53028, 496),
(53028, 517),
(53028, 552),
(53028, 754),
(53029, 43),
(53029, 317),
(53029, 478),
(53029, 496),
(53029, 497),
(53029, 641),
(53029, 801),
(53030, 293),
(53030, 496),
(53030, 641),
(53030, 774),
(53030, 801),
(53031, 43),
(53031, 92),
(53031, 139),
(53031, 213),
(53031, 317),
(53031, 490),
(53031, 496),
(53031, 497),
(53031, 537),
(53031, 552),
(53031, 613),
(53031, 641),
(53031, 756),
(53031, 758),
(53031, 817),
(53032, 79),
(53032, 117),
(53032, 264),
(53032, 293),
(53032, 508),
(53032, 567),
(53032, 755),
(53032, 790),
(53032, 828),
(53033, 466),
(53033, 541),
(53033, 702),
(53033, 725),
(53034, 158),
(53034, 264),
(53034, 466),
(53034, 497),
(53034, 564),
(53034, 696),
(53034, 718),
(53034, 725),
(53034, 790),
(53034, 792),
(53035, 92),
(53035, 95),
(53035, 236),
(53035, 264),
(53035, 295),
(53035, 317),
(53035, 369),
(53035, 483),
(53035, 702),
(53036, 27),
(53036, 56),
(53036, 92),
(53036, 128),
(53036, 256),
(53036, 262),
(53036, 458),
(53036, 556),
(53036, 574),
(53036, 702),
(53036, 790),
(53037, 27),
(53037, 40),
(53037, 92),
(53037, 95),
(53037, 112),
(53037, 138),
(53037, 168),
(53037, 567),
(53037, 574),
(53037, 726),
(53038, 92),
(53038, 458),
(53038, 483),
(53038, 574),
(53038, 702),
(53039, 55),
(53039, 95),
(53039, 112),
(53039, 131),
(53039, 193),
(53039, 214),
(53039, 244),
(53039, 315),
(53039, 324),
(53039, 342),
(53039, 454),
(53039, 495),
(53039, 517),
(53039, 598),
(53039, 601),
(53039, 609),
(53040, 92),
(53040, 256),
(53040, 280),
(53040, 315),
(53040, 496),
(53040, 556),
(53040, 576),
(53040, 598),
(53040, 702),
(53040, 817),
(53041, 315),
(53041, 424),
(53041, 496),
(53041, 517),
(53041, 598),
(53041, 631),
(53041, 644),
(53042, 38),
(53042, 46),
(53042, 117),
(53042, 167),
(53042, 315),
(53042, 394),
(53042, 496),
(53042, 522),
(53042, 627),
(53042, 702),
(53042, 799),
(53043, 79),
(53043, 193),
(53043, 214),
(53043, 264),
(53043, 293),
(53043, 315),
(53043, 324),
(53043, 344),
(53043, 367),
(53043, 537),
(53043, 574),
(53043, 790),
(53044, 424),
(53044, 425),
(53044, 454),
(53044, 496),
(53044, 517),
(53044, 564),
(53044, 574),
(53044, 790),
(53044, 816),
(53045, 29),
(53045, 40),
(53045, 174),
(53045, 186),
(53045, 193),
(53045, 251),
(53045, 315),
(53045, 482),
(53045, 499),
(53045, 559),
(53045, 574),
(53045, 598),
(53045, 602),
(53045, 636),
(53045, 704),
(53045, 749),
(53046, 117),
(53046, 172),
(53046, 197),
(53046, 263),
(53046, 264),
(53046, 390),
(53046, 426),
(53046, 556),
(53046, 580),
(53046, 781),
(53046, 820),
(53047, 112),
(53047, 193),
(53047, 213),
(53047, 314),
(53047, 317),
(53047, 425),
(53047, 496),
(53047, 497),
(53048, 95),
(53048, 146),
(53048, 152),
(53048, 256),
(53048, 317),
(53048, 490),
(53048, 495),
(53048, 531),
(53048, 574),
(53048, 576),
(53048, 601),
(53048, 696),
(53048, 740),
(53048, 753),
(53048, 801),
(53049, 31),
(53049, 264),
(53049, 293),
(53049, 458),
(53049, 495),
(53049, 528),
(53049, 641),
(53049, 718),
(53049, 774),
(53050, 119),
(53050, 123),
(53050, 140),
(53050, 184),
(53050, 193),
(53050, 213),
(53050, 275),
(53050, 317),
(53050, 324),
(53050, 718),
(53050, 740),
(53050, 768),
(53050, 801),
(53051, 13),
(53051, 40),
(53051, 149),
(53051, 184),
(53051, 212),
(53051, 264),
(53051, 315),
(53051, 324),
(53051, 327),
(53051, 497),
(53051, 531),
(53051, 613),
(53051, 666),
(53051, 718),
(53051, 740),
(53051, 790),
(53051, 801),
(53052, 29),
(53052, 146),
(53052, 264),
(53052, 454),
(53052, 460),
(53052, 497),
(53052, 537),
(53052, 641),
(53053, 43),
(53053, 110),
(53053, 123),
(53053, 173),
(53053, 178),
(53053, 182),
(53053, 433),
(53053, 706),
(53053, 718),
(53053, 740),
(53053, 790),
(53053, 801),
(53054, 182),
(53054, 184),
(53054, 197),
(53054, 264),
(53054, 293),
(53054, 613),
(53054, 641),
(53054, 718),
(53054, 801),
(53055, 31),
(53055, 79),
(53055, 315),
(53055, 460),
(53055, 462),
(53055, 497),
(53055, 517),
(53055, 522),
(53055, 537),
(53055, 641),
(53055, 793),
(53055, 801),
(53056, 19),
(53056, 112),
(53056, 202),
(53056, 320),
(53056, 346),
(53056, 417),
(53056, 496),
(53056, 497),
(53056, 537),
(53056, 574),
(53056, 748),
(53056, 756),
(53056, 816),
(53057, 40),
(53057, 43),
(53057, 112),
(53057, 315),
(53057, 483),
(53057, 499),
(53057, 517),
(53057, 537),
(53057, 607),
(53057, 641),
(53057, 790),
(53057, 801),
(53058, 103),
(53058, 123),
(53058, 164),
(53058, 315),
(53058, 522),
(53058, 758),
(53058, 790),
(53059, 40),
(53059, 88),
(53059, 315),
(53059, 481),
(53059, 497),
(53059, 522),
(53059, 694),
(53059, 790),
(53059, 793),
(53059, 817),
(53060, 284),
(53060, 460),
(53060, 495),
(53060, 497),
(53060, 537),
(53060, 641),
(53061, 293),
(53061, 641),
(53061, 644),
(53061, 790),
(53062, 86),
(53062, 92),
(53062, 117),
(53062, 172),
(53062, 264),
(53062, 293),
(53062, 390),
(53062, 458),
(53062, 641),
(53062, 800),
(53062, 830),
(53063, 27),
(53063, 44),
(53063, 76),
(53063, 256),
(53063, 369),
(53063, 431),
(53063, 476),
(53063, 497),
(53063, 537),
(53063, 754),
(53064, 61),
(53064, 92),
(53064, 281),
(53064, 374),
(53064, 519),
(53064, 522),
(53065, 117),
(53065, 212),
(53065, 454),
(53065, 621),
(53065, 696),
(53065, 725),
(53067, 59),
(53067, 144),
(53067, 170),
(53067, 213),
(53067, 229),
(53067, 315),
(53067, 346),
(53067, 496),
(53067, 497),
(53067, 537),
(53067, 584),
(53067, 641),
(53067, 676),
(53067, 689),
(53067, 733),
(53068, 41),
(53068, 43),
(53068, 61),
(53068, 315),
(53068, 424),
(53068, 496),
(53068, 497),
(53068, 574),
(53068, 641),
(53068, 696),
(53068, 756),
(53068, 801),
(53069, 43),
(53069, 315),
(53069, 424),
(53069, 496),
(53069, 497),
(53069, 641),
(53069, 696),
(53069, 801),
(53070, 43),
(53070, 50),
(53070, 112),
(53070, 149),
(53070, 315),
(53070, 346),
(53070, 496),
(53070, 497),
(53070, 528),
(53070, 574),
(53070, 602),
(53070, 696),
(53070, 756),
(53070, 801),
(53071, 40),
(53071, 43),
(53071, 51),
(53071, 92),
(53071, 315),
(53071, 424),
(53071, 496),
(53071, 497),
(53071, 537),
(53071, 696),
(53071, 756),
(53071, 757),
(53071, 801),
(53071, 817),
(53072, 79),
(53072, 258),
(53072, 264),
(53072, 537),
(53072, 641),
(53072, 662),
(53072, 790),
(53073, 40),
(53073, 258),
(53073, 315),
(53073, 364),
(53073, 496),
(53073, 537),
(53073, 620),
(53073, 641),
(53073, 696),
(53073, 718),
(53074, 184),
(53074, 258),
(53074, 425),
(53074, 499),
(53074, 603),
(53074, 641),
(53075, 258),
(53075, 264),
(53075, 496),
(53075, 641),
(53076, 76),
(53076, 256),
(53076, 641),
(53077, 40),
(53077, 95),
(53077, 112),
(53077, 121),
(53077, 232),
(53077, 497),
(53077, 574),
(53077, 694),
(53077, 758),
(53077, 774),
(53077, 792),
(53078, 55),
(53078, 103),
(53078, 139),
(53078, 232),
(53078, 496),
(53078, 574),
(53078, 801),
(53079, 40),
(53079, 112),
(53079, 186),
(53079, 288),
(53079, 496),
(53079, 497),
(53079, 574),
(53079, 639),
(53079, 801),
(53080, 88),
(53080, 92),
(53080, 256),
(53080, 293),
(53080, 458),
(53080, 641),
(53080, 830),
(53081, 112),
(53081, 232),
(53081, 264),
(53081, 454),
(53081, 499),
(53081, 533),
(53081, 574),
(53081, 641),
(53081, 647),
(53081, 817),
(53082, 205),
(53082, 338),
(53082, 694),
(53082, 712),
(53082, 718),
(53083, 92),
(53083, 315),
(53083, 411),
(53083, 425),
(53083, 497),
(53083, 522),
(53083, 579),
(53083, 613),
(53083, 636),
(53083, 792),
(53086, 76),
(53086, 315),
(53086, 496),
(53086, 564),
(53089, 293),
(53089, 641),
(53089, 718),
(53089, 790),
(53089, 801),
(53089, 830),
(53091, 212),
(53091, 233),
(53091, 271),
(53091, 315),
(53091, 372),
(53091, 425),
(53091, 431),
(53091, 517),
(53091, 552),
(53091, 601),
(53091, 737),
(53091, 754),
(53091, 801),
(53092, 170),
(53092, 315),
(53092, 343),
(53092, 496),
(53092, 641),
(53093, 172),
(53093, 537),
(53093, 641),
(53093, 699),
(53093, 756),
(53093, 757),
(53093, 790),
(53094, 119),
(53094, 258),
(53094, 269),
(53094, 315),
(53094, 342),
(53094, 410),
(53094, 424),
(53094, 465),
(53094, 522),
(53094, 737),
(53095, 4),
(53095, 61),
(53095, 92),
(53095, 138),
(53095, 172),
(53095, 352),
(53095, 544),
(53095, 613),
(53095, 641),
(53096, 61),
(53096, 199),
(53096, 302),
(53096, 410),
(53096, 497),
(53096, 574),
(53096, 774),
(53097, 256),
(53097, 293),
(53097, 458),
(53097, 724),
(53098, 41),
(53098, 52),
(53098, 92),
(53098, 112),
(53098, 121),
(53098, 274),
(53098, 293),
(53098, 453),
(53098, 497),
(53098, 520),
(53098, 574),
(53098, 748),
(53098, 756),
(53098, 790),
(53098, 828),
(53099, 190),
(53099, 422),
(53099, 486),
(53099, 627),
(53099, 695),
(53100, 11),
(53100, 64),
(53100, 262),
(53100, 293),
(53100, 390),
(53100, 774),
(53100, 778),
(53101, 31),
(53101, 92),
(53101, 117),
(53101, 181),
(53101, 227),
(53101, 256),
(53101, 390),
(53101, 458),
(53101, 555),
(53101, 657),
(53102, 100),
(53102, 164),
(53102, 317),
(53102, 424),
(53102, 496),
(53102, 522),
(53102, 598),
(53102, 602),
(53102, 704),
(53103, 36),
(53103, 144),
(53103, 193),
(53103, 317),
(53103, 357),
(53103, 424),
(53103, 496),
(53103, 517),
(53104, 181),
(53104, 227),
(53104, 236),
(53104, 256),
(53104, 333),
(53104, 390),
(53104, 458),
(53104, 591),
(53104, 641),
(53104, 643),
(53104, 657),
(53104, 774),
(53105, 41),
(53105, 140),
(53105, 148),
(53105, 216),
(53105, 315),
(53105, 424),
(53105, 496),
(53105, 631),
(53105, 748),
(53106, 18),
(53106, 175),
(53106, 231),
(53106, 269),
(53106, 398),
(53106, 609),
(53106, 627),
(53106, 713),
(53106, 754),
(53107, 20),
(53107, 23),
(53107, 214),
(53107, 383),
(53107, 424),
(53107, 433),
(53107, 488),
(53107, 496),
(53107, 760),
(53108, 154),
(53108, 193),
(53108, 495),
(53108, 664),
(53108, 704),
(53108, 727),
(53109, 50),
(53109, 160),
(53109, 354),
(53109, 357),
(53109, 383),
(53109, 406),
(53109, 460),
(53109, 497),
(53109, 574),
(53109, 596),
(53109, 694),
(53109, 724),
(53109, 756),
(53110, 135),
(53110, 231),
(53110, 380),
(53110, 496),
(53110, 696),
(53110, 756),
(53111, 56),
(53111, 92),
(53111, 117),
(53111, 227),
(53111, 334),
(53111, 556),
(53111, 572),
(53112, 61),
(53112, 146),
(53112, 170),
(53112, 216),
(53112, 317),
(53112, 358),
(53112, 495),
(53112, 517),
(53112, 601),
(53112, 641),
(53112, 685),
(53112, 754),
(53112, 756),
(53112, 801),
(53113, 236),
(53113, 404),
(53113, 495),
(53113, 601),
(53113, 641),
(53114, 801),
(53114, 810),
(53115, 41),
(53115, 61),
(53115, 169),
(53115, 339),
(53115, 601),
(53115, 653),
(53116, 110),
(53116, 117),
(53116, 172),
(53116, 256),
(53116, 273),
(53116, 293),
(53116, 458),
(53116, 496),
(53116, 641),
(53116, 715),
(53116, 774),
(53117, 18),
(53117, 61),
(53117, 92),
(53117, 209),
(53117, 232),
(53117, 329),
(53117, 381),
(53117, 425),
(53117, 537),
(53117, 635),
(53117, 641),
(53117, 666),
(53117, 790),
(53117, 804),
(53118, 92),
(53118, 172),
(53118, 293),
(53118, 310),
(53118, 458),
(53118, 641),
(53118, 718),
(53119, 92),
(53119, 110),
(53119, 201),
(53119, 263),
(53119, 293),
(53119, 339),
(53119, 391),
(53119, 458),
(53119, 575),
(53119, 674),
(53119, 783),
(53119, 784),
(53119, 801),
(53121, 2),
(53121, 92),
(53121, 293),
(53121, 339),
(53121, 374),
(53121, 456),
(53121, 574),
(53121, 641),
(53121, 718),
(53122, 92),
(53122, 112),
(53122, 158),
(53122, 209),
(53122, 286),
(53122, 288),
(53122, 293),
(53122, 315),
(53122, 423),
(53122, 458),
(53122, 574),
(53122, 678),
(53123, 293),
(53123, 411),
(53123, 641),
(53123, 801),
(53123, 807),
(53123, 819),
(53124, 2),
(53124, 70),
(53124, 92),
(53124, 112),
(53124, 205),
(53124, 293),
(53124, 302),
(53124, 492),
(53124, 568),
(53124, 574),
(53124, 605),
(53124, 641),
(53124, 647),
(53124, 726),
(53125, 92),
(53125, 201),
(53125, 352),
(53125, 492),
(53125, 497),
(53125, 537),
(53125, 641),
(53125, 801),
(53126, 43),
(53126, 50),
(53126, 112),
(53126, 121),
(53126, 423),
(53126, 496),
(53126, 497),
(53126, 522),
(53126, 574),
(53126, 726),
(53127, 11),
(53127, 262),
(53127, 425),
(53127, 575),
(53128, 11),
(53128, 31),
(53128, 92),
(53128, 201),
(53128, 262),
(53128, 263),
(53128, 293),
(53128, 339),
(53128, 374),
(53128, 458),
(53128, 784),
(53128, 803),
(53129, 92),
(53129, 110),
(53129, 256),
(53129, 293),
(53129, 492),
(53129, 641),
(53129, 718),
(53129, 801),
(53130, 11),
(53130, 31),
(53130, 92),
(53130, 256),
(53130, 263),
(53130, 293),
(53130, 339),
(53130, 374),
(53130, 783),
(53131, 7),
(53131, 11),
(53131, 31),
(53131, 75),
(53131, 86),
(53131, 92),
(53131, 256),
(53131, 263),
(53131, 293),
(53131, 339),
(53131, 456),
(53131, 783),
(53132, 7),
(53132, 8),
(53132, 92),
(53132, 256),
(53132, 293),
(53132, 374),
(53132, 575),
(53132, 783),
(53133, 164),
(53133, 467),
(53133, 475),
(53133, 641),
(53134, 2),
(53134, 92),
(53134, 213),
(53134, 256),
(53134, 345),
(53134, 352),
(53134, 497),
(53134, 517),
(53134, 537),
(53134, 641),
(53134, 801),
(53135, 45),
(53135, 79),
(53135, 256),
(53135, 315),
(53135, 522),
(53135, 537),
(53135, 641),
(53136, 151),
(53136, 164),
(53136, 210),
(53137, 31),
(53137, 458),
(53137, 718),
(53137, 783),
(53138, 2),
(53138, 92),
(53138, 201),
(53138, 227),
(53138, 254),
(53138, 263),
(53138, 426),
(53138, 718),
(53139, 142),
(53139, 496),
(53139, 537),
(53139, 641),
(53139, 801),
(53140, 47),
(53140, 345),
(53140, 476),
(53140, 504),
(53140, 537),
(53140, 641),
(53140, 757),
(53141, 43),
(53141, 50),
(53141, 112),
(53141, 237),
(53141, 497),
(53141, 537),
(53141, 574),
(53141, 582),
(53141, 641),
(53142, 128),
(53142, 193),
(53142, 216),
(53142, 256),
(53142, 497),
(53142, 574),
(53142, 598),
(53142, 724),
(53143, 93),
(53143, 140),
(53143, 164),
(53143, 269),
(53143, 315),
(53143, 345),
(53143, 497),
(53143, 522),
(53143, 602),
(53143, 732),
(53143, 750),
(53143, 833),
(53144, 119),
(53144, 317),
(53144, 496),
(53144, 522),
(53144, 593),
(53145, 79),
(53145, 256),
(53145, 293),
(53145, 445),
(53145, 458),
(53145, 496),
(53145, 547),
(53145, 790),
(53145, 824),
(53146, 43),
(53146, 164),
(53146, 247),
(53146, 248),
(53146, 497),
(53146, 517),
(53146, 537),
(53146, 564),
(53146, 574),
(53146, 582),
(53146, 641),
(53147, 40),
(53147, 496),
(53147, 497),
(53147, 512),
(53147, 593),
(53147, 636),
(53147, 654),
(53147, 704),
(53147, 756),
(53147, 816),
(53148, 117),
(53148, 173),
(53148, 197),
(53148, 236),
(53148, 263),
(53148, 426),
(53148, 458),
(53148, 503),
(53149, 117),
(53149, 256),
(53149, 419),
(53149, 714),
(53149, 790),
(53149, 830),
(53150, 496),
(53150, 511),
(53151, 81),
(53151, 164),
(53151, 250),
(53151, 315),
(53151, 426),
(53151, 482),
(53151, 496),
(53151, 497),
(53151, 512),
(53151, 522),
(53151, 594),
(53151, 636),
(53151, 704),
(53151, 754),
(53152, 41),
(53152, 76),
(53152, 138),
(53152, 164),
(53152, 247),
(53152, 315),
(53152, 368),
(53152, 496),
(53152, 497),
(53152, 517),
(53152, 522),
(53152, 748),
(53153, 31),
(53153, 76),
(53153, 92),
(53153, 117),
(53153, 172),
(53153, 221),
(53153, 236),
(53153, 334),
(53153, 458),
(53153, 556),
(53153, 724),
(53153, 783),
(53154, 93),
(53154, 164),
(53154, 174),
(53154, 210),
(53154, 317),
(53154, 497),
(53154, 522),
(53154, 670),
(53154, 750),
(53154, 792),
(53155, 131),
(53155, 315),
(53155, 345),
(53155, 496),
(53155, 497),
(53155, 517),
(53155, 574),
(53155, 625),
(53155, 750),
(53156, 28),
(53156, 62),
(53156, 138),
(53156, 148),
(53156, 247),
(53156, 269),
(53156, 317),
(53156, 425),
(53156, 497),
(53156, 512),
(53156, 517),
(53156, 559),
(53156, 566),
(53156, 602),
(53156, 748),
(53157, 23),
(53157, 164),
(53157, 256),
(53157, 317),
(53157, 343),
(53157, 522),
(53157, 670),
(53158, 38),
(53158, 315),
(53158, 496),
(53158, 497),
(53158, 517),
(53158, 574),
(53158, 750),
(53158, 756),
(53159, 125),
(53159, 164),
(53159, 256),
(53159, 496),
(53159, 522),
(53159, 574),
(53160, 19),
(53160, 41),
(53160, 202),
(53160, 256),
(53160, 317),
(53160, 470),
(53160, 496),
(53160, 497),
(53160, 504),
(53160, 522),
(53160, 748),
(53160, 754),
(53161, 131),
(53161, 138),
(53161, 164),
(53161, 315),
(53161, 495),
(53161, 497),
(53161, 522),
(53161, 602),
(53161, 613),
(53161, 748),
(53161, 756),
(53161, 816),
(53162, 11),
(53162, 41),
(53162, 112),
(53162, 121),
(53162, 138),
(53162, 140),
(53162, 173),
(53162, 178),
(53162, 250),
(53162, 256),
(53162, 269),
(53162, 317),
(53162, 497),
(53162, 522),
(53162, 636),
(53162, 705),
(53163, 11),
(53163, 75),
(53163, 175),
(53163, 178),
(53163, 237),
(53163, 240),
(53163, 282),
(53163, 662),
(53164, 138),
(53164, 140),
(53164, 424),
(53164, 496),
(53164, 497),
(53164, 517),
(53164, 522),
(53165, 76),
(53165, 209),
(53165, 236),
(53165, 256),
(53165, 333),
(53165, 390),
(53165, 458),
(53165, 496),
(53165, 731),
(53166, 41),
(53166, 112),
(53166, 121),
(53166, 143),
(53166, 164),
(53166, 172),
(53166, 269),
(53166, 315),
(53166, 497),
(53166, 517),
(53166, 670),
(53166, 701),
(53166, 748),
(53167, 164),
(53167, 288),
(53167, 308),
(53167, 423),
(53167, 496),
(53167, 533),
(53167, 613),
(53167, 768),
(53168, 138),
(53168, 143),
(53168, 148),
(53168, 164),
(53168, 210),
(53168, 648),
(53168, 750),
(53169, 11),
(53169, 269),
(53169, 317),
(53169, 609),
(53169, 805),
(53170, 31),
(53170, 92),
(53170, 172),
(53170, 181),
(53170, 221),
(53170, 236),
(53170, 333),
(53170, 388),
(53170, 456),
(53170, 480),
(53170, 556),
(53170, 724),
(53170, 783),
(53171, 256),
(53171, 315),
(53171, 398),
(53171, 496),
(53171, 497),
(53171, 522),
(53171, 642),
(53172, 149),
(53172, 315),
(53172, 496),
(53172, 497),
(53172, 517),
(53172, 522),
(53172, 574),
(53172, 718),
(53172, 750),
(53172, 756),
(53173, 315),
(53173, 433),
(53173, 523),
(53173, 598),
(53173, 602),
(53173, 670),
(53174, 11),
(53174, 76),
(53174, 317),
(53174, 496),
(53174, 522),
(53174, 598),
(53174, 602),
(53174, 609),
(53174, 668),
(53174, 749),
(53174, 754),
(53175, 60),
(53175, 93),
(53175, 112),
(53175, 138),
(53175, 315),
(53175, 316),
(53175, 385),
(53175, 417),
(53175, 496),
(53175, 497),
(53175, 522),
(53175, 625),
(53175, 631),
(53176, 29),
(53176, 315),
(53176, 496),
(53176, 537),
(53176, 641),
(53176, 661),
(53176, 754),
(53177, 164),
(53177, 496),
(53177, 520),
(53177, 522),
(53177, 602),
(53177, 699),
(53178, 105),
(53178, 315),
(53178, 424),
(53178, 454),
(53178, 556),
(53178, 704),
(53178, 790),
(53179, 79),
(53179, 256),
(53179, 269),
(53179, 423),
(53179, 458),
(53179, 492),
(53179, 547),
(53179, 556),
(53179, 724),
(53179, 792),
(53180, 250),
(53180, 315),
(53180, 496),
(53180, 522),
(53180, 576),
(53181, 41),
(53181, 140),
(53181, 164),
(53181, 398),
(53181, 497),
(53181, 517),
(53181, 522),
(53181, 549),
(53181, 701),
(53181, 748),
(53182, 308),
(53182, 317),
(53182, 424),
(53182, 496),
(53182, 497),
(53182, 512),
(53182, 522),
(53182, 602),
(53182, 636),
(53182, 792),
(53182, 833),
(53183, 79),
(53183, 92),
(53183, 164),
(53183, 174),
(53183, 250),
(53183, 263),
(53183, 269),
(53183, 315),
(53183, 496),
(53183, 522),
(53183, 564),
(53183, 666),
(53183, 689),
(53183, 704),
(53183, 754),
(53183, 816),
(53184, 39),
(53184, 164),
(53184, 315),
(53184, 346),
(53184, 496),
(53184, 497),
(53184, 576),
(53184, 602),
(53184, 750),
(53185, 53),
(53185, 164),
(53185, 269),
(53185, 601),
(53185, 670),
(53185, 748),
(53186, 131),
(53186, 138),
(53186, 250),
(53186, 315),
(53186, 496),
(53186, 522),
(53186, 544),
(53186, 587),
(53186, 636),
(53186, 748),
(53187, 2),
(53187, 92),
(53187, 363),
(53187, 574),
(53187, 575),
(53187, 641),
(53187, 659),
(53188, 61),
(53188, 76),
(53188, 79),
(53188, 256),
(53188, 293),
(53188, 315),
(53188, 364),
(53188, 448),
(53188, 458),
(53188, 483),
(53188, 497),
(53188, 522),
(53188, 641),
(53188, 790),
(53189, 2),
(53189, 61),
(53189, 256),
(53189, 315),
(53189, 448),
(53189, 495),
(53189, 497),
(53189, 574),
(53189, 641),
(53190, 27),
(53190, 87),
(53190, 158),
(53190, 256),
(53190, 556),
(53190, 574),
(53190, 641),
(53191, 42),
(53191, 119),
(53191, 193),
(53191, 287),
(53191, 433),
(53191, 480),
(53191, 531),
(53191, 616),
(53191, 702),
(53191, 727),
(53191, 749),
(53191, 790),
(53192, 38),
(53192, 86),
(53192, 133),
(53192, 184),
(53192, 245),
(53192, 287),
(53192, 312),
(53192, 315),
(53192, 343),
(53192, 356),
(53192, 357),
(53192, 360),
(53192, 397),
(53192, 427),
(53192, 433),
(53192, 442),
(53192, 515),
(53192, 531),
(53192, 598),
(53192, 679),
(53193, 38),
(53193, 57),
(53193, 82),
(53193, 287),
(53193, 291),
(53193, 315),
(53193, 508),
(53193, 684),
(53193, 696),
(53193, 718),
(53193, 790),
(53194, 139),
(53194, 184),
(53194, 193),
(53194, 287),
(53194, 312),
(53194, 428),
(53194, 434),
(53194, 442),
(53194, 497),
(53194, 507),
(53194, 593),
(53194, 598),
(53194, 744),
(53194, 754),
(53195, 37),
(53195, 184),
(53195, 193),
(53195, 593),
(53195, 598),
(53195, 702),
(53195, 709),
(53195, 746),
(53195, 771),
(53195, 790),
(53195, 792),
(53196, 138),
(53196, 193),
(53196, 287),
(53196, 312),
(53196, 344),
(53196, 408),
(53196, 427),
(53196, 434),
(53196, 442),
(53197, 86),
(53197, 184),
(53197, 193),
(53197, 397),
(53197, 433),
(53197, 528),
(53197, 571),
(53197, 696),
(53197, 702),
(53197, 733),
(53197, 747),
(53197, 790),
(53198, 84),
(53198, 193),
(53198, 256),
(53198, 287),
(53198, 307),
(53198, 317),
(53198, 386),
(53198, 593),
(53198, 598),
(53198, 601),
(53198, 696),
(53198, 790),
(53199, 38),
(53199, 43),
(53199, 508),
(53199, 598),
(53199, 790),
(53200, 42),
(53200, 117),
(53200, 193),
(53200, 287),
(53200, 315),
(53200, 324),
(53200, 344),
(53200, 359),
(53200, 433),
(53200, 594),
(53200, 602),
(53200, 616),
(53200, 696),
(53200, 702),
(53200, 802),
(53201, 38),
(53201, 131),
(53201, 287),
(53201, 315),
(53201, 598),
(53201, 666),
(53201, 696),
(53201, 718),
(53201, 790),
(53202, 24),
(53202, 317),
(53202, 324),
(53202, 433),
(53202, 598),
(53202, 696),
(53202, 761),
(53203, 42),
(53203, 119),
(53203, 287),
(53203, 324),
(53203, 431),
(53203, 433),
(53203, 462),
(53203, 480),
(53203, 495),
(53203, 598),
(53203, 601),
(53203, 662),
(53203, 684),
(53203, 724),
(53203, 795),
(53204, 134),
(53204, 184),
(53204, 202),
(53204, 433),
(53204, 601),
(53204, 602),
(53204, 747),
(53205, 182),
(53205, 193),
(53205, 324),
(53205, 497),
(53205, 592),
(53205, 747),
(53205, 750),
(53205, 790),
(53206, 133),
(53206, 193),
(53206, 315),
(53206, 324),
(53206, 344),
(53206, 433),
(53206, 496),
(53206, 497),
(53206, 598),
(53206, 702),
(53206, 727),
(53207, 57),
(53207, 117),
(53207, 138),
(53207, 140),
(53207, 184),
(53207, 194),
(53207, 287),
(53207, 313),
(53207, 428),
(53207, 433),
(53207, 435),
(53207, 507),
(53207, 613),
(53208, 42),
(53208, 86),
(53208, 112),
(53208, 128),
(53208, 155),
(53208, 184),
(53208, 193),
(53208, 257),
(53208, 433),
(53208, 702),
(53208, 747),
(53208, 790),
(53208, 792),
(53209, 193),
(53209, 256),
(53209, 324),
(53209, 433),
(53209, 465),
(53209, 531),
(53209, 576),
(53209, 598),
(53209, 616),
(53209, 664),
(53209, 696),
(53210, 184),
(53210, 324),
(53210, 427),
(53210, 434),
(53210, 497),
(53210, 582),
(53210, 598),
(53210, 718),
(53210, 724),
(53210, 747),
(53210, 792),
(53211, 43),
(53211, 50),
(53211, 86),
(53211, 194),
(53211, 289),
(53211, 317),
(53211, 324),
(53211, 428),
(53211, 433),
(53211, 598),
(53211, 616),
(53211, 696),
(53211, 790),
(53212, 135),
(53212, 315),
(53212, 500),
(53212, 727),
(53212, 747),
(53213, 85),
(53213, 138),
(53213, 194),
(53213, 287),
(53213, 435),
(53213, 513),
(53213, 593),
(53213, 747),
(53213, 811),
(53214, 33),
(53214, 37),
(53214, 138),
(53214, 140),
(53214, 184),
(53214, 287),
(53214, 317),
(53214, 343),
(53214, 433),
(53214, 435),
(53214, 497),
(53214, 702),
(53214, 724),
(53214, 746),
(53215, 61),
(53215, 256),
(53215, 269),
(53215, 317),
(53215, 641),
(53215, 754),
(53216, 197),
(53216, 206),
(53216, 409),
(53216, 425),
(53216, 458),
(53216, 476),
(53216, 630),
(53216, 718),
(53216, 774),
(53216, 801),
(53216, 831),
(53217, 50),
(53217, 119),
(53217, 166),
(53217, 354),
(53217, 355),
(53217, 356),
(53217, 357),
(53217, 358),
(53217, 425),
(53217, 517),
(53217, 641),
(53217, 768),
(53218, 119),
(53218, 133),
(53218, 213),
(53218, 315),
(53218, 342),
(53218, 353),
(53218, 356),
(53218, 357),
(53218, 425),
(53218, 496),
(53218, 641),
(53218, 689),
(53219, 61),
(53219, 121),
(53219, 256),
(53219, 280),
(53219, 315),
(53219, 357),
(53219, 496),
(53219, 602),
(53219, 641),
(53219, 666),
(53219, 701),
(53219, 757),
(53220, 61),
(53220, 112),
(53220, 131),
(53220, 346),
(53220, 403),
(53220, 481),
(53220, 587),
(53220, 602),
(53220, 613),
(53220, 641),
(53220, 733),
(53220, 768),
(53221, 390),
(53221, 458),
(53221, 556),
(53221, 659),
(53221, 724),
(53221, 774),
(53222, 119),
(53222, 148),
(53222, 213),
(53222, 256),
(53222, 318),
(53222, 517),
(53222, 522),
(53222, 601),
(53222, 602),
(53222, 751),
(53222, 754),
(53223, 4),
(53223, 61),
(53223, 213),
(53223, 256),
(53223, 284),
(53223, 315),
(53223, 324),
(53223, 456),
(53223, 463),
(53223, 517),
(53223, 641),
(53223, 702),
(53223, 718),
(53223, 754),
(53223, 768),
(53224, 31),
(53224, 189),
(53224, 221),
(53224, 323),
(53224, 443),
(53224, 458),
(53224, 505),
(53224, 641),
(53224, 665),
(53224, 775),
(53224, 799),
(53224, 808),
(53225, 4),
(53225, 61),
(53225, 256),
(53225, 437),
(53225, 496),
(53225, 497),
(53225, 754),
(53226, 31),
(53226, 293),
(53226, 495),
(53226, 641),
(53226, 718),
(53226, 801),
(53227, 112),
(53227, 315),
(53227, 324),
(53227, 364),
(53227, 617),
(53227, 620),
(53227, 662),
(53227, 664),
(53227, 671),
(53227, 696),
(53227, 702),
(53227, 790),
(53227, 807),
(53228, 68),
(53228, 193),
(53228, 287),
(53228, 324),
(53228, 333),
(53228, 424),
(53228, 586),
(53228, 598),
(53228, 613),
(53229, 85),
(53229, 86),
(53229, 112),
(53229, 153),
(53229, 193),
(53229, 283),
(53229, 287),
(53229, 317),
(53229, 433),
(53229, 588),
(53229, 598),
(53229, 620),
(53229, 702),
(53230, 57),
(53230, 197),
(53230, 287),
(53230, 433),
(53230, 556),
(53230, 583),
(53230, 662),
(53230, 693),
(53230, 718),
(53230, 790),
(53231, 38),
(53231, 86),
(53231, 287),
(53231, 317),
(53231, 324),
(53231, 359),
(53231, 416),
(53231, 418),
(53231, 428),
(53231, 433),
(53231, 465),
(53231, 497),
(53231, 598),
(53231, 706),
(53231, 729),
(53231, 756),
(53232, 112),
(53232, 134),
(53232, 212),
(53232, 287),
(53232, 433),
(53232, 465),
(53232, 531),
(53232, 585),
(53232, 598),
(53232, 601),
(53232, 616),
(53232, 664),
(53232, 696),
(53233, 61),
(53233, 117),
(53233, 197),
(53233, 212),
(53233, 287),
(53233, 344),
(53233, 556),
(53233, 598),
(53233, 601),
(53233, 620),
(53233, 702),
(53233, 704),
(53233, 724),
(53233, 735),
(53234, 86),
(53234, 138),
(53234, 193),
(53234, 433),
(53234, 616),
(53234, 639),
(53234, 671),
(53234, 696),
(53234, 733),
(53234, 747),
(53235, 86),
(53235, 150),
(53235, 287),
(53235, 358),
(53235, 359),
(53235, 513),
(53235, 570),
(53235, 598),
(53235, 613),
(53235, 666),
(53235, 702),
(53236, 86),
(53236, 94),
(53236, 194),
(53236, 317),
(53236, 324),
(53236, 343),
(53236, 397),
(53236, 696),
(53236, 702),
(53236, 790),
(53236, 792),
(53237, 121),
(53237, 193),
(53237, 212),
(53237, 287),
(53237, 333),
(53237, 428),
(53237, 433),
(53237, 465),
(53237, 571),
(53237, 598),
(53237, 664),
(53237, 696),
(53237, 702),
(53237, 790),
(53237, 807),
(53238, 37),
(53238, 50),
(53238, 57),
(53238, 173),
(53238, 178),
(53238, 193),
(53238, 195),
(53238, 287),
(53238, 324),
(53238, 433),
(53238, 497),
(53238, 514),
(53238, 616),
(53238, 684),
(53238, 696),
(53238, 702),
(53238, 706),
(53239, 42),
(53239, 184),
(53239, 212),
(53239, 528),
(53239, 576),
(53239, 616),
(53239, 702),
(53239, 727),
(53240, 82),
(53240, 114),
(53240, 317),
(53240, 379),
(53240, 447),
(53240, 513),
(53240, 598),
(53240, 696),
(53240, 697),
(53240, 702),
(53240, 790),
(53241, 112),
(53241, 133),
(53241, 193),
(53241, 212),
(53241, 287),
(53241, 431),
(53241, 433),
(53241, 465),
(53241, 598),
(53241, 602),
(53241, 614),
(53241, 616),
(53241, 620),
(53242, 27),
(53242, 175),
(53242, 256),
(53242, 315),
(53242, 324),
(53242, 696),
(53242, 718),
(53242, 724),
(53242, 756),
(53242, 806),
(53243, 57),
(53243, 112),
(53243, 193),
(53243, 202),
(53243, 287),
(53243, 408),
(53243, 433),
(53243, 465),
(53243, 514),
(53243, 617),
(53243, 620),
(53244, 86),
(53244, 193),
(53244, 212),
(53244, 287),
(53244, 293),
(53244, 315),
(53244, 433),
(53244, 465),
(53244, 576),
(53244, 598),
(53244, 601),
(53244, 616),
(53244, 624),
(53244, 666),
(53244, 790),
(53245, 175),
(53245, 193),
(53245, 315),
(53245, 324),
(53245, 359),
(53245, 384),
(53245, 425),
(53245, 577),
(53245, 616),
(53245, 664),
(53245, 696),
(53245, 702),
(53245, 719),
(53246, 86),
(53246, 112),
(53246, 194),
(53246, 359),
(53246, 433),
(53246, 465),
(53246, 597),
(53246, 598),
(53246, 601),
(53246, 624),
(53247, 317),
(53247, 324),
(53247, 598),
(53247, 652),
(53247, 696),
(53247, 702),
(53247, 724),
(53248, 146),
(53248, 193),
(53248, 433),
(53248, 539),
(53248, 616),
(53248, 639),
(53248, 702),
(53249, 29),
(53249, 112),
(53249, 137),
(53249, 212),
(53249, 333),
(53249, 358),
(53249, 454),
(53249, 465),
(53249, 597),
(53249, 598),
(53249, 620),
(53249, 764),
(53250, 29),
(53250, 193),
(53250, 333),
(53250, 386),
(53250, 387),
(53250, 465),
(53250, 595),
(53250, 743),
(53250, 788),
(53251, 4),
(53251, 148),
(53251, 197),
(53251, 273),
(53251, 344),
(53251, 352),
(53251, 357),
(53251, 424),
(53251, 496),
(53251, 522),
(53251, 601),
(53251, 702),
(53251, 714),
(53251, 754),
(53252, 138),
(53252, 613),
(53252, 774),
(53252, 790),
(53252, 794),
(53253, 19),
(53253, 172),
(53253, 212),
(53253, 315),
(53253, 342),
(53253, 414),
(53253, 424),
(53253, 465),
(53253, 496),
(53253, 497),
(53253, 517),
(53253, 522),
(53253, 754),
(53254, 243),
(53254, 269),
(53254, 315),
(53254, 344),
(53254, 497),
(53254, 522),
(53254, 562),
(53254, 581),
(53254, 604),
(53254, 629),
(53254, 722),
(53254, 754),
(53254, 756),
(53255, 19),
(53255, 143),
(53255, 193),
(53255, 317),
(53255, 324),
(53255, 342),
(53255, 357),
(53255, 424),
(53255, 496),
(53255, 497),
(53255, 598),
(53255, 754),
(53255, 800),
(53256, 212),
(53256, 243),
(53256, 269),
(53256, 315),
(53256, 425),
(53256, 488),
(53257, 150),
(53257, 193),
(53257, 314),
(53257, 316),
(53257, 411),
(53257, 497),
(53257, 552),
(53257, 597),
(53257, 601),
(53257, 754),
(53257, 835),
(53258, 112),
(53258, 357),
(53258, 413),
(53258, 454),
(53258, 496),
(53258, 552),
(53258, 702),
(53258, 718),
(53258, 728),
(53258, 807),
(53258, 817),
(53259, 19),
(53259, 232),
(53259, 315),
(53259, 424),
(53259, 835),
(53260, 172),
(53260, 175),
(53260, 277),
(53260, 315),
(53260, 357),
(53260, 413),
(53260, 424),
(53260, 496),
(53261, 141),
(53261, 214),
(53261, 315),
(53261, 380),
(53261, 424),
(53261, 496),
(53262, 415),
(53262, 581),
(53262, 604),
(53262, 629),
(53262, 724),
(53263, 39),
(53263, 172),
(53263, 237),
(53263, 411),
(53263, 418),
(53263, 465),
(53263, 496),
(53263, 497),
(53263, 544),
(53264, 140),
(53264, 277),
(53264, 315),
(53264, 357),
(53264, 496),
(53264, 609),
(53264, 732),
(53264, 780),
(53265, 144),
(53265, 213),
(53265, 315),
(53265, 324),
(53265, 414),
(53265, 425),
(53265, 496),
(53266, 143),
(53266, 256),
(53266, 315),
(53266, 356),
(53266, 357),
(53266, 497),
(53266, 522),
(53266, 724),
(53267, 19),
(53267, 128),
(53267, 203),
(53267, 331),
(53267, 424),
(53267, 465),
(53267, 496),
(53267, 792),
(53268, 138),
(53268, 140),
(53268, 193),
(53268, 213),
(53268, 315),
(53268, 424),
(53268, 496),
(53268, 497),
(53268, 517),
(53268, 552),
(53268, 683),
(53268, 800),
(53269, 143),
(53269, 317),
(53269, 342),
(53269, 424),
(53269, 738),
(53270, 244),
(53270, 389),
(53270, 413),
(53270, 424),
(53270, 465),
(53270, 552),
(53270, 601),
(53270, 656),
(53270, 835),
(53271, 34),
(53271, 92),
(53271, 175),
(53271, 256),
(53271, 354),
(53271, 480),
(53271, 657),
(53271, 710),
(53271, 800),
(53272, 496),
(53272, 714),
(53272, 716),
(53272, 718),
(53272, 830),
(53273, 19),
(53273, 32),
(53273, 128),
(53273, 269),
(53273, 331),
(53273, 465),
(53273, 552),
(53273, 598),
(53273, 627),
(53273, 666),
(53274, 19),
(53274, 193),
(53274, 315),
(53274, 342),
(53274, 424),
(53274, 465),
(53274, 496),
(53274, 522),
(53274, 738),
(53275, 158),
(53275, 269),
(53275, 380),
(53275, 496),
(53275, 666),
(53275, 670),
(53275, 702),
(53275, 729),
(53276, 11),
(53276, 16),
(53276, 342),
(53276, 390),
(53276, 451),
(53276, 457),
(53276, 465),
(53276, 501),
(53276, 767),
(53277, 79),
(53277, 237),
(53277, 315),
(53277, 356),
(53277, 357),
(53277, 415),
(53277, 465),
(53277, 496),
(53277, 552),
(53277, 601),
(53277, 718),
(53277, 750),
(53278, 19),
(53278, 76),
(53278, 128),
(53278, 269),
(53278, 387),
(53278, 424),
(53278, 522),
(53278, 790),
(53278, 800),
(53279, 11),
(53279, 284),
(53279, 353),
(53279, 354),
(53279, 362),
(53279, 424),
(53279, 425),
(53279, 500),
(53279, 534),
(53279, 622),
(53279, 718),
(53279, 774),
(53279, 782),
(53279, 800),
(53280, 32),
(53280, 61),
(53280, 119),
(53280, 131),
(53280, 231),
(53280, 315),
(53280, 496),
(53280, 497),
(53280, 641),
(53280, 801),
(53281, 315),
(53281, 352),
(53281, 497),
(53281, 522),
(53281, 537),
(53281, 559),
(53281, 641),
(53281, 801),
(53282, 40),
(53282, 61),
(53282, 112),
(53282, 315),
(53282, 354),
(53282, 357),
(53282, 425),
(53282, 496),
(53282, 641),
(53282, 748),
(53282, 801),
(53283, 61),
(53283, 119),
(53283, 315),
(53283, 357),
(53283, 489),
(53283, 496),
(53283, 517),
(53283, 598),
(53283, 641),
(53283, 756),
(53283, 801),
(53284, 315),
(53284, 394),
(53284, 496),
(53284, 602),
(53284, 641),
(53284, 659),
(53284, 754),
(53284, 801),
(53285, 2),
(53285, 11),
(53285, 31),
(53285, 201),
(53285, 256),
(53285, 424),
(53285, 425),
(53285, 501),
(53285, 544),
(53285, 641),
(53285, 718),
(53285, 781),
(53285, 790),
(53285, 801),
(53286, 2),
(53286, 256),
(53286, 458),
(53286, 641),
(53286, 660),
(53286, 662),
(53286, 718),
(53286, 790),
(53286, 801),
(53286, 830),
(53287, 61),
(53287, 112),
(53287, 119),
(53287, 121),
(53287, 138),
(53287, 140),
(53287, 170),
(53287, 357),
(53287, 358),
(53287, 496),
(53287, 497),
(53287, 517),
(53287, 522),
(53287, 579),
(53287, 587),
(53287, 641),
(53287, 729),
(53287, 768),
(53288, 315),
(53288, 346),
(53288, 496),
(53288, 537),
(53288, 559),
(53288, 601),
(53288, 641),
(53289, 61),
(53289, 112),
(53289, 121),
(53289, 143),
(53289, 170),
(53289, 298),
(53289, 354),
(53289, 411),
(53289, 465),
(53289, 497),
(53289, 517),
(53289, 574),
(53289, 641),
(53289, 754),
(53289, 756),
(53289, 790),
(53289, 801),
(53289, 836),
(53290, 256),
(53290, 265),
(53290, 315),
(53290, 336),
(53290, 522),
(53290, 540),
(53290, 602),
(53290, 774),
(53291, 2),
(53291, 11),
(53291, 256),
(53291, 354),
(53291, 501),
(53291, 550),
(53291, 641),
(53291, 718),
(53291, 774),
(53291, 790),
(53292, 86),
(53292, 175),
(53292, 221),
(53292, 236),
(53292, 256),
(53292, 354),
(53292, 355),
(53292, 358),
(53292, 360),
(53292, 537),
(53292, 557),
(53292, 657),
(53292, 774),
(53293, 31),
(53293, 92),
(53293, 117),
(53293, 236),
(53293, 256),
(53293, 390),
(53293, 451),
(53293, 550),
(53293, 551),
(53293, 556),
(53293, 590),
(53293, 779),
(53293, 783),
(53294, 29),
(53294, 92),
(53294, 125),
(53294, 158),
(53294, 232),
(53294, 315),
(53294, 369),
(53294, 454),
(53294, 476),
(53294, 481),
(53294, 497),
(53294, 560),
(53294, 755),
(53294, 790),
(53295, 117),
(53295, 159),
(53295, 179),
(53295, 236),
(53295, 256),
(53295, 262),
(53295, 556),
(53295, 573),
(53295, 800),
(53296, 92),
(53296, 256),
(53296, 378),
(53296, 556),
(53296, 646),
(53296, 666),
(53296, 694),
(53296, 724),
(53296, 790),
(53297, 22),
(53297, 128),
(53297, 280),
(53297, 380),
(53297, 425),
(53297, 496),
(53297, 561),
(53297, 598),
(53297, 702),
(53297, 748),
(53298, 6),
(53298, 11),
(53298, 92),
(53298, 117),
(53298, 236),
(53298, 263),
(53298, 293),
(53298, 350),
(53298, 390),
(53298, 395),
(53298, 424),
(53298, 458),
(53298, 495),
(53298, 718),
(53298, 783),
(53298, 830),
(53299, 78),
(53299, 79),
(53299, 256),
(53299, 317),
(53299, 352),
(53299, 448),
(53299, 458),
(53299, 497),
(53299, 790),
(53300, 5),
(53300, 27),
(53300, 40),
(53300, 43),
(53300, 50),
(53300, 178),
(53300, 322),
(53300, 401),
(53300, 419),
(53300, 481),
(53300, 497),
(53300, 538),
(53300, 579),
(53300, 607),
(53300, 756),
(53300, 807),
(53301, 41),
(53301, 50),
(53301, 214),
(53301, 315),
(53301, 419),
(53301, 497),
(53301, 517),
(53301, 556),
(53301, 569),
(53301, 694),
(53301, 803),
(53301, 814),
(53302, 61),
(53302, 251),
(53302, 315),
(53302, 424),
(53302, 569),
(53302, 641),
(53302, 790),
(53303, 117),
(53303, 321),
(53303, 424),
(53303, 590),
(53303, 803),
(53304, 31),
(53304, 92),
(53304, 117),
(53304, 181),
(53304, 256),
(53304, 390),
(53304, 458),
(53304, 556),
(53305, 32),
(53305, 39),
(53305, 96),
(53305, 121),
(53305, 175),
(53305, 191),
(53305, 204),
(53305, 496),
(53305, 497),
(53305, 631),
(53305, 792),
(53306, 41),
(53306, 55),
(53306, 112),
(53306, 232),
(53306, 247),
(53306, 317),
(53306, 497),
(53306, 522),
(53306, 565),
(53306, 574),
(53306, 598),
(53306, 602),
(53306, 694),
(53306, 756),
(53306, 807),
(53307, 55),
(53307, 109),
(53307, 497),
(53307, 597),
(53307, 653),
(53308, 109),
(53308, 380),
(53308, 634),
(53308, 641),
(53308, 714),
(53308, 830),
(53309, 212),
(53309, 232),
(53309, 276),
(53309, 424),
(53309, 694),
(53309, 718),
(53309, 817),
(53310, 117),
(53310, 256),
(53310, 563),
(53310, 714),
(53310, 724),
(53310, 830),
(53311, 40),
(53311, 49),
(53311, 55),
(53311, 112),
(53311, 209),
(53311, 210),
(53311, 232),
(53311, 406),
(53311, 497),
(53311, 574),
(53311, 579),
(53311, 602),
(53311, 724),
(53311, 750),
(53311, 807),
(53312, 112),
(53312, 121),
(53312, 122),
(53312, 169),
(53312, 424),
(53312, 454),
(53312, 497),
(53312, 597),
(53312, 807),
(53312, 823),
(53313, 55),
(53313, 109),
(53313, 128),
(53313, 256),
(53313, 315),
(53313, 342),
(53313, 357),
(53313, 424),
(53313, 465),
(53313, 556),
(53313, 588),
(53313, 627),
(53314, 92),
(53314, 256),
(53314, 378),
(53314, 556),
(53314, 646),
(53314, 666),
(53314, 694),
(53314, 724),
(53314, 790),
(53315, 74),
(53315, 86),
(53315, 92),
(53315, 402),
(53315, 496),
(53315, 597),
(53315, 598),
(53315, 601),
(53315, 609),
(53315, 631),
(53316, 31),
(53316, 55),
(53316, 65),
(53316, 92),
(53316, 256),
(53316, 306),
(53316, 342),
(53316, 446),
(53316, 458),
(53316, 657),
(53316, 783),
(53317, 2),
(53317, 151),
(53317, 244),
(53317, 256),
(53317, 261),
(53317, 315),
(53317, 419),
(53317, 517),
(53317, 522),
(53317, 537),
(53317, 601),
(53317, 603),
(53317, 641),
(53317, 684),
(53317, 702),
(53317, 754),
(53317, 801),
(53318, 2),
(53318, 31),
(53318, 125),
(53318, 244),
(53318, 256),
(53318, 369),
(53318, 458),
(53318, 641),
(53318, 790),
(53319, 27),
(53319, 77),
(53319, 92),
(53319, 151),
(53319, 256),
(53319, 261),
(53319, 315),
(53319, 369),
(53319, 431),
(53319, 458),
(53319, 472),
(53319, 476),
(53319, 483),
(53319, 497),
(53319, 641),
(53319, 662),
(53319, 684),
(53319, 754),
(53319, 801),
(53319, 830),
(53320, 2),
(53320, 31),
(53320, 92),
(53320, 201),
(53320, 254),
(53320, 256),
(53320, 380),
(53320, 459),
(53320, 500),
(53320, 718),
(53320, 776),
(53321, 2),
(53321, 31),
(53321, 92),
(53321, 183),
(53321, 201),
(53321, 254),
(53321, 256),
(53321, 263),
(53321, 718),
(53321, 783),
(53322, 254),
(53322, 256),
(53322, 263),
(53322, 458),
(53322, 718),
(53322, 784),
(53323, 2),
(53323, 201),
(53323, 254),
(53323, 256),
(53323, 262),
(53323, 374),
(53323, 525),
(53323, 526),
(53323, 641),
(53323, 718),
(53323, 783),
(53324, 2),
(53324, 92),
(53324, 172),
(53324, 189),
(53324, 256),
(53324, 458),
(53324, 641),
(53324, 718),
(53324, 776),
(53325, 200),
(53325, 641),
(53325, 790),
(53325, 801),
(53326, 50),
(53326, 94),
(53326, 116),
(53326, 170),
(53326, 315),
(53326, 377),
(53326, 423),
(53326, 497),
(53326, 537),
(53326, 641),
(53326, 650),
(53326, 730),
(53326, 733),
(53326, 818),
(53326, 829),
(53327, 41),
(53327, 61),
(53327, 134),
(53327, 184),
(53327, 213),
(53327, 315),
(53327, 327),
(53327, 496),
(53327, 497),
(53327, 641),
(53327, 718),
(53327, 754),
(53327, 768),
(53327, 801),
(53328, 50),
(53328, 213),
(53328, 315),
(53328, 496),
(53328, 497),
(53328, 537),
(53328, 602),
(53328, 641),
(53328, 686),
(53328, 754),
(53328, 755),
(53328, 756),
(53328, 828),
(53329, 43),
(53329, 50),
(53329, 126),
(53329, 213),
(53329, 269),
(53329, 315),
(53329, 497),
(53329, 504),
(53329, 517),
(53329, 602),
(53329, 641),
(53329, 801),
(53330, 113),
(53330, 164),
(53330, 345),
(53330, 476),
(53330, 517),
(53330, 733),
(53330, 757),
(53330, 765),
(53331, 31),
(53331, 92),
(53331, 256),
(53331, 361),
(53331, 458),
(53331, 641),
(53331, 712),
(53331, 718),
(53331, 720),
(53331, 783),
(53332, 105),
(53332, 319),
(53332, 346),
(53332, 352),
(53332, 357),
(53332, 497),
(53332, 537),
(53332, 602),
(53332, 649),
(53332, 757),
(53332, 790),
(53332, 832),
(53333, 189),
(53333, 262),
(53333, 465),
(53333, 524),
(53333, 718),
(53333, 772),
(53334, 59),
(53334, 196),
(53334, 303),
(53334, 537),
(53334, 542),
(53334, 641),
(53334, 675),
(53334, 754),
(53335, 43),
(53335, 61),
(53335, 92),
(53335, 95),
(53335, 112),
(53335, 574),
(53335, 770),
(53335, 834),
(53336, 27),
(53336, 86),
(53336, 169),
(53336, 249),
(53336, 472),
(53336, 483),
(53336, 497),
(53336, 537),
(53336, 641),
(53337, 2),
(53337, 201),
(53337, 256),
(53337, 641),
(53337, 645),
(53337, 718),
(53337, 774),
(53337, 791),
(53337, 799),
(53337, 801),
(53338, 2),
(53338, 31),
(53338, 86),
(53338, 494),
(53338, 554),
(53338, 641),
(53338, 774),
(53338, 781),
(53338, 801),
(53339, 31),
(53339, 92),
(53339, 172),
(53339, 256),
(53339, 293),
(53339, 395),
(53339, 472),
(53339, 641),
(53339, 718),
(53339, 781),
(53339, 801),
(53340, 61),
(53340, 92),
(53340, 112),
(53340, 158),
(53340, 232),
(53340, 343),
(53340, 374),
(53340, 458),
(53340, 489),
(53340, 533),
(53340, 641),
(53341, 201),
(53341, 207),
(53341, 262),
(53341, 263),
(53341, 337),
(53341, 354),
(53341, 456),
(53341, 458),
(53341, 641),
(53341, 718),
(53341, 783),
(53342, 2),
(53342, 4),
(53342, 31),
(53342, 86),
(53342, 172),
(53342, 324),
(53342, 456),
(53342, 472),
(53342, 587),
(53342, 801),
(53343, 40),
(53343, 50),
(53343, 104),
(53343, 242),
(53343, 256),
(53343, 315),
(53343, 352),
(53343, 355),
(53343, 360),
(53343, 364),
(53343, 497),
(53343, 537),
(53343, 633),
(53343, 641),
(53343, 672),
(53344, 2),
(53344, 4),
(53344, 86),
(53344, 184),
(53344, 354),
(53344, 358),
(53344, 360),
(53344, 587),
(53344, 641),
(53344, 729),
(53344, 783),
(53345, 3),
(53345, 140),
(53345, 216),
(53345, 315),
(53345, 346),
(53345, 496),
(53345, 497),
(53345, 537),
(53345, 633),
(53345, 641),
(53345, 651),
(53345, 702),
(53345, 748),
(53345, 801),
(53346, 189),
(53346, 340),
(53346, 374),
(53346, 783),
(53347, 4),
(53347, 86),
(53347, 189),
(53347, 223),
(53347, 354),
(53347, 374),
(53347, 587),
(53347, 641),
(53347, 783),
(53348, 2),
(53348, 31),
(53348, 54),
(53348, 86),
(53348, 108),
(53348, 238),
(53348, 240),
(53348, 256),
(53348, 354),
(53348, 380),
(53348, 458),
(53348, 472),
(53348, 587),
(53348, 641),
(53348, 774),
(53348, 783),
(53349, 3),
(53349, 4),
(53349, 315),
(53349, 351),
(53349, 497),
(53349, 641),
(53349, 651),
(53349, 678),
(53349, 680),
(53349, 748),
(53349, 815),
(53350, 95),
(53350, 199),
(53350, 315),
(53350, 346),
(53350, 496),
(53350, 497),
(53350, 537),
(53350, 559),
(53350, 641),
(53350, 748),
(53350, 755),
(53351, 2),
(53351, 34),
(53351, 86),
(53351, 172),
(53351, 492),
(53351, 495),
(53351, 641),
(53351, 783),
(53352, 4),
(53352, 61),
(53352, 184),
(53352, 315),
(53352, 406),
(53352, 496),
(53352, 497),
(53352, 613),
(53352, 641),
(53352, 702),
(53352, 748),
(53352, 801),
(53353, 2),
(53353, 641),
(53353, 801),
(53354, 3),
(53354, 4),
(53354, 315),
(53354, 330),
(53354, 358),
(53354, 396),
(53354, 495),
(53354, 497),
(53354, 537),
(53354, 633),
(53354, 641),
(53354, 651),
(53354, 748),
(53354, 801),
(53355, 2),
(53355, 31),
(53355, 200),
(53355, 458),
(53355, 495),
(53355, 641),
(53355, 718),
(53355, 783),
(53356, 2),
(53356, 31),
(53356, 458),
(53356, 495),
(53356, 641),
(53357, 61),
(53357, 184),
(53357, 349),
(53357, 406),
(53357, 410),
(53357, 613),
(53357, 651),
(53357, 702),
(53357, 748),
(53357, 801),
(53358, 39),
(53358, 40),
(53358, 110),
(53358, 131),
(53358, 172),
(53358, 178),
(53358, 193),
(53358, 315),
(53358, 344),
(53358, 495),
(53358, 497),
(53358, 537),
(53358, 641),
(53358, 769),
(53358, 801),
(53359, 39),
(53359, 40),
(53359, 50),
(53359, 110),
(53359, 178),
(53359, 315),
(53359, 344),
(53359, 495),
(53359, 497),
(53359, 641),
(53359, 754),
(53359, 769),
(53360, 718),
(53360, 741),
(53361, 27),
(53361, 61),
(53361, 99),
(53361, 315),
(53361, 497),
(53361, 559),
(53361, 642),
(53361, 651),
(53361, 702),
(53361, 748),
(53362, 3),
(53362, 315),
(53362, 346),
(53362, 396),
(53362, 400),
(53362, 496),
(53362, 497),
(53362, 537),
(53362, 602),
(53362, 641),
(53362, 651),
(53362, 748),
(53362, 755),
(53362, 777),
(53363, 184),
(53363, 285),
(53363, 349),
(53363, 354),
(53363, 360),
(53363, 734),
(53363, 783),
(53363, 801),
(53364, 61),
(53364, 95),
(53364, 112),
(53364, 315),
(53364, 410),
(53364, 496),
(53364, 497),
(53364, 559),
(53364, 651),
(53364, 702),
(53364, 748),
(53364, 774),
(53364, 801),
(53365, 2),
(53365, 61),
(53365, 140),
(53365, 201),
(53365, 256),
(53365, 315),
(53365, 500),
(53365, 502),
(53365, 613),
(53365, 620),
(53365, 641),
(53365, 650),
(53365, 662),
(53365, 664),
(53365, 666),
(53365, 696),
(53365, 718),
(53365, 790),
(53365, 801),
(53366, 61),
(53366, 82),
(53366, 138),
(53366, 201),
(53366, 250),
(53366, 315),
(53366, 376),
(53366, 508),
(53366, 684),
(53366, 696),
(53366, 801),
(53367, 104),
(53367, 112),
(53367, 140),
(53367, 154),
(53367, 256),
(53367, 315),
(53367, 358),
(53367, 397),
(53367, 497),
(53367, 533),
(53367, 641),
(53367, 650),
(53367, 664),
(53367, 696),
(53368, 112),
(53368, 171),
(53368, 216),
(53368, 256),
(53368, 315),
(53368, 358),
(53368, 369),
(53368, 394),
(53368, 487),
(53368, 497),
(53368, 602),
(53368, 641),
(53368, 650),
(53368, 655),
(53368, 664),
(53368, 678),
(53368, 696),
(53368, 795),
(53369, 157),
(53369, 650),
(53369, 662),
(53369, 682),
(53369, 696),
(53370, 201),
(53370, 256),
(53370, 397),
(53370, 410),
(53370, 479),
(53370, 508),
(53370, 537),
(53370, 667),
(53370, 678),
(53370, 696),
(53370, 702),
(53370, 718),
(53370, 773),
(53370, 790),
(53370, 801),
(53371, 156),
(53371, 239),
(53371, 530),
(53371, 641),
(53371, 664),
(53371, 681),
(53371, 696),
(53371, 718),
(53372, 132),
(53372, 264),
(53372, 397),
(53372, 537),
(53372, 559),
(53372, 641),
(53372, 664),
(53372, 702),
(53372, 718),
(53372, 790),
(53373, 95),
(53373, 112),
(53373, 253),
(53373, 259),
(53373, 315),
(53373, 324),
(53373, 364),
(53373, 495),
(53373, 496),
(53373, 558),
(53373, 620),
(53373, 650),
(53373, 696),
(53374, 14),
(53374, 138),
(53374, 147),
(53374, 170),
(53374, 201),
(53374, 258),
(53374, 315),
(53374, 324),
(53374, 530),
(53374, 650),
(53374, 681),
(53374, 696),
(53374, 718),
(53375, 138),
(53375, 201),
(53375, 250),
(53375, 315),
(53375, 358),
(53375, 410),
(53375, 530),
(53375, 650),
(53375, 664),
(53375, 678),
(53375, 692),
(53375, 696),
(53376, 86),
(53376, 140),
(53376, 201),
(53376, 262),
(53376, 324),
(53376, 410),
(53376, 495),
(53376, 545),
(53376, 546),
(53376, 602),
(53376, 755),
(53376, 815),
(53376, 833),
(53377, 67),
(53377, 201),
(53377, 246),
(53377, 324),
(53377, 410),
(53377, 487),
(53377, 530),
(53377, 537),
(53377, 650),
(53377, 696),
(53377, 801),
(53378, 38),
(53378, 212),
(53378, 599),
(53378, 620),
(53378, 641),
(53378, 662),
(53378, 664),
(53379, 89),
(53379, 92),
(53379, 264),
(53379, 293),
(53379, 390),
(53379, 458),
(53379, 785),
(53379, 830),
(53380, 15),
(53380, 264),
(53380, 354),
(53380, 365),
(53380, 456),
(53380, 641),
(53380, 657),
(53380, 718),
(53380, 783),
(53381, 10),
(53381, 11),
(53381, 86),
(53381, 92),
(53381, 256),
(53381, 458),
(53381, 641),
(53381, 657),
(53381, 700),
(53382, 2),
(53382, 86),
(53382, 172),
(53382, 255),
(53382, 256),
(53382, 391),
(53382, 458),
(53382, 641),
(53382, 718),
(53382, 774),
(53383, 150),
(53383, 256),
(53383, 490),
(53383, 537),
(53383, 641),
(53383, 696),
(53383, 702),
(53383, 801),
(53385, 2),
(53385, 92),
(53385, 221),
(53385, 254),
(53385, 256),
(53385, 641),
(53385, 718),
(53386, 15),
(53386, 92),
(53386, 172),
(53386, 188),
(53386, 263),
(53386, 293),
(53386, 587),
(53386, 641),
(53386, 718),
(53387, 31),
(53387, 110),
(53387, 219),
(53387, 324),
(53387, 458),
(53387, 641),
(53387, 657),
(53387, 718),
(53388, 27),
(53388, 92),
(53388, 126),
(53388, 315),
(53388, 458),
(53388, 483),
(53388, 497),
(53388, 574),
(53388, 632),
(53388, 641),
(53389, 15),
(53389, 27),
(53389, 126),
(53389, 173),
(53389, 256),
(53389, 354),
(53389, 446),
(53389, 574),
(53389, 641),
(53389, 662),
(53391, 31),
(53391, 110),
(53391, 173),
(53391, 185),
(53391, 228),
(53391, 293),
(53391, 425),
(53391, 706),
(53391, 718),
(53391, 783),
(53391, 789),
(53391, 830),
(53392, 110),
(53392, 172),
(53392, 433),
(53392, 580),
(53392, 785),
(53393, 293),
(53393, 391),
(53393, 458),
(53393, 641),
(53393, 718),
(53394, 86),
(53394, 110),
(53394, 172),
(53394, 256),
(53394, 293),
(53394, 458),
(53394, 641),
(53394, 718),
(53394, 774),
(53394, 830),
(53395, 201),
(53395, 264),
(53395, 293),
(53395, 309),
(53395, 395),
(53395, 491),
(53395, 718),
(53395, 785),
(53395, 803);

INSERT INTO meal_allergens (meal_id, allergen_id) VALUES
(52764, 2),
(52764, 7),
(52765, 2),
(52767, 1),
(52767, 2),
(52767, 3),
(52767, 4),
(52768, 2),
(52768, 3),
(52768, 4),
(52769, 2),
(52770, 1),
(52770, 2),
(52771, 3),
(52772, 6),
(52773, 6),
(52773, 8),
(52773, 10),
(52774, 1),
(52774, 3),
(52774, 5),
(52774, 6),
(52775, 1),
(52775, 2),
(52775, 6),
(52776, 1),
(52776, 2),
(52776, 3),
(52777, 2),
(52777, 8),
(52779, 1),
(52779, 2),
(52779, 3),
(52780, 2),
(52781, 1),
(52783, 8),
(52784, 4),
(52786, 2),
(52786, 5),
(52787, 2),
(52788, 1),
(52788, 2),
(52791, 2),
(52792, 1),
(52792, 2),
(52792, 3),
(52793, 1),
(52793, 2),
(52793, 3),
(52794, 1),
(52794, 3),
(52794, 4),
(52795, 2),
(52796, 1),
(52796, 2),
(52802, 1),
(52802, 2),
(52802, 7),
(52802, 8),
(52803, 1),
(52803, 3),
(52804, 2),
(52805, 2),
(52805, 4),
(52806, 2),
(52808, 2),
(52809, 8),
(52810, 1),
(52810, 2),
(52810, 9),
(52811, 1),
(52811, 2),
(52811, 9),
(52813, 1),
(52813, 3),
(52813, 9),
(52814, 8),
(52815, 9),
(52816, 3),
(52816, 9),
(52817, 2),
(52817, 3),
(52818, 2),
(52819, 1),
(52819, 2),
(52819, 8),
(52820, 1),
(52820, 3),
(52820, 6),
(52821, 1),
(52821, 7),
(52821, 8),
(52822, 1),
(52822, 2),
(52822, 3),
(52823, 2),
(52823, 7),
(52823, 8),
(52824, 1),
(52824, 2),
(52824, 3),
(52827, 2),
(52827, 5),
(52827, 8),
(52828, 3),
(52828, 5),
(52828, 6),
(52828, 8),
(52829, 1),
(52829, 2),
(52830, 2),
(52831, 6),
(52832, 1),
(52832, 2),
(52833, 2),
(52834, 1),
(52834, 2),
(52835, 1),
(52835, 2),
(52836, 1),
(52836, 7),
(52836, 8),
(52837, 1),
(52837, 2),
(52838, 1),
(52838, 2),
(52839, 1),
(52839, 7),
(52840, 1),
(52840, 2),
(52841, 2),
(52841, 9),
(52842, 2),
(52842, 9),
(52843, 1),
(52843, 2),
(52844, 2),
(52844, 9),
(52845, 1),
(52845, 3),
(52846, 1),
(52846, 2),
(52847, 1),
(52848, 2),
(52849, 2),
(52850, 1),
(52851, 2),
(52851, 5),
(52852, 3),
(52852, 8),
(52854, 1),
(52854, 2),
(52854, 3),
(52855, 3),
(52855, 4),
(52856, 1),
(52856, 2),
(52856, 3),
(52856, 4),
(52857, 1),
(52857, 2),
(52857, 3),
(52858, 1),
(52858, 2),
(52858, 3),
(52859, 2),
(52859, 3),
(52860, 1),
(52860, 2),
(52860, 3),
(52861, 2),
(52861, 5),
(52862, 1),
(52862, 2),
(52863, 9),
(52864, 1),
(52864, 6),
(52865, 1),
(52866, 1),
(52866, 2),
(52870, 2),
(52871, 1),
(52871, 6),
(52871, 10),
(52872, 2),
(52872, 3),
(52873, 1),
(52873, 2),
(52873, 9),
(52874, 1),
(52874, 2),
(52874, 3),
(52875, 1),
(52875, 2),
(52875, 3),
(52876, 1),
(52876, 3),
(52877, 1),
(52877, 3),
(52878, 1),
(52878, 2),
(52878, 3),
(52879, 2),
(52879, 3),
(52879, 9),
(52880, 1),
(52880, 2),
(52880, 3),
(52881, 1),
(52881, 3),
(52882, 1),
(52882, 2),
(52882, 3),
(52882, 8),
(52883, 1),
(52883, 2),
(52883, 3),
(52884, 1),
(52884, 2),
(52886, 1),
(52886, 2),
(52887, 2),
(52887, 3),
(52887, 8),
(52888, 1),
(52888, 2),
(52888, 3),
(52889, 1),
(52890, 1),
(52890, 2),
(52891, 1),
(52891, 2),
(52892, 1),
(52892, 2),
(52892, 3),
(52893, 1),
(52893, 2),
(52894, 1),
(52894, 2),
(52894, 3),
(52894, 4),
(52895, 1),
(52895, 3),
(52896, 1),
(52896, 3),
(52897, 1),
(52897, 2),
(52897, 3),
(52897, 4),
(52898, 1),
(52898, 2),
(52898, 3),
(52899, 1),
(52899, 2),
(52899, 3),
(52899, 4),
(52900, 1),
(52900, 2),
(52900, 3),
(52901, 1),
(52901, 2),
(52901, 3),
(52902, 1),
(52902, 2),
(52902, 3),
(52903, 1),
(52903, 2),
(52905, 2),
(52905, 3),
(52906, 1),
(52906, 2),
(52906, 3),
(52909, 1),
(52909, 2),
(52911, 2),
(52912, 1),
(52912, 2),
(52912, 3),
(52913, 1),
(52913, 2),
(52913, 3),
(52915, 2),
(52915, 3),
(52916, 2),
(52917, 2),
(52917, 3),
(52918, 1),
(52918, 7),
(52918, 8),
(52919, 2),
(52921, 2),
(52921, 3),
(52922, 2),
(52922, 7),
(52922, 8),
(52923, 2),
(52923, 3),
(52923, 4),
(52924, 2),
(52924, 3),
(52924, 4),
(52925, 1),
(52925, 9),
(52926, 3),
(52927, 9),
(52928, 1),
(52928, 2),
(52928, 3),
(52929, 1),
(52929, 2),
(52929, 3),
(52930, 2),
(52931, 1),
(52931, 2),
(52931, 3),
(52932, 1),
(52932, 2),
(52932, 3),
(52933, 2),
(52934, 2),
(52935, 2),
(52936, 1),
(52936, 8),
(52937, 6),
(52938, 1),
(52938, 2),
(52938, 3),
(52940, 6),
(52941, 1),
(52943, 1),
(52943, 6),
(52945, 1),
(52945, 5),
(52945, 6),
(52945, 10),
(52946, 1),
(52946, 5),
(52946, 6),
(52946, 7),
(52947, 6),
(52947, 10),
(52948, 6),
(52948, 9),
(52948, 10),
(52949, 3),
(52949, 6),
(52950, 3),
(52950, 6),
(52950, 9),
(52950, 10),
(52951, 1),
(52951, 3),
(52951, 6),
(52951, 10),
(52952, 1),
(52952, 3),
(52952, 6),
(52952, 10),
(52953, 1),
(52953, 3),
(52953, 6),
(52953, 7),
(52953, 10),
(52954, 6),
(52954, 10),
(52955, 10),
(52957, 1),
(52957, 2),
(52958, 2),
(52958, 3),
(52958, 5),
(52959, 8),
(52960, 8),
(52961, 1),
(52961, 3),
(52962, 2),
(52962, 3),
(52962, 8),
(52963, 3),
(52964, 2),
(52964, 3),
(52964, 8),
(52966, 2),
(52967, 1),
(52967, 2),
(52967, 3),
(52968, 1),
(52969, 3),
(52970, 1),
(52970, 3),
(52971, 3),
(52974, 2),
(52975, 3),
(52975, 8),
(52976, 3),
(52976, 4),
(52978, 2),
(52979, 1),
(52979, 2),
(52979, 3),
(52980, 2),
(52981, 9),
(52982, 1),
(52982, 3),
(52987, 1),
(52987, 2),
(52988, 1),
(52988, 2),
(52988, 3),
(52988, 4),
(52989, 2),
(52989, 4),
(52990, 1),
(52990, 2),
(52990, 3),
(52990, 4),
(52991, 1),
(52991, 2),
(52991, 3),
(52992, 1),
(52992, 2),
(52992, 6),
(52993, 2),
(52994, 2),
(52995, 1),
(52996, 2),
(52997, 6),
(53000, 2),
(53000, 6),
(53005, 1),
(53005, 2),
(53006, 2),
(53006, 3),
(53007, 2),
(53007, 3),
(53007, 4),
(53009, 1),
(53010, 1),
(53010, 2),
(53011, 2),
(53012, 2),
(53013, 2),
(53013, 10),
(53014, 1),
(53014, 2),
(53015, 1),
(53015, 2),
(53015, 3),
(53016, 1),
(53016, 2),
(53016, 3),
(53016, 9),
(53016, 10),
(53017, 1),
(53017, 2),
(53017, 3),
(53018, 1),
(53019, 1),
(53019, 2),
(53019, 3),
(53020, 9),
(53021, 2),
(53022, 1),
(53022, 2),
(53022, 3),
(53024, 1),
(53024, 2),
(53024, 3),
(53026, 1),
(53028, 1),
(53028, 2),
(53030, 1),
(53030, 2),
(53031, 1),
(53031, 2),
(53032, 1),
(53032, 3),
(53034, 3),
(53034, 6),
(53035, 1),
(53035, 2),
(53035, 3),
(53036, 1),
(53036, 2),
(53036, 3),
(53037, 2),
(53038, 2),
(53039, 2),
(53040, 1),
(53040, 2),
(53040, 3),
(53040, 7),
(53043, 1),
(53043, 3),
(53043, 8),
(53045, 7),
(53045, 8),
(53046, 1),
(53046, 2),
(53046, 3),
(53048, 1),
(53048, 3),
(53048, 5),
(53048, 6),
(53048, 7),
(53049, 1),
(53049, 2),
(53049, 3),
(53049, 5),
(53051, 3),
(53051, 5),
(53051, 8),
(53052, 3),
(53053, 2),
(53054, 1),
(53054, 2),
(53054, 3),
(53055, 1),
(53059, 1),
(53059, 2),
(53061, 1),
(53062, 1),
(53062, 2),
(53062, 3),
(53062, 4),
(53063, 1),
(53063, 2),
(53063, 3),
(53064, 2),
(53065, 6),
(53067, 2),
(53068, 6),
(53069, 6),
(53070, 2),
(53070, 5),
(53070, 6),
(53071, 2),
(53071, 6),
(53072, 1),
(53072, 3),
(53072, 10),
(53073, 3),
(53073, 6),
(53074, 3),
(53075, 3),
(53076, 1),
(53076, 3),
(53077, 2),
(53077, 9),
(53079, 8),
(53080, 1),
(53080, 2),
(53080, 3),
(53081, 3),
(53082, 2),
(53083, 2),
(53086, 1),
(53089, 1),
(53091, 1),
(53093, 1),
(53094, 2),
(53094, 3),
(53095, 2),
(53096, 2),
(53097, 1),
(53097, 2),
(53097, 3),
(53098, 1),
(53098, 2),
(53098, 9),
(53099, 1),
(53099, 2),
(53100, 1),
(53100, 2),
(53100, 3),
(53100, 4),
(53101, 1),
(53101, 2),
(53101, 3),
(53104, 1),
(53104, 2),
(53104, 3),
(53107, 2),
(53108, 10),
(53109, 2),
(53110, 6),
(53111, 1),
(53111, 2),
(53113, 2),
(53116, 1),
(53116, 2),
(53116, 3),
(53117, 1),
(53117, 2),
(53118, 1),
(53118, 2),
(53119, 1),
(53119, 2),
(53119, 3),
(53121, 1),
(53121, 2),
(53122, 1),
(53122, 2),
(53122, 7),
(53122, 8),
(53123, 1),
(53124, 1),
(53124, 2),
(53125, 2),
(53126, 9),
(53127, 3),
(53127, 4),
(53128, 1),
(53128, 2),
(53128, 3),
(53128, 4),
(53129, 1),
(53129, 2),
(53129, 3),
(53130, 1),
(53130, 2),
(53130, 3),
(53130, 4),
(53131, 1),
(53131, 2),
(53131, 3),
(53131, 4),
(53132, 1),
(53132, 2),
(53132, 3),
(53132, 4),
(53134, 1),
(53134, 2),
(53134, 3),
(53135, 1),
(53135, 3),
(53136, 1),
(53137, 2),
(53138, 1),
(53138, 2),
(53138, 3),
(53139, 1),
(53140, 2),
(53142, 3),
(53143, 2),
(53144, 7),
(53145, 1),
(53145, 2),
(53145, 3),
(53147, 7),
(53148, 1),
(53148, 2),
(53148, 3),
(53149, 1),
(53149, 3),
(53151, 7),
(53152, 1),
(53153, 1),
(53153, 2),
(53154, 1),
(53154, 2),
(53157, 3),
(53159, 2),
(53159, 3),
(53160, 3),
(53162, 1),
(53162, 3),
(53162, 4),
(53162, 9),
(53163, 4),
(53163, 10),
(53165, 1),
(53165, 2),
(53165, 3),
(53166, 9),
(53167, 8),
(53168, 1),
(53169, 1),
(53169, 4),
(53170, 1),
(53170, 2),
(53171, 3),
(53171, 8),
(53174, 1),
(53174, 4),
(53174, 7),
(53175, 2),
(53177, 1),
(53177, 2),
(53178, 1),
(53179, 1),
(53179, 2),
(53179, 3),
(53180, 7),
(53183, 1),
(53183, 2),
(53183, 3),
(53184, 7),
(53187, 1),
(53187, 2),
(53188, 1),
(53188, 2),
(53188, 3),
(53189, 1),
(53189, 3),
(53190, 1),
(53190, 2),
(53190, 3),
(53191, 1),
(53191, 5),
(53191, 7),
(53191, 8),
(53192, 5),
(53192, 7),
(53192, 8),
(53193, 1),
(53193, 6),
(53193, 8),
(53194, 7),
(53194, 8),
(53195, 1),
(53195, 7),
(53196, 7),
(53196, 8),
(53197, 2),
(53197, 5),
(53197, 6),
(53198, 3),
(53198, 6),
(53198, 7),
(53198, 8),
(53200, 1),
(53200, 6),
(53200, 7),
(53200, 8),
(53201, 6),
(53201, 8),
(53202, 6),
(53203, 1),
(53203, 8),
(53203, 10),
(53205, 2),
(53205, 7),
(53207, 8),
(53208, 1),
(53208, 3),
(53209, 1),
(53209, 3),
(53209, 5),
(53209, 6),
(53209, 7),
(53209, 10),
(53211, 1),
(53211, 6),
(53213, 1),
(53213, 7),
(53213, 8),
(53214, 8),
(53215, 3),
(53216, 1),
(53216, 2),
(53218, 2),
(53219, 3),
(53219, 9),
(53221, 1),
(53221, 2),
(53222, 3),
(53223, 2),
(53223, 3),
(53224, 2),
(53224, 4),
(53225, 2),
(53225, 3),
(53226, 1),
(53227, 6),
(53227, 10),
(53228, 8),
(53229, 1),
(53229, 8),
(53230, 1),
(53230, 8),
(53230, 10),
(53231, 8),
(53232, 1),
(53232, 5),
(53232, 6),
(53232, 8),
(53232, 10),
(53233, 1),
(53233, 8),
(53234, 1),
(53234, 6),
(53234, 8),
(53235, 8),
(53236, 2),
(53236, 6),
(53237, 6),
(53237, 8),
(53237, 9),
(53237, 10),
(53238, 1),
(53238, 6),
(53238, 8),
(53239, 1),
(53239, 2),
(53239, 5),
(53239, 7),
(53240, 4),
(53240, 6),
(53241, 1),
(53241, 8),
(53242, 1),
(53242, 3),
(53242, 6),
(53243, 7),
(53243, 8),
(53244, 1),
(53244, 5),
(53244, 7),
(53244, 8),
(53245, 1),
(53245, 6),
(53245, 8),
(53245, 10),
(53246, 5),
(53247, 6),
(53248, 1),
(53248, 8),
(53251, 1),
(53252, 1),
(53252, 2),
(53253, 2),
(53255, 2),
(53255, 4),
(53256, 2),
(53257, 1),
(53257, 2),
(53258, 1),
(53259, 2),
(53266, 3),
(53267, 1),
(53267, 2),
(53268, 1),
(53268, 2),
(53268, 4),
(53269, 2),
(53270, 1),
(53270, 2),
(53271, 1),
(53271, 2),
(53271, 3),
(53271, 4),
(53272, 1),
(53273, 1),
(53273, 2),
(53274, 2),
(53276, 2),
(53276, 4),
(53277, 1),
(53278, 1),
(53278, 4),
(53279, 2),
(53279, 4),
(53285, 1),
(53285, 3),
(53285, 4),
(53286, 1),
(53286, 2),
(53286, 3),
(53286, 10),
(53287, 9),
(53289, 9),
(53290, 2),
(53290, 3),
(53291, 1),
(53291, 2),
(53291, 3),
(53291, 4),
(53292, 1),
(53292, 2),
(53292, 3),
(53293, 1),
(53293, 2),
(53293, 3),
(53293, 4),
(53294, 2),
(53295, 1),
(53295, 2),
(53295, 3),
(53295, 4),
(53296, 1),
(53296, 2),
(53296, 3),
(53298, 1),
(53298, 2),
(53298, 3),
(53298, 4),
(53299, 1),
(53299, 2),
(53299, 3),
(53301, 1),
(53301, 2),
(53303, 2),
(53304, 1),
(53304, 2),
(53304, 3),
(53305, 9),
(53306, 2),
(53308, 1),
(53309, 2),
(53310, 1),
(53310, 3),
(53311, 1),
(53312, 9),
(53313, 1),
(53313, 2),
(53313, 3),
(53314, 1),
(53314, 2),
(53314, 3),
(53315, 2),
(53316, 1),
(53316, 2),
(53316, 3),
(53317, 1),
(53317, 3),
(53318, 1),
(53318, 2),
(53318, 3),
(53319, 1),
(53319, 2),
(53319, 3),
(53319, 10),
(53320, 1),
(53320, 2),
(53320, 3),
(53321, 1),
(53321, 2),
(53321, 3),
(53322, 2),
(53322, 3),
(53323, 1),
(53323, 2),
(53323, 3),
(53324, 1),
(53324, 2),
(53324, 3),
(53326, 2),
(53329, 2),
(53330, 2),
(53331, 1),
(53331, 2),
(53331, 3),
(53333, 2),
(53333, 3),
(53334, 2),
(53335, 2),
(53337, 1),
(53337, 2),
(53337, 3),
(53338, 1),
(53338, 2),
(53339, 1),
(53339, 2),
(53339, 3),
(53340, 2),
(53341, 2),
(53341, 3),
(53342, 1),
(53342, 2),
(53343, 3),
(53344, 1),
(53346, 2),
(53347, 2),
(53348, 1),
(53348, 2),
(53348, 3),
(53349, 7),
(53351, 1),
(53353, 1),
(53355, 1),
(53355, 2),
(53356, 1),
(53356, 2),
(53361, 8),
(53362, 2),
(53362, 7),
(53363, 2),
(53364, 2),
(53365, 1),
(53365, 3),
(53365, 6),
(53365, 10),
(53366, 6),
(53367, 3),
(53367, 6),
(53367, 10),
(53368, 1),
(53368, 3),
(53368, 6),
(53368, 7),
(53368, 10),
(53369, 6),
(53369, 10),
(53370, 3),
(53370, 6),
(53370, 7),
(53371, 5),
(53371, 6),
(53371, 10),
(53372, 3),
(53372, 10),
(53373, 3),
(53373, 6),
(53374, 3),
(53374, 5),
(53374, 6),
(53375, 5),
(53375, 6),
(53375, 7),
(53375, 10),
(53376, 3),
(53377, 5),
(53377, 6),
(53377, 7),
(53378, 10),
(53379, 1),
(53379, 2),
(53379, 3),
(53380, 1),
(53380, 2),
(53380, 3),
(53381, 1),
(53381, 2),
(53381, 3),
(53381, 4),
(53382, 1),
(53382, 2),
(53382, 3),
(53383, 1),
(53383, 3),
(53383, 6),
(53385, 1),
(53385, 2),
(53385, 3),
(53386, 1),
(53386, 2),
(53386, 3),
(53387, 1),
(53387, 2),
(53388, 2),
(53389, 2),
(53389, 3),
(53389, 10),
(53391, 1),
(53393, 1),
(53393, 2),
(53394, 1),
(53394, 2),
(53394, 3),
(53395, 1),
(53395, 2),
(53395, 3);


-- ====== STORED PROCEDURES ======

DELIMITER $$


CREATE PROCEDURE add_ingredient(IN p_name VARCHAR(255))
BEGIN
    INSERT IGNORE INTO ingredients(name) VALUES(p_name);
END$$


CREATE PROCEDURE add_meal(
    IN p_id INT,
    IN p_name VARCHAR(255),
    IN p_category VARCHAR(255),
    IN p_area VARCHAR(255),
    IN p_instructions TEXT,
    IN p_thumb VARCHAR(500)
)
BEGIN
    INSERT INTO meals(id, name, category, area, instructions, thumbnail_url)
    VALUES(p_id, p_name, p_category, p_area, p_instructions, p_thumb);
END$$


CREATE PROCEDURE delete_meal(IN p_id INT)
BEGIN
    DELETE FROM meals WHERE id = p_id;
END$$


CREATE PROCEDURE find_meals_by_ingredient(IN p_ingredient VARCHAR(255))
BEGIN
  SELECT m.* FROM meals m
  JOIN meal_ingredients mi ON m.id=mi.meal_id
  JOIN ingredients i ON mi.ingredient_id=i.id
  WHERE i.name = p_ingredient;
END$$


CREATE PROCEDURE find_meals_without_allergen(IN p_allergen_name VARCHAR(100))
BEGIN
    SELECT m.*
      FROM meals m
     WHERE m.id NOT IN (
         SELECT ma.meal_id
           FROM meal_allergens ma
           JOIN allergens a ON a.id = ma.allergen_id
          WHERE a.name = p_allergen_name
     );
END$$


CREATE PROCEDURE gebruiker_aanmaken(IN p_naam VARCHAR(255), IN p_email VARCHAR(255))
BEGIN
    INSERT INTO gebruikers (naam, email) VALUES (p_naam, p_email);
END$$


CREATE PROCEDURE gebruiker_aanmelden(IN p_email VARCHAR(255))
BEGIN
    SELECT id, naam, email FROM gebruikers WHERE email = p_email;
END$$


CREATE PROCEDURE gebruiker_allergeen_toevoegen(IN p_gebruiker_id INT, IN p_allergeen VARCHAR(255))
BEGIN
    INSERT IGNORE INTO gebruiker_allergenen (gebruiker_id, allergen_id)
    SELECT p_gebruiker_id, id FROM allergens WHERE name = p_allergeen;
END$$


CREATE PROCEDURE gebruiker_allergenen_ophalen(IN p_gebruiker_id INT)
BEGIN
    SELECT a.id, a.name FROM gebruiker_allergenen ga
    JOIN allergens a ON ga.allergen_id = a.id
    WHERE ga.gebruiker_id = p_gebruiker_id ORDER BY a.name;
END$$


CREATE PROCEDURE gerechten_voor_gebruiker(IN p_gebruiker_id INT)
BEGIN
    SELECT m.* FROM meals m
    WHERE NOT EXISTS (
        SELECT 1 FROM meal_allergens ma
        JOIN gebruiker_allergenen ga ON ma.allergen_id = ga.allergen_id
        WHERE ma.meal_id = m.id AND ga.gebruiker_id = p_gebruiker_id
    )
    ORDER BY m.name;
END$$


CREATE PROCEDURE get_meal_allergens(IN p_meal_id INT)
BEGIN
    SELECT a.id, a.name, a.description
      FROM allergens a
      JOIN meal_allergens ma ON a.id = ma.allergen_id
     WHERE ma.meal_id = p_meal_id;
END$$


CREATE PROCEDURE link_ingredient_allergen(
    IN p_ingredient_name VARCHAR(255),
    IN p_allergen_name VARCHAR(100)
)
BEGIN
    DECLARE v_meal_id INT;

    
    INSERT IGNORE INTO meal_allergens (meal_id, allergen_id)
    SELECT mi.meal_id, a.id
      FROM meal_ingredients mi
      JOIN ingredients i ON mi.ingredient_id = i.id
      JOIN allergens a ON a.name = p_allergen_name
     WHERE i.name = p_ingredient_name;
END$$


CREATE PROCEDURE link_meal_ingredient(
    IN p_meal_id INT,
    IN p_ingredient_name VARCHAR(255)
)
BEGIN
    CALL add_ingredient(p_ingredient_name);
    INSERT IGNORE INTO meal_ingredients(meal_id, ingredient_id)
    SELECT p_meal_id, id FROM ingredients WHERE name = p_ingredient_name;
END$$


CREATE PROCEDURE update_meal(
    IN p_id INT,
    IN p_name VARCHAR(255),
    IN p_category VARCHAR(255),
    IN p_area VARCHAR(255),
    IN p_instructions TEXT,
    IN p_thumb VARCHAR(500)
)
BEGIN
    UPDATE meals
       SET name = p_name,
           category = p_category,
           area = p_area,
           instructions = p_instructions,
           thumbnail_url = p_thumb
     WHERE id = p_id;
END$$


DELIMITER ;
