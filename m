Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8679F1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 13:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJIU2v (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 16:28:51 -0400
Received: from fed1rmfepo201.cox.net ([68.230.241.146]:56768 "EHLO
        fed1rmfepo201.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIU2v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 16:28:51 -0400
Received: from fed1rmimpo109.cox.net ([68.230.241.158])
          by fed1rmfepo201.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20181009131158.INOJ4167.fed1rmfepo201.cox.net@fed1rmimpo109.cox.net>
          for <git@vger.kernel.org>; Tue, 9 Oct 2018 09:11:58 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo109.cox.net with cox
        id lRBx1y00F59yGBo01RBxF0; Tue, 09 Oct 2018 09:11:57 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A09020B.5BBCA91D.007E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=FLWvONgs c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=smKx5t2vBNcA:10 a=WDhBSedXqNQA:10
 a=jMRJoq7ExjWD2RKvYvQA:9 a=CjuIK1q_8ugA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 590CB29A00FC;
        Tue,  9 Oct 2018 06:11:57 -0700 (MST)
From:   Stephen Smith <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: How to handle patch series conflicts
Date:   Tue, 09 Oct 2018 06:11:57 -0700
Message-ID: <3649573.ScJ4RYJQ9R@thunderbird>
Organization: Personal
References: <CACsJy8B1UDN26tWPvOtixSBiFF6bYP2BtK2n1u4W-tWdVeKK1A@mail.gmail.com> <2206767.tHxkKBSiVS@thunderbird>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, October 8, 2018 10:51:09 PM MST Junio C Hamano wrote:

> The scripts themselves having the same name that is no more specific
> tha just "commit" does not bother _me_ personally too much.  If I
> were doing it, unless you are an obsessive type that wants to see
> spanking cleanness everywhere, I'd limit the changes to the minimum.
> 
No I'm not an obsessive type.

sps


