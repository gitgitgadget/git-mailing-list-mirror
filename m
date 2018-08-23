Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 550801F404
	for <e@80x24.org>; Thu, 23 Aug 2018 20:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeHXAbW (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 20:31:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:38365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbeHXAbV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:31:21 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPppG-1fo11r4BfO-0051UQ; Thu, 23
 Aug 2018 22:59:50 +0200
Date:   Thu, 23 Aug 2018 22:59:48 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] t2024: mark a `checkout -p` test as requiring
 Perl
In-Reply-To: <877ekhf7rj.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808232259330.73@tvgsbejvaqbjf.bet>
References: <pull.20.git.gitgitgadget@gmail.com> <pull.20.v2.git.gitgitgadget@gmail.com> <8d46b31f5ad9925c8d1867c8db4fcbf86480d431.1535035282.git.gitgitgadget@gmail.com> <877ekhf7rj.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-44782917-1535057990=:73"
X-Provags-ID: V03:K1:E6cNmWrTX37tKhlUI31+vVXl+5Ab+PpC2Jek9ZKdCbTHC7Pagvu
 2Efguw17w8qouN0Qej3iC9CsDy2InE6n2zdzngDwnhlOOTqGqoPQURwmYIvXf+AZJbmRMa6
 NQFtjIHK/QuzWLVi8y3qSivOj7ARTvvWFEXSjOAAlLy+aqi1HUNq3Iqy4WjyGW57I6j9p/P
 czLNImYo0Z3NqwcKjfheg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7wVikaFQwUg=:ucahc74lDhbITSJwk3ZNbw
 KEuWs+x0gf+qFFAiWimMamu29kh/Rn9hgB4J94jhORCP4VFYWWmbhtnBWDlztPYL121IoYkCZ
 f4DOnwdkiaIEoO2ACpPVOIL3qLZQNG3yZJzrtU3eGm1JK7ycVe6R+4etgkNcpyqReXE1USVMR
 wfKo/Pe1fdJBg+uGGOPXAQ8V+/FASwslrcEPWH7E1odX7qtS3FQQuEO3bikut03nJ+bQ5FumV
 332XrkshBI4HzO7RGla/eEdlbQZRZfdZuQFZAs4O5e0f/ocVaV3sQXEPsqOuDpv6jeBnJIrgI
 xArjh6cnQdNL57R43dP62QAjk7jhcxxe03vX3099Vlxio/HuScdaFlTHt1FJDsH/uUAlP8Epk
 ZlU1dNpvMyj1w6nnWKvY8nGKk30O1C+RhjDmcmyJh//qJVNWLTmig2BwWgRfD59E7L7gbAfxp
 mXWQ5l2L+Mt5bSbmxCzThyf5YS8klzl0k7jubvNStNlcyL2HYExlOeTm9+rotv/DxtIZT+i2A
 VWg9MaHo5EzwBn3rxltlQvXp/RlazDt6Jf7/skmyl5XcCjJfgQtZGrxX2GiHjuSPFerLdFZ6R
 VIyImVGqGJqFc66dD0YFTdSGhaqKgE91YMtgiRXEltFTMtnXUKZXh1nxPTeOR/Jq6nj+8B7qZ
 CJM5nZy7IMvJdV8g+aRHqWBSQOI5cogB+fLajU4vXNfSxadMD/JinUW1uMQhzgGMQE2SPnNRd
 AcilPGxtLi8XExi9EYQjGm4S1mnoPJ0A+jur5ueUHoJYfV87EqvOK84aoYEDnuOKbZGZry2B2
 Uc+fDLN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-44782917-1535057990=:73
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Thu, 23 Aug 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>=20
> On Thu, Aug 23 2018, Johannes Schindelin via GitGitGadget wrote:
>=20
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > A recently-added test case tries to verify that the output of `checkout
> > -p` contains a certain piece of advice.
> >
> > But if Git was built without Perl and therefore lacks support for `git
> > add -i`, the error output contains the hint that `-p` is not even
> > available instead.
> >
> > Let's just skip that test case altogether if Git was built with NO_PERL=
=2E
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t2024-checkout-dwim.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
> > index 26dc3f1fc0..29e1e25300 100755
> > --- a/t/t2024-checkout-dwim.sh
> > +++ b/t/t2024-checkout-dwim.sh
> > @@ -76,7 +76,8 @@ test_expect_success 'checkout of branch from multiple=
 remotes fails #1' '
> >  =09test_branch master
> >  '
> >
> > -test_expect_success 'checkout of branch from multiple remotes fails wi=
th advice' '
> > +test_expect_success NO_PERL \
> > +=09'checkout of branch from multiple remotes fails with advice' '
> >  =09git checkout -B master &&
> >  =09test_might_fail git branch -D foo &&
> >  =09test_must_fail git checkout foo 2>stderr &&
>=20
> This issue is already fixed in master as 3338e9950e ("t2024: mark test
> using "checkout -p" with PERL prerequisite", 2018-08-18).

Excellent,
Dscho
--8323328-44782917-1535057990=:73--
