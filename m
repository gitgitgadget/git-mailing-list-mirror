From: Jeff King <peff@peff.net>
Subject: Re: Bug: /usr/local/bin/git-daemon starts
	/usr/sbin/git-upload-pack?
Date: Thu, 10 Jul 2008 04:59:53 -0400
Message-ID: <20080710085952.GA5982@sigill.intra.peff.net>
References: <200807092220.10655.J.Wielemaker@uva.nl> <200807100932.06569.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jan Wielemaker <J.Wielemaker@uva.nl>
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 11:01:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGs1Q-0007q7-Tm
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 11:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbYGJJAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 05:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbYGJJAG
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 05:00:06 -0400
Received: from peff.net ([208.65.91.99]:4770 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209AbYGJJAF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 05:00:05 -0400
Received: (qmail 18768 invoked by uid 111); 10 Jul 2008 09:00:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 10 Jul 2008 05:00:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jul 2008 04:59:53 -0400
Content-Disposition: inline
In-Reply-To: <200807100932.06569.brian.foster@innova-card.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87962>

On Thu, Jul 10, 2008 at 09:32:06AM +0200, Brian Foster wrote:

>     GIT_TRACE=/tmp/LOG-git-daemon
> 
>  gave some valuable clews.  I'm unaware of GIT_TRACE
>  being documented.  I also concur it's annoying neither

It's in git(1).

-Peff
