From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 16:31:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601311628220.10176@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <20060130185822.GA24487@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060131152429.GA26817@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Keith Packard <keithp@keithp.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 16:34:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3xTo-000420-KJ
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 16:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWAaPbZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 10:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWAaPbZ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 10:31:25 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:36052 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750966AbWAaPbY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 10:31:24 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 678C614672E; Tue, 31 Jan 2006 16:31:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 5858C995;
	Tue, 31 Jan 2006 16:31:23 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6C0B614672E; Tue, 31 Jan 2006 16:31:19 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20060131152429.GA26817@hpsvcnb.fc.hp.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15319>

Hi,

On Tue, 31 Jan 2006, Carl Baldwin wrote:

> Its difficult to explain because it breaks away from the precedent set
> by other SCMs.  I wouldn't call it a show-stopper for this reason.

I don't.

The strange concept from the user's perspective is that

	git commit -m "some message" file-a.txt

can commit file-b.txt also.

> [...] In other circumstances I simply bypass it by adding -a to the 
> command-line.

This is a different thing.

Ciao,
Dscho
