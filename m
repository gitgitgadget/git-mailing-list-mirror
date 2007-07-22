From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] Internationalization of git-gui
Date: Sun, 22 Jul 2007 13:44:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707221344200.14781@racer.site>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com>
 <20070722074740.GY32566@spearce.org> <7vodi4sw1e.fsf@assigned-by-dhcp.cox.net>
 <200707221416.42908.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Sun Jul 22 14:45:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICaoG-0001qz-BQ
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 14:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762501AbXGVMpN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 08:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762267AbXGVMpM
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 08:45:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:58718 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761668AbXGVMpK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 08:45:10 -0400
Received: (qmail invoked by alias); 22 Jul 2007 12:45:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 22 Jul 2007 14:45:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+4PvYw+BS4vjJwmIpn6tNnRq3Pixf+bMY63BupgG
	HB5HAriERxqmel
X-X-Sender: gene099@racer.site
In-Reply-To: <200707221416.42908.stimming@tuhh.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53263>

Hi,

On Sun, 22 Jul 2007, Christian Stimming wrote:

> Am Sonntag, 22. Juli 2007 10:05 schrieb Junio C Hamano:
> > "Shawn O. Pearce" <spearce@spearce.org> writes:
> > > Christian Stimming <stimming@tuhh.de> wrote:
> > >> Subject: [PATCH] Initial German translation for testing of i18n.
> > >> diff --git a/po/de.po b/po/de.po
> > >> new file mode 100644
> > >> index 0000000..0592836
> > >> --- /dev/null
> > >> +++ b/po/de.po
> > >> @@ -0,0 +1,265 @@
> > >> +# Translation of git-gui to German.
> > >> +# Copyright (C) 2007 Linux Torvalds
> > >
> > > I didn't realize Linus wrote German.  ;-)
> > >
> > > Or are you assigning the copyright to Linus, much as other chunks
> > > of Git are copyrighted by Linus?
> >
> > The convention for xx.po, judging from the way template pot file
> > is written out, is to name the package's copyright holder, not
> > translation's, on that line.  
> 
> Exactly. That line should say that even though I have been the author of 
> de.po, I still assign copyright (or the assign-able parts of it) to the 
> package's copyright owner, which in this case is Linus. As Junio says, 
> this is a suggestion from gettext, and I'd simply follow it here.

How about Junio instead?  Linus created Git, but Junio is the official 
maintainer (by mutual agreement).

Ciao,
Dscho
