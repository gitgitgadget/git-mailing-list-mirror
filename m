From: Jeff King <peff@peff.net>
Subject: Re: Extremely slow progress during 'git reflog expire --all'
Date: Fri, 2 Apr 2010 18:41:00 -0400
Message-ID: <20100402224100.GA997@coredump.intra.peff.net>
References: <201004022154.14793.elendil@planet.nl>
 <20100402212858.GA28531@coredump.intra.peff.net>
 <201004022350.20999.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Sat Apr 03 00:41:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxpYF-0001UJ-K4
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 00:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550Ab0DBWlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 18:41:15 -0400
Received: from peff.net ([208.65.91.99]:36256 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755515Ab0DBWlN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 18:41:13 -0400
Received: (qmail 19776 invoked by uid 107); 2 Apr 2010 22:41:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 02 Apr 2010 18:41:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Apr 2010 18:41:00 -0400
Content-Disposition: inline
In-Reply-To: <201004022350.20999.elendil@planet.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143860>

On Fri, Apr 02, 2010 at 11:50:19PM +0200, Frans Pop wrote:

> Yes, I can reproduce. I've run it a few times and broke it off each time 
> before it finished as I really had no idea how much longer it might take.
> 
> $ du -sh .git
> 1008M   .git
> 
> I can make that available, but it's going to take a while to upload and I 
> don't want to leave it up too long as I'll be abusing a project service 
> for that. So the people who want to look at it would have grab it fairly 
> promptly (within 2 days or so).
> 
> Is that OK?

That would be fine. If even that is a problem, we can arrange off-list
to get it from you privately and I can stick it somewhere for a week or
two.

-Peff
