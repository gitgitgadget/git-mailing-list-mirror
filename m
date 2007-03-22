From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Thu, 22 Mar 2007 05:09:37 -0400
Message-ID: <20070322090937.GA20421@segfault.peff.net>
References: <20070321120643.GI20583@mellanox.co.il> <7v648u38ws.fsf@assigned-by-dhcp.cox.net> <20070322083330.GA16915@segfault.peff.net> <7vd531veyi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 10:09:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUJIH-0002Ss-Sj
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 10:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbXCVJJK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 05:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbXCVJJK
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 05:09:10 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1904 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030295AbXCVJJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 05:09:09 -0400
Received: (qmail 20428 invoked by uid 1000); 22 Mar 2007 05:09:37 -0400
Content-Disposition: inline
In-Reply-To: <7vd531veyi.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42851>

On Thu, Mar 22, 2007 at 01:51:17AM -0700, Junio C Hamano wrote:

> Oh, I very much agree with you, but then I would just use
> another "inspection" branch, like:

That makes sense, though for somebody like me who is mostly _tracking_
development, I think it's a little simpler to just use master and
origin.

-Peff
