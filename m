From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] gitweb test script
Date: Sun, 06 Aug 2006 14:38:19 -0700
Message-ID: <7vac6h8rzo.fsf@assigned-by-dhcp.cox.net>
References: <20060806165151.GB9548@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 06 23:38:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9qKF-0004zD-H8
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 23:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWHFViV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 17:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWHFViV
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 17:38:21 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:58006 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750723AbWHFViU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Aug 2006 17:38:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060806213820.KMF27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Aug 2006 17:38:20 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <20060806165151.GB9548@moooo.ath.cx> (Matthias Lederhofer's
	message of "Sun, 6 Aug 2006 18:51:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24992>

Matthias Lederhofer <matled@gmx.net> writes:

> Perhaps this script has a place in the git repository.
> Creating some automated tests at least checking for warnings
> should be easy too.  This should work from the git repository
> and makes gitweb use .git as repository.  At the moment it
> still needs the git binary to be in the path already to find
> the top repository directory.

A good start.  We really need something like this.
