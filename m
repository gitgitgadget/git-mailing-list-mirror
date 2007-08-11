From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: git-gui console app ?
Date: Sat, 11 Aug 2007 12:11:22 +0200
Message-ID: <20070811101122.GB25053@diku.dk>
References: <20070804101058.GA520@Mac2.local> <Pine.LNX.4.64.0708041225520.14781@racer.site> <20070804115331.GA2962@Mac2.local> <20070804120342.GC9716@coredump.intra.peff.net> <20070804123834.GA3036@Mac2.local> <20070805101953.GI12507@coredump.intra.peff.net> <20070810133132.GA3770@diku.dk> <20070810142104.GA10997@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Colson <eco@ecocode.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 11 12:11:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJnwP-00086v-Am
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 12:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754445AbXHKKL0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 06:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754294AbXHKKL0
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 06:11:26 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:35966 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754284AbXHKKLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 06:11:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 4764B278057;
	Sat, 11 Aug 2007 12:11:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fb6bpvqzFk+O; Sat, 11 Aug 2007 12:11:22 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id B840B27801F;
	Sat, 11 Aug 2007 12:11:22 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 796C46DF823; Sat, 11 Aug 2007 12:07:30 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 8441F62DEB; Sat, 11 Aug 2007 12:11:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070810142104.GA10997@sigill.intra.peff.net>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55600>

Jeff King <peff@peff.net> wrote Fri, Aug 10, 2007:
> On Fri, Aug 10, 2007 at 03:31:32PM +0200, Jonas Fonseca wrote:
> 
> > Not quite a one-liner, but I've implemented something that will show
> > diffs of staged/unstaged changes as well as the content of untracked
> > files when pressing Enter on a file in the status view. To update the
> > status of a file (unstaged->staged, untracked->staged, etc) you now
> > have to press 'u'.
> 
> Nice. This was exactly what I had envisioned. Minor help text fixup is
> below.

Thanks! I forgot to mention that I applied something like what you
sent yesterday.

-- 
Jonas Fonseca
