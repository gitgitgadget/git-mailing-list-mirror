Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8671F428
	for <e@80x24.org>; Fri,  7 Sep 2018 17:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeIGVvr (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 17:51:47 -0400
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:54801 "EHLO
        fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeIGVvr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 17:51:47 -0400
Received: from fed1rmimpo306.cox.net ([68.230.241.174])
          by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180907170952.BRWZ4136.fed1rmfepo103.cox.net@fed1rmimpo306.cox.net>
          for <git@vger.kernel.org>; Fri, 7 Sep 2018 13:09:52 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo306.cox.net with cox
        id Yh9s1y00259yGBo01h9sr6; Fri, 07 Sep 2018 13:09:52 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090209.5B92B0E0.0062,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=MJoQoIRl c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=JBFolyDoGHsA:10
 a=lPatIPGQtwYJtXryofoA:9 a=CjuIK1q_8ugA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 9A0EC29A011B;
        Fri,  7 Sep 2018 10:09:51 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
Subject: Re: Mailsplit
Date:   Fri, 07 Sep 2018 10:09:51 -0700
Message-ID: <1628565.fYxLUN5jIU@thunderbird>
Organization: Personal
References: <6663238.U5hdlisbr1@thunderbird>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, September 7, 2018 8:15:43 AM MST Kevin Daudt wrote:
> On Wed, Sep 05, 2018 at 09:17:29PM -0700, Stephen & Linda Smith wrote:
> 
> This is the mailsplit command, and should be executed when running `git
> mailsplit`. What does git --exec-dir return?
> 

The other night when I ran "git mailsplit", I recieved an unknown command 
response.  Since then I have upated to 2.19.0 plush my submitted patches for 
git commit.  With the new build mailsplit is found.

I don't know what was wrong before.



