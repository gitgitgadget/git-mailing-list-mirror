Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D61901F403
	for <e@80x24.org>; Sun,  3 Jun 2018 20:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeFCUwy (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 16:52:54 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41110 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeFCUwx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 16:52:53 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w53KqmTp005335
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 3 Jun 2018 22:52:48 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w53KqmqD005334;
        Sun, 3 Jun 2018 22:52:48 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w53KqY5i013548;
        Sun, 3 Jun 2018 22:52:34 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w53KqXRH013547;
        Sun, 3 Jun 2018 22:52:33 +0200
Date:   Sun, 3 Jun 2018 22:52:33 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180603205233.GA13451@helen.PLASMA.Xg8.DE>
References: <87vab087y2.fsf@evledraar.gmail.com>
 <20180603112557.GA6564@helen.PLASMA.Xg8.DE>
 <87tvqk81qp.fsf@evledraar.gmail.com>
 <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
 <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
 <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <20180603181807.GB1750@thunk.org>
 <20180603191107.GA12182@helen.PLASMA.Xg8.DE>
 <20180603192417.GA12416@helen.PLASMA.Xg8.DE>
 <20180603200739.GC1750@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180603200739.GC1750@thunk.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 03, 2018 at 04:07:39PM -0400, Theodore Y. Ts'o wrote:
> Why don't you try to implement your proposal then, and then benchmark
> it.  After you find out how much of a performance disaster it's going
> to be, especially for large git repos, we can discuss who is being
> tyrannical.

See, Ted, but I have this other hobby project with git stash preserving 
timestamps, which is 90% done but not yet finished. I am a very busy 
person. I might implement it but it's not the topmost priority. Thus, 
first I want to discuss to not waste too much time implementing 
something that's then rejected by valid criticism while that criticms 
could have been raised beforehand. Perhaps I can convince my employer 
to work on it on their account. But there's so much to do at the moment.

I have a PhD, about very complex things like static program analysis by 
abstract interpretation. I love hacking very much but I can mostly only 
do it as a hobby because humanity is better served doing the complex 
things that not every hacker can do.

I know I am being whiny but that's how it is.

But I will take your message as saying you at least don't see any 
obvious criticism leading to complete rejection of the approach.

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
