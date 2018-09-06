Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6301F404
	for <e@80x24.org>; Thu,  6 Sep 2018 16:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeIFUnI convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 6 Sep 2018 16:43:08 -0400
Received: from fed1rmfepo201.cox.net ([68.230.241.146]:52945 "EHLO
        fed1rmfepo201.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbeIFUnI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 16:43:08 -0400
Received: from fed1rmimpo306.cox.net ([68.230.241.174])
          by fed1rmfepo201.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180906160656.LWSX4167.fed1rmfepo201.cox.net@fed1rmimpo306.cox.net>
          for <git@vger.kernel.org>; Thu, 6 Sep 2018 12:06:56 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo306.cox.net with cox
        id YG6v1y00V59yGBo01G6vM2; Thu, 06 Sep 2018 12:06:56 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090205.5B9150A0.0021,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=MJoQoIRl c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=8nJEP1OIZ-IA:10 a=x7bEGLp0ZPQA:10 a=JBFolyDoGHsA:10 a=kviXuzpPAAAA:8
 a=RWnLtC6b8q7BEvjgEyMA:9 a=wPNLvfGTeEIA:10 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 7994329A0115;
        Thu,  6 Sep 2018 09:06:55 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 0/4] wt-status.c: commitable flag
Date:   Thu, 06 Sep 2018 09:06:55 -0700
Message-ID: <28999379.B3KWMFSn5l@thunderbird>
Organization: Personal
References: <20180906005329.11277-1-ischis2@cox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, September 6, 2018 12:38:55 AM MST Ævar Arnfjörð Bjarmason wrote:
> On Thu, Sep 06 2018, Stephen P. Smith wrote:
> Sometimes you send mail from this address as "Stephen & Linda Smith
> <ischis2@cox.net>", do we also need Linda Smith's Signed-Off-By? :)

My wife and I share one email account.   If I use the GUI email client to 
respond to emails then her name is on the From line (I could edit future 
emails).

When I am submitting patches/updates, I do so under my name since it is 
"Stephen P. Smith" that is creating the patch.   

I've never had anyone ask before.




