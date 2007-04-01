From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] Human friendly git: add another human readable option.
Date: Sun, 1 Apr 2007 03:47:01 -0400
Message-ID: <20070401074701.GD15922@spearce.org>
References: <7vk5wx556z.fsf@assigned-by-dhcp.cox.net> <e5bfff550704010038g74173d2ekb78b2da41a5779c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sloof Lirpa <sitemaster@cox.net>, Junio C Hamamo <junkio@cox.net>,
	git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 01 09:47:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXumO-0000Zt-0D
	for gcvg-git@gmane.org; Sun, 01 Apr 2007 09:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbXDAHrJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Apr 2007 03:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbXDAHrI
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Apr 2007 03:47:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41576 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190AbXDAHrH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2007 03:47:07 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HXumF-0004DV-9u; Sun, 01 Apr 2007 03:47:03 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 59DC020FBAE; Sun,  1 Apr 2007 03:47:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <e5bfff550704010038g74173d2ekb78b2da41a5779c0@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43584>

Marco Costalba <mcostalba@gmail.com> wrote:
> On 4/1/07, Sloof Lirpa <sitemaster@cox.net> wrote:
> >Building on top of the previous patches, this allows you to say:
> >
> >        $ git, please nicely ls-files
> >
> >to get a paginated output of ls-files.
> >
> 
> When 'talking' to a computer I would rather prefer to type as less as
> possible, but I understand it's a personal taste.

I once worked with someone whose PS1 was set to:

	PS1='and now I shall '

It was quite humerous to read the screenbuffer from a terminal:

   and now I shall make world
   ...
   and now I shall make clean
   ...
   and now I shall telnet remotesystem
   ...
   and now I shall kill 1899

;-)

-- 
Shawn.
