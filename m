From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: Re* OS X Yosemite make all doc fails
Date: Wed, 26 Aug 2015 21:40:03 +0200
Message-ID: <55DE1613.30804@web.de>
References: <CAJD5XByPQASzYpyTFdKo83RJ0QwPFHg-nPWyusDCucMRFbor4g@mail.gmail.com>
 <CAJD5XBy=skwogN+kbqHipa3poUt-EjSxMABxRZKoEk0J+2TM3w@mail.gmail.com>
 <CAJD5XBy+RnM7ZYt9_SGXgoE2gOKaiM=rmUv=Tkn3Ndi4S4-atQ@mail.gmail.com>
 <20150825010428.GA428718@vauxhall.crustytoothpaste.net>
 <CAJD5XBze8S23umS5enPaOKF6RFKwqkY-ZyuAfLG4SBp8CbCeRg@mail.gmail.com>
 <xmqqmvxe2bgo.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff S <acornblue@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 21:40:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUgYY-0007zv-T9
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 21:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbbHZTkQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Aug 2015 15:40:16 -0400
Received: from mout.web.de ([212.227.15.4]:52523 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751967AbbHZTkO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 15:40:14 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LopMx-1Yok1S24Et-00goCQ; Wed, 26 Aug 2015 21:40:09
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.2.0
In-Reply-To: <xmqqmvxe2bgo.fsf_-_@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:dq6+LYR/FdSqR/rMW2eIjNWcxJ4qTQ8HWXQ/sevJ7BBaJDsr8N0
 wrBQAyAKMiXoZOuio52A9ffyOCkr0yhuZQUj9Q1G/UW52dCnYqPZ/ZFMnSqN9pqGSTO9l/s
 KqpQSqflfX53nSHsWFXcGs/1W2GmOlWUIXPKosBUftpgJo5V6LEAQH122qJJt8a2cf0CvCz
 uuNjDwMajEnWyv6tIAN7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q2ZQgGNm5OE=:mlGU7Obna+AZ5BEGKaQID7
 Y+4Wd5QBqMH53l5JycpicsezQVHoMJ0t2y5iIcYgEk/zxHmN5q9BLmoTMifx+GVLM2NrIaRdu
 NLdTwdKgCTIVJI+A4irzsT3WyG7a0tYG9XZ74ftwae1xkYb2uSzFMqeBQJenfXXrnCr0UqKJI
 8xf1eONqAK5N7+UDlwOT8EoHg1GeFrFo/OyNvj3VBC7BjPwSS9CWW53wtLZtb/4TdBuMuWgxA
 J2TdkL1K0IVWeO51sLyHcWjCCS5ihFlUIAEFVLDqWuVbBDEq+pw8qG75jZbRWREG89yGgTop6
 sEF2kucTvFf3LXsAkeGu3NZT9QCTR7khMKd49DZstsEcQ7KROuHvRQcjVgVOuCEtnx1WT9yck
 Pc6LKfsHozWcw6KT/X6b5F1n1t/2DrDYKQZR1C/AjOn6npU6oIv1aOpO1sIOg4Q9C6ebWjUTJ
 77r0VCQrmDxHnoLxmSKQbhCsaBhN8Aa7Km1RCsokx1xsf6DtCx+sjuhpMtCm2Bl3e0HpKXVOS
 cY9X7W3OBI5PD+rxqoMKcMp2vTvPzSwwJB6VZokmD5nPbDR/B8PkbsWMaHNWGyeBfnd4rSgab
 0qJANWT7fh1AIdTCRhoqxdJvV4LAtpfrg/m3UEdoy/t1HeLZ/uxW0WjP0T07SFXQ3i4TbdYs2
 3cxCcj0jnv1ipCCoZJyb0++FN8f6pVDo1qoZkuWgRrbBmixLrWJpxZHVv5EZjt9g9ASg9+J9d
 xWLUF7TvAyPYlWqL8tIzaL/o7/2adkSXzlc2Pg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276626>

On 2015-08-26 19.42, Junio C Hamano wrote:
> Jeff S <acornblue@gmail.com> writes:
>=20
>> Brian thanks for responding! I'm finally able to build git completel=
y.
>> Would it be possible to add the OS X dependency to the git/INSTALL
>> file?
>>
>> OSX Yosemite 10.10.5
>> Xcode 6.4 (6E35b)
>> =E2=80=A6
>> $ brew install autoconf
>> $ brew install asciidoc
>> $ brew install xmlto
>> $ brew install docbook
>> $ export XML_CATALOG_FILES=3D/usr/local/etc/xml/catalog
>> $ brew install docbook-xsl
>=20
> It may not be a bad idea to add a whole section at the end of the
> document to list the prerequisite packages for various common
> platforms, whose beginning perhaps would look like this?
>=20
> diff --git a/INSTALL b/INSTALL
> index ffb071e..84fa5cf 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -221,3 +221,23 @@ Issues of note:
>           http://www.oasis-open.org/docbook/xml/4.5/xsl/current \
>           /usr/share/sgml/docbook/xml-dtd-4.5 \
>       /etc/xml/catalog
> +
> +
> +Platform specific hints:
> +
> +You would need to install prerequiste tools and libraries to compile
> +and use Git from the source.
> +
> + - OSX needs the following packages installed with 'brew install'
> +   (in addition to the usual make and C compiler suite):
> +
> +   autoconf, asciidoc, xmlto, docbook, docbook-xsl
> +
> + - Linux distributions derived from Debian need the following packag=
es
> +   instaslled via 'apt-get install' or similar (in addition to the
> +   usual 'make' and C compiler suite that come as part of
> +   build-essential):
> +
> +   autoconf, asciidoc, xmlto, docbook, libz-dev, livcurl4-openssl-de=
v,
> +   ...
> +
I like this.

This is what I have been using for Debian (and RHEL 6.5 or so)
(But it doesn't include "make doc")

#!/bin/sh
if type apt-get; then
  APTGET=3D"sudo apt-get install"
fi
if type yum; then
  APTGET=3D"sudo /usr/bin/yum install"
fi
export APTGET

type gcc || $APTGET gcc
type curl-config || $APTGET libcurl4-openssl-dev || $APTGET libcurl-dev=
el
test -r /usr/include/expat.h || $APTGET libexpat1-dev || $APTGET expat-=
devel
test -r /usr/include/ssl.h || test -r /usr/include/openssl/ssl.h || $AP=
TGET
openssl-devel
type msgfmt || $APTGET gettext
type make || $APTGET make
