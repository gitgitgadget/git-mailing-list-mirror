X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Sat, 18 Nov 2006 15:14:36 -0800
Message-ID: <7v1wo0bb4z.fsf@assigned-by-dhcp.cox.net>
References: <7v64dcbdgb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 23:14:57 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v64dcbdgb.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 18 Nov 2006 14:24:36 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31811>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlZOY-0000RG-3y for gcvg-git@gmane.org; Sun, 19 Nov
 2006 00:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755351AbWKRXOh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 18:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755354AbWKRXOh
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 18:14:37 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:2534 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1755351AbWKRXOh
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 18:14:37 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061118231436.VIUE4817.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Sat, 18
 Nov 2006 18:14:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id oPE81V00G1kojtg0000000; Sat, 18 Nov 2006
 18:14:09 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

>  - 'pu' has the shallow clone WIP and a half-finished rewrite of
>    git branch in C, both by Johannes.  Both needs a bit more
>    polishing and confidence building before going into 'next',
>    and given the recent discussion of enhancing branch
>    management for pulls/pushes, it might be easier to drop the
>    latter for now.

OOPS; sorry but the latter half is entirely untrue.  What's
there is half-done git-shortlog.  Scratch everything about
branch management please.
