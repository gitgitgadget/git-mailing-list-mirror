From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Sun, 05 Mar 2006 02:10:49 -0800
Message-ID: <7vy7zpgq1i.fsf@assigned-by-dhcp.cox.net>
References: <7vacc5jza6.fsf@assigned-by-dhcp.cox.net>
	<46a038f90603050121u6bccbb71ve78de69ae45b96ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 05 11:11:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFqDC-0006h5-Q9
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 11:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbWCEKKw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 05:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752239AbWCEKKw
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 05:10:52 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:51681 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1752216AbWCEKKv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 05:10:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060305100802.VHAX17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Mar 2006 05:08:02 -0500
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90603050121u6bccbb71ve78de69ae45b96ad@mail.gmail.com>
	(Martin Langhoff's message of "Sun, 5 Mar 2006 22:21:46 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17216>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> I'm somewhat confused by the fact that there are two emacs modes, both
> by Alexandre. Which one should I use? Also -- the killer app for
> emacs+git would be to leverage the great patch-editing mode in emacs.

They are different styles.  I've been in VC camp but my
understanding is pcl-cvs style integration is closer to
whole-tree than VC which is more per-file.  I still haven't
adjusted to pcl-cvs style yet..

> (of course, if xxdiff and others can help, that'd be cool too, but
> currently they seem strangely unable to deal with files with diff3
> conflict markers.)

I had pleasant experiences with "xxdiff -U".
