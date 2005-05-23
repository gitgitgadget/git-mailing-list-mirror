From: Junio C Hamano <junkio@cox.net>
Subject: Re: cogito - how do I ???
Date: Mon, 23 May 2005 09:34:55 -0700
Message-ID: <7v1x7x7vf4.fsf@assigned-by-dhcp.cox.net>
References: <20050521214700.GA18676@mars.ravnborg.org>
	<2765.10.10.10.24.1116713164.squirrel@linux1>
	<Pine.LNX.4.58.0505211635440.2206@ppc970.osdl.org>
	<20050523071919.GG23388@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505230731430.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Sean <seanlkml@sympatico.ca>, Sam Ravnborg <sam@ravnborg.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 18:35:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaFs7-0008MN-BU
	for gcvg-git@gmane.org; Mon, 23 May 2005 18:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVEWQe6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 12:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVEWQe6
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 12:34:58 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:38608 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261906AbVEWQe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 12:34:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050523163454.ZQVQ12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 May 2005 12:34:54 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505230731430.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 23 May 2005 07:35:47 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> ..., and we can (and probably should) order rev-tree output 
LT> with some topological sort based on the commit tree.

Seconded.

