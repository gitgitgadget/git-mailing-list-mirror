From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Fri, 13 Jan 2006 12:01:24 -0800
Message-ID: <20060113200124.GO14196@ca-server1.us.oracle.com>
References: <20060112093700.1d3d25db.seanlkml@sympatico.ca> <20060112190031.GH14196@ca-server1.us.oracle.com> <7vhd89mc0y.fsf@assigned-by-dhcp.cox.net> <20060113065855.GJ14196@ca-server1.us.oracle.com> <7vpsmwbo9s.fsf@assigned-by-dhcp.cox.net> <20060113191231.GM14196@ca-server1.us.oracle.com> <7vhd877w9m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 21:05:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExVAk-00061G-5s
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 21:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422939AbWAMUCH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 15:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422905AbWAMUBo
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 15:01:44 -0500
Received: from rgminet01.oracle.com ([148.87.122.30]:17192 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1422920AbWAMUB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 15:01:29 -0500
Received: from rgmsgw01.us.oracle.com (rgmsgw01.us.oracle.com [138.1.186.51])
	by rgminet01.oracle.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id k0DK1OeA013766;
	Fri, 13 Jan 2006 13:01:25 -0700
Received: from rgmsgw01.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0DK1OOa030868;
	Fri, 13 Jan 2006 13:01:24 -0700
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.48.5])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0DK1NXt030856
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Fri, 13 Jan 2006 13:01:24 -0700
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.60)
	(envelope-from <joel.becker@oracle.com>)
	id 1ExV6y-0002xW-Ga; Fri, 13 Jan 2006 12:01:24 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd877w9m.fsf@assigned-by-dhcp.cox.net>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14645>

On Fri, Jan 13, 2006 at 11:39:17AM -0800, Junio C Hamano wrote:
> That's what I do.  Although I use git-am not git-applymbox, both
> of them are designed to work that way.

	While I can see that git-am and git-applymbox have different
options for the same basic task, I can't quite see why one would be
preferred to the other.  What does git-am do that git-applymbox does
not?

Joel

-- 

"I'm so tired of being tired,
 Sure as night will follow day.
 Most things I worry about
 Never happen anyway."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
