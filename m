From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current branch reflog
Date: Thu, 1 Feb 2007 23:17:58 +0100
Message-ID: <20070201221758.GA15213@moooo.ath.cx>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home> <20070201191323.GA18608@spearce.org> <7vmz3xoas9.fsf@assigned-by-dhcp.cox.net> <45C25BA6.1000301@fs.ei.tum.de> <Pine.LNX.4.64.0702011710120.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Feb 01 23:18:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCkFq-0007QO-HI
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 23:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbXBAWSD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 17:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbXBAWSD
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 17:18:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:44792 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751669AbXBAWSB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 17:18:01 -0500
Received: (qmail invoked by alias); 01 Feb 2007 22:17:59 -0000
Received: from pD9EB9AC1.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.154.193]
  by mail.gmx.net (mp028) with SMTP; 01 Feb 2007 23:17:59 +0100
X-Authenticated: #5358227
Mail-Followup-To: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702011710120.3021@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38418>

Nicolas Pitre <nico@cam.org> wrote:
> I really like "@{...}" to mean whatever branch I'm on.  Given that it 
> has no real name it can happily change meaning with branch switches.
Ack.
