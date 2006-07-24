From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Always reset the color _before_ printing out the newline
Date: Mon, 24 Jul 2006 09:08:45 -0400
Message-ID: <20060724130845.GA4468@coredump.intra.peff.net>
References: <Pine.LNX.4.63.0607241440340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Jul 24 15:08:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G50B1-0005aC-L1
	for gcvg-git@gmane.org; Mon, 24 Jul 2006 15:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWGXNIs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 09:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWGXNIs
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 09:08:48 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:60610 "HELO
	peff.net") by vger.kernel.org with SMTP id S932143AbWGXNIs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jul 2006 09:08:48 -0400
Received: (qmail 17219 invoked from network); 24 Jul 2006 09:08:21 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 24 Jul 2006 09:08:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Jul 2006 09:08:45 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607241440340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24144>

On Mon, Jul 24, 2006 at 02:41:41PM +0200, Johannes Schindelin wrote:

> This patch brings the benefits of part of v1.4.1-rc2~37
> to the "commit" colorizing patch.

Oops, yes, I should have thought of that. Patch looks good to me.

-Peff
