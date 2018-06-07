Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7255E1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 23:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeFGXV5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 19:21:57 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41296 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752364AbeFGXV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 19:21:56 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w57NLlx8021167
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Jun 2018 01:21:47 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w57NLlgp021166;
        Fri, 8 Jun 2018 01:21:47 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w57NLT3K005993;
        Fri, 8 Jun 2018 01:21:29 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w57NLTAV005990;
        Fri, 8 Jun 2018 01:21:29 +0200
Date:   Fri, 8 Jun 2018 01:21:29 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     David Lang <david@lang.hm>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180607232128.GA5879@helen.PLASMA.Xg8.DE>
References: <20180603112557.GA6564@helen.PLASMA.Xg8.DE>
 <87tvqk81qp.fsf@evledraar.gmail.com>
 <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
 <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
 <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz>
 <20180607063225.GA28343@helen.PLASMA.Xg8.DE>
 <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley>
 <20180607223442.GA5322@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 07, 2018 at 03:38:49PM -0700, David Lang wrote:
> > Again: The GDPR certainly allows you to keep a proof of copyright
> > privately if you have it. However, it does not allow you to keep
> > publishing it if someone exercises his right to be forgotten.
> someone is granting the world the right to use the code and you are claiming
> that the evidence that they have granted this right is illegal to have?

Hell no! Please read what I wrote:

- "allows you to keep a proof ... privately"
- "However, it does not allow you to keep publishing it"

> And you are incorrect to say that the GDPR lets you keep records privately
> and only applies to publishing them. The GDPR is specifically targeted at
> companies like Facebook and Google that want to keep lots of data privately.
> It does no good to ask Facebook to not publish your info, they don't want to
> publish it in the first place, they want to keep it internally and use it.

How can you misunderstand so badly what I wrote.

Sure the GDPR does not let you keep records privately at will. You 
ultimately need to have overriding legitimate grounds for doing so. 

However, overriding legitimate grounds for keeping private records are 
rarely overriding legitimate grounds for publishing them.

In case of git history metadata, for publishing, you may have consent 
or even legitimate interests, but not overriding legitimate grounds. 
For keeping a private copy of the metadata, your probably have 
overriding legitimate grounds, however.

The GDPR is not an "all or nothing" thing.

Facebook and Google certainly do not have overriding legitimate grounds 
for most of the data they keep privately.

Is it that so hard to understand?

Best wishes
Peter
-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
