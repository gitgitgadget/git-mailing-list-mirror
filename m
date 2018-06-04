Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 290371F403
	for <e@80x24.org>; Mon,  4 Jun 2018 18:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbeFDSvU (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 14:51:20 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41162 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbeFDSvT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 14:51:19 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w54IpCL3009119
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 4 Jun 2018 20:51:12 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w54IpCbn009118;
        Mon, 4 Jun 2018 20:51:12 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w54IMDXC025604;
        Mon, 4 Jun 2018 20:22:13 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w54IMCCV025603;
        Mon, 4 Jun 2018 20:22:12 +0200
Date:   Mon, 4 Jun 2018 20:22:12 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180604182212.GA25492@helen.PLASMA.Xg8.DE>
References: <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
 <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <20180603181807.GB1750@thunk.org>
 <20180603191107.GA12182@helen.PLASMA.Xg8.DE>
 <20180603192417.GA12416@helen.PLASMA.Xg8.DE>
 <20180603200739.GC1750@thunk.org>
 <20180603205233.GA13451@helen.PLASMA.Xg8.DE>
 <20180603210344.GF1750@thunk.org>
 <20180603221616.GA14636@helen.PLASMA.Xg8.DE>
 <20180604134718.GA7198@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604134718.GA7198@thunk.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 04, 2018 at 09:47:18AM -0400, Theodore Y. Ts'o wrote:
> For people who are doing real work on git repos, other commands that
> we very much care about include "git log --author=<authorname>", "git
> tag --contains", "git blame", etc.

I do not see how those, or anything but git clone (and even that only 
if author verification is requested) could possibly be affected in any 
significant way.

Best wishes
Peter


-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
