X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Minor grammar fixes for git-diff-index.txt
Date: Wed, 25 Oct 2006 11:42:36 -0700
Message-ID: <7vfydcb5k3.fsf@assigned-by-dhcp.cox.net>
References: <200610251549.34193.andyparkins@gmail.com>
	<200610251602.42433.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 18:42:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610251602.42433.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 25 Oct 2006 16:02:38 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30090>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcni5-0007NQ-8c for gcvg-git@gmane.org; Wed, 25 Oct
 2006 20:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932280AbWJYSmi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 14:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWJYSmi
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 14:42:38 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:57793 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S932280AbWJYSmh
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 14:42:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025184237.DFL6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 14:42:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id eiiK1V00f1kojtg0000000 Wed, 25 Oct 2006
 14:42:20 -0400
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> From 9f5b5b3d4925ac5f22a64fd075c50417cff7b496 Mon Sep 17 00:00:00 2001
> From: Andy Parkins <andyparkins@gmail.com>
> Date: Wed, 25 Oct 2006 15:59:53 +0100
> Subject: [PATCH] Minor grammar fixes for git-diff-index.txt
> To: git@vger.kernel.org

We do not want these in-body.

>
> "what you are going to commit is" doesn't need the "is" and does need a comma.
>
> "can trivially see" is an unecessary split infinitive and "easily" is a more
> appropriate adverb.
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>
> ---
> This corrects the previous grammar patch - the original use of "where" was 
> correct.  You know when you say a word enough and it loses all meaning...
>
>  Documentation/git-diff-index.txt |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-diff-index.txt 
> b/Documentation/git-diff-index.txt
> index 9cd43f1..2df581c 100644
> --- a/Documentation/git-diff-index.txt
> +++ b/Documentation/git-diff-index.txt
> @@ -54,7 +54,7 @@ If '--cached' is specified, it allows yo
>  
>  For example, let's say that you have worked on your working directory, 
> updated

Please check who wrapped this line and correct it.  Most likely
your MUA.
