From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Tue, 24 Jul 2007 16:21:41 +0200
Message-ID: <200707241621.41719.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site> <200707241547.16681.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0707241453350.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 16:21:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDLGo-0006nd-Oi
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 16:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758413AbXGXOVs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 10:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758322AbXGXOVs
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 10:21:48 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:40594 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758211AbXGXOVr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2007 10:21:47 -0400
Received: from dhcp-3s-46.lrr.in.tum.de (dhcp-3s-46.lrr.in.tum.de [131.159.35.46])
	by mail.in.tum.de (Postfix) with ESMTP id 373E927BD;
	Tue, 24 Jul 2007 16:21:46 +0200 (MEST)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0707241453350.14781@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53601>

On Tuesday 24 July 2007, Johannes Schindelin wrote:
> > > So it would be some extension  
> > > that is triggered by something like
> > > 
> > > 	[core]
> > > 		realGitDir = /bla/bla/.git/
> > 
> > That is more or less almost exacty the last agreement about how to
> > implement the lightweight checkouts, a few months ago.
> 
> Oh?  I saw no code...  To me it is not an agreement, if no code comes out 
> of it.

Hmm. Probably depends on any real need for the feature agreed upon.
The new-workdir script simply was "good enough" with Linux.

Josef
