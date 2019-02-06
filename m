Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A873E1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 12:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfBFM1W (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 07:27:22 -0500
Received: from mout.gmx.net ([212.227.15.18]:49655 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbfBFM1W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 07:27:22 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4nt7-1h3WV22pwL-00yvnH; Wed, 06
 Feb 2019 13:27:13 +0100
Date:   Wed, 6 Feb 2019 13:27:12 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
In-Reply-To: <20190205211736.GD6085@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1902061325530.41@tvgsbejvaqbjf.bet>
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com> <20190204215251.GB6085@hank.intra.tgummerer.com> <20190205211736.GD6085@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HyyLMp/9tjcOEeCaEh/hIzBFt1MDUxJgU1uVsOyxEDSz9B0thet
 Q+sBjmDpGVL7yF97Uj5QkrvRucvmZ925qMfNEOp7NYKLT9k6F8+UDrxrzQa6nMjrQz7Nk+i
 nOSQH3hRmxz51m9Qc9KTjMizM+keZWzxRRnAlb+L5axxAlAhRrgkdqnRKwETlZ1QO8qLkXj
 rA3gfR+nLQhexnLGhsUJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:An6IAsdGMYk=:ZLzIPWRHBw6x7RQVCkIof2
 x1tCcFlJKWoDjteyd3vxor8PZzVU2zQ6qFbfsC7ZF7oF+Pr0QbF0jWdYfZj6wVtAy1NHMDpZB
 xRu+G33UhhT6V3fQmb4ni+cUmpDT2RPGD1grVVwQEXJvDt1opOjcYI61ndgiuFdNvXTQyRgeP
 LaoPujoiJjU3+6MQcbUbJS6EpL3iqRUfVh8asnzcxzYllg9JrM7jpJanIo+M6XIhGeLn6ESp4
 Fk4/WUllf+ToqqW5WSJ8u9O65Qicq7/nE8Vlp70PThYwrkTDyBFdhCXvc1ClXszqOLt/KfYF1
 zvMlkgq8x46SCi9o3UioN9Jmj4fbkhlY/sCpd9BuF3jbDA747xy4IteLtz27zaMkCiDMiP4rY
 8IoFDmufSSVRp94VG//NOFm84U/LTFhtqXgXblbZHWKfiX4qCKfaOXVg6HUmrx9KGyVuOJ/qs
 DMjTvferwHXGuDn86FMlQ2oOKMNQiRp4GPAskmY8l2MmFRwzLLRPYxTBjkxM2VZk5Agr7wGXj
 EwKYgCp52nkaHhHXFA8+Rus2bY6WFthVJRZDLP/gJvi97ekfiQPcEBszDqMsOCHZU8/3n7o50
 hGHvKyaLB8pWd28G9WTJXTKq2t5Asc4NzjkHCmMuJU+iIGiiGilaxU4HFeYQ2aKuXX42i33+u
 GTBq4oqHATlP+qC9+6gh1gx4pIT6Ij/7HDcmqtTc7nqQXsq4V26fxY4ynFRaGM4Kqw16b39qt
 KYwttkOgF6CFLb24cKVG+l7kNzbh1bBh1w5PKP+0Kzcma8dvTCaBwg1AbXn00sSrMBoohIC02
 eksH18FUZIm0/UnqalbDKLSfgm0zFV9InQFX5XIh7pepnjFIEDcAVhr6WUWHIvj+EIagLvxhV
 PuQi5PDksPsQ+bw9+Lke6VjYcYjO5es//tAQjWtbDdGYZZcMG+0DHwlBijRIxQJ6gEPuQ/uq9
 NAZSNwM12Nw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Tue, 5 Feb 2019, Thomas Gummerer wrote:

> Here's an idea, that I think could make a good GSoC project.  Dscho
> mentioned this to me at Git Merge, and I liked the idea, but I'd like to
> get some feedback on the list first before adding it to the project
> list, to get others opinions on the feasibility.
> 
> The idea is to add an option to 'git stash push', so it can stash merge
> conflicts, and restore them with 'git stash pop'.  The various stages of
> the files could be represented as commits, and the stash commit would be
> an octopus merge of those commits, so they could be re-created later.
> The same idea can also be extended to store staged vs. unstaged changes,
> so we can re-create the index state as it was before creating the stash.
> 
> Thoughts?

Yep, would make for a good GSoC project, as it is straight-forward to
implement and easy to structure, there is no exploratory work needed.

Ciao,
Dscho
