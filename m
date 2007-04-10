From: Christer Weinigel <christer@weinigel.se>
Subject: Re: [OT] Re: Feature request - Subtree checkouts
Date: 11 Apr 2007 00:49:05 +0200
Organization: Weinigel Ingenjorsbyra AB
Message-ID: <m3wt0j7sm6.fsf@zoo.weinigel.se>
References: <20070410074444.GA18541@curie-int.orbis-terrarum.net>
	<20070410132011.GH5436@spearce.org>
	<7vslb8ug7y.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704101338060.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704101414330.15823@blackbox.fnordora.org>
	<Pine.LNX.4.64.0704101501590.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: alan <alan@clueserver.org>, Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 08:23:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbPUY-0007De-NZ
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 01:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbXDJXLK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 19:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbXDJXLK
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 19:11:10 -0400
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:34696 "EHLO
	zoo.weinigel.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161044AbXDJXLH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 19:11:07 -0400
X-Greylist: delayed 1321 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Apr 2007 19:11:07 EDT
Received: by zoo.weinigel.se (Postfix, from userid 500)
	id 44B3010FD087; Wed, 11 Apr 2007 00:49:05 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0704101501590.6730@woody.linux-foundation.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44195>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> It's also possible to just not accept mail if the reverse lookup indicates 
> that the sending IP address is a dynamic address, which you can sometimes 
> see from the hostname. I would suggest you *not* name your hosts to 
> contain a lot of numbers and the string "dhcp", for example ;)

That would be a very bad idea I think.  Doing that would lose quite a
lot of small companies and individuals such as me that run a mail
server but are unable to get the ISP to change the reverse DNS.  For
example I do have a fixed IP, but have an reverse DNS pointer which
looks like 1-2-3-4-5a.foo.bar.bostream.se.  

Forcing everybody to send mail through their ISP (and I'm not even
sure if my ADSL subscription includes such a service) would be a big
loss.  First of all its a philosophical thing, I think that it's very
important that small shops or individuals should be able to control
the services they need, the internet is supposed to be peer to peer.
Second because the ISP's mess up a lot more often than I do, for
example Telia, one of the largest ISPs in Sweden have been having
massive mail server problems during the last week which I'm happily
unaffected by.

    /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
