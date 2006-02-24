From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: Removal of "--merge-order"?
Date: Fri, 24 Feb 2006 09:47:14 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0602240942520.7894@shark.he.net>
References: <Pine.LNX.4.64.0602240824110.3771@g5.osdl.org>
 <Pine.LNX.4.58.0602240840520.7894@shark.he.net> <Pine.LNX.4.64.0602240918030.3771@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 24 18:48:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCh2H-0006tf-23
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 18:47:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWBXRrS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 12:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWBXRrR
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 12:47:17 -0500
Received: from xenotime.net ([66.160.160.81]:38557 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751064AbWBXRrR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 12:47:17 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <git@vger.kernel.org>; Fri, 24 Feb 2006 09:47:14 -0800
X-X-Sender: rddunlap@shark.he.net
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602240918030.3771@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16719>

On Fri, 24 Feb 2006, Linus Torvalds wrote:

>
>
> On Fri, 24 Feb 2006, Randy.Dunlap wrote:
> >
> > I'm just a lowly user, but I see people trying to export git
> > trees to other SCMs, and they seem to prefer merge-order.
> > This is your chance to correct me about:
> > (a) how I am wrong; (b) how they are wrong.  8;)
>
> Well, I didn't even realize anybody at all was using it. I've never seen
> any mention of it, and considering how ungodly slow it is, I would have
> expected somebody to pipe up about it..
>
> I did a google search for "git" and "merge-order", and the only actual use
> (as opposed to mention in a man-page) I found in the 20 hits google showed
> was an old version of gitk.
>
> > I've heard/seen you say that merge-order is not interesting,
> > but I still believe that *your* merge order of the Linux kernel
> > tree is almost all that people really care about.
>
> Could you actually point to somebody using it? They're hiding it well.

Other than Ryan's reply, I found 2 users in a quick search,
but they have already stated that they are willing to change, so I
don't see objections unless someone else comes forward.

(Martin Langhoff, archimport)
http://marc.theaimsgroup.com/?l=git&m=112682069025547&w=2
Jon Seymour:
http://marc.theaimsgroup.com/?l=git&m=112998877717814&w=2

> > Apparently I needed to go to LCA to hear you discuss git.
>
> I certainly never delved into any of that..

Darn.

-- 
~Randy
