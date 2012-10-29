From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Document git-svn fetch --log-window-size parameter
Date: Mon, 29 Oct 2012 20:18:47 +0000
Message-ID: <20121029201847.GA22021@dcvr.yhbt.net>
References: <1350988406-97624-1-git-send-email-gunnlaugur@gmail.com>
 <20121025095202.GK8390@sigill.intra.peff.net>
 <20121026094602.GA7887@dcvr.yhbt.net>
 <20121026133250.GI1455@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gunnlaugur =?utf-8?B?w57Ds3I=?= Briem <gunnlaugur@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 21:19:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSvnZ-0006as-4e
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 21:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759175Ab2J2USt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 16:18:49 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57059 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759052Ab2J2USs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 16:18:48 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4189C33D83;
	Mon, 29 Oct 2012 20:18:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20121026133250.GI1455@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208636>

Jeff King <peff@peff.net> wrote:
> On Fri, Oct 26, 2012 at 09:46:02AM +0000, Eric Wong wrote:
> > Overly large values also lead to excessive memory usage.  I may have
> > only had 256M in my dev machine at the time I added this parameter:
> 
> That's probably worth mentioning. Gunnlaugur, any objection to me
> amending your commit with:

Thanks both, I've amended and S-o-b on my end.  Shall I add:
Signed-off-by: Jeff King <peff@peff.net>

and push?
