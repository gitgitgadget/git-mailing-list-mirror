From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Comments on recursive merge..
Date: Wed, 9 Nov 2005 00:18:56 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511090017370.28256@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
 <20051107225807.GA10937@c165.ib.student.liu.se> <7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
 <Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051108210211.GA23265@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081351020.3247@g5.osdl.org>
 <20051108223609.GA4805@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081450080.3247@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 00:21:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZck8-0006Po-Rp
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 00:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbVKHXS7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 18:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbVKHXS7
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 18:18:59 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:2464 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030217AbVKHXS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 18:18:58 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5C8CBE25DD; Wed,  9 Nov 2005 00:18:57 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3B1909F1E0; Wed,  9 Nov 2005 00:18:57 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 266F18A825; Wed,  9 Nov 2005 00:18:57 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E709DE25DD; Wed,  9 Nov 2005 00:18:56 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511081450080.3247@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11367>

Hi,

On Tue, 8 Nov 2005, Linus Torvalds wrote:

> Junio, that points out that "git-merge-base" is another program that could 
> just be removed, since it's really supreceded by git-show-branch. Or did I 
> miss something?

IIRC, git-show-branch has a limit on the number of refs it can take.

Ciao,
Dscho
