# image-analysis
Detecting sandstone components visible at the photomicrograph using Matlab

Projekt zrealizowany w ramach przedmiotu Analiza i Przetwarzanie Sygnałów i Obrazów Cyfrowych.

Celem projektu była detekcja, wizualizacja w postaci obrazu binarnego oraz obliczenie powierzchni
trzech składników skalnych piaskowca godulskiego z warstw godulskich środkowych - glaukonitu,
węglanów i kwarcu - na podstawie zdjęć mikroskopowych, z wykorzystaniem programu MatLAB.

Wykorzystano zdjęcia mikroskopowe wykonane przy pojedynczym oraz przy skrzyżowanych polaryzatorach, w rotacji co 30°.

![pojedyncza](https://user-images.githubusercontent.com/87367190/161380255-cb0ecffb-7e10-4032-b60f-512f2f8fda18.png)
![skrzyzowane](https://user-images.githubusercontent.com/87367190/161380311-a27fe2f0-94ab-4640-a14b-460a5c1000bb.png)

Dokonano wizualnej oceny przydatności poszczególnych zdjęć, które następnie poddano binaryzacji. 
Tak przygotowane obrazy logiczne przetworzono poprzez szereg operacji morfologicznych - dylacji, erozji, otwarcia lub zamknięcia.  

Następnie obliczono sumaryczne pola powierzchni składników skalnych, w przeliczeniu z pikseli na milimetry.

W rezultacie otrzymano poniższy obraz binarny.

![logiczna](https://user-images.githubusercontent.com/87367190/161380319-f14c7908-abd8-475b-8eec-dcb10d9cf9cd.png)
