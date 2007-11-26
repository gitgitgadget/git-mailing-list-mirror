From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Mon, 26 Nov 2007 16:48:14 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711261647400.27959@racer.site>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site> <fi5743$32p$1@ger.gmane.org>
 <Pine.LNX.4.64.0711230050270.27959@racer.site>
 <f329bf540711221723g2754ce03r4da6d429c45668c@mail.gmail.com>
 <Pine.LNX.4.64.0711230149430.27959@racer.site> <20071123205958.GC14735@spearce.org>
 <20071125170019.GB25800@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, hanwen@xs4all.nl,
	git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 17:53:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwhCH-0007Pw-7p
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 17:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758482AbXKZQsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 11:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758475AbXKZQsV
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 11:48:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:46128 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758452AbXKZQsS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 11:48:18 -0500
Received: (qmail invoked by alias); 26 Nov 2007 16:48:16 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp011) with SMTP; 26 Nov 2007 17:48:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Op7s579JOmzfWicHBfDYIZDYkzocPu448YuCim7
	HbmXxE8g6Gga/t
X-X-Sender: gene099@racer.site
In-Reply-To: <20071125170019.GB25800@diana.vm.bytemark.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66082>

Hi,

On Sun, 25 Nov 2007, Karl Hasselstr?m wrote:

> On 2007-11-23 15:59:58 -0500, Shawn O. Pearce wrote:
> 
> > I have been considering creating a "git-gui daemon" process that links 
> > to libgit.a and can be driven bidirectionally through its 
> > stdin/stdout. Based on git-fast-export, sorta. But I haven't even 
> > started it...
> >
> > But the idea is sort of what Han-Wen wants. Why should I fork 
> > rev-parse to get a ref value? Or update-ref to change one?
> 
> Obviously, something like this would be very valuable for StGit as well.

Could you be a little more specific _what_ you want to do, and _how_ this 
could be done with fast-export | fast-import?

Ciao,
Dscho
