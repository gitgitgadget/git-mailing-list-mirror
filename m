X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Document git-diff whitespace flags -b and -w
Date: Sun, 03 Dec 2006 18:20:30 -0800
Message-ID: <7vvekstn9t.fsf@assigned-by-dhcp.cox.net>
References: <11651630814064-git-send-email-jnareb@gmail.com>
	<Pine.LNX.4.63.0612031908020.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<ekv5k6$1ih$1@sea.gmane.org>
	<Pine.LNX.4.63.0612032006580.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 02:21:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612032006580.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 3 Dec 2006 20:10:10 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33159>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr3SI-0005pq-QV for gcvg-git@gmane.org; Mon, 04 Dec
 2006 03:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758768AbWLDCVK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 21:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758795AbWLDCVK
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 21:21:10 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:15783 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1758768AbWLDCVJ
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 21:21:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061204022031.BWXM7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Sun, 3
 Dec 2006 21:20:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id uSLg1V00F1kojtg0000000; Sun, 03 Dec 2006
 21:20:40 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> make tests pass for recent "diff -b" change

Both patches look sane.  Thanks.  Mind if I forge your
signature?

> 	Am I the only one finding it funny to read diffs of diffs, 
> 	especially when being used to combined diffs?

I agree that it is very hard to get used to.
