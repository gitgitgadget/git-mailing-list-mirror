Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AF7D1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 18:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfA0SaW (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 13:30:22 -0500
Received: from mout.gmx.net ([212.227.17.20]:50241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfA0SaW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 13:30:22 -0500
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LxcbX-1hGQz33XAZ-017BNL; Sun, 27
 Jan 2019 19:30:18 +0100
Date:   Sun, 27 Jan 2019 19:30:18 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 09/21] Add a build definition for Azure DevOps
In-Reply-To: <xmqqd0on54gw.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901271927130.45@tvgsbejvaqbjf.bet>
References: <pull.31.v3.git.gitgitgadget@gmail.com> <pull.31.v4.git.gitgitgadget@gmail.com> <eaba471b89976b51ea19fc6772890304135ab539.1548254412.git.gitgitgadget@gmail.com> <xmqqd0on54gw.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Fhl9H3iwc7xDGz8EVGMYHi3peymHQUxT8ba1/UweYunl89R6E1C
 A5trzGQWZHXoGy/NM/PSJjSvWIHbSiqVHUoxSYU5DgJmQiCP24j3x/hD+qElw1Z8RVpFyrf
 83zN8UDquI0VOK4Ibj15r91UT9eJUcreJgYrIkty/L5rqZ6I0BZfehhoA/EB3ymgRCo93Tv
 jKSqVDOfKQ6UkwbuecT5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YOlka5X+tEE=:NBFjpNfEKdr6Ux0xuyfxMc
 2JBoobq+l0Q0lgLGhn5LWXvlQTrwC1ZQlUV7OCet1KOAZCC2GbkHirf+iOjUHHX+rS1GcQHa6
 pl3AGKInoaCi7J0ZikuVbW+kDeA295mFpdxevTVVnCIAmIhHtgys9dP6KZ24r4KND+qgZnSMV
 sSTW+pDIyK7WUQxf30eGX0AMo8uhl8b3hVFo7G/3GY9uRjZI5tYCNdXSSPKuwmvcgqzl/ok31
 Rs5jPUdm68P54yzAhilOgyeVVlO9+FT/i8WjgbKTOSnQxo8ftROk74OYX5MfT7TRJmXFMsunl
 giBL0H4+Hsx7A6vrNDSLCZrHHvCgc51Tdfyjun7LagUQBS4yc1J7rYrRsbnE4kW8m+Q0QJWna
 VmgWEihHv1Fn9nDhKyybgF60BiLVJhZ+2Fv5xAb0EeT4VCTDLShWrSItKZYuwNPMp/d9P2FNr
 S7jSX8bl2LmNH8kke23S/tYFMNkj0165+x06JPd5IpkmczTKNSY5j9VZMqshxE1X2xkXmhHyD
 /HmsLfL19PSOSlfNwmEYdU305xPgcOW2MtI1hI0sB1qCJXsUyHImkjk9ru1odVB4P2AQ3vrqd
 DC1oMiSE/70A/cR5bS8dQKgRmIc5WhPM/s95B8WTtkWFY1XUamEqbNwnnMbGMbww61q5y0HfP
 b+vbx9LQ4upsg7y9O0l3ctSZZPKANMunw5AA7q3tdfVBFGRqzN7BsQUu1h2Wv01il+GYSyuOp
 zNMRL6tSPkKeLYpdpv4y+2s9rVp5q7Vt/dCNwBKWoj5FvewKMe25H5qJ1r6xG5NR+thkn5Ftr
 2aeneOW1mszVJXAHSUgHNBKuJvsuyGz8xpHwZgKyJDkxYU4VbNLIhewP0PgEI+UM9dgYQy7aA
 0yakKgFFZbWTmyZHqZdBzDcBQ+rXezPp9J9GbzqHdZDSv5zEuOce6nG1tT3M2pSmjtwLRmGH/
 DTYCVHb2z0Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 23 Jan 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This commit adds an azure-pipelines.yml file which is Azure DevOps'
> > equivalent to Travis CI's .travis.yml.
> >
> > To make things a bit easier to understand, we refrain from using the
> > `matrix` feature here because (while it is powerful) it can be a bit
> > confusing to users who are not familiar with CI setups. Therefore, we
> > use a separate phase even for similar configurations (such as GCC vs
> > Clang on Linux, GCC vs Clang on macOS).
> >
> > Also, we make use of the shiny new feature we just introduced where the
> > test suite can output JUnit-style .xml files. This information is made
> > available in a nice UI that allows the viewer to filter by phase and/or
> > test number, and to see trends such as: number of (failing) tests, time
> > spent running the test suite, etc.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  azure-pipelines.yml   | 306 ++++++++++++++++++++++++++++++++++++++++++
> 
> Way-overlong line in this file bothers me somewhat, but let's say
> these are not for human consumption and it is OK ;-)

Right ;-)

> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index a9eb4f4eae..91cf1402bf 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -42,7 +42,7 @@ then
> >  
> >  	BREW_INSTALL_PACKAGES=
> >  	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
> > -	export GIT_TEST_OPTS="--quiet --write-junit-xml"
> > +	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
> >  fi
> 
> Interesting to see this change here, not in the previous step.  If
> we stopped at 08/21, did we even have a chance to enter this elif
> block?  If not, it probably is sane to squash this hunk to the
> previous one that introduced the elif block.

Oh my. You're right. I think I just picked the wrong commit to make this
fixup.

Will squash as suggested,
Dscho
