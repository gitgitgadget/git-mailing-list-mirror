From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] show changed tree objects with recursive git-diff-tree
Date: Wed, 25 May 2005 12:18:27 -0700
Message-ID: <7vd5rfktbw.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.62.0505202131520.4397@localhost.localdomain>
	<7vsm0hpbub.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505202025480.2206@ppc970.osdl.org>
	<Pine.LNX.4.62.0505231724270.16151@localhost.localdomain>
	<7vmzqjn7qh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0505250934040.16151@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 21:20:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db1NL-0002BA-3X
	for gcvg-git@gmane.org; Wed, 25 May 2005 21:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVEYTSi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 15:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVEYTSi
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 15:18:38 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:5800 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261535AbVEYTSb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 15:18:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525191827.FLGZ23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 May 2005 15:18:27 -0400
To: Nicolas Pitre <nico@cam.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:

NP> Now there is only the minor inconsistency that the recursive output 
NP> without -t doesn't display tree objects while the non recursive output 
NP> does output tree objects regardless.  Do we care?

Hmph.  I agree, although I do not care about that much myself
enough to start coding right now.  With luck I may have
something by tomorrow morning US Pacific time though.

