From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add "--sign" option to git-format-patch-script
Date: Fri, 12 Aug 2005 18:05:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508121804240.26333@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0508121532051.25606@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vr7czxj6s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 18:06:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3c1y-0003WG-7k
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 18:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVHLQFL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 12:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVHLQFL
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 12:05:11 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:51874 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751211AbVHLQFK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 12:05:10 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 668CFE259A; Fri, 12 Aug 2005 18:05:09 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4959D9CC79; Fri, 12 Aug 2005 18:05:09 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3794B9972E; Fri, 12 Aug 2005 18:05:09 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 06421E259A; Fri, 12 Aug 2005 18:05:09 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7czxj6s.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 12 Aug 2005, Junio C Hamano wrote:

> Good intentions, but I'd rather see these S-O-B lines in the
> actual commit objects.  Giving format-patch this option would
> discourage people to do so.  Maybe a patch to git commit would
> be more appropriate, methinks.

Maybe in addition to this one? I meant that option to be for on-passers of 
commits they are not author of.

Ciao,
Dscho
