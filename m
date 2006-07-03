From: Junio C Hamano <junkio@cox.net>
Subject: contrib/ status
Date: Sun, 02 Jul 2006 19:13:59 -0700
Message-ID: <7vmzbrwi3c.fsf_-_@assigned-by-dhcp.cox.net>
References: <200607030156.50455.jnareb@gmail.com>
	<200607030202.55919.jnareb@gmail.com>
	<7vodw7zgt2.fsf@assigned-by-dhcp.cox.net> <e89ock$gks$1@sea.gmane.org>
	<7vslljwiat.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 03 04:14:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxDws-0005qx-AL
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 04:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWGCCOB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 22:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWGCCOA
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 22:14:00 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:57072 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751011AbWGCCOA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 22:14:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060703021400.HGZB27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Jul 2006 22:14:00 -0400
To: git@vger.kernel.org
In-Reply-To: <7vslljwiat.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 02 Jul 2006 19:09:30 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23150>

Junio C Hamano <junkio@cox.net> writes:

> ... the
> things under contrib/ are not part of git.git but are there only
> for convenience....

This reminds me of something quite different.  I am getting an
impression that enough people have been helped by git-svn and it
might be a good idea to have it outside contrib/ area.

OTOH I haven't seen much interest in contrib/colordiff, now
Johannes's built-in "diff --color" is in.  So if people do not
mind, I'd like to drop it.
