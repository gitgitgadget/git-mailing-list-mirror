From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [ANNOUNCE] GIT 0.99.7b
Date: Fri, 23 Sep 2005 13:52:42 -0700
Message-ID: <20050923205242.GY27375@ca-server1.us.oracle.com>
References: <7voe6ki9x7.fsf@assigned-by-dhcp.cox.net> <dh0uur$h4g$1@sea.gmane.org> <7v8xxnbjhl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 22:53:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIuXM-00051B-8s
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 22:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVIWUwt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 16:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVIWUwt
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 16:52:49 -0400
Received: from rgminet02.oracle.com ([148.87.122.31]:61385 "EHLO
	rgminet02.oracle.com") by vger.kernel.org with ESMTP
	id S1751143AbVIWUwt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 16:52:49 -0400
Received: from rgmsgw03.us.oracle.com (rgmsgw03.us.oracle.com [138.1.186.53])
	by rgminet02.oracle.com (Switch-3.1.6/Switch-3.1.7) with ESMTP id j8NKqhTN027655;
	Fri, 23 Sep 2005 14:52:43 -0600
Received: from rgmsgw03.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw03.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id j8NKqgMb029539;
	Fri, 23 Sep 2005 14:52:42 -0600
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.118.41])
	by rgmsgw03.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id j8NKqgKg029534
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Fri, 23 Sep 2005 14:52:42 -0600
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.52)
	id 1EIuXC-0006aI-3E; Fri, 23 Sep 2005 13:52:42 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xxnbjhl.fsf@assigned-by-dhcp.cox.net>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9202>

On Fri, Sep 23, 2005 at 01:46:14PM -0700, Junio C Hamano wrote:
> If you pulled from "master" branch, then --version would still
> say 0.99.7; I agree it is confusing.  On the other hand, I do
> not think we would want to increment the version string with
> every little changes, so...

	Every little change, no.  But ANNOUNCEd releases should be
considered 'major' from this point of view.  I don't think a little
extra version number incrementing is too big a deal.

Joel

-- 

Life's Little Instruction Book #451

	"Don't be afraid to say, 'I'm sorry.'"

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
