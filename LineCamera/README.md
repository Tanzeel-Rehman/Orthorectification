**Orthorectification of push-broom hyperspectral images**

**DSM generation from LiDAR data**

<img src="media\image1.png" style="width:3.14549in;height:4.05155in" alt="A picture containing text, laser Description automatically generated" />

The actual LiDAR point cloud with red rectangle highlighting the DSM
extent

<img src="media\image2.png" style="width:3.05208in;height:4.1874in" />

Final DSM with grid cell size of 2cm

**Input images**

<img src="media\image3.png" style="width:1.4955in;height:5.27163in" alt="A picture containing building, tree Description automatically generated" />

<img src="media\image4.png" style="width:1.52801in;height:5.27163in" alt="A picture containing outdoor Description automatically generated" />

**Corresponding ortho-rectified images**

<img src="media\image5.jpg" style="width:1.40455in;height:5.25909in" alt="A picture containing text Description automatically generated" />

<img src="media\image6.jpg" style="width:1.52083in;height:5.26042in" alt="A picture containing text, furniture, chest of drawers Description automatically generated" />

**3.2. Quantitative results**

The quality of the orthorectification was quantitatively evaluated by
comparing the derived ground coordinates of the checkerboard targets
from the orthophoto and their respective surveyed coordinates. The
planimetric ground coordinates of checkerboard targets were manually
extracted by recording the image coordinates (row and columns) of the
centroids of these targets. These image coordinates were then converted
to ground coordinates using the minimum ground coordinates of DSM and
GSD of hyperspectral camera. As the vertical ground coordinate (Z)
cannot be directly extracted, therefore we just compared the planimetric
ground coordinates in this study.

**Nominal and calibrated boresight matrix**

| **Boresight matrix** | **ω (º)** | **φ (º)** | **κ (º)** |
|----------------------|-----------|-----------|-----------|
| Nominal              | 0.0       | 0.0       | 0.0       |
| Calibrated           | 0.341067  | -0.945744 | -0.125163 |

**RMSE of the residuals obtained by comparing the orthophoto and the
surveyed ground coordinates of different targets by using nominal
boresight matrix.**

| **Target ID** | **X-residuals (m)** | **Y-residuals (m)** | **RMSE of X residuals (cm)** | **RMSE of Y residuals (cm)** |
|---------------|---------------------|---------------------|------------------------------|------------------------------|
| Cal2          | 0.1120              | 0.2000              | 13.68443459                  | 20.11109765                  |
| Cal3          | 0.1290              | 0.1910              |                              |                              |
| Cal4          | 0.1300              | 0.1800              |                              |                              |
| Cal5          | 0.1730              | 0.1910              |                              |                              |
| Cal6          | 0.1380              | 0.1830              |                              |                              |
| Cal7          | 0.1280              | 0.2230              |                              |                              |
| Cal8          | 0.1600              | 0.2530              |                              |                              |
| Cal9          | 0.1130              | 0.1760              |                              |                              |

**RMSE of the residuals obtained by comparing the orthophoto and the
surveyed ground coordinates of different targets by using calibrated
boresight matrix.**

| **Target ID** | **X-residuals (m)** | **Y-residuals (m)** | **RMSE of X residuals (cm)** | **RMSE of Y residuals (cm)** |
|---------------|---------------------|---------------------|------------------------------|------------------------------|
| Cal2          | 0.01200             | 0.0400              | 4.007960828                  | 4.399573802                  |
| Cal3          | 0.00900             | 0.0510              |                              |                              |
| Cal4          | 0.01000             | 0.0200              |                              |                              |
| Cal5          | 0.09300             | 0.0310              |                              |                              |
| Cal6          | 0.05800             | 0.0430              |                              |                              |
| Cal7          | 0.00800             | 0.0630              |                              |                              |
| Cal8          | 0.06000             | 0.0530              |                              |                              |
| Cal9          | 0.01300             | 0.0360              |                              |                              |

Acknowledgements

-   Dr. Ayman F. Habib, Digital Photogrammetry, Civil Engineering,
    Purdue University

-   Digital Photogrammetry Research Group at Purdue University.
