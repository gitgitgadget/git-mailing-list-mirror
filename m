From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add specialized object allocator
Date: Mon, 19 Jun 2006 12:44:07 -0700
Message-ID: <7vejxl9bi0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606191028540.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 19 21:44:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsPfQ-0007IT-7h
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 21:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWFSToJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 15:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWFSToJ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 15:44:09 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:8868 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964859AbWFSToI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 15:44:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060619194407.CTEC19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Jun 2006 15:44:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606191028540.5498@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 19 Jun 2006 10:44:15 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22135>

Impressed.  I wonder if we want to deal with any_object
structure as well.
