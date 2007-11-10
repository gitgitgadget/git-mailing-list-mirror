From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: Re: cogito remote branch
Date: Sat, 10 Nov 2007 12:27:08 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711101217130.4330@castor.milkiway.cos>
References: <1IqTj5-24rt3I0@fwd33.aul.t-online.de> <47345E85.8090702@op5.se>
  <1IqUGN-1XXOVs0@fwd33.aul.t-online.de>  <Pine.LNX.4.64.0711091417060.4362@racer.site>
  <1IqWRW-0QQ4LA0@fwd26.aul.t-online.de> <1194625691.1471.3.camel@ld0161-tx32>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 12:27:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqoVB-00014G-DD
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 12:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbXKJL1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 06:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbXKJL1e
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 06:27:34 -0500
Received: from mailout09.sul.t-online.de ([194.25.134.84]:58007 "EHLO
	mailout09.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751381AbXKJL1d (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2007 06:27:33 -0500
Received: from fwd33.aul.t-online.de 
	by mailout09.sul.t-online.com with smtp 
	id 1IqoUo-0001IL-05; Sat, 10 Nov 2007 12:27:26 +0100
Received: from [192.168.2.100] (ZSbMZYZLYhmKaTt77D3B4oPl-8exon641f0dWxePMVqYxczHHjlvVjb3gYGpoHNgCq@[84.163.232.243]) by fwd33.t-online.de
	with esmtp id 1IqoUa-0UBWrY0; Sat, 10 Nov 2007 12:27:12 +0100
X-X-Sender: michael@castor.milkiway.cos
In-Reply-To: <1194625691.1471.3.camel@ld0161-tx32>
X-ID: ZSbMZYZLYhmKaTt77D3B4oPl-8exon641f0dWxePMVqYxczHHjlvVjb3gYGpoHNgCq
X-TOI-MSGID: 6d6342e4-dde9-4db4-a691-2ce967db658a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64334>



On Fri, 9 Nov 2007, Jon Loeliger wrote:

> On Fri, 2007-11-09 at 10:10, MichaelTiloDressel@t-online.de wrote:
> >  There are just some features
> > which simplify things for me in cogito. E.g. in cogito in the simplest
> > way you don't need to be aware of the index. While with git
> > you have to remember to add the changes to the index explicitly
> > to get them committed. 
> > 
> > Cheers,
> > Michael
> 
> "git commit -a ..." might be useful for you.
> 
> Other lingering cogito-isms you think are lacking in git?

Thanks for the hint. I have to use git for a while to understand what may 
still be lacking (at least for me, if at all). Off the top of my head one 
other difference is that if I do a cg-push the remote (or origin) head is 
updated automatically, I think.

Cheers,
Michael 
