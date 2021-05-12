Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50626C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 10:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01415611BF
	for <git@archiver.kernel.org>; Wed, 12 May 2021 10:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhELKem (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 06:34:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:55226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhELKem (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 06:34:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5FEEEB028;
        Wed, 12 May 2021 10:33:33 +0000 (UTC)
Date:   Wed, 12 May 2021 12:33:32 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Message-ID: <20210512103332.GB8544@kitsune.suse.cz>
References: <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <609ae224aa509_6064920851@natae.notmuch>
 <20210511202502.GM12700@kitsune.suse.cz>
 <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com>
 <609b4eea1088a_678ff208ba@natae.notmuch>
 <20210512040926.GN12700@kitsune.suse.cz>
 <609b63e48fd49_6d7da2086@natae.notmuch>
 <20210512064733.GP12700@kitsune.suse.cz>
 <609b9ab0b1120_6e4e9208cc@natae.notmuch>
 <20210512100855.GA8544@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210512100855.GA8544@kitsune.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 12:08:55PM +0200, Michal Suchánek wrote:
> On Wed, May 12, 2021 at 04:06:56AM -0500, Felipe Contreras wrote:
> > Michal Suchánek wrote:
> > > On Wed, May 12, 2021 at 12:13:08AM -0500, Felipe Contreras wrote:
> > > > Michal Suchánek wrote:
> > 
> > > > > You can use 'affect' or 'impact' and it generally conveys the same
> > > > > meaning.
> > > > 
> > > > That's clearly *your* opinion, but that's not my opinon.
> > > > 
> > > > I'm not arguing between blue and red; I'm arguing between water-based and
> > > > lead-based paint.
> > > 
> > > No, you are not. There is no clear problem with 'impact', either.
> > 
> > There's no clear problem *to you*.
> > 
> > > So if somebody comes along later and says that they find 'affect'
> > > confusing and impact should be used does that need to be accepted as
> > > well, back and forth ad nauseam?
> > 
> > No. When that happens we start a new discussion, and see where that
> > leads.
> > 
> > > > The difference may not matter to you, but it matters to me.
> > > > 
> > > > If it's bikeshedding to you, and it "gnerally conveys the same meaning",
> > > > why are you arguing against?
> > > 
> > > So if 'for' loops and 'while' loops generally convey the same meaning
> > > should we accept patches that replace some 'for' loops with 'while'
> > > lopps or vice versa?
> > 
> > You are not answering my question, and you are providing an irrelevant
> > example.
> > 
> > I don't see any general difference between 'for' loops and 'while'
> > loops. But I do see a difference between 'impact' and 'affect'.
> > 
> > You are starting from the premise that $a is no different than $b.
> > That's your opinion, and I'm not disregarding it. But other people (e.g.
> > Varun and me) do have a different opinion.
> > 
> > Again, to make it crystal clear; you opine that $a and $b are equal, we
> > opine that they are not. We don't disregard your opinion, you do
> > disregard ours.
> > 
> > I don't know how much clearer I can make this.

And changes to git should be based on fact, not opinion.

I don't know how much clearer I can state it.

Thanks

Michal
