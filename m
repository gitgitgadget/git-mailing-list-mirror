Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C811F424
	for <e@80x24.org>; Fri, 13 Apr 2018 11:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754289AbeDMLMy (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 07:12:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:53229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754273AbeDMLMw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 07:12:52 -0400
Received: from [192.168.0.129] ([37.201.203.18]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LrqNe-1eSmH00bUM-013aBa; Fri, 13
 Apr 2018 13:12:48 +0200
Date:   Fri, 13 Apr 2018 13:12:34 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jakub Narebski <jnareb@gmail.com>
cc:     Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: File versioning based on shallow Git repositories?
In-Reply-To: <86efjjmqsi.fsf@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804131157360.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <hbf.20180412fvfi@bombur.uio.no>        <87d0z4b6ti.fsf@evledraar.gmail.com>        <4af21bcd-7a68-50df-4cce-0b050ccaeb90@usit.uio.no> <86efjjmqsi.fsf@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dfWJ43yWwpflWrRGOi5HFjOpGN0zqQuIKsssbzTGP+Eeir7DetY
 o8mLX4UhUUsDj80izg3Xn+XsIRB1mX/gJA6F9mICRZgS0Vp9GSsDz4+P1NNOuA0VhcMGumi
 y/1344bO5gQopOr0iwg0g1N5KyZlSh/npwKHZEAx1cpS+Gp15SmSW1mwLnHopyTV0VJMm9G
 kfVUFMsFJlVqwiXvHNBxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HtOMSm6ohx0=:kA+C6s8BtUShkUakb1vmdN
 noBbfzXw2TurXCSw1IsXURDRaYWZRd9exQ9tzryOf+jRAV0cC/9qv1GMstFYg5jz58klTfqxs
 0dKLgoz2N2HjpVevuPG85fA3o7s7e+N4tDQTRwPRrYLHVXOlxMz0SafwFaNMzn3MSwRaxO0Fw
 DqIUXaW+xUrgQlxdp7ZTpzSOaeSrviTQjRLcAbt9F9Sn2S7NpxdvgPlPgStMdHnHJ+vKv+nmU
 XzIV9fd7KzmaI+waT/jmLMeanXHwBxuBHxXyT32hHV5d1djHkNmKdGHbMcqRy+mlZqhjJI2A6
 MRTpuqHMiQ8Arrs1PC8GPSfxh0yJ0pgS6QpExIda6So6RRTiqaadOS/6cT9QvPcAbTfnnGuVQ
 nvYgMF0w7U3LV1eyuMGKbfYcSME7NgDwUPmEyCWBXD951QOziEEdb+2YVVzZy5/gxBLJprXqi
 T5yobkg2tdNuOq+6Wo643TwSv45+N3mK8kMvPS2ma6qKTIg+p+WZR1bJbVRTofqUt8nni20m4
 uM97pFKiTieWzixbspdCTXB9dKHp17ihPfG4gTIP5Q6sx0BsoZJd5GmNthEUO9MHCoNysYaLk
 +/AAfRi442DVKP0AMG2FUN/8smplfOC6ywAVFAhlnSPcrXRa55tU/J9TXLaNYuY69wnDwREc2
 cUq32lL2Lirv/veYFBlTJaSGz8USuUxAKl3ZOtRo1ZSr8bwnGcusDmRHePihGO32CU1tbmZzK
 YB5tkYIvjTYI39LvjMmcgX2tPIB5dzHxahFbGDzNcfsxALM7X6TkDW/FXxpAgbm3vTXpwJQ8A
 QdZtK1txQHIMjGAaK0fNdftV9eph+kpYmYr43TuY7ngOOxdTOQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kuba,

On Fri, 13 Apr 2018, Jakub Narebski wrote:

> Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no> writes:
> 
> > Also maybe it'll be worthwhile to generate .git/info/grafts in a local
> > clone of the repo to get back easily visible history.  No grafts in
> > the original repo, grafts mess things up.
> 
> Just a reminder: modern Git has "git replace", a modern and safe
> alternative to the grafts file.

Right!

Maybe it is time to start deprecating grafts? They *do* cause problems,
such as weird "missing objects" problems when trying to fetch into, or
push from, a repository with grafts. These problems are not shared by the
`git replace` method.

I just sent out a patch to add a deprecation warning.

Ciao,
Dscho
