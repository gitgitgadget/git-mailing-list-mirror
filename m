From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb wishlist
Date: Wed, 25 May 2005 12:01:19 -0700
Message-ID: <7vvf57ku4g.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org>
	<20050524184612.GA23637@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org>
	<20050524202846.GC25606@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505241410380.2307@ppc970.osdl.org>
	<20050524213102.GB19180@vrfy.org>
	<7vu0ksoxg4.fsf@assigned-by-dhcp.cox.net>
	<20050525123544.GA1420@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 21:05:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db1Aj-0000SU-Hm
	for gcvg-git@gmane.org; Wed, 25 May 2005 21:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVEYTDn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 15:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVEYTDd
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 15:03:33 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:36515 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262370AbVEYTBU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 15:01:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525190120.IXRW20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 May 2005 15:01:20 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050525123544.GA1420@vrfy.org> (Kay Sievers's message of
 "Wed, 25 May 2005 14:35:44 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "KS" == Kay Sievers <kay.sievers@vrfy.org> writes:

KS> gitweb could follow the old filename and show the whole history. :)

Yes, it would work for diff-helper.c, but not for merge-tree.c,
which does not have any equivalent in the tip of the tree.

