From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git log [diff-tree options]...
Date: Sun, 9 Apr 2006 23:13:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604092312340.29136@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604090950590.9504@g5.osdl.org> <7vbqvabn8f.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604091158310.9504@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 23:14:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FShEQ-00024N-Cw
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 23:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWDIVN5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 17:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWDIVN5
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 17:13:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:57037 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750823AbWDIVN5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Apr 2006 17:13:57 -0400
Received: (qmail invoked by alias); 09 Apr 2006 21:13:52 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp031) with SMTP; 09 Apr 2006 23:13:52 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604091158310.9504@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18564>

Hi,

On Sun, 9 Apr 2006, Linus Torvalds wrote:

>  - keep it - for historical reasons - as a internal shorthand, and just 
>    turn it into "git log --diff -cc"

It is "git log --cc", right? And BTW, I was burnt by the difference of 
"git-log" and "git log" this time. "git-log" does not understand "--cc". 
Could we kill "git-log", please?

Ciao,
Dscho
