# Kubernetes Example

## :link: Table of Contents

* [:link: Table of Contents](#link-table-of-contents)
* [:grey\_question: Why](#greyquestion-why)
* [:receipt: Prerequisites](#receipt-prerequisites)
* [:computer: Installation](#computer-installation)
* [:gear: Usage](#gear-usage)
* [:raising\_hand\_man: Support \& Assistance](#raisinghandman-support--assistance)
* [:handshake: Contributing](#handshake-contributing)
* [:clipboard: References](#clipboard-references)
* [:wave: Acknowledgements](#wave-acknowledgements)
* [:balance\_scale: License](#balancescale-license)

## :grey_question: Why

After some searching on the internet, I wasn't able to find a complete
Kubernetes installation tutorial that included all the features I wanted for my
home cluster. I've collected bits and pieces of multiples sources and combined
them into a single cluster setup example. This repository is the result of my
research, trial and error and personal preferences.

<!-- TODO: Add a section explaining cluster components and how they relate to each other -->
<!-- TODO: Add disclaimer section explaining that setup shouldn't be used in production -->

## :receipt: Prerequisites

To implement this cluster example as-is, you'll need:

* [K3s' requirements](https://docs.k3s.io/installation/requirements)
* Helm (was tested with version `v3.11.1`)
* Terraform (was tested with version `v1.3.9`)
* iSCSI target(s) for remote storage

## :computer: Installation

All cluster components are managed with Helm charts and can be installed mostly
independently. For detailed installation instructions, please see the related
[document](./Installation.md)

## :gear: Usage

Cluster access is documented [here](https://docs.k3s.io/cluster-access).

<!-- TODO: Complete section with service and ingress list -->

## :raising_hand_man: Support & Assistance

* :heart: Please review the [Code of Conduct](.github/CODE_OF_CONDUCT.md) for
     guidelines on ensuring everyone has the best experience interacting with
     the community.
* :raising_hand_man: Take a look at the [support](.github/SUPPORT.md) document
     on guidelines for tips on how to ask the right questions.
* :lady_beetle: For all features/bugs/issues/questions/etc, [head over
  here](https://github.com/Bibz87/kubernetes-example/issues/new/choose).

## :handshake: Contributing

* :heart: Please review the [Code of Conduct](.github/CODE_OF_CONDUCT.md) for
     guidelines on ensuring everyone has the best experience interacting with
    the community.
* :clipboard: Please review the [contributing](.github/CONTRIBUTING.md) doc for
     submitting issues/a guide on submitting pull requests and helping out.

## :clipboard: References

* [Building a bare-metal Kubernetes cluster on Raspberry
  Pi](https://anthonynsimon.com/blog/kubernetes-cluster-raspberry-pi/)
* [k3s on Raspberry Pi:
  Introduction](https://blog.differentpla.net/blog/2020/02/06/k3s-raspi-intro/)
* [K3s DNS Setup](https://trenta3.gitlab.io/note:k3s-dns-setup/)
* [Vault using Kubernetes
  auth](https://ddymko.medium.com/vault-using-kubernetes-auth-c67cfcdc8d6e)

## :wave: Acknowledgements

Huge thanks to @lrstanley for letting me use his repository documentation
templates!

## :balance_scale: License

[![Creative Commons
Licence](https://i.creativecommons.org/l/by-nc/4.0/88x31.png)](http://creativecommons.org/licenses/by-nc/4.0/)

This work is licensed under a [Creative Commons Attribution-NonCommercial 4.0
International License](http://creativecommons.org/licenses/by-nc/4.0/).

_Also located [here](LICENSE)_
