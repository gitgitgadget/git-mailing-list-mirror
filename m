X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC (take 2)] gitweb: New improved patchset view
Date: Mon, 30 Oct 2006 15:40:23 -0800
Message-ID: <7vd589tlso.fsf@assigned-by-dhcp.cox.net>
References: <92622.251.qm@web31812.mail.mud.yahoo.com>
	<200610301458.33634.jnareb@gmail.com>
	<7v7iyhv29o.fsf@assigned-by-dhcp.cox.net>
	<200610310032.09726.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 23:40:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610310032.09726.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 31 Oct 2006 00:32:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30555>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gegk1-0007Ro-1h for gcvg-git@gmane.org; Tue, 31 Oct
 2006 00:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161549AbWJ3XkZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 18:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161552AbWJ3XkZ
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 18:40:25 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:51645 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1161549AbWJ3XkY
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 18:40:24 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061030234024.LULA6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 18:40:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gng41V00Y1kojtg0000000 Mon, 30 Oct 2006
 18:40:05 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> By the way, git-ls-tree -z uses TAB as a start of filename, while
> git-diff-tree -z uses NUL as a start of (first) filename. Why?

I do not know a good explanation other than hysterical raisins.
