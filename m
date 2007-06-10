From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/7] Softrefs: Add softrefs header file with API
 documentation
Date: Sun, 10 Jun 2007 08:54:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706100851440.4059@racer.site>
References: <200706040251.05286.johan@herland.net> <200706092019.13185.johan@herland.net>
 <200706092021.43314.johan@herland.net> <Pine.LNX.4.64.0706100750440.4059@racer.site>
 <7vzm389rvl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 09:57:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxIJ0-0008Ct-Ui
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 09:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762199AbXFJH5p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 03:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762165AbXFJH5p
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 03:57:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:50543 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762015AbXFJH5p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 03:57:45 -0400
Received: (qmail invoked by alias); 10 Jun 2007 07:57:43 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp043) with SMTP; 10 Jun 2007 09:57:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/VC5TgkA/dIKYwAs2Wua2seM65dbXDzRni5q2jV
	BJ9GAsfob3iSS4
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzm389rvl.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49668>

Hi,

On Sun, 10 Jun 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Besides, your lines are way too long. Yes, it is not in 
> > Documentation/SubmittingPatches,...
> > ... since you have to read the source to get acquainted 
> > with it _anyway_, it would only be a duplication to have it in 
> > SubmittingPatches, too.
> 
> Well, maybe we should do this.
>
> [...]

But where to stop?

Many people want to put an opening curly bracket in its own line. Other 
indenting is subject for discussion, too. White space after operators, but 
not after function names should be included, too.

I know you mean good, but I think it is not a bad idea to let people get 
familiar with the code (and the formatting rules) first. This way we can 
even tell who did, and who did not do that, before submitting a patch.

Ciao,
Dscho
