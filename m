From: Junio C Hamano <junkio@cox.net>
Subject: Re: Log message printout cleanups
Date: Mon, 17 Apr 2006 17:37:40 -0700
Message-ID: <7v7j5nk9bf.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604161433000.3701@g5.osdl.org>
	<7vbqv1oxie.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604171149330.3701@g5.osdl.org>
	<7vodyzkehq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604171647380.3701@g5.osdl.org>
	<7vejzvka09.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 02:37:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVeE0-00022w-KO
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 02:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWDRAhn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 20:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWDRAhm
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 20:37:42 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:42729 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932083AbWDRAhm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Apr 2006 20:37:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060418003741.ESGB16517.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 17 Apr 2006 20:37:41 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <7vejzvka09.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 17 Apr 2006 17:22:46 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18844>

 Linus Torvalds <torvalds@osdl.org> writes:

> I realize that Dscho has been looking at some much "fancier" merge 
> diffstats, but I really do believe that the "what got merged" difference 
> to the original branch (ie parent 1) is what you want in practice.

These days I find myself running "git log --stat" more often
than "git whatchanged"; it looks so much nicer ;-).

Thanks for a job well done.
