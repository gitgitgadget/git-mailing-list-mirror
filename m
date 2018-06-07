Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 854791F517
	for <e@80x24.org>; Thu,  7 Jun 2018 22:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeFGWfF (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 18:35:05 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41284 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbeFGWfE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 18:35:04 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w57MYtJR020993
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Jun 2018 00:34:55 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w57MYtbU020992;
        Fri, 8 Jun 2018 00:34:55 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w57MYhEG005530;
        Fri, 8 Jun 2018 00:34:43 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w57MYgtu005529;
        Fri, 8 Jun 2018 00:34:42 +0200
Date:   Fri, 8 Jun 2018 00:34:42 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     David Lang <david@lang.hm>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180607223442.GA5322@helen.PLASMA.Xg8.DE>
References: <20180603092736.GA5510@helen.PLASMA.Xg8.DE>
 <87vab087y2.fsf@evledraar.gmail.com>
 <20180603112557.GA6564@helen.PLASMA.Xg8.DE>
 <87tvqk81qp.fsf@evledraar.gmail.com>
 <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
 <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
 <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz>
 <20180607063225.GA28343@helen.PLASMA.Xg8.DE>
 <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 07, 2018 at 10:28:47PM +0100, Philip Oakley wrote:
> Some of Peter's fine distinctions may be technically valid, but that does
> not stop there being legal grounds. The proof of copyright is a legal
> grounds.

Again: The GDPR certainly allows you to keep a proof of copyright 
privately if you have it. However, it does not allow you to keep 
publishing it if someone exercises his right to be forgotten.

There is simply no justification for publishing against the explicit 
will of the subject, except for the rare circumstances where there are 
overriding legitimate grounds for doing so. I hardly see those for the 
average author entry in your everyday git repo. Such a justification is 
extremely fragile.

> Unfortunately once one gets into legal nitpicking the wording becomes
> tortuous and helps no-one.

That's not nitpicking. If what you say were true, the GDPR would be 
without any practical validity at all.

> If one starts from an absolute "right to be forgotten" perspective one can
> demand all evidence of wrong doing , or authority to do something, be
> forgotten. The GDPR has the right to retain such evidence.

Yes, but not to keep it published.

> I'll try and comment where I see the distinctions to be.

You're essentially repeating what you already said there.

> Publishing (the meta data) is *distinct* from having it.

Absolutely right. That is my point.

> You either start off public and stay public, or you start off private and
> stay there.

Nope. The GDPR says you have to go from public to private if the 
subject wishes so and there are no overriding legitimate grounds.

That is the entire purpose of the GDPR's right to be forgotten.

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
