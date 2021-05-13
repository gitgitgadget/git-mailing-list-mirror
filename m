Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBF0C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29343613E9
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhEMHsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 03:48:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:43012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231891AbhEMHrd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 03:47:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9ACF3AF35;
        Thu, 13 May 2021 07:46:23 +0000 (UTC)
Date:   Thu, 13 May 2021 09:46:22 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Message-ID: <20210513074622.GG8544@kitsune.suse.cz>
References: <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com>
 <609b4eea1088a_678ff208ba@natae.notmuch>
 <20210512040926.GN12700@kitsune.suse.cz>
 <609b63e48fd49_6d7da2086@natae.notmuch>
 <20210512064733.GP12700@kitsune.suse.cz>
 <CAD2i4DBF3Tvf62Zyh0XnNH=5ifTD2QQNL5Fx01UHMzoTn3OMVw@mail.gmail.com>
 <20210512170153.GE8544@kitsune.suse.cz>
 <609c112066acd_71bd1208aa@natae.notmuch>
 <20210512180418.GF8544@kitsune.suse.cz>
 <609c2f98932f3_71bd120840@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <609c2f98932f3_71bd120840@natae.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 02:42:16PM -0500, Felipe Contreras wrote:
> Michal Suchánek wrote:
> > On Wed, May 12, 2021 at 12:32:16PM -0500, Felipe Contreras wrote:
> > > Michal Suchánek wrote:
> > > > Yes, I am not opposed to the change in principle.
> > > 
> > > Good, so you accept you see nothing wrong with "affect".
> > > 
> > > > You just failed to provide any valid reason.
> > > 
> > > *In your opinion*.
> > > 
> > > In my opinion the problems with the word "impact" have been clearly
> > > explained.
> > 
> > However, you only brought your personal opinion for the case that
> > 'impact' is somehow wrong and should be changed.
> 
> No I didn't. I used dictionary definitions to explain why it's wrong to
> use it the way git uses both as a noun and a transitive verb.
> 
> > 'impact' and 'affect' are equally good based on the past discussion so
> > you will not bring change based on the 'badness' of 'impact'.
> 
> That is your opinion, and its not shared by everyone.
> 
> It's extremely disingenious to elevate your opinion as fact, especially
> when this is precisely the thing we are discussing.
> 
> > You claim that people who do not want to change 'impact' ignore your
> > opinion.
> 
> No I don't.
> 
> I clam *you* pretend other opinions don't even exist.
> 
> > Don't you equally ignore the opinion of people who think 'impact' is
> > fine by insisting that the wording be changed based solely on your
> > opinion?
> 
> No, unlike you I acknowledge there's other people with different
> opinions.
> 
> However, that opinion is that "impact" is fine, *not* that "affect" is
> bad.
> 
> 
> If you and your wife are deciding what to eat for dinner, and you have
> two opinions:
> 
>   1. Whatever is fine
>   2. I really would like pizza
> 
> What do you think you should order?

That would be the situation if you comented on the patch adding 'impact'
before it was merged.

If you want a dining metaphor for the current situation it would be more
like

1. There are 100 people around the table eating lasagne
2. You stand up and say you don't like lasagne and pizza should be
brought instead
3. people say comeon, we already have lasagne. And are you so sure if we
bring in pizza instead that nobody will object?
4. you say nonsense, pizza is the best, nobody ever objected to it.
5. you start banging your cutlery against the plate and shouting to
bring the pizza already

Sounds very rude to me.

Best regards

Michal
