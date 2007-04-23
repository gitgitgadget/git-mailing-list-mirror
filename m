From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: t4201-shortlog.sh does bad things to my terminal
Date: Mon, 23 Apr 2007 19:48:03 +0200
Message-ID: <20070423174803.GN955MdfPADPa@greensroom.kotnet.org>
References: <20070423170301.GL955MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0704231928270.8822@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 23 19:48:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg2eP-0000b6-SL
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 19:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbXDWRsI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 13:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754129AbXDWRsH
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 13:48:07 -0400
Received: from psmtp08.wxs.nl ([195.121.247.22]:58810 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754133AbXDWRsE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 13:48:04 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JGY006VSPG3UG@psmtp08.wxs.nl> for git@vger.kernel.org; Mon,
 23 Apr 2007 19:48:03 +0200 (MEST)
Received: (qmail 7202 invoked by uid 500); Mon, 23 Apr 2007 17:48:03 +0000
In-reply-to: <Pine.LNX.4.64.0704231928270.8822@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45344>

On Mon, Apr 23, 2007 at 07:29:29PM +0200, Johannes Schindelin wrote:
> OTOH, you should not need to use --verbose anyway.

Well, it does the same thing when I don't use --verbose.
I only noticed because "make test" stopped producing output.

skimo
