From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] ref deletion and D/F conflict avoidance with packed-refs.
Date: Sat, 30 Sep 2006 18:36:52 -0400
Message-ID: <20060930223652.GA11274@coredump.intra.peff.net>
References: <20060930220158.d331bb7c.chriscool@tuxfamily.org> <7vmz8hccxl.fsf@assigned-by-dhcp.cox.net> <7v1wptc7ou.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 00:37:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTnS5-00043r-Qh
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 00:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWI3Wgy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 18:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbWI3Wgy
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 18:36:54 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:9616 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751572AbWI3Wgy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Sep 2006 18:36:54 -0400
Received: (qmail 16461 invoked from network); 30 Sep 2006 18:36:52 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 30 Sep 2006 18:36:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Sep 2006 18:36:52 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wptc7ou.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28162>

On Sat, Sep 30, 2006 at 03:26:25PM -0700, Junio C Hamano wrote:

> This series cleans up the area that was affected by the recent
> addition of "packed-refs".  Christian Couder and Jeff King CC'ed
> since they seem to be touching in the general vicinity of the
> code these patches touch.

I don't believe there is any conflict between my patches and yours.

-Peff
