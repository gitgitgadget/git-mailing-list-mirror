Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58B5D1F45F
	for <e@80x24.org>; Sun,  5 May 2019 16:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfEEQbK convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 5 May 2019 12:31:10 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:26282 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfEEQbK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 12:31:10 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 3D8242003BE;
        Sun,  5 May 2019 18:31:05 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Jeff King <peff@peff.net>
Cc:     Priscila Gutierres <priscila.gutierres@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Contributing with documentation/translation
Date:   Sun, 05 May 2019 18:31:04 +0200
Message-ID: <1637274.A4eT74VTMb@cayenne>
In-Reply-To: <20190501203545.GA13372@sigill.intra.peff.net>
References: <CAHtYWY4g4BYDr_z7pfS-p=aX_YkVo4HzGR1Dsytn4RkzBo0GjA@mail.gmail.com> <CACsJy8DHH_PqZ9DQ5jpA_4AuLmVXmt3F3x6nYVGqZ1pNWnC5+Q@mail.gmail.com> <20190501203545.GA13372@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, 1 May 2019 22:35:45 CEST Jeff King wrote:
> On Wed, May 01, 2019 at 05:11:38PM +0700, Duy Nguyen wrote:
> 
> > On Wed, May 1, 2019 at 1:10 AM Priscila Gutierres
> > <priscila.gutierres@gmail.com> wrote:
> > >
> > > Hi
> > > I want to contribute to git by creating and/or translating
> > > documentation. Where may I find the info to do this?
> > 
> > For translation, you could start at po/README. That's mostly UI
> > translation. I think some team actually started document translation
> > too [1], but I don't know the status.
> 
> +cc Jean-Noel, who is working on this. It looks like translations will
> be done through Weblate:
> 
>   https://hosted.weblate.org/projects/git-manpages/translations/
> 
> There's some more discussion in:
> 
>   https://public-inbox.org/git/1992944.NOdEsaAZKb@cayenne/
> 
> There are also translations of the "Pro Git" book. This isn't strictly
> "Git documentation", but it is CC-licensed and we show it on
> git-scm.com. Details are at:
> 
>   https://github.com/progit/progit2/blob/master/TRANSLATING.md
> 
> -Peff
> 

Hi Priscila,

Peff has said it all. Depending on where you are on you way to learning about git, I would recommend:

* Starting with Progit for a gentle introduction to using git
* Translating git manpages for extensive knowledge of all git commands
* Translating git itself for indepth knowledge of how git works

The translation teams are welcoming to new contributors.

----
Jean-Noël



