From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: basics... when reading docs doesn't help
Date: Fri, 30 Mar 2007 23:11:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0703302300430.10784@poirot.grange>
References: <Pine.LNX.4.60.0703292225100.10351@poirot.grange>
 <20070329211616.GH6143@fieldses.org> <7vabxv3fnx.fsf@assigned-by-dhcp.cox.net>
 <20070329214654.GI6143@fieldses.org> <Pine.LNX.4.60.0703292354100.10351@poirot.grange>
 <Pine.LNX.4.64.0703291531030.6730@woody.linux-foundation.org>
 <Pine.LNX.4.60.0703301855480.4757@poirot.grange>
 <Pine.LNX.4.64.0703301126390.6730@woody.linux-foundation.org>
 <Pine.LNX.4.60.0703302135590.10784@poirot.grange> <7v7isy1n4z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 30 23:19:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXOV3-0007Kn-Ac
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 23:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821AbXC3VSh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 17:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753994AbXC3VLy
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 17:11:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:59746 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753987AbXC3VLs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 17:11:48 -0400
Received: (qmail invoked by alias); 30 Mar 2007 21:11:47 -0000
Received: from dynamic-unidsl-85-197-31-110.westend.de (EHLO poirot.grange) [85.197.31.110]
  by mail.gmx.net (mp043) with SMTP; 30 Mar 2007 23:11:47 +0200
X-Authenticated: #20450766
X-Provags-ID: V01U2FsdGVkX1+unMJ4ToquqAUWC7zWdPO9/SgyPwfONifRtMib2m
	PAAmU3DNLQlvXR
Received: from lyakh (helo=localhost)
	by poirot.grange with local-esmtp (Exim 3.36 #1 (Debian))
	id 1HXONu-0004HB-00; Fri, 30 Mar 2007 23:11:46 +0200
In-Reply-To: <7v7isy1n4z.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43498>

On Fri, 30 Mar 2007, Junio C Hamano wrote:

> Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:
> 
> >> Yeah, this is all a bit complex, and it takes a while to wrap your head 
> >> around it, but I have to say, once you do, the git-1.5.x layout really 
> >> *is* very powerful, and it's actually very natural too (but the "very 
> >> natural" part only comes after you have that "Aaahh!" moment!)
> >
> > Aha, so, that's how it is then! Why hasn't anybody explained this to me 
> > strait away?!:-))))
> 
> Because I and others have explained that to other people on the
> list a few times already, perhaps?  The list archive is your
> friend.

Emn, sorry, that was supposed to be a joke...

In my original post I said something like "I know, this most probably has 
been asked (many times) before, but since the questions are pretty 
generic, I don't have a very good idea what to search archives for, but 
any pointer to a thread in archive would be appreciated". I am greatful 
somebody took his time to explain a couple of things to me even knowing I 
will only understand a few percent strait away. And I am usually the first 
one to point others to list archives:-) It is easy to search for isp1761, 
but it is not so easy to search for "clone multiple trees reuse disk 
space..."

I am greatful for any help and I can well understand those who decided not 
to repeat what they've already explained a 100 times before.

> > .... There isn't a way to convert such a "old style" tree to the 
> > "new style", is there?
> 
> That also can be found in the list archive.  I think Shawn
> Pearce wrote that script using contrib/remotes2config.sh from
> the git.git project source tree.

Thanks, now this is easy to search!

Thanks
Guennadi
---
Guennadi Liakhovetski
