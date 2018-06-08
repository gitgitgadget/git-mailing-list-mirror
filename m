Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90A6E1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 07:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbeFHHnG (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 03:43:06 -0400
Received: from lang.hm ([66.167.227.134]:37489 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbeFHHnF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 03:43:05 -0400
Received: from dlang-laptop ([10.2.0.162])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id w587gs3L027642;
        Fri, 8 Jun 2018 00:42:54 -0700
Date:   Fri, 8 Jun 2018 00:42:54 -0700 (PDT)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@dlang-laptop
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
cc:     David Lang <david@lang.hm>, Philip Oakley <philipoakley@iee.org>,
        =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
In-Reply-To: <20180608061656.GA9383@helen.PLASMA.Xg8.DE>
Message-ID: <nycvar.QRO.7.76.6.1806080040060.4962@qynat-yncgbc>
References: <20180603141801.GA8898@helen.PLASMA.Xg8.DE> <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley> <20180603174617.GA10900@helen.PLASMA.Xg8.DE> <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz> <20180607063225.GA28343@helen.PLASMA.Xg8.DE>
 <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley> <20180607223442.GA5322@helen.PLASMA.Xg8.DE> <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz> <20180607232128.GA5879@helen.PLASMA.Xg8.DE> <alpine.DEB.2.02.1806071651310.27871@nftneq.ynat.uz>
 <20180608061656.GA9383@helen.PLASMA.Xg8.DE>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 8 Jun 2018, Peter Backes wrote:

>> you are the one arguing that the GDPR prohibits Git from storing and
>> revealing this license granting data, not me.
>
> It prohibits publishing, and only after a request to be forgotten. It
> does not prohibit storing your private copy.

Wrong, if you have to delete info, you are not allowed to keep a private copy. 
There is _nothing_ in the GDPR about publishing information, everything in it is 
about what you are allowed to store privately, how you are required to protect 
it (or more precisely, what you are required to do if private data gets hacked), 
and how you are required to keep it available.
