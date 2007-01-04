From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: How to commit removed file?
Date: Thu, 4 Jan 2007 19:41:19 +0200
Message-ID: <20070104174119.GC2203@mellanox.co.il>
References: <7vwt44pop0.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 04 18:41:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2WaP-00040T-Cm
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 18:41:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbXADRlA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 12:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbXADRlA
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 12:41:00 -0500
Received: from p02c11o141.mxlogic.net ([208.65.145.64]:49540 "EHLO
	p02c11o141.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbXADRlA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 12:41:00 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o141.mxlogic.net (mxl_mta-4.0.1-5)
	with ESMTP id b2c3d954.1988185008.6723.00-016.p02c11o141.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Thu, 04 Jan 2007 10:40:59 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 4 Jan 2007 19:42:26 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu,  4 Jan 2007 19:39:13 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwt44pop0.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 04 Jan 2007 17:42:26.0642 (UTC) FILETIME=[B2E2E320:01C73027]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14914.003
X-TM-AS-Result: No--11.833700-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2006120601)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35940>

> > ...  That's a
> > great news.
> >
> > I am not interested to make it "all" myself -- if somebody else
> > does it, that is fine, though ;-).
> 
> Just in case you do not know me, sorry for too much negative
> tone in my message.  I was just venting. It was not like I was
> offended by something you said or anything like that.
> 
> The "commit path..." feature, while I would even agree that it
> sometimes is useful in simple cases, is something that goes
> quite against what git does normally, and anybody would
> understand why after inspecting what git-commit has to do to
> implement that.  I personally hate that "feature".
> 
> Having said that, I am known to support features that I do not
> agree with myself for other people, and sometimes even implement
> them myself.  But that does not mean I have to like them ;-).

Well, it's just a minor annoyance for me, so unless more people
ask for this to be fixed, I'm unlikely to invest time in this, either.

-- 
MST
