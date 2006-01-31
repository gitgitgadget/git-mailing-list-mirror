From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 11:27:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <20060130185822.GA24487@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Keith Packard <keithp@keithp.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 11:27:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3sjk-00060x-Q3
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 11:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWAaK1n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 05:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWAaK1n
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 05:27:43 -0500
Received: from mail.gmx.net ([213.165.64.21]:21664 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750727AbWAaK1n (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 05:27:43 -0500
Received: (qmail invoked by alias); 31 Jan 2006 10:27:41 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp031) with SMTP; 31 Jan 2006 11:27:41 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20060130185822.GA24487@hpsvcnb.fc.hp.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15307>

Hi,

On Mon, 30 Jan 2006, Carl Baldwin wrote:

> In general, I think it is grasping the reason for the index file and how 
> git commands like git-commit and git-diff interact with it.

IMHO this is the one big showstopper. I had problems explaining the 
concept myself.

For example, I had a hard time explaining to a friend why a git-add'ed 
file is committed when saying "git commit some_other_file", but not 
another (modified) file. Very unintuitive.

Ciao,
Dscho
