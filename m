Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CB281FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 21:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932270AbdBIVpT (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 16:45:19 -0500
Received: from mout.gmx.net ([212.227.15.18]:52601 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932136AbdBIVpS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 16:45:18 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lvkwm-1cLESa2OmC-017Vt1; Thu, 09
 Feb 2017 22:38:08 +0100
Date:   Thu, 9 Feb 2017 22:38:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Christian Couder <christian.couder@gmail.com>
cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: Re: GSoC 2017: application open, deadline = February 9, 2017
In-Reply-To: <CAP8UFD3aygSf5U2abnpCfRzEf-hH5fSNuzFBBtgCjSQC3F8c5A@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1702092236500.3496@virtualbox>
References: <vpq1svtstud.fsf@anie.imag.fr> <20170125204504.ebw2sa4uokfwwfnt@sigill.intra.peff.net> <vpq37fowx5q.fsf@anie.imag.fr> <CAP8UFD3aygSf5U2abnpCfRzEf-hH5fSNuzFBBtgCjSQC3F8c5A@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:asjZeCqnn0Dvs3GKZuPOy/1oBqrVaILWb4dr5hXMloy5hGMpl89
 oike3LxkvjKPCDX1MPg4ctuWk+NW+GeVDi26U+BiUFyE2xQEr6X1BfonN3j/FCojU9b2lXq
 NKqQVfcdOQZHMUmksY/sGaW191Iy76xswpEOKhwlStgJ3voPROPTWpY/K//V2PAYqHqYCCi
 BGMO7IluDGVIn3trK648A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZfS4eWf0DSs=:Q7libuhbywn6gn4AizEHo7
 r+EHzaDgYyOvC7Kf2N6Hoi+JCZokg7A8wwCDsS4ep67Oh7u6h4VZlQSxkwqgrTHuqKIja/AEb
 NzK7yCcn3TrljRZy7gsINJo6fxEf8gW1HGqkvJ5+iV6f9ZYyiy6Q9ISfJwjzRX0Z5XHUcyJdh
 /YHciBXlK+lGIWpSTi5R9Uzj5H+gA334NwOiG+DBDpF8Fnk6dyLwK+EvT7N9iME5+YhbovyBp
 knjLrOqykOlRA80spHuEYk6gV2RzyYFlasgi+9hbj8B/PyjtECCN6Rz3rzvY7jUbN8EWNJBic
 cRJ7HHSbLTx+c1pVTukludn1O9nvOMi/UuZrQXcC66DjZMZoALj22HROPfaWvjAHDDahdQVLI
 m1mNHXHftTKHhj10yfZpNVpNZ0ZgzlN7lFYgmIals+2eWEQEtc8WGKY7uuyEy0wv11Chyrs94
 GB5Wd9ZhPraKfh8dfizSbJyPlri5l7pMKQGXXnWvIx2S5hZkHA1Kx4jXLJL8scU+f6WDdTAEM
 H4kEQJCXAGdQi3ONENP0Z9F/V88iAKdf3et+pnUcLlPWP1S9RCKw2Yabs9hVLXkmlt5oSjPRc
 CuWrRpds8JtAxHZ7Sir7xaCW0LcB7jAagLQp2QOs96QdugrYzuzewazNAp/p8evkBYYfmyz2Q
 osipaxKHTR5c5wSZQKdO90sTErk6Pg3qn4/0sBr0/pFAR5EdHIbqtciczfoPv3aZPQ0RbT8xX
 dYBgWwA8XwpotY/KMFQzybj2MMopPqDcx/SKY3JkPDqBgTPTx6gSGwCs1Dfn1bty9Jrz71xtf
 PIOMbtY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Thu, 9 Feb 2017, Christian Couder wrote:

> I just had a look and the microproject and idea pages for this year are
> ok.  They are not great sure, but not much worse than the previous
> years.  What should probably be done is to remove project ideas where is
> no "possible mentor" listed.
>
> But I am reluctant to do that as I don't know what Dscho would be ok to
> mentor.

I am okay to mentor (except anything that touches submodules).

Ciao,
Johannes
