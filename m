From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Sat, 12 Aug 2006 19:21:30 -0700
Message-ID: <7v7j1dnzo5.fsf@assigned-by-dhcp.cox.net>
References: <200608071626.52655.jnareb@gmail.com> <ebln1v$s6j$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 13 04:22:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GC5bv-00010x-O9
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 04:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbWHMCVc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Aug 2006 22:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbWHMCVc
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Aug 2006 22:21:32 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:4235 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932662AbWHMCVc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Aug 2006 22:21:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060813022131.OUVY6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 12 Aug 2006 22:21:31 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25273>

Jakub Narebski <jnareb@gmail.com> writes:

> I have series of gitweb patches to send: should I make them pre-rename, or
> post-rename?

Do people happy with the general naming guidelines (I am)?

I'll be pushing out 1.4.2 this weekend, and then moving all the
gitweb stuff pending in "next" to "master" after that.

Let's have the rename immediately on top of it first, then
continue cleaning up after that.
