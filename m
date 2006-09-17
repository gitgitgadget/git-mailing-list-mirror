From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] apply --unidiff-zero: loosen sanity checks for --unidiff=0 patches
Date: Sun, 17 Sep 2006 02:50:44 -0700
Message-ID: <7v64fm6cuj.fsf@assigned-by-dhcp.cox.net>
References: <20060915132225.12040.qmail@a0896f98af57b2.315fe32.mid.smarden.org>
	<7vzmcz6mrq.fsf@assigned-by-dhcp.cox.net>
	<7vsliq7vqr.fsf_-_@assigned-by-dhcp.cox.net>
	<eej12j$36t$2@sea.gmane.org> <7vac4y7u8n.fsf@assigned-by-dhcp.cox.net>
	<eej2s7$97c$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 11:50:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOtIX-0007Ur-Ju
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 11:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWIQJuq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 05:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWIQJuq
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 05:50:46 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:14312 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964803AbWIQJuq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 05:50:46 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917095045.YHSI12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 05:50:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PMqZ1V0021kojtg0000000
	Sun, 17 Sep 2006 05:50:33 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eej2s7$97c$2@sea.gmane.org> (Jakub Narebski's message of "Sun,
	17 Sep 2006 11:01:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27176>

Jakub Narebski <jnareb@gmail.com> writes:

> By the way, could you document this option (usage and manpage), please?

Will not do this late at night.  The list is welcome to come up
with a janotorial patch while I take a nap ;-).
