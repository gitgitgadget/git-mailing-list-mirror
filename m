From: Junio C Hamano <junkio@cox.net>
Subject: Re: git log is a bit antisocial
Date: Fri, 14 Apr 2006 13:56:24 -0700
Message-ID: <7vlku7q3k7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604141647360.2215@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 14 22:56:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUVLB-0005Xa-8J
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 22:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbWDNU40 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 16:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbWDNU40
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 16:56:26 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:24532 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965160AbWDNU40 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 16:56:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060414205625.IWBF18224.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Apr 2006 16:56:25 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0604141647360.2215@localhost.localdomain> (Nicolas
	Pitre's message of "Fri, 14 Apr 2006 16:50:07 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18701>

Nicolas Pitre <nico@cam.org> writes:

> $  git log -h
> fatal: unrecognized argument: -h
> $ git log --help
> fatal: unrecognized argument: --help
>
> Maybe the usage string could be printed in those cases?

Perhaps.  Alternatively, "git help log", perhaps.
