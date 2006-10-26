X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-format.txt: Combined diff format documentation supplement
Date: Wed, 25 Oct 2006 23:15:36 -0700
Message-ID: <7vac3jk3g7.fsf@assigned-by-dhcp.cox.net>
References: <ehoo2k$1g6$1@sea.gmane.org>
	<7vejswkoi4.fsf@assigned-by-dhcp.cox.net>
	<200610260544.50614.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 06:15:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610260544.50614.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 26 Oct 2006 05:44:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30140>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcyWj-00074k-E1 for gcvg-git@gmane.org; Thu, 26 Oct
 2006 08:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423427AbWJZGPi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 02:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423428AbWJZGPi
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 02:15:38 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:31170 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1423427AbWJZGPi
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 02:15:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061026061537.XCOS22409.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Thu, 26
 Oct 2006 02:15:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id euFK1V00V1kojtg0000000 Thu, 26 Oct 2006
 02:15:20 -0400
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> So here you have. It should perhaps get review on validity by someone
> well versed in the combined diff generation code. There are some guesses
> here...

Thanks.

I guess review by the original author would be good enough;
this is entirely my code -- it was done while Linus and gang
was having fun in NZ, if I recall correctly ;-).

> It compiles, but the output was not inspected.

I've done minimal asciidoc mark-up fixes.  Troff man output look
horrible but that is not limited to this man page -- it looks
quite wrong whenever numbered list with displayed examples are
used.
