From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Optionally do not list empty directories in git-ls-files --others
Date: Sun, 26 Mar 2006 13:32:31 -0800
Message-ID: <7vslp4q4cw.fsf@assigned-by-dhcp.cox.net>
References: <3afbacad0602270643k9fdd255w8f3769ad77c54e65@mail.gmail.com>
	<20060326142505.GL18185@pasky.or.cz>
	<20060326145952.GM18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, Jim MacBaine <jmacbaine@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 23:33:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNcqz-0002gF-BA
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 23:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWCZVcu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 16:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWCZVcu
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 16:32:50 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:38305 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932132AbWCZVcu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Mar 2006 16:32:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060326213247.NOCK20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 26 Mar 2006 16:32:47 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060326145952.GM18185@pasky.or.cz> (Petr Baudis's message of
	"Sun, 26 Mar 2006 16:59:52 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18059>

Petr Baudis <pasky@suse.cz> writes:

>   it turned out that cg-clean depends on the original behaviour...

Supporting both sounds sensible.
