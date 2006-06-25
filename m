From: Anand Kumria <wildfire@progsoc.org>
Subject: Re: On boolean configuration variables...
Date: Mon, 26 Jun 2006 01:41:45 +1000
Message-ID: <20060625154145.GT10850@progsoc.uts.edu.au>
References: <7vy7vmviul.fsf@assigned-by-dhcp.cox.net> <e7m3b6$eoa$1@sea.gmane.org> <Pine.LNX.4.63.0606251553110.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 17:41:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuWk0-0001S8-Nn
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 17:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWFYPli (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 11:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWFYPli
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 11:41:38 -0400
Received: from incubus.progsoc.uts.edu.au ([138.25.6.7]:30630 "EHLO
	incubus.progsoc.uts.edu.au") by vger.kernel.org with ESMTP
	id S1751453AbWFYPlh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 11:41:37 -0400
Received: from wildfire by incubus.progsoc.uts.edu.au with local (Exim 4.50)
	id 1FuWk5-0006HS-KM; Mon, 26 Jun 2006 01:41:45 +1000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606251553110.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: wildfire@progsoc.uts.edu.au
X-SA-Exim-Scanned: No (on incubus.progsoc.uts.edu.au); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22634>

On Sun, Jun 25, 2006 at 04:00:34PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 25 Jun 2006, Anand Kumria wrote:
> 
> > Allowing 'yes' and 'no' to equal 'true' and 'false' respectively sounds
> > pretty sane and user-friendly.
> > 
> > Why wouldn't you want to do that?
> 
> 'Cause you'd have to add "maybe", too ;-)
> 
> Seriously, there is a subtle side to booleans, which is the reason that 
> they typically take on only "false" and "true": Consider the question "Is 
> the box not red?". If the answer is "yes", I do not know if "yes, the box 
> is red" or "yes, the box is not red".
> 
> "true" and "false" are less ambiguous.

"True, the box is red" and "true, the box is not red" are just as ambiguous.
It is always ambiguous if you allow a qualifier.

Cheers,
Anand

-- 
 `When any government, or any church for that matter, undertakes to say to
  its subjects, "This you may not read, this you must not see, this you are
  forbidden to know," the end result is tyranny and oppression no matter how
  holy the motives' -- Robert A Heinlein, "If this goes on --"
