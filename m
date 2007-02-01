From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [PATCH] add --remote option to git-clone.
Date: Fri, 2 Feb 2007 01:47:06 +0200
Message-ID: <20070201234706.GP17617@mellanox.co.il>
References: <Pine.LNX.4.63.0702020028540.18776@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 02 00:46:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCldd-0000a4-2t
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 00:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbXBAXqm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 18:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbXBAXqm
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 18:46:42 -0500
Received: from p02c11o141.mxlogic.net ([208.65.145.64]:46308 "EHLO
	p02c11o141.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbXBAXql (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 18:46:41 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o141.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id 1eb72c54.2148993968.3726.00-005.p02c11o141.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Thu, 01 Feb 2007 16:46:41 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 2 Feb 2007 01:48:41 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Fri,  2 Feb 2007 01:46:07 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702020028540.18776@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 01 Feb 2007 23:48:41.0643 (UTC) FILETIME=[8092EFB0:01C7465B]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14972.000
X-TM-AS-Result: No--2.231900-4.000000-31
X-Spam: [F=0.1819064760; S=0.181(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38432>

> Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Subject: Re: [PATCH] add --remote option to git-clone.
> 
> Hi,
> 
> would this option not be better named "--branch"?

OK

> Of course, you'd have to 
> support this, too:
> 
> 	$ git clone --branch topic1 --branch topic2 git://...

Why is this useful? and which branch to check out?
One can always get more branches later, is my approach.

-- 
MST
