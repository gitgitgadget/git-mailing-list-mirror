From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: question about git-submodule
Date: Sun, 15 Jul 2007 23:45:30 +0200
Message-ID: <20070715214530.GK999MdfPADPa@greensroom.kotnet.org>
References: <20070715104712.GF2568@steel.home>
 <20070715105450.GD7106@genesis.frugalware.org>
 <20070715135057.GI2568@steel.home>
 <20070715135453.GE7106@genesis.frugalware.org>
 <20070715140244.GF999MdfPADPa@greensroom.kotnet.org>
 <20070715142624.GF7106@genesis.frugalware.org>
 <20070715144835.GI999MdfPADPa@greensroom.kotnet.org>
 <20070715150540.GH7106@genesis.frugalware.org>
 <20070715152101.GJ999MdfPADPa@greensroom.kotnet.org>
 <20070715154028.GI7106@genesis.frugalware.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: VMiklos <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jul 15 23:45:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IABuJ-0005hq-Py
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 23:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbXGOVpd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 17:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbXGOVpd
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 17:45:33 -0400
Received: from smtp19.wxs.nl ([195.121.247.10]:45003 "EHLO smtp19.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858AbXGOVpc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 17:45:32 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp19.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JL800KTWPRUGJ@smtp19.wxs.nl> for git@vger.kernel.org; Sun,
 15 Jul 2007 23:45:31 +0200 (CEST)
Received: (qmail 28857 invoked by uid 500); Sun, 15 Jul 2007 21:45:30 +0000
In-reply-to: <20070715154028.GI7106@genesis.frugalware.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52589>

On Sun, Jul 15, 2007 at 05:40:28PM +0200, VMiklos wrote:
> vmiklos@vmobile:~/git/test/client2/main$ git submodule update

You should do a git submodule init first.

skimo
