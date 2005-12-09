From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb.cgi in C
Date: Thu, 08 Dec 2005 23:33:55 -0800
Message-ID: <7vhd9i9124.fsf@assigned-by-dhcp.cox.net>
References: <43988299.4090101@tiscali.cz> <20051208222759.GO22159@pasky.or.cz>
	<7vfyp3b4ki.fsf@assigned-by-dhcp.cox.net>
	<20051208224626.GP22159@pasky.or.cz>
	<7vhd9j9k3e.fsf@assigned-by-dhcp.cox.net>
	<86irtyank4.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 08:34:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkclU-0006iP-Ms
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 08:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVLIHd5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 02:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVLIHd5
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 02:33:57 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:52440 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932405AbVLIHd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2005 02:33:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051209073241.FOEJ17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Dec 2005 02:32:41 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13416>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
>
> Junio> Yes, that is exactly what I meant by what Smurf is working on --
> Junio> libified git with Pyrex.
>
> Pyrex?  not XS?  I'd like to see Perl "use Git;". :)

OK, for the record I should mention that I first suggested using
Swig, to be neutral across perl/python/tcl.  BTW, this list is
merely alphabetical not suggesting the order of my preference
;-).
