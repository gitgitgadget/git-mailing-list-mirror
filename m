Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4D9C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 09:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3557561404
	for <git@archiver.kernel.org>; Thu, 13 May 2021 09:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhEMJtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 05:49:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:57864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230338AbhEMJta (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 05:49:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5AE9AF2C;
        Thu, 13 May 2021 09:48:19 +0000 (UTC)
Date:   Thu, 13 May 2021 11:48:18 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Robert Coup <robert.coup@koordinates.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Message-ID: <20210513094818.GH8544@kitsune.suse.cz>
References: <20210512040926.GN12700@kitsune.suse.cz>
 <609b63e48fd49_6d7da2086@natae.notmuch>
 <20210512064733.GP12700@kitsune.suse.cz>
 <CAD2i4DBF3Tvf62Zyh0XnNH=5ifTD2QQNL5Fx01UHMzoTn3OMVw@mail.gmail.com>
 <20210512170153.GE8544@kitsune.suse.cz>
 <609c112066acd_71bd1208aa@natae.notmuch>
 <20210512180418.GF8544@kitsune.suse.cz>
 <609c2f98932f3_71bd120840@natae.notmuch>
 <20210513074622.GG8544@kitsune.suse.cz>
 <CAFLLRpJeU3BFKmsGgFoKQRLCw-uGRRH1Ob7PZBHUEQu_Pqshgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLLRpJeU3BFKmsGgFoKQRLCw-uGRRH1Ob7PZBHUEQu_Pqshgw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 13, 2021 at 09:55:42AM +0100, Robert Coup wrote:
> Hi Michal,
> 
> On Thu, 13 May 2021 at 08:47, Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > That would be the situation if you comented on the patch adding 'impact'
> > before it was merged.
> 
> As a lurker (and there are a lot more of us than people who email the
> list), this comes across to me as veering well into bad faith. Because
> it wasn't picked up at the time it can never be improved? Code doesn't
> work that way, neither should any other aspect of the project.
> 
> Non-native English speakers outnumber native ones about 3:1 [1], and
> even within native English speaking countries there are variances in
> common vocabulary. This sort of stuff trips up non-native speakers
> though (and the lack of rules in English makes it difficult enough) -
> why would we want to make understanding Git harder for people when
> there's a simple improvement to be had?

Indeed, and I even provided an argument why eliminating 'impact' in git
would likely improve the situation for non-native speakers. 'impact' is
very rarely used in git, and by eliminating it (which is completely
feasible) we reduce the vocabulary needed to read git documentation and
make it more consistent.

Yet Felipe insists that 'impact' is somehow generally bad word to use or
that it should be abolished solely because he finds it bad and nobody
objected to the alternative wording.

Opinions on use of 'impact' differ both among the participants of this
discussion and authorities like authors well-known dictionaries.

It looks like this is generally matter of stylistic preferences and
opinions. That is even if there is some slight stylistic preference for
not using the word 'impact' it is very hard to prove such and then it is
very hard to request change based only on writing style preferences.

That's not to say it's impossible but Felipe chooses the option to
rehash the same arguments ad nauseam without bringing clear and
substantial arguments in favor of the change.

Thanks

Michal
