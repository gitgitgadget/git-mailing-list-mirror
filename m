From: Junio C Hamano <junkio@cox.net>
Subject: Re: Remote git-cat-file?
Date: Sun, 28 May 2006 10:38:12 -0700
Message-ID: <7vu07acanv.fsf@assigned-by-dhcp.cox.net>
References: <loom.20060528T002420-957@post.gmane.org>
	<Pine.LNX.4.64.0605271727110.5623@g5.osdl.org>
	<loom.20060528T124835-757@post.gmane.org> <e5c3c5$i47$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 28 19:38:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkPDU-0006qx-Mr
	for gcvg-git@gmane.org; Sun, 28 May 2006 19:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWE1RiO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 13:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWE1RiO
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 13:38:14 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:26509 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750823AbWE1RiN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 May 2006 13:38:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060528173813.MWKG27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 28 May 2006 13:38:13 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e5c3c5$i47$1@sea.gmane.org> (Jakub Narebski's message of "Sun,
	28 May 2006 14:00:21 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20883>

Jakub Narebski <jnareb@gmail.com> writes:

> It would be nice I think to be able to have remote alternatives,...

Yup, I think I've mentioned that one as one of "the mostly
unimplementable but would be very nice to have crazy wishlist
items" some time ago.  What people would want is not a "shallow"
clone, but a "lazy" clone, and in the ideal world that would
obviously be a nice thing to have.
