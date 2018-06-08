Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6729B1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 12:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeFHMDq (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 08:03:46 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41374 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbeFHMDo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 08:03:44 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w58C3WEq023326
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Jun 2018 14:03:32 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w58C3WXx023325;
        Fri, 8 Jun 2018 14:03:32 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w58C3KdT012582;
        Fri, 8 Jun 2018 14:03:20 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w58C3KJw012581;
        Fri, 8 Jun 2018 14:03:20 +0200
Date:   Fri, 8 Jun 2018 14:03:20 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, David Lang <david@lang.hm>,
        Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180608120320.GB12013@helen.PLASMA.Xg8.DE>
References: <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz>
 <20180607063225.GA28343@helen.PLASMA.Xg8.DE>
 <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley>
 <20180607223442.GA5322@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz>
 <20180607232128.GA5879@helen.PLASMA.Xg8.DE>
 <20180608025313.GA12749@thunk.org>
 <20180608062657.GB9383@helen.PLASMA.Xg8.DE>
 <8736xxzof3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736xxzof3.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 08, 2018 at 10:13:20AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Can you walk us through how anyone would be expected to fork (as create
> a new project, not the github-ism) existing projects under such a
> regiment?

I don't see your point. Copy the repository to fork. Nothing changes 
about that. Nothing prevents anyone from forking a repository which had 
some of its author names removed from the commits.

> As David Lang notes upthread, "the license is granted to the world, so
> the world has an interest in it". I wouldn't be so sure that this line
> of argument wouldn't work.

As I already stressed, having an interest is not enough. You need to 
have overriding legitimate grounds.

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
