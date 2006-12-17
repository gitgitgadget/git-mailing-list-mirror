X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] gitweb wishlist and TODO list (part 1)
Date: Sat, 16 Dec 2006 17:47:50 -0800
Message-ID: <7vfybf70op.fsf@assigned-by-dhcp.cox.net>
References: <200612170000.06771.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 17 Dec 2006 01:48:13 +0000 (UTC)
Cc: git@vger.kernel.org, Kernel Org Admin <ftpadmin@kernel.org>,
	Petr Baudis <pasky@suse.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612170000.06771.jnareb@gmail.com> (Jakub Narebski's message
	of "Sun, 17 Dec 2006 00:00:05 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34674>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvl8K-00049M-Kn for gcvg-git@gmane.org; Sun, 17 Dec
 2006 02:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751506AbWLQBsF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 20:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWLQBsF
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 20:48:05 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:65376 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751506AbWLQBsE (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 20:48:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061217014802.NJUW22053.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Sat, 16
 Dec 2006 20:48:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zdo21V01H1kojtg0000000; Sat, 16 Dec 2006
 20:48:03 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> This is yet another series of planned gitweb features. This part
> concentrates on improving gitweb rather than on adding new features.
> Comments appreciated.
>
> Copy send to Kernel.Org admin (which probably is most interested
> in improving gitweb and git performance), and to Petr Baudis which
> maintains repo.or.cz public git hosting site, which runs new(est)
> version of gitweb.

To be honest, I think the 0th item of this wishlist and TODO
list would be to find a sucker^Wvolunteer who will maintain the
gitweb installation at kernel.org, for the message to be of any
interest to kernel.org admins.

