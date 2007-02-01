From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: should git push . from:to work?
Date: Thu, 1 Feb 2007 17:05:45 +0200
Message-ID: <20070201150545.GA30858@mellanox.co.il>
References: <Pine.LNX.4.63.0702011559100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 01 16:06:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCdVs-0005wg-Re
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 16:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422921AbXBAPFs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 10:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422919AbXBAPFs
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 10:05:48 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:33076 "EHLO
	dev.mellanox.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422914AbXBAPF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 10:05:27 -0500
Received: from mellanox.co.il ([194.90.237.34])
	by dev.mellanox.co.il (8.13.1/8.13.1) with SMTP id l11F5JiC027991;
	Thu, 1 Feb 2007 17:05:19 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu,  1 Feb 2007 17:05:45 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702011559100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38360>

> Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Subject: Re: should git push . from:to work?
> 
> Hi,
> 
> On Thu, 1 Feb 2007, Michael S. Tsirkin wrote:
> 
> > Should I not be able to use . as a URL?
> > git push seems to think . is a remote, not a URL:
> 
> You seem to be infected by the less-than-intuitive
> "git pull ."-makes-perfect-sense camp.

Not really, I don't really care.

> Why not just do "git branch to from"?

Because I want to update am existing local branch that is different from what
I have checked out.

-- 
MST
