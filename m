From: Petr Baudis <pasky@suse.cz>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Wed, 9 May 2007 15:14:34 +0200
Message-ID: <20070509131434.GS4489@pasky.or.cz>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <8b65902a0705070440t40889af0p1fb8dbf7e2a072e4@mail.gmail.com> <Pine.LNX.4.64.0705071453120.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 09 15:15:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlm0Y-0001hd-2s
	for gcvg-git@gmane.org; Wed, 09 May 2007 15:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756620AbXEINOh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 09:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756484AbXEINOh
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 09:14:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52828 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754475AbXEINOg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 09:14:36 -0400
Received: (qmail 19896 invoked by uid 2001); 9 May 2007 15:14:34 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705071453120.4167@racer.site>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46712>

  Hi,

On Mon, May 07, 2007 at 02:55:13PM CEST, Johannes Schindelin wrote:
> On Mon, 7 May 2007, Guilhem Bonnefille wrote:
> 
> > As a newbie, I'm agree with Matthieu: the Git's index is surprising for 
> > people coming from CVS/SVN (mindless?) world. So a good documentation 
> > about this, even in tutorials, is really important.
> 
> So, you are not only a newbie, but you have to unlearn some CVS 
> braindamage.
> 
> I don't know how to make it even more prominent that CVS users should read 
> a special introduction first. AFAICT such a hint is in all the appropriate 
> places. (I mean, you would not expect to be able to fly a plane, just 
> because you have learnt to drive a car, wouldn't you?)

  http://www.kernel.org/pub/software/scm/git/docs/tutorial.html does not
talk about anything like that (it links to "Git for CVS users" but
that's really just about importing from CVS and the shared repository
workflow).

  On the other hand, I think the tutorial linked above gives quite a
clear explanation of git commit -a, git add etc. Guilhem, what do you
find missing in the tutorial about this topic?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
