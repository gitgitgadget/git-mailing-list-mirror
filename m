From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Rss produced by git is not valid xml?
Date: Sun, 20 Nov 2005 02:16:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511200215480.11653@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr>
 <20051118200217.GA2831@vrfy.org> <200511182208.24248.ismail@uludag.org.tr>
 <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org> <20051118205513.GA3168@vrfy.org>
 <Pine.LNX.4.64.0511181314470.13959@g5.osdl.org> <Pine.LNX.4.64.0511181338460.13959@g5.osdl.org>
 <437E51EB.7050100@zytor.com> <Pine.LNX.4.64.0511181520390.13959@g5.osdl.org>
 <7vek5deam6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511181653191.13959@g5.osdl.org>
 <7v7jb57wud.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511190950161.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 02:18:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EddpJ-0007wE-Tv
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 02:17:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVKTBQm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 20:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVKTBQm
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 20:16:42 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:12782 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751131AbVKTBQl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 20:16:41 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4EBBB13FEB7; Sun, 20 Nov 2005 02:16:40 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 364329F37A; Sun, 20 Nov 2005 02:16:40 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0F6C29CC77; Sun, 20 Nov 2005 02:16:40 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9F11313FEB7; Sun, 20 Nov 2005 02:16:39 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511190950161.13959@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12361>

Hi,

On Sat, 19 Nov 2005, Linus Torvalds wrote:

> And text with 8-bit latin1 is almost never valid utf-8. 

I had the impression utf-8 was designed in a way so you could strike 
"almost". But I don't have my docs handy...

Ciao,
Dscho
