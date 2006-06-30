From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-grep: --and to combine patterns with and instead of or
Date: Fri, 30 Jun 2006 13:26:40 -0700
Message-ID: <7vmzbugzjz.fsf@assigned-by-dhcp.cox.net>
References: <7vejx7oa3x.fsf@assigned-by-dhcp.cox.net>
	<E1Fw8hS-00023y-FY@moooo.ath.cx>
	<7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net>
	<E1FwDiI-0007Xp-2s@moooo.ath.cx>
	<7v3bdnkrfb.fsf@assigned-by-dhcp.cox.net>
	<E1FwGgm-0006Nc-9a@moooo.ath.cx>
	<7vejx6k54p.fsf@assigned-by-dhcp.cox.net>
	<E1FwMPf-0005XA-N9@moooo.ath.cx>
	<7vpsgqimu7.fsf@assigned-by-dhcp.cox.net> <e83n97$973$1@sea.gmane.org>
	<E1FwN7M-0007GI-Ng@moooo.ath.cx> <e83p0q$dla$1@sea.gmane.org>
	<7v1wt6ik4x.fsf@assigned-by-dhcp.cox.net> <e83t0m$4s0$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 22:26:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwPZd-0006EP-I4
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 22:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWF3U0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 16:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWF3U0m
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 16:26:42 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:31448 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751126AbWF3U0l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 16:26:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630202641.UVCN554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 16:26:41 -0400
To: jnareb@gmail.com
In-Reply-To: <e83t0m$4s0$2@sea.gmane.org> (Jakub Narebski's message of "Fri,
	30 Jun 2006 21:11:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23016>

Jakub Narebski <jnareb@gmail.com> writes:

> Matthias version is truly more expressive, especially with context limiting
> extension. 

That's orthogonal.  I do not think there is any reason you
cannot make the version whose --near is similar to --and to
understand different ranges for each "neighbor search"
expression using --near=M:N syntax.

Now stop talking and code it up, please ;-).
