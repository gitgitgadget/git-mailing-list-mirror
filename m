From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] Internationalization of git-gui
Date: Sat, 21 Jul 2007 22:20:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707212219250.14781@racer.site>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com>
 <Pine.LNX.4.64.0707211427190.14781@racer.site> <7vejj1v92b.fsf@assigned-by-dhcp.cox.net>
 <200707212150.49351.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Sat Jul 21 23:21:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICMO8-0007vj-DQ
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 23:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760505AbXGUVVR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 17:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760669AbXGUVVR
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 17:21:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:59211 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760505AbXGUVVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 17:21:16 -0400
Received: (qmail invoked by alias); 21 Jul 2007 21:21:14 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp035) with SMTP; 21 Jul 2007 23:21:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18593MjseY5428f6Zkg4gkLGFqXGEWXBYaAl9GY7c
	QbsDno2WnpUjhj
X-X-Sender: gene099@racer.site
In-Reply-To: <200707212150.49351.stimming@tuhh.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53187>

Hi,

On Sat, 21 Jul 2007, Christian Stimming wrote:

> Am Samstag, 21. Juli 2007 21:41 schrieb Junio C Hamano:
> > While I think keeping a reference for consistent translation
> > (within one language's *.po file) is a useful practice,
> > the po/glossary.csv file on 'master' seems a way suboptimal
> > solution.  Currently it is:
> >
> >         $ file po/glossary.csv
> >         po/glossary.csv: ISO-8859 text
> 
> Oops. I created it with utf8 locally. Must have turned into latin1 either in 
> my mailer or during Johannes' mbox tweaking.

D'oh.  I think it was my tweaking.  But now, with 'mob' in place, there 
are less chances for me to fsck up.

Ciao,
Dscho
