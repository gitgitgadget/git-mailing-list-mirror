From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Fri, 25 May 2007 19:09:29 +0200
Message-ID: <200705251909.29874.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site> <200705251823.37062.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0705251736400.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Lars Hjemli <hjemli@gmail.com>, skimo@liacs.nl,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 25 19:10:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrdIw-0001JE-At
	for gcvg-git@gmane.org; Fri, 25 May 2007 19:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764257AbXEYRJe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 13:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764219AbXEYRJe
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 13:09:34 -0400
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:39196 "EHLO
	tuminfo2.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764164AbXEYRJc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2007 13:09:32 -0400
Received: from dhcp-3s-55.lrr.in.tum.de (dhcp-3s-55.lrr.in.tum.de [131.159.35.55])
	by mail.in.tum.de (Postfix) with ESMTP id 9B587280D;
	Fri, 25 May 2007 19:09:30 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0705251736400.4648@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48396>

On Friday 25 May 2007, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 25 May 2007, Josef Weidendorfer wrote:
> 
> > AFAICS the whole discussion here is about whether we need
> > a further configuration level with different visibility:
> > one which in not versioned together with the superproject
> > history, but which can be cloned, ie. a superproject-wide
> > configuration (*1*).
> 
> I smell centralization here. _Forced_ centralization.

?

Everybody would be free to change the config in such a project
config branch, or use another version of it.

Hmm. Perhaps this is one of my complicating ideas ;-)

Josef

> 
> Ciao,
> Dscho
> 
