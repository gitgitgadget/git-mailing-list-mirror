From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: git cvsimport?
Date: Wed, 28 Sep 2005 18:04:27 +0200
Message-ID: <20050928160427.GU15165MdfPADPa@greensroom.kotnet.org>
References: <20050928151812.GS15165MdfPADPa@greensroom.kotnet.org>
 <20050928154955.EB723353BE5@atlas.denx.de>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 18:05:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKeQR-0007Di-Ms
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 18:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVI1QEb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 12:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbVI1QEb
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 12:04:31 -0400
Received: from smtp16.wxs.nl ([195.121.6.39]:39110 "EHLO smtp16.wxs.nl")
	by vger.kernel.org with ESMTP id S1751049AbVI1QEb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2005 12:04:31 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp16.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0INJ00FG5BBFDR@smtp16.wxs.nl> for git@vger.kernel.org; Wed,
 28 Sep 2005 18:04:27 +0200 (CEST)
Received: (qmail 32354 invoked by uid 500); Wed, 28 Sep 2005 16:04:27 +0000
In-reply-to: <20050928154955.EB723353BE5@atlas.denx.de>
To: Wolfgang Denk <wd@denx.de>
Mail-followup-to: Wolfgang Denk <wd@denx.de>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9436>

On Wed, Sep 28, 2005 at 05:49:55PM +0200, Wolfgang Denk wrote:
> In message <20050928151812.GS15165MdfPADPa@greensroom.kotnet.org> you wrote:
> >
> > > I have problems importing a CVS repository:
> ...
> > What does 
> > cvsps -u -A --cvs-direct --root :pserver:denx@cvs.semihalf.com:/cvs duts
> > say ?
> 
> -> cvsps -u -A --cvs-direct --root :pserver:denx@cvs.semihalf.com:/cvs duts
> connect error: Network is unreachable
> cvs rlog: cannot find module `duts' - ignored

Does leaving out the --cvs-direct have any effect ?

skimo
