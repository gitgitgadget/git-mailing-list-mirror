From: Junio C Hamano <junkio@cox.net>
Subject: More Porcelains?
Date: Mon, 26 Sep 2005 17:43:46 -0700
Message-ID: <7v64sn8hml.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050926175156.GB9410@reactrix.com>
	<20050926182341.GA26340@pasky.or.cz>
	<7v3bnrh85g.fsf@assigned-by-dhcp.cox.net>
	<20050927001542.GC15615@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 02:44:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK3Za-00055y-0j
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 02:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVI0Anu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 20:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVI0Anu
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 20:43:50 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:40398 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932077AbVI0Ant (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 20:43:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050927004347.GJSC29747.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Sep 2005 20:43:47 -0400
To: git@vger.kernel.org
In-Reply-To: <20050927001542.GC15615@reactrix.com> (Nick Hengeveld's message
	of "Mon, 26 Sep 2005 17:15:42 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9358>

Nick Hengeveld <nickh@reactrix.com> writes:

> Good point - use of environment variables is more consistent.  Use of
> command-line arguments is a bit more convenient in my case since I'm
> driving the transfer from a perl script, but I suppose consistency is
> more important...

Now you made me curious.

How many of you are working on your own Porcelains, announced or
unannounced?  I know about Cogito and StGIT ;-).  In a distant
past I have heard of something called JIT but I think it is now
defunct.  Matthias Urlichs said he is doing something with
Python.  Anybody else?
