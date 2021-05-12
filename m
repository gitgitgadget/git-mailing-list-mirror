Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B28C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 04:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1456461378
	for <git@archiver.kernel.org>; Wed, 12 May 2021 04:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhELEMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 00:12:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:57284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhELEMr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 00:12:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6F355B05E;
        Wed, 12 May 2021 04:11:39 +0000 (UTC)
Date:   Wed, 12 May 2021 06:11:38 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Message-ID: <20210512041138.GO12700@kitsune.suse.cz>
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz>
 <609ad9473d535_6011e2082@natae.notmuch>
 <20210511195723.GL12700@kitsune.suse.cz>
 <609b47043a719_678ff208e@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <609b47043a719_678ff208e@natae.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 10:09:56PM -0500, Felipe Contreras wrote:
> Michal Suchánek wrote:
> > On Tue, May 11, 2021 at 02:21:43PM -0500, Felipe Contreras wrote:
> > > Michal Suchánek wrote:
> 
> > > > If you are concerned about correctness and clarity of the documentation please
> > > > avoid spreading misinformation.
> > > 
> > > Under certain definition of "jaron" Varun's statement would be
> > > incorrect, but not under all definitions. If you use the definition
> > > I stated above, "impact" can be considered jargon, because it's a bit
> > > obscure language.
> > 
> > Do you have any frequency data that supports your claim that the word
> > 'impact' is obscure?
> 
> This is not how logic works.
> 
> If I don't have frequency data that supports $x, but you have no
> frequency data that supports !$x, then we return to the default position;
> we don't know if $x is true or not.
> 
> Do **you** have any frequency data that supports the negative claim that
> the word "impact" is not obscure?

I don't need that data. You are proposing a change so it is your duty to
support your claim that the change is worthwhile.
Otherwise it's a change just for the sake of change.

> 
> > The bar for change should be that the word as used is very unfitting or
> > unintelligible.
> 
> No. The bar is that **nobody** have any problem with "affect", and some
> people have a problem with "impact".

And that's established how, specifically?

Thanks

Michal
