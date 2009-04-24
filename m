From: Johan Herland <johan@herland.net>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 22:30:12 +0200
Message-ID: <200904242230.13239.johan@herland.net>
References: <m24owgqy0j.fsf@boostpro.com>
 <200904240051.46233.johan@herland.net>
 <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, David Abrahams <dave@boostpro.com>,
	Jeff King <peff@peff.net>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 22:32:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxS3s-00040V-D0
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 22:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbZDXUaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 16:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbZDXUaS
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 16:30:18 -0400
Received: from mx.getmail.no ([84.208.15.66]:36734 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751917AbZDXUaR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2009 16:30:17 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KIM00K49GYE4GB0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 24 Apr 2009 22:30:14 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KIM00LYUGYDZ430@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 24 Apr 2009 22:30:14 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.4.24.201636
User-Agent: KMail/1.11.2 (Linux/2.6.29-ARCH; KDE/4.2.2; x86_64; ; )
In-reply-to: <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117486>

On Friday 24 April 2009, Michael Witten wrote:
> On Thu, Apr 23, 2009 at 17:51, Johan Herland <johan@herland.net> wrote:
> > There's also http://www.eecs.harvard.edu/~cduan/technical/git/ which I
> > think is a great bottom-up introduction:
> > - not too heavy on the concepts
>
> I really don't understand this mentality. Concepts are the only things
> that are important. From concepts falls all else.

Sorry for not being clear: Concepts are indeed (and should be) important. 
What I mean is that the concepts introduced are short and simple enough for 
novice users to understand (without much VCS experience, if any at all). If 
we start off _too_ detailed, we risk loosing the audience, and no one is 
better off.

Like Jeff King said elsewhere in this thread: We want to start a little 
higher from the bottom. The above introduction does not focus on blobs or 
trees, but manages to introduce Git in a useful manner by starting off with 
only two concepts: commits and refs. With only these two concepts, and 
showing how high-level commands (remember: no plumbing) work with these 
concepts, I believe it is possible to teach anyone to use Git well. Of 
course, as users progress towards becoming power-users, more concepts are 
needed, but I don't think these are needed from the start.

As Einstein might have said: As simple as possible, but no simpler.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
