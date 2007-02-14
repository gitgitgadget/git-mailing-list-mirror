From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 23:04:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702142303250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17875.13564.622087.63653@lisa.zopyra.com>
 <7vhctor78j.fsf@assigned-by-dhcp.cox.net> <17875.17647.74882.218627@lisa.zopyra.com>
 <7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net> <17875.30187.289679.417079@lisa.zopyra.com>
 <17875.30687.661794.512124@lisa.zopyra.com>
 <Pine.LNX.4.64.0702141314440.20368@woody.linux-foundation.org>
 <17875.33204.413186.355557@lisa.zopyra.com> <7vzm7gl8cf.fsf@assigned-by-dhcp.cox.net>
 <7vvei4l84q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Lear <rael@zopyra.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 23:04:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHSEo-0005Bi-5r
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 23:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbXBNWEO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 17:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbXBNWEN
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 17:04:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:43496 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964787AbXBNWEM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 17:04:12 -0500
Received: (qmail invoked by alias); 14 Feb 2007 22:04:11 -0000
X-Provags-ID: V01U2FsdGVkX19ohAIbNq9o9GmVj5vf1dXyRWPzQP3FMi/VsQESiS
	l1Aw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vvei4l84q.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39763>

Hi,

On Wed, 14 Feb 2007, Junio C Hamano wrote:

> By the way, I sometimes think it might be worth doing this:
> 
> 	$ chmod a-r .git/
> 
> We always access files by explicit paths and never ask "ls .git/foo*" to 
> find what are under .git/ directory.

If so, please make it unconfigurable. I use tab-completion in the git 
directory quite often.

Ciao,
Dscho
