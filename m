Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC8641F403
	for <e@80x24.org>; Fri,  8 Jun 2018 18:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbeFHSwJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 14:52:09 -0400
Received: from lang.hm ([66.167.227.134]:54596 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752826AbeFHSwI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 14:52:08 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id w58Ipxrh003163;
        Fri, 8 Jun 2018 11:51:59 -0700
Date:   Fri, 8 Jun 2018 11:51:59 -0700 (PDT)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@asgard.lang.hm
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
cc:     Philip Oakley <philipoakley@iee.org>,
        =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
In-Reply-To: <20180608115842.GA12013@helen.PLASMA.Xg8.DE>
Message-ID: <alpine.DEB.2.02.1806081148030.14286@nftneq.ynat.uz>
References: <20180603174617.GA10900@helen.PLASMA.Xg8.DE> <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz> <20180607063225.GA28343@helen.PLASMA.Xg8.DE> <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley> <20180607223442.GA5322@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz> <20180607232128.GA5879@helen.PLASMA.Xg8.DE> <alpine.DEB.2.02.1806071651310.27871@nftneq.ynat.uz> <20180608061656.GA9383@helen.PLASMA.Xg8.DE> <nycvar.QRO.7.76.6.1806080040060.4962@qynat-yncgbc>
 <20180608115842.GA12013@helen.PLASMA.Xg8.DE>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 8 Jun 2018, Peter Backes wrote:

> On Fri, Jun 08, 2018 at 12:42:54AM -0700, David Lang wrote:
>> Wrong, if you have to delete info, you are not allowed to keep a private
>> copy.
>
> Yes you are allowed. See Art. 17 (3) lit e GDPR.
>
>> There is _nothing_ in the GDPR about publishing information,
>> everything in it is about what you are allowed to store privately, how you
>> are required to protect it (or more precisely, what you are required to do
>> if private data gets hacked), and how you are required to keep it available.
>
> Nope, the GDPR is not at all restricted to private copies.

If the GDPR doesn't restrict private copies, then Google and Facebook are free 
to keep all data about everyone. That is explicitly what the GDPR is trying to 
prevent.

> The GDPR has special jargon for publishing; the GDPR calls it
> "disclosure (Art. 4 (2) GDPR) to an unspecified number of unspecified
> recipients (Art. 4 (9) GDPR), including ones in third countries
> (Chapter 5) in a repetitive (Art 49 (1) GDPR) fashion".

disclosure is what the person who submits the patch is doing, torturing the 
language of the GDPR to say that hanging on to data that people want you to 
delete is legal, and echoing public data that people have asked to be public is 
not legal is not going to be a successful line of argument, it's the exact 
opposite of the stated goals of the GDPR.

David Lang
