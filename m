Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBE4D20248
	for <e@80x24.org>; Wed, 13 Mar 2019 09:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfCMJOB (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 05:14:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:35077 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfCMJOB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 05:14:01 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MCLx3-1hD6e23MzR-0097RF; Wed, 13
 Mar 2019 10:13:55 +0100
Date:   Wed, 13 Mar 2019 10:13:39 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v1 09/11] t: add tests for restore
In-Reply-To: <20190308101655.9767-10-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903131005180.41@tvgsbejvaqbjf.bet>
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-10-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-543548457-1552468435=:41"
X-Provags-ID: V03:K1:t7AIC8wAuBadX/g7zUTzQuIZgxIdXiNQXhOFy9vg82EPhdK7yBG
 L7e1rFhhZP1K9mx6d6ni5dJbiJ8uIUOMbFCR6FlIe/AeuO+R/KbUMlQHtJ2XrgD1Tb4Nvfc
 y1JqgLi6K1Nf/ijpiLmE5jh3FRDlKomPU63Rr1lNyPJ4kmJrCyTbRycADfl95hXhpV+doR3
 BOtG+4iZi/awNB1oSm1YA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E9zgQlFihE4=:UzONURseWVt5UYvcAcZe2R
 z5ePD3hk2H5MF4oL5Wd94jOMFa3p0gB5C/dFGJmz8EX2Oevr5DnDtrQDU0fDJwKIHIGIAScMY
 LMEELAzD77jrdMU3S29u8uWcrMBdjP/JuPPoDGpPqNjyRuw6IUmgVU+IK0Q/eriDibMwe+KWe
 Q8t8NQLAjYX2A2ByLvtWHoFLG29wb+KjQ43B5zG/bAu8ibCco98w7IZd92qiGz/vk+rhBNLOS
 Qi5RDznMzDxl6bFMXxH9WkMflMPfU8k0tbRLb0h5T0tf4MhGFWuWmW7WxkaKwjYAWC5Zstb5M
 7T4t5MLKUTWmZiGlQ9cSm4u+Yo3Z+5LEziwvRW5NuJRBGkc/CwpI2E6J+JW1iIWbvELSOyREf
 iJW5HwasgJSuTsJ26AtuKK7PrwhC3LEShvs17I4oVg32Sjcorqgl80L//qRTgwhQ9RHg3fjT9
 C5Sgjie1Ry0EIb7wddQraL5M2GZjNUZuXEtVhWLT6hyOpMeC0qEGLjGLwcSnJse6wzBIMdwoG
 gpf2ouFwtRD9eIFKcYGBe30XL0QT+UmWgU6V/QnmE9WkjECGqqzQLT4pwjEi9yLa6MhX6SGgu
 yaDrphWox0scoTyD7/6Sv9qHH+lkmLdAjwNK22gZCF+BjA2PKlKjIeQrcDRL7w2Z5W5fLu5mI
 A98dRw8EK5aZdRNJ7GJ3ywcvTYXqoPOZr3660TBrteEKp61uFZ+8eoqITq6SZAodCviU6pnHk
 C1Z73PxoSP9XLdXEXdWXcYP0aDeLU809tjLRU2oj9Edx4E14zgyNJgHX9zWXvzJe5/9GcZPBW
 Nx4bYBFyValbRmo1+98um3OEDwIA25MmxKn4CU9eYhevj5y8KiDJfRTDVLNjqVxv+nt600gH/
 Pqp5BoNAJMjWT4QnTWIv/v+sS8dJtal9sDMUxGmVXriZP8SxnL2CmQ/y0gKUDR0NFgturZvmM
 hZjVqyW3KjA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-543548457-1552468435=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Duy,

On Fri, 8 Mar 2019, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
> new file mode 100755
> index 0000000000..df91bf54bc
> --- /dev/null
> +++ b/t/t2070-restore.sh
> @@ -0,0 +1,77 @@
> +#!/bin/sh
> +
> +test_description='restore basic functionality'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	test_commit first &&
> +	echo first-and-a-half >>first.t &&
> +	git add first.t &&
> +	test_commit second &&
> +	echo one >one &&
> +	echo two >two &&
> +	echo untracked >untracked &&
> +	echo ignored >ignored &&
> +	echo /ignored >.gitignore &&
> +	git add one two .gitignore &&
> +	git update-ref refs/heads/one master
> +'
> +
> +test_expect_success 'restore without pathspec is not ok' '
> +	test_must_fail git restore &&
> +	test_must_fail git restore --source=first
> +'
> +
> +test_expect_success 'restore -p without pathspec is fine' '
> +	echo q >cmd &&
> +	git restore -p <cmd
> +'

This breaks with NO_PERL builds. See e.g.

https://dev.azure.com/gitgitgadget/git/_build/results?buildId=4581
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=4584
https://dev.azure.com/git/git/_build/results?buildId=386

You need this squashed in:

diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index df91bf54bc06..f4766544c5de 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -23,7 +23,7 @@ test_expect_success 'restore without pathspec is not ok'
'
 	test_must_fail git restore --source=first
 '
 
-test_expect_success 'restore -p without pathspec is fine' '
+test_expect_success PERL 'restore -p without pathspec is fine' '
 	echo q >cmd &&
 	git restore -p <cmd
 '


Junio, could you please add that as SQUASH??? on top of
nd/switch-and-restore to unbreak the CI builds?

Duy, have you thought about making use of the CI builds? You could catch
those bugs before they hit the Git mailing list...

Thanks,
Dscho
--8323328-543548457-1552468435=:41--
