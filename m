Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAF6D1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 19:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeFCTYd (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 15:24:33 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41084 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeFCTYc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 15:24:32 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w53JOSkS005033
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 3 Jun 2018 21:24:28 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w53JOSnt005032;
        Sun, 3 Jun 2018 21:24:28 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w53JOHGo012521;
        Sun, 3 Jun 2018 21:24:17 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w53JOHBx012520;
        Sun, 3 Jun 2018 21:24:17 +0200
Date:   Sun, 3 Jun 2018 21:24:17 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180603192417.GA12416@helen.PLASMA.Xg8.DE>
References: <87y3hlecod.fsf@evledraar.gmail.com>
 <20180603092736.GA5510@helen.PLASMA.Xg8.DE>
 <87vab087y2.fsf@evledraar.gmail.com>
 <20180603112557.GA6564@helen.PLASMA.Xg8.DE>
 <87tvqk81qp.fsf@evledraar.gmail.com>
 <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
 <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
 <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <20180603181807.GB1750@thunk.org>
 <20180603191107.GA12182@helen.PLASMA.Xg8.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180603191107.GA12182@helen.PLASMA.Xg8.DE>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Addendum:

I one discussed with a philosopher the question: What is your argument 
against libertarianism?

He said: It would be a tyranny of lawyers.

Let's not have a tyranny of lawyers. Let us, the engineers and hackers, 
exercise the necessary control over those pesky lawyers by defining and 
redefining the state of the art in technology, and prevent them from 
defining it by themselves. For a hammer, everything looks like a nail. 
What is the better options: To suggest people to pay for legal advice 
by lawyers, who only offer lengthy disclaimers and such for bypassing 
the right to be forgotten, or simply discuss technical changes for git 
which enable its easy implementation, without legal excuses for not 
doing supporting it?

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
