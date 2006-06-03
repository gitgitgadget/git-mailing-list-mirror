From: Junio C Hamano <junkio@cox.net>
Subject: Re: http-fetch troubles
Date: Fri, 02 Jun 2006 18:24:48 -0700
Message-ID: <7virnj9gkf.fsf@assigned-by-dhcp.cox.net>
References: <20060601232437.GD12261@reactrix.com>
	<7vhd34dptq.fsf@assigned-by-dhcp.cox.net>
	<7vac8vbgqg.fsf_-_@assigned-by-dhcp.cox.net>
	<1C422237-D48C-4A30-9BDD-5C165222873D@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Sat Jun 03 03:25:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmKsw-0005gU-9q
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 03:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWFCBYu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 21:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWFCBYu
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 21:24:50 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:61147 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030359AbWFCBYt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 21:24:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060603012449.HWFU5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Jun 2006 21:24:49 -0400
To: Becky Bruce <Becky.Bruce@freescale.com>
In-Reply-To: <1C422237-D48C-4A30-9BDD-5C165222873D@freescale.com> (Becky
	Bruce's message of "Fri, 2 Jun 2006 20:13:12 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21182>

Becky Bruce <Becky.Bruce@freescale.com> writes:

> Woohoo!  The stuff you moved to master (which is what I was building
> from, not "next", as Nick pointed out) has fixed the git-http-fetch
> segfault problem I was seeing.
>
> Thanks!

Thanks Nick for fixing, and Becky for confirming.

... and I take all the credit ;-).

I haven't pushed it out yet, but I believe "next" is also good
to go.
