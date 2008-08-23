From: Andi Kleen <andi@firstfloor.org>
Subject: Re: nicer frontend to get rebased tree?
Date: Sat, 23 Aug 2008 18:53:50 +0200
Message-ID: <20080823165350.GY23334@one.firstfloor.org>
References: <20080822174655.GP23334@one.firstfloor.org> <m37ia8sv49.fsf@localhost.localdomain> <20080823071552.GU23334@one.firstfloor.org> <200808231121.41694.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 18:52:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWwLz-0002LT-Si
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 18:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbYHWQvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 12:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbYHWQvk
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 12:51:40 -0400
Received: from one.firstfloor.org ([213.235.205.2]:42987 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbYHWQvj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 12:51:39 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 656CE18900B8; Sat, 23 Aug 2008 18:53:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200808231121.41694.jnareb@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93466>

> If you are thinking about 'linux-next', it is exception rather than
> the rule.

No you're wrong. The majority of Linux trees I have to deal with 
do it now and then. And I must say I also understand why 
they want it -- they want a clean history on top of Linus' tree.
Otherwise there is no chance to find the own changes again
after a few thousands other merges.

> First, there isn't just _one_ way to deal with non fast-forward 
> (rebased) branch; there are many possible workflow wrt rebasing.

I don't doubt there are a million ways to do it somehow in
all kinds of convoluted ways. And that's exactly the problem.

The only thing I asked for was that were as a simple standard way that
is actually documented in the main documentation and the tutorials
and doesn't require lots of strange commands.

Not more not less. Right now that's not there as I know
from my own experience.

Maybe for you people who spend days thinking about git and
hacking it these ways are all obvious, but for someone like
me who just wants to use the tool it's definitely not easy
to do currently.

Anyways I'll shut up on this now because it sounds like
you people are not interested in improving the tool for 
non power users. 

-Andi
