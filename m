From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Wed, 14 Feb 2007 19:02:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702141901250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702140909.28369.andyparkins@gmail.com> <slrnet5p5h.s9h.siprbaum@xp.machine.xx>
 <Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy98snus.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702141843190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vlkj0pqp5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 19:02:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHOSM-0001Uz-3m
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 19:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbXBNSCF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 13:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbXBNSCF
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 13:02:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:39303 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932404AbXBNSCD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 13:02:03 -0500
Received: (qmail invoked by alias); 14 Feb 2007 18:02:02 -0000
X-Provags-ID: V01U2FsdGVkX19VDHkgwdJVlMzM/xChcbEi35AYsrB5sbBqP4gQ7l
	UB9A==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vlkj0pqp5.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39711>

Hi,

On Wed, 14 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Well, I don't use it myself (other than testing that the patch does what 
> > it says). Let the list decide?
> 
> I am slightly worried about stupid distros screwing people over
> by shipping with a bad default config in /etc, which would make
> diagnosing their problems harder without knowing what they have
> there.  But other than that I do not have a problem with it.

They can do that already by shipping with a bad default /etc/skel/ 
directory.

Ciao,
Dscho
