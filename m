From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH] xdiff shows trivially redundant diff.
Date: Mon, 03 Apr 2006 18:55:43 -0700
Message-ID: <7vslouayu8.fsf@assigned-by-dhcp.cox.net>
References: <7v4q1cmj7l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604021035130.30097@alien.or.mcafeemobile.com>
	<7vzmj3k7x9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604031625330.30048@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 03:56:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQalt-0006k7-8Y
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 03:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWDDBzq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 21:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbWDDBzp
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 21:55:45 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:48356 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751420AbWDDBzp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Apr 2006 21:55:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060404015544.VTDY20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Apr 2006 21:55:44 -0400
To: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.64.0604031625330.30048@alien.or.mcafeemobile.com>
	(Davide Libenzi's message of "Mon, 3 Apr 2006 16:29:16 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18368>

Davide Libenzi <davidel@xmailserver.org> writes:

> This is the change I made to libxdiff. Xregression already made a few
> thousands on iterations w/out problems.

Thanks.  Merged-in and builds fine.
