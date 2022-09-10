# NeRFactor

[[Paper]](https://arxiv.org/pdf/2106.01970.pdf)
[[Video]](https://www.youtube.com/watch?v=UUVSPJlwhPg)
[[Project]](http://people.csail.mit.edu/xiuming/projects/nerfactor/)

![teaser](assets/teaser.jpg)

This is the authors' code release for:
> **NeRFactor: Neural Factorization of Shape and Reflectance Under an Unknown Illumination**  
> Xiuming Zhang, Pratul P. Srinivasan, Boyang Deng, Paul Debevec, William T. Freeman, Jonathan T. Barron  
> **TOG 2021 (Proc. SIGGRAPH Asia)**

This is not an officially supported Google product.


## Setup

1. Clone this repository:
    ```bash
    git clone https://github.com/google/nerfactor.git
    ```

1. Install a Conda environment with all dependencies:
    ```bash
    cd nerfactor
    conda env create -f environment.yml
    conda activate nerfactor
    ```

Tips:
* You can find the TensorFlow, cuDNN, and CUDA versions in `environment.yml`.
* The IPython dependency in `environment.yml` is for `IPython.embed()` alone.
  If you are not using that to insert breakpoints during debugging, you can
  take it out (it should not hurt to just leave it there).


## Data

If you are using our data, see the "Downloads" section of the
[project page](http://people.csail.mit.edu/xiuming/projects/nerfactor/).

If you are BYOD'ing (bringing your own data), go to [`data_gen/`](./data_gen) to
either render your own synthetic data or process your real captures.


## Running the Code

Go to [`nerfactor/`](./nerfactor) and follow the instructions there.


## Evaluation (New as of 09/10/2022)

We were contacted a few times about the numbers reported in Table 1.
Here are the sequences we used for those numbers:
`drums_3072`, `ficus_2188`, `hotdog_2163`, `lego_3072`, all of which have
been released (see the Data section above).
For all sequences, we used these validation views: `0,1,2,3,4,5,6,7`
and these uniformly sampled test views: `49,99,149,199`.


## Issues or Questions?

If the issue is code-related, please open an issue here.

For questions, please also consider opening an issue as it may benefit future
reader. Otherwise, email [Xiuming Zhang](http://people.csail.mit.edu/xiuming).


## Acknowledgments

This repository builds upon or draws inspirations from
[this TOG 2015 code release](https://brdf.compute.dtu.dk/),
[the NeRF repository](https://github.com/bmild/nerf), and
[the pixelNeRF repository](https://github.com/sxyu/pixel-nerf).
We thank the authors for making their code publicly available.


## Changelog

* 09/01/2021: Updates related to SIGGRAPH Asia revision.
* 06/01/2021: Initial release.
