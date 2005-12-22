From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git /objects directory created 755 by default?
Date: Thu, 22 Dec 2005 17:03:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512221700310.18982@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
 <7vacevgwqr.fsf@assigned-by-dhcp.cox.net> <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vek465cev.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de>
 <43AA75D1.7040009@op5.se> <Pine.LNX.4.63.0512221220220.7112@wbgn013.biozentrum.uni-wuerzburg.de>
 <43AA9BE6.7000601@op5.se> <Pine.LNX.4.63.0512221530570.18551@wbgn013.biozentrum.uni-wuerzburg.de>
 <43AACBE9.7060201@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 17:03:57 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpSuw-0005tw-Az
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 17:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbVLVQDn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 11:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVLVQDn
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 11:03:43 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:45959 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932433AbVLVQDm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 11:03:42 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7A98413FC8F; Thu, 22 Dec 2005 17:03:41 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6031D9E38A; Thu, 22 Dec 2005 17:03:41 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4A1449E231; Thu, 22 Dec 2005 17:03:41 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 27CEE13FC8F; Thu, 22 Dec 2005 17:03:41 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43AACBE9.7060201@op5.se>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13953>

Hi,

this is getting silly. The problem is: how to setup a shared repository, 
i.e. a repository into which different users can push their updates.

Yes, I can work around the fact that git (in its current official version) 
does not have an option to make that happen.

It is just awfully cumbersome. And that is what good software should 
prevent. Especially if it is *that* easy.

Hth,
Dscho
