From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] First cut at libifying revlist generation
Date: Sat, 25 Feb 2006 19:40:30 -0800
Message-ID: <7vwtfi6b4h.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602251608160.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 26 04:40:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDClx-0000Us-Nn
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 04:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWBZDkd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Feb 2006 22:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWBZDkd
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Feb 2006 22:40:33 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:43663 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751192AbWBZDkc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2006 22:40:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060226033902.YKMK20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Feb 2006 22:39:02 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602251608160.22647@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 25 Feb 2006 16:19:46 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16769>

Linus Torvalds <torvalds@osdl.org> writes:

> This really just splits things up partially, and creates the
> interface to set things up by parsign the command line.

Sorry, I'll keep this but I ended up wasting the whole day
setting up a new machine for my wife (a windows box).  The next
task would be to install Cygwin so I can have fun with git...
