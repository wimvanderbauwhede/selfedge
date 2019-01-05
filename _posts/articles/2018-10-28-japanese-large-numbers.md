---
layout: article
title: "Why does Japanese have kanji for very large numbers?"
date: 2018-11-24
modified: 2018-11-24
tags: [ Japanese ]
excerpt: "A story of counting systems, a mathematics treatise and buddhist scriptures, with a supercomputer and a samurai."
current: ""
current_image:   japanese-large-numbers_1600x600.jpg
current_anchor:  homepage_banner
comments: false
toc: false
categories: articles
image:
  feature: japanese-large-numbers_1600x600.jpg
  teaser: japanese-large-numbers_400x150.jpg
  thumb: japanese-large-numbers_400x150.jpg
---

As a slow learner of Japanese, I often have to look up _kanji_ (Chinese characters) in my dictionary. I was intrigued to notice that for some kanji, one of their meanings is a _very_ large number:

| Kanji |	Reading |	Number |
| ----| ----| ----|
| 万|  	man|  	10<sup>4</sup>|
| 億 | 	oku|  	10<sup>8</sup>|
| 兆 | 	chō|  	10<sup>12</sup>|
| 京 | 	kei|  	10<sup>16</sup>|
| 垓 | 	gai|  	10<sup>20</sup>|
| 𥝱 | 	jo |  	10<sup>24</sup>|
| 穣 | 	jō|  	10<sup>28</sup>|
| 溝|  	kō|  	10<sup>32</sup>|
| 澗 | 	kan|  	10<sup>36</sup>|
| 正 | 	sei|  	10<sup>40</sup>|
| 載 | 	sai|  	10<sup>44</sup>|
| 極 | 	goku|  	10<sup>48</sup>|

Table 1. _Kanji for large numbers with readings and number values_

<!-- K computer picture and anecdote -->

## Kanji and the supercomputer

For example, the character 京, which is the "kyō" in Kyoto (京都) means "metropolis", but also 10<sup>16</sup>. For that meaning it is pronounced "kei", and this is the origin of the name of the famous Riken supercomputer in Kobe, the "K computer": it is a computer capable of 10 petaflops, so 10<sup>16</sup> or _kei_ flops. Incidentally, it is probably the only supercomputer that has its own railway station, 京コンピュータ前駅.

<figure>
<img src="{{ site.url }}/images/k-computer-mae_1600.jpg" alt="K Computer Mae Station"/>
<figcaption>The 京コンピュータ前駅 (K Computer Mae Station) in Kobe.</figcaption>
</figure>

<!-- I asked a Japanese friend and he told me that originally, these kanji simply indicated degrees of large, and then they got numerical values, and then the intervals were increased over time. -->

## Counting systems

The story of how these kanji came to represent such large numbers is quite interesting. It started with [the emergence of a number of different counting systems](http://www.sf.airnet.ne.jp/~ts/language/largenumber.html).

Japan has adopted kanji from China -- the word _kanji_ (漢字) means Chinese characters, the 漢 character meaning ["Han"](https://en.wikipedia.org/wiki/Han_Chinese).  The traditional numeral systems of China, Korea, and Japan are all decimal-based but grouped into ten thousands, also known as myriads (_man_, 万), rather than thousands. Very long ago, the characters beyond _man_ simply indicated degrees of large, so _oku_ (億) was larger than _man_ (万), _chō_ (兆) was larger than _oku_, _kei_ (京) was larger than _chō_, etc. Actual counting of numbers beyond one myriad was ten myriads, hundred myriads, thousand myriads.

Then over time the characters _oku_, _chō_, _kei_ etc. started to be used for this, in a counting system called _kasū_ (下数,かすう, "lower arithmetic"). So in this system, _oku_ was ten times _man_, _chō_ was ten times _oku_, etc. This was very long ago, more than two thousand years, and clearly it was not entirely satisfactory because already from the Han dynasty onwards (i.e. 200 BCE), a separate counting system called _jōsū_（上数,じょうすう,"upper arithmetic"）also became used. In this system, the character after _man_ got the value of _man man_ (万万), so _oku_ = _man man_ = 10<sup>8</sup>. The next value _chō_ became  _oku oku_ (億億) = 10<sup>16</sup>, _kei_ = _chō chō_ (兆兆) =10<sup>32</sup> and so on.
Later, yet another system, called _chūsū_ (中数,ちゅうすう,"middle arithmetic") came into use. In this system, the values for consecutive kanji where 10<sup>4</sup> apart. To be precise, in China there were two variants of _chūsū_, _manshin_ (万進) and (万万進) _manmanshin_, the latter had intervals of 10<sup>8</sup>.

The table below summarises the various systems:

|Kanji | Reading | &nbsp;_kasū_&nbsp; (下数)| _chūsū/manshin_　(中数／万進)| _chūsū/manmanshin_ (中数／万万進)|_jōsū_&nbsp;&nbsp;&nbsp; (上数)|
|---|---|---|---|---|-------|
|万	|_man_|10<sup>4</sup>|10<sup>4</sup> | 10<sup>4</sup>|10<sup>4</sup>|
|億|_oku_|	10<sup>5</sup>|	10<sup>4&times;2</sup>=10<sup>8</sup>|	10<sup>8&times;1</sup>=10<sup>8</sup>|	10<sup>4&times;2</sup>=10<sup>8</sup>|
|兆|_chō_|	10<sup>6</sup>|	10<sup>4&times;3</sup>=10<sup>12</sup>|	10<sup>8&times;2</sup>=10<sup>16</sup>|	10<sup>4&times;2<sup>2</sup></sup>=10<sup>16</sup>|
|京|_kei_|	10<sup>7</sup>|	10<sup>4&times;4</sup>=10<sup>16</sup>|	10<sup>8&times;3</sup>=10<sup>24</sup>|	10<sup>4&times;2<sup>3</sup></sup>=10<sup>32</sup>|
|垓|_gai_|	10<sup>8</sup>|	10<sup>4&times;5</sup>=10<sup>20</sup>|	10<sup>8&times;4</sup>=10<sup>32</sup>|	10<sup>4&times;2<sup>4</sup></sup>=10<sup>64</sup>|
|秭|_jo_|	10<sup>9</sup>|	10<sup>4&times;6</sup>=10<sup>24</sup>|	10<sup>8&times;5</sup>=10<sup>40</sup>|	10<sup>4&times;2<sup>5</sup></sup>=10<sup>128</sup>|
|穣|_jō_|	10<sup>10</sup>|	10<sup>4&times;7</sup>=10<sup>28</sup>|	10<sup>8&times;6</sup>=10<sup>48</sup>|	10<sup>4&times;2<sup>6</sup></sup>=10<sup>256</sup>|
|溝|_kō_|	10<sup>11</sup>|	10<sup>4&times;8</sup>=10<sup>32</sup>|	10<sup>8&times;7</sup>=10<sup>56</sup>|	10<sup>4&times;2<sup>7</sup></sup>=10<sup>512</sup>|
|澗|_kan_|	10<sup>12</sup>|	10<sup>4&times;9</sup>=10<sup>36</sup>|	10<sup>8&times;8</sup>=10<sup>64</sup>|	10<sup>4&times;2<sup>8</sup></sup>=10<sup>1024</sup>|
|正|_sei_|	10<sup>13</sup>|	10<sup>4&times;10</sup>=10<sup>40</sup>|	10<sup>8&times;9</sup>=10<sup>72</sup>|	10<sup>4&times;2<sup>9</sup></sup>=10<sup>2048</sup>|
|載|_sai_|	10<sup>14</sup>|	10<sup>4&times;11</sup>=10<sup>44</sup>|	10<sup>8&times;10</sup>=10<sup>80</sup>|	10<sup>4&times;2<sup>10</sup></sup>=10<sup>4096</sup>|
|極|_goku_| 10<sup>15</sup>| 10<sup>4&times;12</sup>= 10<sup>48</sup>|10<sup>8&times;11</sup>=10<sup>88</sup>|10<sup>4&times;2<sup>11</sup></sup>=10<sup>8192</sup>|

Table 2. _Summary of the different counting systems used historically_

## An Edo-era mathematics book

In Edo-era Japan, the 1634 edition of an influential mathematics book, [_jinkōki_](http://www.ndl.go.jp/math/e/s2/1.html) ([塵劫記](https://ja.wikipedia.org/wiki/%E5%A1%B5%E5%8A%AB%E8%A8%98)), standardised on the _chūsū/manshin_ (中数/万進) system as shown in the table above. The work covers a wide variety of mathematical problems but its main purpose was to explain techniques for calculating using the _soroban_ (算盤), the Japanese abacus.

## The daimyo, the samurai and the soroban

[The oldest _soroban_ in existence](https://www.maa.org/press/periodicals/convergence/elementary-soroban-arithmetic-techniques-in-edo-period-japan) is the _Shibei Shigekatsu hairyo soroban_, from 1591. It was made from plum tree wood and silver and given to the samurai Shibei Shigekatsu by the famous daimyō [Toyotomi Hideyoshi](https://www.britannica.com/biography/Toyotomi-Hideyoshi) (The word _hairyo_ (拝領) means "receiving from a superior"). It shows that this kind of calculating device was highly valued. This soroban has 20 number rods, so it can represent any number up to 10<sup>20</sup>-1. So in any case the introduction of the _soroban_ made it easier to conceive very large numbers.

## Buddhist angels and mustard seeds

The story so far does not quite explain where those different systems came from or _why_ these choices were made, and indeed earlier editions of the _jinkōki_ used different combinations of _kasū_ and _chūsū_. In any case, it turns out that the origin of these very large numbers lies in ancient Buddhist texts.

Buddhism has the notion of a [_kalpa_ or aeon](https://en.wikipedia.org/wiki/Kalpa_(aeon)), a very long unit of time. There are in the old texts two definitions for a kalpa, provided by the Buddha by analogy. I found the following explanation on [a Japanese web site for the book "巨大数入門" ("An introduction to very large numbers")](http://gyafun.jp/ln/intro.html):

<small>『仏教では、とても長い時間を表すときに劫（こう）という時間の単位が使われます。「未来永劫」「億劫」「五劫のすり切れ」などの言葉は、ここから来ています。この「劫」には2通りの意味があり、1つ目は「磐石劫」で、四十里四方の大石を、いわゆる天人の羽衣で百年に一度払い、その大きな石が摩滅して無くなってもなお「一劫」の時間は終わらないと譬えています。 2つ目は「芥子劫」で、方四十里の城に小さな芥子粒を満たして百年に一度、一粒ずつ取り去り、その芥子がすべて無くなってもなお尽きないほどの長い時間が一劫であるとのことです。』</small>

Loosely translated, this means that there are two definitions for a kalpa:

1. Imagine a huge cube of rock of 40 _ri_ on the side. Every hundred years, an angel brushes the rock with its wings. A kalpa won't have ended by the time it takes to entirely wear away the rock.
2. Imagine a huge building of 40 _ri_ on the side. Every hundred years, a small mustard seed is put into it. The kalpa won't have ended by the time the building is full.

To estimate how long a kalpa actually lasts, [someone](http://gyafun.jp/ln/intro.html) made the following assumptions:

- Suppose the angel's wings remove one layer of atoms over an area of one square meter. Given that 1 _ri_ is 500 _m_ and the diameter of an atom is 0.2 _nm_, it would take 4&times;10<sup>24</sup> years to wear away the rock.
- For the second definition, assuming a mustard seed is 0.5 _mm_, it would take  6.4&times;10<sup>24</sup> years to fill the entire volume.

It's rather striking that both estimates produce the same order of magnitude, 10<sup>24</sup> years. For comparison, the estimated age of the universe is "only" 1.38&times;10<sup>10</sup> years.

## Grains of sand in the Ganges

Regardless, it means that Buddhist scholar monks had a need to express very large numbers. In fact, Buddhism has concepts such as [the number of grains of sand in the Ganges](http://diamond-sutra.com/read-the-diamond-sutra-here/diamond-sutra-chapter-11/) (_gōgasha_,恒河沙), which are even larger than _goku_ (極, 10<sup>48</sup>). The largest quantified term I could find in my dictionary is _muryōtaisū_ (無量大数,"immeasurably large number"),  with a value of 10<sup>68</sup> using _chūsū_, but often defined as 10<sup>88</sup>, due to a [variant system used for values above _goku_ used in the 1631 edition of the _jinkōki_](http://www.sf.airnet.ne.jp/~ts/language/largenumber.html).

<!--

この時間がどの程度のものなのか「カガクのじかん」というサイト (http://d.hatena.ne.jp/inyoko/) では、次のように計算しています。 「磐石劫」では、「1里=500m」「原子=1辺0.2nmの立方体」「1回なでると、1平方メートルの範囲の原子が1層はがれる」という仮定の下、4𥝱、すなわち 4&times;10<sup>24年という計算結果を出しました。

2つ目の「芥子劫」については、「1里=500m」、「けし粒=1辺0.5mmの立方体」、という仮定の下、6𥝱4000垓、すなわち 6.4&times;10<sup>24年という計算結果を出しました。磐石劫でも芥子劫でも同じ𥝱の単位になるのは面白いところです。

----
宇宙の年齢は138億年程度であるとされていますので、それと比べて100兆倍ほどの気の遠くなるほど長い時間です。

----
恒河沙という数と劫という時間の単位を組み合わせれば、恒河沙劫というとても長い時間が表現できますので、そういう表現があるか検索してみたところ、『首楞厳経』という経典に恒河沙劫という表現が出てきて、親鸞が『尊号真像銘文』で引用していることが分かりました。恒河沙劫は、10の46乗年、すなわち100載年のオーダーになります。







載よりも上の単位である極から上は、元の朱世傑（しゅせいけつ、生没年不詳）による『算学啓蒙』(1299年)において登場しました。ここで極以外の単位はすべて仏教から取られたものです。恒河沙は「ガンジス川の砂」の意味で、それだけ大きな数ということです。 阿僧祇は「数えることができない」、 那由他は「極めて大きな数量」、 不可思議「思い測ったり言葉で言い表したりすることができない」 無量大数は、『算学啓蒙』では「無量数」として登場し、「量ることのできない数」ということです。

この中で恒河沙以外は「数え切れないほどの大きな数」と理解すれば良いのですが、恒河沙については、ガンジス川の砂の数という具体的な数になっているので、どの程度の大きさなのか見積もってみます。 今は恒河沙と言えば日本では10の52乗という意味になり、中国でも下数、中数、上数によって数は変わります。仏教の中ではそういう数を意味するものではなく、ガンジス川の砂の数という意味ですから、今の日本で恒河沙を意味する10の52乗と比較することは無意味です。


| Word | Reading | Number |
| ---- | ---- | ---- |
| 恒河沙 	| gōgasha 	| 10<sup>52,10<sup>56|
| 阿僧祇 	| asōgi 	| 10<sup>56,10<sup>64|
| 那由他, 那由多 	| nayuta 	| 10<sup>60,10<sup>72|
| 不可思議 	| fukashigi 	| 10<sup>64,10<sup>80|
| 無量大数 	| muryōtaisū 	| 10<sup>68,10<sup>88|

-->


<!--

## References

https://en.wikipedia.org/wiki/Japanese_numerals
https://en.wikipedia.org/wiki/Kalpa_(aeon)
https://en.wikipedia.org/wiki/Buddhist_cosmology

https://ja.wikipedia.org/wiki/%E7%84%A1%E9%87%8F%E5%A4%A7%E6%95%B0
http://gyafun.jp/ln/intro.html
http://www.sf.airnet.ne.jp/~ts/language/largenumber.html
http://www.sf.airnet.ne.jp/~ts/personal/indexj.html
https://ja.wikipedia.org/wiki/%E5%91%BD%E6%95%B0%E6%B3%95

-->
