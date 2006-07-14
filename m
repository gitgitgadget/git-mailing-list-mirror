From: Junio C Hamano <junkio@cox.net>
Subject: Re: Kernel headers git tree
Date: Fri, 14 Jul 2006 00:52:10 -0700
Message-ID: <7vy7uwr5cl.fsf@assigned-by-dhcp.cox.net>
References: <1152835150.31372.23.camel@shinybook.infradead.org>
	<1152861620.6977.3.camel@insmouth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Fri Jul 14 09:52:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1ITL-0002o4-RX
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 09:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbWGNHwR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 03:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWGNHwR
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 03:52:17 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:57277 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964803AbWGNHwR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 03:52:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060714075216.GOSM12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Jul 2006 03:52:16 -0400
To: Ian Campbell <ijc@hellion.org.uk>
In-Reply-To: <1152861620.6977.3.camel@insmouth> (Ian Campbell's message of
	"Fri, 14 Jul 2006 08:20:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23880>

Ian Campbell <ijc@hellion.org.uk> writes:

> It might be useful to append the commit checksum from Linus' tree to the
> comments so it is easier to backtrack to the original commit.

Although I am not a kernel person, I can imagine how that would
be useful.

The pre-generated documentation branches in git.git repository
are managed similarly to allow tracking of the branch they
originate from.
