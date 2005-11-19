From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Rss produced by git is not valid xml?
Date: Sat, 19 Nov 2005 11:58:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511191156450.12213@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr>
 <20051118200217.GA2831@vrfy.org> <200511182208.24248.ismail@uludag.org.tr>
 <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org> <20051118205513.GA3168@vrfy.org>
 <Pine.LNX.4.64.0511181314470.13959@g5.osdl.org> <Pine.LNX.4.64.0511181338460.13959@g5.osdl.org>
 <437E51EB.7050100@zytor.com> <Pine.LNX.4.64.0511181519100.13959@g5.osdl.org>
 <437E6505.8000201@zytor.com> <437E697C.7090307@op5.se> <437E7E3E.4040303@zytor.com>
 <437EE72A.3050704@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 11:58:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdQQ7-0001jv-7g
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 11:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbVKSK6H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 05:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbVKSK6H
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 05:58:07 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:13747 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751014AbVKSK6F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 05:58:05 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 238191401BE; Sat, 19 Nov 2005 11:58:05 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 03746B525D; Sat, 19 Nov 2005 11:58:05 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CFB44B525B; Sat, 19 Nov 2005 11:58:04 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9A3411401BE; Sat, 19 Nov 2005 11:58:04 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <437EE72A.3050704@op5.se>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12327>

Hi,

On Sat, 19 Nov 2005, Andreas Ericsson wrote:

> Isn't it already? You can install and use any hooks you like after all.

Exactly. All you have to do is provide a recipe for Documentation/howto/. 
Anybody wanting to enforce policy just takes that recipe, adjusts it for 
her needs, and installs the hook.

Hth,
Dscho
