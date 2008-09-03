From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Git User's Survey 2008 partial summary
Date: Wed, 3 Sep 2008 17:20:50 +0200
Message-ID: <20080903172050.61d510d6@pc09.procura.nl>
References: <200809031607.19722.jnareb@gmail.com>
	<20080903144552.GA27682@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 17:22:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KauBF-0005PB-GF
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 17:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbYICPUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 11:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbYICPUz
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 11:20:55 -0400
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:2771 "EHLO
	smtp-vbr15.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbYICPUy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 11:20:54 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr15.xs4all.nl (8.13.8/8.13.8) with ESMTP id m83FKoXK032240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Sep 2008 17:20:51 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <20080903144552.GA27682@spearce.org>
X-Mailer: Claws Mail 3.5.0cvs88 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94803>

On Wed, 3 Sep 2008 07:45:52 -0700, "Shawn O. Pearce"
<spearce@spearce.org> wrote:

> Jakub Narebski <jnareb@gmail.com> wrote:
> > This is partial summary of Git User's Survey 2008 [...]
> > 
> > 03. With which programming languages are you proficient?
> > 
> > Around 939 people answered this question.  C is most popular with 59%;
> > Ruby and surprisingly a bit shell script programming have around second
> > place, with about 52-53%.  More people are proficient with Python than 
> > in Perl by about 1/3-1/4.  Very few people (25 responses, around 3%)
> > feel proficient in Tcl/Tk, which means shallow pool of possible git-gui
> > and gitk contributors.

Rewrite them in perl or python and get more patches?
The fact that it is not perl withheld me from finding solutions to
problems I still have with the git-gui gitk combination

> > Java is quite popular with around 42%, which
> > gives hope in continued JGit/EGit development.

I would love to use git in Eclipse, but I tried again this week and
found the following problems

1. egit web site does not give you any clue about installation or
   integration with eclipse or how that could be done at all
2. I found no suitable eclipse-egit package for OpenSUSE 10.3, and the
   packages I /did/ find depended on packages not available for SuSE
   10.3

> Yea, I liked seeing that result from our user base.  42% of the
> respondants know Java as a language.  Not all of them may like
> programming in it for fun, but at least they claim they know it.  :-)

I *hate* programming in Eclipse, but some java projects here require me
to work with it. My preferred IDE is elvis (a vi clone)

> In the IDE part Eclipse received 13% (124 responses), which is
> almost close to Emacs (20%, 193 responses).  Sadly only 2% (19
> responses) use EGit.  There's probably a lot of reasons for that.
> Possibly the "egit_sux" tag on repo.or.cz.  Or our lack of a stable
> update site that users can install reasonably stable versions from.

/me fiercely nods!

-- 
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
