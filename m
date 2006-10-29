X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Swap the porcelain and plumbing commands in the git man page
Date: Sun, 29 Oct 2006 12:47:27 -0800
Message-ID: <7v1woq26jk.fsf@assigned-by-dhcp.cox.net>
References: <20061029200940.11233.20277.stgit@lathund.dewire.com>
	<20061029200948.11233.27482.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 20:47:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30458>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeHZ7-0001Bs-Ih for gcvg-git@gmane.org; Sun, 29 Oct
 2006 21:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030197AbWJ2Ur3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 15:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWJ2Ur3
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 15:47:29 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:29646 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1030197AbWJ2Ur2
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 15:47:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061029204728.WCZZ22409.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Sun, 29
 Oct 2006 15:47:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id gLnY1V00Q1kojtg0000000 Sun, 29 Oct 2006
 15:47:32 -0500
To: Robin Rosenberg <robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org

Thanks for these two.  Applied.

By the way, people who run "next" may want to view:

	git pickaxe -M v1.4.0.. -- Documentaiton/git.txt

and marvel at Linus's genius ;-).
