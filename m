From: Junio C Hamano <junkio@cox.net>
Subject: Re: Something wrong with pickaxe?
Date: Wed, 18 Jan 2006 19:29:21 -0800
Message-ID: <7v3bjknbe6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0601190004130.15298@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0601181541150.3240@g5.osdl.org>
	<7vwtgxlysf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601181855570.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 04:29:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzQUU-0001Y0-4X
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 04:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWASD3Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 22:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWASD3Z
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 22:29:25 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:9437 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964926AbWASD3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 22:29:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060119032804.TXAM20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 Jan 2006 22:28:04 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601181855570.3240@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 18 Jan 2006 18:59:39 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14880>

Linus Torvalds <torvalds@osdl.org> writes:

> For example, getting the tabs/spaces right is basically impossible with 
> normal cut-and-paste. I assume you do the above inside GNU emacs or some 
> similar special-purpose setup, rather than anything generic.

Ah, that is very very very true.  Sometimes I cut and paste
inside screen and find it annoying to see pasted tabs do not
work properly, so I understand that issue very well.

But most of the time, I always work inside Emacs and rarely step
out if ever.  Thanks for making me realize that.
