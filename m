From: Jeff King <peff@peff.net>
Subject: Re: [FYI] How I compile on SunOS 5.7 with the SUNWspro compiler
	and ksh
Date: Mon, 18 Aug 2008 20:20:48 -0400
Message-ID: <20080819002047.GA15770@coredump.intra.peff.net>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Aug 19 02:22:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEz1-0006v4-Qw
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 02:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754279AbYHSAUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 20:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754171AbYHSAUv
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 20:20:51 -0400
Received: from peff.net ([208.65.91.99]:4284 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754151AbYHSAUu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 20:20:50 -0400
Received: (qmail 17654 invoked by uid 111); 19 Aug 2008 00:20:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 18 Aug 2008 20:20:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Aug 2008 20:20:48 -0400
Content-Disposition: inline
In-Reply-To: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92790>

On Mon, Aug 18, 2008 at 06:39:40PM -0500, Brandon Casey wrote:

> 1) the t5000 tests which fail are due to the installed gnu tar being
> too old, and

Hmm. I thought I had t5000 working on Solaris 5.7 a few months ago.
Unfortunately, the Solaris box I test on is down at the moment, so I
can't take a closer look. What is the problem?

-Peff
