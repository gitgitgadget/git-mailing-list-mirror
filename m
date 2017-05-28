Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D324E20D0A
	for <e@80x24.org>; Sun, 28 May 2017 10:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750986AbdE1Kjy (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 06:39:54 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:50520 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbdE1Kjx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 06:39:53 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id EvbzdzMIKcpskEvbzd1TzV; Sun, 28 May 2017 11:39:52 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=Q9fys5e9bTEA:10 a=pGLkceISAAAA:8
 a=ZopTJbMfCDBpo1aPunkA:9 a=PUjeQqilurYA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <ABE60A6489CD42CFA43B9F5E946D8735@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Kaartic Sivaraam" <kaarticsivaraam91196@gmail.com>,
        <git@vger.kernel.org>
References: <1495955737.4716.3.camel@gmail.com> <1495956144.4716.5.camel@gmail.com>
Subject: Re: Missing: Consistency of clean state output of "git add -i"
Date:   Sun, 28 May 2017 11:39:49 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="ISO-8859-15";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfFp9rACUU5ljfb9sj+3wzpC3DKBOVMJ0Q482XBkaJ0fh2oNks4EGI0ObYsDCTGJWNiUYGioMO4xCJr7v6tcDagU/re33MPIpNQK8lwwyGJVEbQHh8xuz
 dfjLhgii0+fS+L87RS7qA700U30jS0LwH5B6LZdpZmm3joFjj+Ru1dCtW068DFoEMW+rGAtpbtropbLe/taVH0N+R2UoninrUMs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Kaartic Sivaraam" <kaarticsivaraam91196@gmail.com>
>I guess I'll take back my note in the previous email that says, I could
> help. I saw the implementation and found that I couldn't help as I
> don't have experience with PERL. My bad.

I wouldn't let that stop you. We were all ignorant once.
I know little of tcl (gitk/git-gui), but I've still managed to fix a couple 
of issues, with the help of others on the list (and the search engines and 
their results;-)

Perl is *that* hard, is it?

regards
Philip 

