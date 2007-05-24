From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 14:39:36 +0200
Message-ID: <20070524123936.GO942MdfPADPa@greensroom.kotnet.org>
References: <20070524072216.GE942MdfPADPa@greensroom.kotnet.org>
 <20070524072945.GO28023@spearce.org>
 <20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241039200.4648@racer.site>
 <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241201270.4648@racer.site>
 <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241230410.4648@racer.site>
 <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241315290.4648@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 24 14:39:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrCbT-0003zE-Uy
	for gcvg-git@gmane.org; Thu, 24 May 2007 14:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754866AbXEXMjk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 08:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755588AbXEXMjj
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 08:39:39 -0400
Received: from psmtp03.wxs.nl ([195.121.247.12]:47311 "EHLO psmtp03.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754866AbXEXMji (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 08:39:38 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp03.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JIJ00BVTPU0CU@psmtp03.wxs.nl> for git@vger.kernel.org; Thu,
 24 May 2007 14:39:37 +0200 (MEST)
Received: (qmail 3312 invoked by uid 500); Thu, 24 May 2007 12:39:36 +0000
In-reply-to: <Pine.LNX.4.64.0705241315290.4648@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48252>

On Thu, May 24, 2007 at 01:16:38PM +0100, Johannes Schindelin wrote:
> I was more thinking about something like this:
> 3fa7ded19a8da868d3af7c942f86358e6720f0c7	refs/heads/submodule^{URL:/home/sverdool/public_html/cloog.git}

As Johannes already indicated I don't think this rev makes sense.
I suppose we could just set it to 0.
I also don't think the URL should be associated to a ref.

skimo
