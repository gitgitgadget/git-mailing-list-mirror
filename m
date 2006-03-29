From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add ALL_LDFLAGS to the git target.
Date: Tue, 28 Mar 2006 16:01:32 -0800
Message-ID: <7vmzfai0f7.fsf@assigned-by-dhcp.cox.net>
References: <7vbqvqjgvi.fsf@assigned-by-dhcp.cox.net>
	<16397.1143590377@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 02:02:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOO8M-0001gy-R4
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 02:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWC2ABh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 19:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWC2ABh
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 19:01:37 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:1787 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964854AbWC2ABg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 19:01:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060329000134.SNSH17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Mar 2006 19:01:34 -0500
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <16397.1143590377@lotus.CS.Berkeley.EDU> (Jason Riedy's message
	of "Tue, 28 Mar 2006 15:59:37 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18144>

Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

> And Junio C Hamano writes:
>  - My preference is to ignore FORTRAN, keep Mark's current rules,
>  - perhaps with a way to turn it off if people really find it
>  - annoying (I do not mind having it always on).

Sorry I forgot to add smiley to the above ;-).
