From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [REQ] git-announce mailing list
Date: Wed, 21 Sep 2005 23:40:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509212336460.28874@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.61.0509060457130.29285@lancer.cnet.absolutedigital.net>
 <20050921143231.GA21971@pasky.or.cz> <7vr7bitbzn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 23:43:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EICKh-0007rn-O5
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 23:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVIUVkt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 17:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbVIUVkt
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 17:40:49 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:1699 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965024AbVIUVks (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2005 17:40:48 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5709D13AFE1; Wed, 21 Sep 2005 23:40:47 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3B46CB3792; Wed, 21 Sep 2005 23:40:47 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1DC78B3778; Wed, 21 Sep 2005 23:40:47 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DCA8113AFE1; Wed, 21 Sep 2005 23:40:46 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7bitbzn.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9081>

Hi,

On Wed, 21 Sep 2005, Junio C Hamano wrote:

>  (3) "It is not a good idea because...".

... because at the current stage, changes happen very quickly, and very 
often. Most of the times, you really can only understand what the change 
is about if you

	1) happen to know how git was supposed to work before the change,
and
	2) happen to understand what is being discussed anyway.

I'll feel differently after 1.0 is released, mostly since I know that 
Junio will release it only after git grew up to be stable enough to evolve 
at a much slower pace. I expect mostly merge enhancements and porcelain 
improvements after that.

Ciao,
Dscho
