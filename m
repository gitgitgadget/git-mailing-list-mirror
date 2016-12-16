Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A3D91FF6D
	for <e@80x24.org>; Fri, 16 Dec 2016 02:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758995AbcLPCBN (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 21:01:13 -0500
Received: from fed1rmfepo102.cox.net ([68.230.241.144]:51577 "EHLO
        fed1rmfepo102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758990AbcLPCBL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 21:01:11 -0500
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Dec 2016 21:01:11 EST
Received: from fed1rmimpo210.cox.net ([68.230.241.161])
          by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20161216015104.FHIL4150.fed1rmfepo103.cox.net@fed1rmimpo210.cox.net>
          for <git@vger.kernel.org>; Thu, 15 Dec 2016 20:51:04 -0500
Received: from thunderbird.smith.home ([68.231.74.134])
        by fed1rmimpo210.cox.net with cox
        id LRr31u00s2tqoqC01Rr3d9; Thu, 15 Dec 2016 20:51:03 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090203.58534888.0009,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.1 cv=L8+9O7n8 c=1 sm=1 tr=0
 a=/Rt4pg3TtX3KzfzhvVoEow==:117 a=/Rt4pg3TtX3KzfzhvVoEow==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=n5n_aSjo0skA:10 a=ybZZDoGAAAAA:8 a=mxE3G1GSVv1aKpg1R4YA:9 a=CjuIK1q_8ugA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 366F991CAB;
        Thu, 15 Dec 2016 18:51:03 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Allow "git shortlog" to group by committer information
Date:   Thu, 15 Dec 2016 18:51:02 -0700
Message-ID: <3720429.U3o1zloj4W@thunderbird>
User-Agent: KMail/5.2.3 (Linux/4.8.0-30-generic; KDE/5.26.0; x86_64; ; )
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com> <xmqqoa0cu3nn.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, December 15, 2016 5:39:53 PM MST Linus Torvalds wrote:
> On Thu, Dec 15, 2016 at 4:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Sorry, I'll just re-send it without the attachment. I prefer inline
> myself, but I thought you didn't care (and gmail makes it
> unnecessarily hard).
> 
>                 Linus

Why does gmail make it unnecessarily hard?  

I thought that a good percentage of the kernel maintainers use git send-email.   
what would make that command easier to use with gmail?

sps

