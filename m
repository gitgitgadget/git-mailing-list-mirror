Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9469C43470
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4BE061408
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhELUfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 16:35:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:50306 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241453AbhELSFf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 14:05:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CCC90B1FC;
        Wed, 12 May 2021 18:04:19 +0000 (UTC)
Date:   Wed, 12 May 2021 20:04:18 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Message-ID: <20210512180418.GF8544@kitsune.suse.cz>
References: <609ae224aa509_6064920851@natae.notmuch>
 <20210511202502.GM12700@kitsune.suse.cz>
 <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com>
 <609b4eea1088a_678ff208ba@natae.notmuch>
 <20210512040926.GN12700@kitsune.suse.cz>
 <609b63e48fd49_6d7da2086@natae.notmuch>
 <20210512064733.GP12700@kitsune.suse.cz>
 <CAD2i4DBF3Tvf62Zyh0XnNH=5ifTD2QQNL5Fx01UHMzoTn3OMVw@mail.gmail.com>
 <20210512170153.GE8544@kitsune.suse.cz>
 <609c112066acd_71bd1208aa@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <609c112066acd_71bd1208aa@natae.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 12:32:16PM -0500, Felipe Contreras wrote:
> Michal Suchánek wrote:
> > On Wed, May 12, 2021 at 11:47:15AM -0500, Varun Varada wrote:
> > > So you're saying you're OK with getting rid of all instances of
> > > "impact"? I'm for this, but insofar as I searched the code base, I
> > > only found the ones I'm changing in my patch (save for a couple that,
> > > as a previous reviewer mentioned, are included from other repos, so I
> > > left those).
> > 
> > Yes, I am not opposed to the change in principle.
> 
> Good, so you accept you see nothing wrong with "affect".
> 
> > You just failed to provide any valid reason.
> 
> *In your opinion*.
> 
> In my opinion the problems with the word "impact" have been clearly
> explained.

However, you only brought your personal opinion for the case that
'impact' is somehow wrong and should be changed. 'impact' and 'affect'
are equally good based on the past discussion so you will not bring
change based on the 'badness' of 'impact'.

You claim that people who do not want to change 'impact' ignore your
opinion.

Don't you equally ignore the opinion of people who think 'impact' is
fine by insisting that the wording be changed based solely on your
opinion?

Cheers

Michal
