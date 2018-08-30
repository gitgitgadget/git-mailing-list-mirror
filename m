Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2D961F404
	for <e@80x24.org>; Thu, 30 Aug 2018 03:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeH3HSB (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 03:18:01 -0400
Received: from fed1rmfepo102.cox.net ([68.230.241.144]:42620 "EHLO
        fed1rmfepo102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbeH3HSB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 03:18:01 -0400
Received: from fed1rmimpo306.cox.net ([68.230.241.174])
          by fed1rmfepo102.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180830031801.TZEW4225.fed1rmfepo102.cox.net@fed1rmimpo306.cox.net>
          for <git@vger.kernel.org>; Wed, 29 Aug 2018 23:18:01 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo306.cox.net with cox
        id VFJ01y00t59yGBo01FJ1Yl; Wed, 29 Aug 2018 23:18:01 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090211.5B8761E9.0014,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=UICtJGXy c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=dapMudl6Dx4A:10
 a=ipXV0xWuZCcrlNm5sxMA:9 a=CjuIK1q_8ugA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 8D4A729A0093;
        Wed, 29 Aug 2018 20:18:00 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Missing Tagger Entry
Date:   Wed, 29 Aug 2018 20:18:00 -0700
Message-ID: <127981262.iZir1BOX86@thunderbird>
Organization: Personal
References: <2548439.nLQp1kU402@thunderbird>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, August 29, 2018 7:43:05 PM MST Ramsay Jones wrote:
> 
> Hope this helps.
> 
> ATB,
> Ramsay Jones

I was working on the patch for wt-status.c and thought I screwed up my git 
database.  So I ran fsck and ran into the tag issue.

Thanks
sps




