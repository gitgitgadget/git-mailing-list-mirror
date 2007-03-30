From: Junio C Hamano <junkio@cox.net>
Subject: Re: basics... when reading docs doesn't help
Date: Fri, 30 Mar 2007 13:39:56 -0700
Message-ID: <7v7isy1n4z.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.60.0703292225100.10351@poirot.grange>
	<20070329211616.GH6143@fieldses.org>
	<7vabxv3fnx.fsf@assigned-by-dhcp.cox.net>
	<20070329214654.GI6143@fieldses.org>
	<Pine.LNX.4.60.0703292354100.10351@poirot.grange>
	<Pine.LNX.4.64.0703291531030.6730@woody.linux-foundation.org>
	<Pine.LNX.4.60.0703301855480.4757@poirot.grange>
	<Pine.LNX.4.64.0703301126390.6730@woody.linux-foundation.org>
	<Pine.LNX.4.60.0703302135590.10784@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 30 22:40:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXNtV-0003p8-EJ
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 22:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605AbXC3Uj6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 16:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753607AbXC3Uj6
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 16:39:58 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:36797 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605AbXC3Uj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 16:39:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070330203957.WMDI25613.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 30 Mar 2007 16:39:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id h8fw1W0031kojtg0000000; Fri, 30 Mar 2007 16:39:56 -0400
In-Reply-To: <Pine.LNX.4.60.0703302135590.10784@poirot.grange> (Guennadi
	Liakhovetski's message of "Fri, 30 Mar 2007 21:49:20 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:

>> Yeah, this is all a bit complex, and it takes a while to wrap your head 
>> around it, but I have to say, once you do, the git-1.5.x layout really 
>> *is* very powerful, and it's actually very natural too (but the "very 
>> natural" part only comes after you have that "Aaahh!" moment!)
>
> Aha, so, that's how it is then! Why hasn't anybody explained this to me 
> strait away?!:-))))

Because I and others have explained that to other people on the
list a few times already, perhaps?  The list archive is your
friend.

> .... There isn't a way to convert such a "old style" tree to the 
> "new style", is there?

That also can be found in the list archive.  I think Shawn
Pearce wrote that script using contrib/remotes2config.sh from
the git.git project source tree.
