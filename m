X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 12:50:26 -0800
Message-ID: <7vtzzy19t9.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<200612140959.19209.andyparkins@gmail.com>
	<7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
	<200612141136.59041.andyparkins@gmail.com>
	<20061214114546.GI1747@spearce.org> <8764ce6654.wl%cworth@cworth.org>
	<20061214120518.GL1747@spearce.org>
	<Pine.LNX.4.64.0612141251520.18171@xanadu.home>
	<7vy7pa45m8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612141507200.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 20:50:34 +0000 (UTC)
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612141507200.18171@xanadu.home> (Nicolas Pitre's
	message of "Thu, 14 Dec 2006 15:17:19 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34398>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuxXD-0005WE-7L for gcvg-git@gmane.org; Thu, 14 Dec
 2006 21:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751021AbWLNUu2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 15:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWLNUu2
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 15:50:28 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:60152 "EHLO
 fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751021AbWLNUu1 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 15:50:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061214205027.JJXV16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Thu, 14
 Dec 2006 15:50:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ykqe1V00V1kojtg0000000; Thu, 14 Dec 2006
 15:50:39 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

>> That changes what the command does to existing repositories,
>> which is somewhat impolite.
>
> You must be kidding, aren't you?

I am dead serious.  I do not have _any_ issue on existing
repositories with a working tree, but I care deeply about public
distribution points.  See my other message.
