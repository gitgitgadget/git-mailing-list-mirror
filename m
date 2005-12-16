From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] We do not like "HEAD" as a new branch name
Date: Fri, 16 Dec 2005 12:32:26 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512161231100.28757@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0512151244230.22400@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vacf2p320.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512152339530.4962@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4q5alyms.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512160238300.6530@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xullfct.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 12:34:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnDpD-0005fI-IW
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 12:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbVLPLc3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 06:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVLPLc3
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 06:32:29 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:2282 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751297AbVLPLc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 06:32:28 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0539413FC4C; Fri, 16 Dec 2005 12:32:27 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DE42B9DF3B; Fri, 16 Dec 2005 12:32:26 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CA8F29DEFE; Fri, 16 Dec 2005 12:32:26 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2A32E13FC4C; Fri, 16 Dec 2005 12:32:26 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xullfct.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13734>

Hi,

On Thu, 15 Dec 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Okay. Why not go the full nine yards, and not be difficult about it:
> 
> That's fine.  There is an off-by-one in your code, though.
> I've committed it with a tweak.

Thanks. I did test it (quickly), and t3300 said it was fine. Strange.

Ciao,
Dscho
