From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008
	projects?
Date: Tue, 8 Jul 2008 03:00:50 +0200
Message-ID: <20080708010050.GD6726@leksak.fem-net>
References: <200807080227.43515.jnareb@gmail.com>
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
	Daniel Barkalow <barkalow@iabervon.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 03:01:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG1ac-00027B-Q0
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 03:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143AbYGHBA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 21:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755135AbYGHBA6
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 21:00:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:46980 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755134AbYGHBA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 21:00:57 -0400
Received: (qmail invoked by alias); 08 Jul 2008 01:00:55 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp029) with SMTP; 08 Jul 2008 03:00:55 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18ScRxCEmoSkZAL7N9EN3EVeyxmqfE0qQSwJoTZqn
	SL74wT8EkLQddH
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KG1Za-0008MG-Ld; Tue, 08 Jul 2008 03:00:50 +0200
Content-Disposition: inline
In-Reply-To: <200807080227.43515.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87677>

Hi,

> 6. git-sequencer (!)
> 
> Student: Stephan Beyer
> Mentor: Christian Couder, Daniel Barkalow
> 
> It started with discussion over TODO file format:
>   http://thread.gmane.org/gmane.comp.version-control.git/84230
> 
> Now there is prototype shell script implementation (which has some 
> limitations because it is prototype) in "git sequencer prototype"
>   http://thread.gmane.org/gmane.comp.version-control.git/86985
> 
> Stephan Beyer wrote:
>   I'm using sequencer-based git-am and git-rebase-i and also 
>   git-sequencer itself for around 2-3 weeks now. So, for me, it is
>   reality-proven [...]

That's a nice "summary".
Imho the prototype patchset needs some more review from others.
(Well, I think the
   http://thread.gmane.org/gmane.comp.version-control.git/86985
thread died in the last days, but I hope some responses will come and
also that Junio's patch for cherry-picking root commits will be
included. I try to be patient...) ;-)

You may also add a little note, that I have started the builtin sequencer,
but I cannot provide really big news here :-)

Thanks for your overall git GSoC engagement,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
