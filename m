Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1AF51F453
	for <e@80x24.org>; Mon,  4 Feb 2019 09:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfBDJtN (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 04:49:13 -0500
Received: from mout.gmx.net ([212.227.17.22]:34911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfBDJtN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 04:49:13 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3ARX-1hAKJj2Hu3-00swQf; Mon, 04
 Feb 2019 10:49:04 +0100
Date:   Mon, 4 Feb 2019 10:49:05 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] travis-ci: make the OSX build jobs' 'brew update' more
 quiet
In-Reply-To: <20190202163421.19686-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1902041045280.41@tvgsbejvaqbjf.bet>
References: <20190202163421.19686-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-740216550-1549273748=:41"
X-Provags-ID: V03:K1:nabfjs63fd0WofCfX2JQfynlk6ZNFhVjVnDCrWqwZeY8BhJ2HAN
 xWj8Q4h1STYyOzfpyHwi7div/sQatZqs+pt05xXDBm76KBo6QJT0rvOjKrLxw62a3PC2xa1
 EU8Hj/eM3fPeUTxyvIXS0YMAqIxnf0HPrMbrGnS/AUQZliQOxFtLm8Om3z6sB9qe0FKhc5Y
 UZtWzopJTY3l0ZkAALPzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NtgeeUo5kPA=:kDwwdrSFtU89zGrk3TwRQq
 Dc1WXQJxO3EpzOGEIurS0pUkbLP//gdIZzHjF0ZbdwwcjQwOLYnzsSOuzDyj/dTaEmqireWbS
 cNLdtMttiyEswMSpe2KfhDQSoZL/6QB8JbEDponh51ZHElc57j02Xz4x63ztgWeX/9WQ8gWWQ
 AdMO2ssLXiVndI3jXmjQ4UeujxB//EAOlYABYLdE+VAysMHAqwjR1CvWFgG7juN42a0l7yEqr
 xXnMyqgrR8i7ENqME1qhFppz3L2yi8x0wD5kT811fZ6ke+DIjJ8q864FE8VPcnWvVUiWXqeS5
 vGxCaKUu1v0BhbSiUdORQKJiAgy8+Jziw/cMHcyy8j3Mqq0q6gIXRn2d4sPGOhdMHsOxwRnJm
 7ZsiGFDSaiavG4QLF7+mp4SidBwWsSUrgXZpwez6rLaSKjfxK+qkx5j5I8mGVrBUhCyqLPL1F
 gzKXHQXGDo8h/+vLVtOnGycyTBYYbwZ4pOWH9myUpAX9k8/xsCwcW3pCfKaKAsiS8nLbpPyMZ
 L78SkJ3GF1ao6fkhYze3I3YtHeY15suUi2CX5xCbf8NMhegzO4DJqLC4ekXO2Nuab9NSWdAHR
 DedG4kesdKlIH3Ydq4jGKjgOrHbYEjKmBiTPJWwYCoCU2FDcYWxYRAIjUsClaTY1r+AbYJUjy
 JySn9ugvy3pkTSQDH1jU9/YfiDo2N8AULv+F1WRZg3rIyX27+nFCz+ZPI0umNkSvVPm4vOdE7
 u03Fdemc65VOZHVQfeKgxsrrATSATaOyUUSU5Bg/i5WNfvZEaoQuPLPypWmuuYX7ZJxKt9mrh
 Sl6MYcBSvM39Ts5tVoXdFpew/pPV6/xsENVuVhLEf2aAmZkVCltmAqsI+5fcYD/71F/QG/W6V
 p9RQiyCDHWQdpyDQzrMZr86++FzSsC1ar3rgW2ZpKMYVLg6aR0GE41L9AyI5g2c+a3onrNS+Q
 lHVOo+f64pA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-740216550-1549273748=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Gábor,

On Sat, 2 Feb 2019, SZEDER Gábor wrote:

> Before installing the necessary dependencies, our OSX build jobs run
> 'brew update --quiet'.  This is problematic for two reasons:
> 
>   - This '--quiet' flag apparently broke overnight, resulting in
>     errored builds:
> 
>       +brew update --quiet
>       ==> Downloading https://homebrew.bintray.com/bottles-portable-ruby/portable-ruby-2.3.7.mavericks.bottle.tar.gz
>       ######################################################################## 100.0%
>       ==> Pouring portable-ruby-2.3.7.mavericks.bottle.tar.gz
>       Usage: brew update_report [--preinstall]
>       The Ruby implementation of brew update. Never called manually.
>               --preinstall                 Run in 'auto-update' mode (faster, less
>                                            output).
>           -f, --force                      Override warnings and enable potentially
>                                            unsafe operations.
>           -d, --debug                      Display any debugging information.
>           -v, --verbose                    Make some output more verbose.
>           -h, --help                       Show this message.
>       Error: invalid option: --quiet
>       The command "ci/install-dependencies.sh" failed and exited with 1 during .
> 
>     I belive that this breakage will be noticed and fixed soon-ish, so
>     we could probably just wait a bit for this issue to solve itself,
>     but:
> 
>   - 'brew update --quiet' wasn't really quiet in the first place, as
>     it listed over about 2000 lines worth of available packages that
>     we absolutely don't care about, see e.g. one of the latest
>     'master' builds:
> 
>       https://travis-ci.org/git/git/jobs/486134962#L113
> 
> So drop this '--quiet' option and redirect 'brew update's standard
> output to /dev/null to make it really quiet, thereby making the OSX
> builds work again despite the above mentioned breakage.
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
> 
> Notes:
>     There is no conflict with Dscho's Azure Pipelines patch series; the
>     patch contexts overlap a bit, but the auto-merging results look good
>     to me.

And this indeed also affects Azure Pipelines.

Since Junio's workflow is very different from GitHub Flow (where this
issue would be worked around with a simple, single Pull Request), we have
no prayer at a workaround on our side, though: pretty much *all* of the
next builds of Junio's branches will be broken, unless he chooses to
backport your patch to all of the base commits he chose for those
branches.

So our best bet at not getting overwhelmed with failed builds is to help
Homebrew get `brew update --quiet` to work again. I just opened a ticket
to that end:

	https://github.com/Homebrew/brew/issues/5666

I do like your patch, though, and am very much in favor of fast-tracking
it all the way down to `maint`.

Ciao,
Dscho

>  ci/install-dependencies.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 06c3546e1e..5968efdbbe 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -34,7 +34,7 @@ linux-clang|linux-gcc)
>  	popd
>  	;;
>  osx-clang|osx-gcc)
> -	brew update --quiet
> +	brew update >/dev/null
>  	# Uncomment this if you want to run perf tests:
>  	# brew install gnu-time
>  	brew install git-lfs gettext
> -- 
> 2.20.1.642.gc55a771460
> 
> 
> 
--8323328-740216550-1549273748=:41--
