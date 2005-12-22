From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] whatchanged: customize diff-tree output
Date: Thu, 22 Dec 2005 23:24:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512222323110.12241@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0512212336230.18908@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvexhr6rc.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0512212245440.4827@g5.osdl.org>
 <Pine.LNX.4.63.0512221200190.7112@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051222210620.GA4679@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 23:24:57 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpYrl-0004eb-FM
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 23:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbVLVWYu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 17:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbVLVWYu
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 17:24:50 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:3261 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030350AbVLVWYt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 17:24:49 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DBCBD13FC1F; Thu, 22 Dec 2005 23:24:48 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C46FB9E3DF; Thu, 22 Dec 2005 23:24:48 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B10689E231; Thu, 22 Dec 2005 23:24:48 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 635E513FC1F; Thu, 22 Dec 2005 23:24:48 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20051222210620.GA4679@steel.home>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13975>

Hi,

On Thu, 22 Dec 2005, Alex Riesen wrote:

> A script from ~user1/bin, which calls git-whatchanged suddenly stops 
> working in ~user2/repo.
> [...]
> 
> Maybe such configuration better left to environment variables?

And that makes the script not stop how?

Ciao,
Dscho
