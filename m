Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF9EC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 10:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A19613BE
	for <git@archiver.kernel.org>; Wed, 12 May 2021 10:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhELKKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 06:10:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:60310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230168AbhELKKO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 06:10:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1EAB1AF9E;
        Wed, 12 May 2021 10:09:06 +0000 (UTC)
Date:   Wed, 12 May 2021 12:08:55 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Message-ID: <20210512100855.GA8544@kitsune.suse.cz>
References: <20210406092440.GZ6564@kitsune.suse.cz>
 <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <609ae224aa509_6064920851@natae.notmuch>
 <20210511202502.GM12700@kitsune.suse.cz>
 <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com>
 <609b4eea1088a_678ff208ba@natae.notmuch>
 <20210512040926.GN12700@kitsune.suse.cz>
 <609b63e48fd49_6d7da2086@natae.notmuch>
 <20210512064733.GP12700@kitsune.suse.cz>
 <609b9ab0b1120_6e4e9208cc@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <609b9ab0b1120_6e4e9208cc@natae.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 04:06:56AM -0500, Felipe Contreras wrote:
> Michal Suchánek wrote:
> > On Wed, May 12, 2021 at 12:13:08AM -0500, Felipe Contreras wrote:
> > > Michal Suchánek wrote:
> 
> > > > You can use 'affect' or 'impact' and it generally conveys the same
> > > > meaning.
> > > 
> > > That's clearly *your* opinion, but that's not my opinon.
> > > 
> > > I'm not arguing between blue and red; I'm arguing between water-based and
> > > lead-based paint.
> > 
> > No, you are not. There is no clear problem with 'impact', either.
> 
> There's no clear problem *to you*.
> 
> > So if somebody comes along later and says that they find 'affect'
> > confusing and impact should be used does that need to be accepted as
> > well, back and forth ad nauseam?
> 
> No. When that happens we start a new discussion, and see where that
> leads.
> 
> > > The difference may not matter to you, but it matters to me.
> > > 
> > > If it's bikeshedding to you, and it "gnerally conveys the same meaning",
> > > why are you arguing against?
> > 
> > So if 'for' loops and 'while' loops generally convey the same meaning
> > should we accept patches that replace some 'for' loops with 'while'
> > lopps or vice versa?
> 
> You are not answering my question, and you are providing an irrelevant
> example.
> 
> I don't see any general difference between 'for' loops and 'while'
> loops. But I do see a difference between 'impact' and 'affect'.
> 
> You are starting from the premise that $a is no different than $b.
> That's your opinion, and I'm not disregarding it. But other people (e.g.
> Varun and me) do have a different opinion.
> 
> Again, to make it crystal clear; you opine that $a and $b are equal, we
> opine that they are not. We don't disregard your opinion, you do
> disregard ours.
> 
> I don't know how much clearer I can make this.
> 
> > In the COCA corpus there is around 200k instances of 'effect', around
> > 100k instances of 'affect', and around 100k instances of 'impact'
> > which makes effect/affect about 3 times more frequent than 'impact'.
> > That's not even an order of magnitude - clearly not enough to claim it
> > obscure.
> 
> I don't think you understand the point.
> 
> The word "impact" is not obscure by any means.
> 
> The Chicxulub impactor (probably an asteroid) did create an impact on
> Earth that probably killed all the non-avian dinosaurs. In that context
> the word "impact" is 100% valid.
> 
> And you can find many such valid instances in those 100k COCA corpus
> instances...
> 
> But not all.
> 
> 
> The way the word "impact" is used in the git documentation is different
> than the COCA corpus. Not all the instances of the word "impact" in the
> git documentation refer to an event so drastic that it destroyed
> thousands of species.
> 
> The point is very simple; there's valid ways of using the word "impact",
> and there's invalid ways of using it. The git documentation for the most
> part uses the word "impact" in an invalid way.
> 
> How many times the COCA corpuses uses "impact" in $b manner is
> irrelevant to the number of times the git documentation uses the same
> word in $a manner; the same word can have completely (and sometimes
> opposite meanings).
> 
> The word "literally" sometimes means the exact opposite of the word
> "literally". So if you find 1 million instances of the word "instance"
> used in some way, that doesn't matter, because you might be using it in
> a different way.
> 
> 
> So... Can you answer my question?
> 
> Do you have anything against the word "affect" in *any* instance?

Yss, the Merriam-Webster dictionary also lists the meaning
"to cause illness, symptoms, etc." I don't think something that drastic
should be included in the git documentation.

SCNR
