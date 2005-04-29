From: Junio C Hamano <junkio@cox.net>
Subject: Re: More problems...
Date: Fri, 29 Apr 2005 15:01:02 -0700
Message-ID: <7vy8b12qg1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0504291717360.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Ryan Anderson <ryan@michonline.com>,
	Petr Baudis <pasky@ucw.cz>,
	Russell King <rmk@arm.linux.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 23:56:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRdSE-0000On-Pf
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 23:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263022AbVD2WBG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 18:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbVD2WBG
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 18:01:06 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:39580 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S263022AbVD2WBF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 18:01:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050429220104.XRUL12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Apr 2005 18:01:04 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504291717360.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Fri, 29 Apr 2005 17:27:57 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> If someone does this, they should make a pull.c out of http-pull and
DB> rpull; the logic for determining what you need to copy, given what you
DB> have and what the user wants to have, should be shared.

I agree with your analysis.  I was hoping that that someone
would be you, knowing where http-pull originated ;-).

