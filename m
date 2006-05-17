From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git 1.3.2 on Solaris
Date: Wed, 17 May 2006 01:22:55 -0700
Message-ID: <7vwtclhxgg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605161904260.16475@g5.osdl.org>
	<4973.1147836384@lotus.CS.Berkeley.EDU>
	<20060517051505.GD31164@h4x0r5.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 10:23:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgHJ7-00060a-0O
	for gcvg-git@gmane.org; Wed, 17 May 2006 10:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWEQIW5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 04:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWEQIW5
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 04:22:57 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:58084 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932477AbWEQIW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 04:22:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517082256.VYPX15447.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 04:22:56 -0400
To: Ryan Anderson <ryan@michonline.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20169>

Ryan Anderson <ryan@michonline.com> writes:

> The only major tool I can think of that has embedded Perl in the shell
> script is format-patch.  That could probably be redone in pure Perl if
> it would help.

Actually, that one is in the process of migrating all C.
