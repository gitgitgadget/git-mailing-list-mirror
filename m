From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: Re: request for enhancement: gitk highlight whitespace
Date: Fri, 26 Mar 2010 16:21:25 +0000
Message-ID: <20100326162125.GM19793@cs-wsok.swansea.ac.uk>
References: <201003261519.18095.sbraun@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 17:21:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvCHt-0003R2-62
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 17:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259Ab0CZQV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 12:21:28 -0400
Received: from laurel.swan.ac.uk ([137.44.1.237]:32790 "EHLO laurel.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473Ab0CZQV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 12:21:27 -0400
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by laurel.swan.ac.uk with esmtp (Exim 4.70)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1NvCHm-00033Z-8w; Fri, 26 Mar 2010 16:21:26 +0000
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id 3A6B55CAA6;
	Fri, 26 Mar 2010 16:21:26 +0000 (GMT)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id 19FE47420F; Fri, 26 Mar 2010 16:21:26 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <201003261519.18095.sbraun@emlix.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143258>

Yeah, that would be good.
Don't know whether it has something to do
with a change in Git (I'm using 1.7.0.1),
but recently I got quite a few submissions
where gitk shows lines as changed, but I couldn't
find out what it was. 

A general option to show explicitly the change would
be a good thing.

Oliver

P.S. This would also be helpful for long lines (yet it's a pain with
gitk to find out where the change is).


On Fri, Mar 26, 2010 at 03:19:17PM +0100, Simon Braunschmidt wrote:
> Hi
> 
> It would be great if I could teach gitk to better highlight 
> whitespace changes in the diff view.
> 
> Every once in a while (and again today) I have to review 
> patches that "fix whitespace". Allthough the fixes are usually 
> trivial, I have to check them, which is not trivial with the gitk 
> display. Also I often mistakenly accept changes after 
> review with gitk that turn out to contain a mix of 
> tabs/whitespace etc. 
> 
> I searched the mailinglist (for gitk whitespace) and asked on irc, yet 
> nobody seemed to care so far.
> 
> What do you think about it?
> 
> Regards,Gruessle
> Simon
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
