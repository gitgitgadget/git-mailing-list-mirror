Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 268F41F403
	for <e@80x24.org>; Fri,  8 Jun 2018 16:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbeFHQCe (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 12:02:34 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41388 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeFHQCd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 12:02:33 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w58G2MUZ023958
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Jun 2018 18:02:22 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w58G2LfI023957;
        Fri, 8 Jun 2018 18:02:21 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w58G295q014672;
        Fri, 8 Jun 2018 18:02:09 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w58G27YB014671;
        Fri, 8 Jun 2018 18:02:07 +0200
Date:   Fri, 8 Jun 2018 18:02:07 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     David Lang <david@lang.hm>, Philip Oakley <philipoakley@iee.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180608160207.GA14472@helen.PLASMA.Xg8.DE>
References: <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz>
 <20180607063225.GA28343@helen.PLASMA.Xg8.DE>
 <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley>
 <20180607223442.GA5322@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz>
 <20180607232128.GA5879@helen.PLASMA.Xg8.DE>
 <20180608025313.GA12749@thunk.org>
 <20180608062657.GB9383@helen.PLASMA.Xg8.DE>
 <20180608144551.GB12749@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608144551.GB12749@thunk.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 08, 2018 at 10:45:51AM -0400, Theodore Y. Ts'o wrote:
> *Anyone* can run a repository.  It's not just github and gitlab.  The
> hobbiest in New Zealand, who might never visit Europe (so she can't
> be arrested when she visits the fair shores of Europe) and who has no
> business interests in Europe, can host such a web site.

Just because letters of request are hardly enforced doesn't make it 
legal to break the GDPR. For sure, a hobbyist would not have much to 
fear, even if he is violating the GDPR and coming to Europe. The GDPR 
is mostly about taming the megacorporations, not about arresting 
tourists.

> So the person trying to engage in censorship

Censorship? The GDPR is not about censorship.

If you want to write an opionion about someone by name, the GDPR gives 
you all legitimization to do so, against that person's will.

This is about removing the data under ordinary circumstances.

> would need to contact *everyone*.

This is the subject's problem, not the repository provider's.

> And someone who has a git note in their private repo who
> then pushes to github/gitlab would end up pushing that note back up to
> the web server.

If that note has been deleted based on the right to be forgotten, you 
as the repository provider have to make sure you don't publish it 
again. Since you are allowed to keep a private copy, ensuring that 
shouldn't be a problem for you. 

> Great, so you can get github and gitlab to get rid of the information.
> But it's *pointless*.

It's up to the subject to consider it pointless or not to exercise his 
rights...

> Your problem is in the word: "a"

...and against whom, whether one repository provider, the major ones, 
all of them he can find.

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
