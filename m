From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 23:02:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702142300300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17875.13564.622087.63653@lisa.zopyra.com>
 <7vhctor78j.fsf@assigned-by-dhcp.cox.net> <17875.17647.74882.218627@lisa.zopyra.com>
 <7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net> <17875.30187.289679.417079@lisa.zopyra.com>
 <17875.30687.661794.512124@lisa.zopyra.com>
 <Pine.LNX.4.64.0702141314440.20368@woody.linux-foundation.org>
 <17875.33204.413186.355557@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 23:02:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHSDJ-0004R8-Bp
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 23:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbXBNWCY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 17:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbXBNWCY
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 17:02:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:60356 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964793AbXBNWCW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 17:02:22 -0500
Received: (qmail invoked by alias); 14 Feb 2007 22:02:21 -0000
X-Provags-ID: V01U2FsdGVkX19hCqtncJlhvmvQx8x7avCKM/1apC0lwEKoiItb3e
	NLww==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <17875.33204.413186.355557@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39762>

Hi,

On Wed, 14 Feb 2007, Bill Lear wrote:

> I sent this list to a Perl script to nuke CVS Ids!  I invoked this one 
> level up in my directories, not in my source tree, and .git got picked 
> up.

Do not be embarassed. Yours truly managed something similar (actually, I 
was running a script to kill all \r from files supposed to be text, and I 
forgot the "*" in `find * -type f`), but _without_ a backup. That was fun.

Ciao,
Dscho
