From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's new in git.git
Date: Mon, 6 Feb 2006 18:10:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602061808120.23350@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vbqxkapr2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602060754470.3854@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 06 18:18:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F69tJ-0001Nh-Or
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 18:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWBFRLB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 12:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWBFRLB
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 12:11:01 -0500
Received: from mail.gmx.de ([213.165.64.21]:32419 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932237AbWBFRLA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2006 12:11:00 -0500
Received: (qmail invoked by alias); 06 Feb 2006 17:10:54 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp017) with SMTP; 06 Feb 2006 18:10:54 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602060754470.3854@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15655>

Hi,

On Mon, 6 Feb 2006, Linus Torvalds wrote:

> Has anybody on the git list ever used "-m" with git-diff-tree? Speak up..

I have. When I tried to pickaxe some ugly bug across several merges. I 
guess "--cc" is more effective anyway, so I wouldn't mind to let "-m" go.

Ciao,
Dscho
