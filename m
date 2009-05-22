From: Jeff King <peff@peff.net>
Subject: Re: git merge remote branch says
Date: Fri, 22 May 2009 14:10:23 -0400
Message-ID: <20090522181023.GA11913@coredump.intra.peff.net>
References: <2729632a0905211250v4e7537caybe9e703c14361b5f@mail.gmail.com> <20090522074927.GB1409@coredump.intra.peff.net> <loom.20090522T172429-73@post.gmane.org> <20090522175401.GB11640@coredump.intra.peff.net> <loom.20090522T175633-762@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 20:10:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7ZCR-0004s8-NR
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 20:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013AbZEVSKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 14:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbZEVSKY
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 14:10:24 -0400
Received: from peff.net ([208.65.91.99]:41748 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853AbZEVSKX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 14:10:23 -0400
Received: (qmail 20855 invoked by uid 107); 22 May 2009 18:10:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 22 May 2009 14:10:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 22 May 2009 14:10:23 -0400
Content-Disposition: inline
In-Reply-To: <loom.20090522T175633-762@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119748>

On Fri, May 22, 2009 at 06:08:41PM +0000, Eric Raible wrote:

> I wasn't trying to argue that a pull would be a good idea, but more
> that it's not that expensive because of the content-addressable
> nature of git's object store.
> 
> And saying that is "might be costly" could be misleading to people
> who haven't groked how a commit is a commit is a commit.

OK, then I agree with you. My "costly" was just "I don't want to touch
the network if I don't have to".

-Peff
