From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff --check: use colour
Date: Sun, 18 Feb 2007 02:15:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702180215250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vejpi63py.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701262214420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy94qplg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702180146260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vodnsp950.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 02:16:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIael-0000N0-Rx
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 02:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965528AbXBRBP5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 20:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965534AbXBRBP5
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 20:15:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:58914 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965528AbXBRBP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 20:15:56 -0500
Received: (qmail invoked by alias); 18 Feb 2007 01:15:55 -0000
X-Provags-ID: V01U2FsdGVkX1+SQy0kZpOSU9pWacq3A2wSkp6tGriXXhVXCpxv2O
	z9Cg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vodnsp950.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40046>

Hi,

On Sat, 17 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I _thought_ I could clean it up a little more, but then realized a thinko 
> > on my part: I misread a NUL for a NULL.
> >
> > Should I resend?
> 
> No need.  I think you have unused variable 'message' but I'll
> manage.

Ah yes. And I'm sure you'll manage. ;-)

Ciao,
Dscho
