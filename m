Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA1B1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 16:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbfACQBd (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 11:01:33 -0500
Received: from mout.gmx.net ([212.227.17.20]:58999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfACQBd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 11:01:33 -0500
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lo3IS-1hGc2g0zyS-00g2l4; Thu, 03
 Jan 2019 17:01:26 +0100
Date:   Thu, 3 Jan 2019 17:01:25 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 5/5] travis-ci: build with the right compiler
In-Reply-To: <20181220162452.17732-6-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901031659100.45@tvgsbejvaqbjf.bet>
References: <20181220162452.17732-1-szeder.dev@gmail.com> <20181220162452.17732-6-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1007439039-1546531286=:45"
X-Provags-ID: V03:K1:d14y+qTgJgdyTSjhwikYq3NtI26Y/ZRG0qFVWVnEp2ZmIm98hLB
 RKdejZcFgLVxYzOE0Ndt/1qMyxmHr7ynWvSFmlGxPgitGECFXwV1HHPf40QhJSdEFl6xcfo
 oGhtJRSEtRIq+I4ClEQlCzZ6AJRjGlNRGAb4c9qOoWPLhck94ctniD6N02POoactY2SOgme
 y6CfMpQgTcbhKcIZhRqiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JMD/qvuYkDM=:6xFZ1ykot2SKY4wMTDNwpJ
 VM7/NYzSlGej17bVYRGXrDBO4+MaY7yVtD2EfKRsIwD6hidzOjCbywQIDXqu2Hi44wHMAvLqf
 4p7TSYeTcQjkPEeCONkxrCE2ciCBPzVIRhnjSDI9flZREityrSpG5RDPxc8UipVxzSE8jcBkU
 5+2tX+AePEyL777j/O0YiqAC3MbeyMJ0VbkcSYWerrYA0+WiLccUgR2sOcBpkb6CctEnBjOcN
 MBNQEmhx4sRsuxlUyVrnkXwHWL8wKQcXtf2wgm44bj0qFlzZo+MFlaGHCsDmWZyNy55oZkRv8
 U6l5cZq9QUWEDOyR75WjbjFfxJzJCcyFMiDNDxp4QQ3Y99isaEa5v6fiCKkEPGE21ym8jG3aS
 +7BwirBDcuY4klwHXdquFntSA2N5e1gPaoR1D6P4krlURyWD1JljdZj0csYP4M51Bje9P4utt
 5CxBPRgLyapS8JyAyUb3PA67EEbTDCbZVJKIbr+CkiMgU6tzz4E6o83y7mcEiNDYAcQ3weyiV
 3Z9Yy7aQBts2kDQN5VG2zmasSCA47R9qfPPFtBD8KUk+S1tJp6qUzlV7+hFGsrNYcYYLpfLFD
 1xUZu6KtpOdj+0IsWZ91Qkw+8HnoR/NfXRsHBJ3tGuZTr/nd9ftWK5gqKC7sqRI0rlM2sZE2X
 KSoW8BNjQ3hNWPW+OB/uCaRK62t+ww/mjkeJW3+ngC8fwrl2S1ve/4PyDuBR8VERMkTC2lbc8
 ahHVPf2g22w9GAjZ9XN0EtuDnWAJcXP2ylOGp1ywOVfu3q3OUp2iBYBXJyAE74cExa0klw7k7
 RAFhOOgCpnKGSlGedQGoNX7WatVOkSMO1klKWvV1Qizyw41n1TuAMSlb1g613F0DEn8jzifq7
 Rdei16uF7gE9hey1/wftThSbidTz+L74r1ugm9zTvAqH4QytYeM+hj09rUVGYhltlzLDiM34L
 jpODS3ZUfMg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1007439039-1546531286=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Gábor,

On Thu, 20 Dec 2018, SZEDER Gábor wrote:

> Our 'Makefile' hardcodes the compiler to build Git as 'CC = cc'.  This

... This CC variable ...

> can be overridden from the command line, i.e. 'make CC=gcc-X.Y' will
> build with that particular GCC version, but not from the environment,
> i.e. 'CC=gcc-X.Y make' will still build with whatever 'cc' happens to
> be on the platform.

Without this edit, it read to me as if the commit message claimed that
CC cannot be overridden via the environment *at all*, even with MAKEFLAGS.

The rest of the entire patch series looks good to me, I did not dig as
deeply as Ævar about that obstack patch, but if there is *some* sort of
upstream from where we can get a fix, I think we should try to go for that
(rather than risking to diverge even further).

Thanks,
Dscho

> 
> Our build jobs on Travis CI are badly affected by this.  In the build
> matrix we have dedicated build jobs to build Git with GCC and Clang
> both on Linux and macOS from the very beginning (522354d70f (Add
> Travis CI support, 2015-11-27)).  Alas, this never really worked as
> supposed to, because Travis CI specifies the compiler for those build
> jobs as 'export CC=gcc' and 'export CC=clang' (which works fine for
> projects built with './configure && make').  Consequently, our
> 'linux-clang' build job has always used GCC, because that's where 'cc'
> points at in Travis CI's Linux images, while the 'osx-gcc' build job
> has always used Clang.  Furthermore, 37fa4b3c78 (travis-ci: run gcc-8
> on linux-gcc jobs, 2018-05-19) added an 'export CC=gcc-8' in an
> attempt to build with a more modern compiler, but to no avail.
> 
> Set MAKEFLAGS with CC based on the $CC environment variable, so 'make'
> will run the "right" compiler.  The Xcode 10.1 macOS image on Travis
> CI already contains the gcc@8 package from Homebrew, but we have to
> 'brew link' it first to be able to use it.
> 
> So with this patch our build jobs will build Git with the following
> compiler versions:
> 
>   linux-clang: clang version 5.0.0 (tags/RELEASE_500/final)
>   linux-gcc:   gcc-8 (Ubuntu 8.1.0-5ubuntu1~14.04) 8.1.0
> 
>   osx-clang: Apple LLVM version 10.0.0 (clang-1000.11.45.5)
>   osx-gcc:   gcc-8 (Homebrew GCC 8.2.0) 8.2.0
> 
>   GETTEXT_POISON: gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  ci/install-dependencies.sh |  5 +++++
>  ci/lib-travisci.sh         | 15 ++++++++++++---
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 06c3546e1e..dc719876bb 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -40,6 +40,11 @@ osx-clang|osx-gcc)
>  	brew install git-lfs gettext
>  	brew link --force gettext
>  	brew install caskroom/cask/perforce
> +	case "$jobname" in
> +	osx-gcc)
> +		brew link gcc@8
> +		;;
> +	esac
>  	;;
>  StaticAnalysis)
>  	sudo apt-get -q update
> diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
> index 69dff4d1ec..a479613a57 100755
> --- a/ci/lib-travisci.sh
> +++ b/ci/lib-travisci.sh
> @@ -99,12 +99,14 @@ export DEFAULT_TEST_TARGET=prove
>  export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
>  export GIT_TEST_OPTS="--verbose-log -x --immediate"
>  export GIT_TEST_CLONE_2GB=YesPlease
> -if [ "$jobname" = linux-gcc ]; then
> -	export CC=gcc-8
> -fi
>  
>  case "$jobname" in
>  linux-clang|linux-gcc)
> +	if [ "$jobname" = linux-gcc ]
> +	then
> +		export CC=gcc-8
> +	fi
> +
>  	export GIT_TEST_HTTPD=YesPlease
>  
>  	# The Linux build installs the defined dependency versions below.
> @@ -118,6 +120,11 @@ linux-clang|linux-gcc)
>  	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
>  	;;
>  osx-clang|osx-gcc)
> +	if [ "$jobname" = osx-gcc ]
> +	then
> +		export CC=gcc-8
> +	fi
> +
>  	# t9810 occasionally fails on Travis CI OS X
>  	# t9816 occasionally fails with "TAP out of sequence errors" on
>  	# Travis CI OS X
> @@ -127,3 +134,5 @@ GIT_TEST_GETTEXT_POISON)
>  	export GIT_TEST_GETTEXT_POISON=YesPlease
>  	;;
>  esac
> +
> +export MAKEFLAGS="CC=${CC:-cc}"
> -- 
> 2.20.1.151.gec613c4b75
> 
> 
--8323328-1007439039-1546531286=:45--
