From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [GSoC] Git projects for Google Summer of Code 2008 final
	evaluation
Date: Fri, 5 Sep 2008 00:36:53 +0200
Message-ID: <20080904223653.GA15170@leksak.fem-net>
References: <200809042315.58898.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 00:38:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbNSz-0000ct-Ok
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 00:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795AbYIDWhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 18:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754775AbYIDWhB
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 18:37:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:36212 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754722AbYIDWhA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 18:37:00 -0400
Received: (qmail invoked by alias); 04 Sep 2008 22:36:56 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp066) with SMTP; 05 Sep 2008 00:36:56 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+snmUEhwysupQXvPAhh4ahDSsE6ulwOuOpbUa0TC
	6lcT/EIattB7OA
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KbNRd-0004lB-8I; Fri, 05 Sep 2008 00:36:53 +0200
Content-Disposition: inline
In-Reply-To: <200809042315.58898.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94968>

Hi,

my reply belongs to:
> 6. git-sequencer
> 
> Student: Stephan Beyer
> Mentor: Christian Couder, Daniel Barkalow

Jakub Narebski wrote:
[...]
> So students and mentors, please write what do you think current status 
> of project is: is it done, is it ready, is it perhaps already merged 
> in, or can be merged in at any time.

It is done, but not ready.

This means, we, my mentors and I, are currently still reviewing the code.
But I am pinched for time until the end of September due to an important
exam. My mentors also have not much time and so everything is a little
slowed down.
When they ACK, it will be sent to the list.

> Please write also what wasn't done, or what should be done different
> way (hindsight and all that).

During the GSoC application phase I have done a breakdown and I declared
two items as "bonus" if I am really quick with the rest. But I wasn't
that quick, so none of the bonus items have even begun.

Those were:
 6. [bonus] rewrite the users in C
 7. [bonus] discuss (with git development team and/or mentor)
    sequencer features needed for gitk and implement them

Now I think (7) is even more needed/interesting, e.g. to be able to do
interactive rebasing with gitk.

And (6) shouldn't be that hard, but it will be even more interesting when
sequencer is libified. I have some ideas for that, but I think, this is
not so important in near time. Perhaps, there are other parts that need
some libification first. :)

> Students, could you please tell us if you plan to work on git further, 

Yes!

But due to my current lack of time I have ignored some topics on the
list that I am interested in. :-(

> and in what range (how much time can you get to work on git).

This is fluctating.

> What do you think about git development community?

Strange people. Lunatics. Geeks.

:-)

> What have you learned from participating in GSoC?

In the beginning: portable shell is a mess. ;)
Well, I guess I have learned a lot more...

Regards,
 Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
