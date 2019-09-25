Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA761F463
	for <e@80x24.org>; Wed, 25 Sep 2019 06:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442340AbfIYGwQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 02:52:16 -0400
Received: from giant.haxx.se ([80.67.6.50]:52178 "EHLO giant.haxx.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436671AbfIYGwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 02:52:16 -0400
X-Greylist: delayed 774 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Sep 2019 02:52:15 EDT
Received: from giant.haxx.se (mail [127.0.0.1])
        by giant.haxx.se (8.15.2/8.15.2/Debian-4) with ESMTPS id x8P6dAcV013582
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Sep 2019 08:39:10 +0200
Received: from localhost (dast@localhost)
        by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id x8P6d94p013566;
        Wed, 25 Sep 2019 08:39:09 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
Date:   Wed, 25 Sep 2019 08:39:09 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@giant.haxx.se
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc:     =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        git@sfconservancy.org, Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [PATCH] add a Code of Conduct document
In-Reply-To: <nycvar.QRO.7.76.6.1909241426580.15067@tvgsbejvaqbjf.bet>
Message-ID: <alpine.DEB.2.20.1909250834220.4757@tvnag.unkk.fr>
References: <20190924064454.GA30419@sigill.intra.peff.net> <20190924090152.GA7209@szeder.dev> <nycvar.QRO.7.76.6.1909241426580.15067@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 24 Sep 2019, Johannes Schindelin wrote:

> A CoC can very easily create clarity in such circumstances. By stating 
> explicitly the standards to which we promise to hold ourselves, as well as 
> others. And it can even help those who think of themselves as decent to 
> improve on that front.

As one of the lurking not-really-in-this-project persons around, I just want 
to step out of the shadows for a sec and say:

I think this is totally the right move and I'm a strong +1 on the CoC as 
suggested.

-- 

  / daniel.haxx.se
