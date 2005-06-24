From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Fri, 24 Jun 2005 15:45:34 -0700
Message-ID: <20050624224534.GF31165@ca-server1.us.oracle.com>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Mackall <mpm@selenic.com>, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
X-From: git-owner@vger.kernel.org Sat Jun 25 00:41:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dlwre-0005tX-4b
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 00:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbVFXWrl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 18:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbVFXWrl
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 18:47:41 -0400
Received: from agminet04.oracle.com ([141.146.126.231]:2837 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S263067AbVFXWqd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2005 18:46:33 -0400
Received: from rgmgw1.us.oracle.com (rgmgw1.us.oracle.com [138.1.191.10])
	by agminet04.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id j5OMkEUl003289;
	Fri, 24 Jun 2005 17:46:15 -0500
Received: from rgmgw1.us.oracle.com (localhost [127.0.0.1])
	by rgmgw1.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id j5OMkE1L007202;
	Fri, 24 Jun 2005 16:46:14 -0600
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.118.41])
	by rgmgw1.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id j5OMkEfZ007195;
	Fri, 24 Jun 2005 16:46:14 -0600
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.51)
	id 1DlwvW-0007TP-BN; Fri, 24 Jun 2005 15:45:34 -0700
To: Petr Baudis <pasky@ucw.cz>
Mail-Followup-To: Petr Baudis <pasky@ucw.cz>,
	Matt Mackall <mpm@selenic.com>, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
Content-Disposition: inline
In-Reply-To: <20050624064101.GB14292@pasky.ji.cz>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 24, 2005 at 08:41:01AM +0200, Petr Baudis wrote:
> Theoretically, dotest should work just fine even if you use Cogito.
> Anyone tested it?

	When I update the OCFS2 git tree, I clone with Cogito and patch
with dotest.  Been doing it for a month or two, no problems.

Joel

-- 

"I think it would be a good idea."  
        - Mahatma Ghandi, when asked what he thought of Western
          civilization

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
