From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detect renames in diff family.
Date: Thu, 19 May 2005 14:44:59 -0700
Message-ID: <7vll6ayjok.fsf@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7v4qcz16n6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0505191426000.20274@localhost.localdomain>
	<7vsm0jyryf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0505191456040.20274@localhost.localdomain>
	<7vy8abx8ay.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0505191643030.20274@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 23:47:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYspJ-000139-4B
	for gcvg-git@gmane.org; Thu, 19 May 2005 23:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVESVpe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 17:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVESVpd
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 17:45:33 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:20950 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261270AbVESVpG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 17:45:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050519214458.XTCX22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 May 2005 17:44:58 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.62.0505191643030.20274@localhost.localdomain> (Nicolas
 Pitre's message of "Thu, 19 May 2005 16:48:13 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:

NP> Are we talking about git plumbing or porcelain here?

We are talking about the Plumbing.  Thank you for reminding me,
but sometimes people end up using the bare Plumbing.

As I stated before, I do not do Porcelain [*1*]; my main
interest lies in helping Linus and Linux Kernel development
process, by helping him in the Plumbing area and making the use
of bare Plumbing layer a confortable enough experience.

My ultimate goal is to make the Plumbing useful enough to make
what Porcelain layers do more or less irrelevant ;-).

[Footnote]

*1* Yes I do have my own Porcelain layer, and personally I feel
some of the things it does and some of the approaches it takes
are quite good, but I do not advocate it more than necessary on
this list.

