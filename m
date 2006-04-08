From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to create independent branches
Date: Sat, 08 Apr 2006 14:00:14 -0700
Message-ID: <7virpjeqap.fsf@assigned-by-dhcp.cox.net>
References: <20060407184701.GA6686@xp.machine.de>
	<7vr749i48s.fsf@assigned-by-dhcp.cox.net>
	<20060408180244.GA4807@xp.machine.de>
	<7vsloneqtb.fsf@assigned-by-dhcp.cox.net>
	<20060408205747.GT27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 08 23:00:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSKXe-0003dM-10
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 23:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWDHVAR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 17:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWDHVAR
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 17:00:17 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:41103 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932246AbWDHVAP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Apr 2006 17:00:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060408210015.YEBG20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 8 Apr 2006 17:00:15 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060408205747.GT27689@pasky.or.cz> (Petr Baudis's message of
	"Sat, 8 Apr 2006 22:57:47 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18531>

Petr Baudis <pasky@suse.cz> writes:

> Wouldn't it be better to separate it to two distinct public repositories
> as well? It's confusing people and encouraging a practice that really
> isn't very feasible and practical in Git.

That's mainly historical.  I haven't bothered to check it
recently, but /pub/scm/git was not writable by me on kernel.org
machine, only /pub/scm/git/git.git/ was.
