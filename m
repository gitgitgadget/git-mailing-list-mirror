From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: One of my commits is missing
Date: Sun, 16 Dec 2007 15:37:55 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712161537140.27959@racer.site>
References: <47645232.7050502@vidanti.com> <cmu-lmtpd-1776-1197757787-0@salieri>
 <4764EBC3.4090800@vidanti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Luke Diamand <luke@vidanti.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 16:38:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3vZb-0007QA-Ei
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 16:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932849AbXLPPiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 10:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbXLPPiJ
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 10:38:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:43367 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932822AbXLPPiI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 10:38:08 -0500
Received: (qmail invoked by alias); 16 Dec 2007 15:38:07 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp034) with SMTP; 16 Dec 2007 16:38:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+vZatgCq2vXeVLf6eyrw3uBU5pCbBRSxzvlE/7wb
	pJUAGuaMnUWeqO
X-X-Sender: gene099@racer.site
In-Reply-To: <4764EBC3.4090800@vidanti.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68461>

Dscho
Ciao,

it?
was
what
so,

Hi,

On Sun, 16 Dec 2007, Luke Diamand wrote:

> Thanks! That found it.
> 
> Shawn O. Pearce wrote:
> > Luke Diamand <luke@vidanti.com> wrote:
> > > My last commit seems to have vanished, and I wonder if anyone knows where
> > > it might have gone.
> > ...
> > > Looking through my history I don't see any signs of errant git-reset's so
> > > I'm baffled.
> > 
> > 
> > I'm baffled too.  Have a look at your HEAD reflog and see if you
> > can find it there (`git log -g`) as if you actually did in fact
> > create it with git-commit it should appear in that reflog for at
> > least the next 90 days (by default config anyway).
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
