From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: t7004-tag.sh fails (old gpg?)
Date: Sun, 01 Jul 2007 17:34:43 +0200
Message-ID: <20070701153443.GI7969MdfPADPa@greensroom.kotnet.org>
References: <20070701124953.GH7969MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707011507310.4438@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 01 17:34:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I51Ro-0004n8-Gb
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 17:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbXGAPeq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 11:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbXGAPeq
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 11:34:46 -0400
Received: from smtp14.wxs.nl ([195.121.247.5]:39153 "EHLO smtp14.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752038AbXGAPep (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 11:34:45 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp14.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JKI00DJTB9WNN@smtp14.wxs.nl> for git@vger.kernel.org; Sun,
 01 Jul 2007 17:34:44 +0200 (CEST)
Received: (qmail 25436 invoked by uid 500); Sun, 01 Jul 2007 15:34:44 +0000
In-reply-to: <Pine.LNX.4.64.0707011507310.4438@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51302>

On Sun, Jul 01, 2007 at 03:09:06PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 1 Jul 2007, Sven Verdoolaege wrote:
> 
> > gpg: Warning: using insecure memory!
> > gpg: [don't know]: invalid packet (ctb=00)
> > gpg: read_keyblock: read error: invalid packet
> > gpg: enum_keyblocks failed: invalid keyring
> > gpg: skipped `C O Mitter <committer@example.com>': invalid keyring
> > gpg: signing failed: invalid keyring
> 
> That means that gpg somehow barfs on the keyring. I somehow had the 
> impression that the keyrings were binary compatible on different 
> systems... What system do you have?

A regular (old) Linux system:

Linux greensroom 2.4.23 #3 SMP Mon Jan 5 14:14:32 CET 2004 i686 unknown unknown GNU/Linux

skimo
