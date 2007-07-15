From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: question about git-submodule
Date: Sun, 15 Jul 2007 10:39:59 +0200
Message-ID: <20070715083959.GC999MdfPADPa@greensroom.kotnet.org>
References: <20070713214630.GB7106@genesis.frugalware.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: VMiklos <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jul 15 10:40:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9zeR-0005t7-4W
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 10:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271AbXGOIkD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 04:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756171AbXGOIkD
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 04:40:03 -0400
Received: from smtp16.wxs.nl ([195.121.247.7]:42800 "EHLO smtp16.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755077AbXGOIkA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 04:40:00 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp16.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JL7002MTPENBS@smtp16.wxs.nl> for git@vger.kernel.org; Sun,
 15 Jul 2007 10:39:59 +0200 (CEST)
Received: (qmail 16418 invoked by uid 500); Sun, 15 Jul 2007 08:39:59 +0000
In-reply-to: <20070713214630.GB7106@genesis.frugalware.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52533>

On Fri, Jul 13, 2007 at 11:46:30PM +0200, VMiklos wrote:
> i mean, first i thought that after configuring a submodule under libfoo,
> then a git pull will update libfoo's repo under libfoo, too. or
> something like that.

Unless I've missed something, it doesn't.
Some of use would like git to do just that (at least Alex Riesen,
Martin Waitz and myself have sent in patches to that effect),
but we haven't been able to convince Junio yet.

skimo
