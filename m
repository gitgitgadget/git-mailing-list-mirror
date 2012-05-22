From: Syed M Raihan <syed_raihan@yahoo.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Tue, 22 May 2012 18:30:13 +0000 (UTC)
Message-ID: <loom.20120522T201747-568@post.gmane.org>
References: <46DDC500.5000606@etek.chalmers.se><1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 20:35:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWtvP-00056O-IQ
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 20:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094Ab2EVSfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 14:35:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:47163 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625Ab2EVSfI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 14:35:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SWtvE-0004dH-G0
	for git@vger.kernel.org; Tue, 22 May 2012 20:35:04 +0200
Received: from 65.200.62.4 ([65.200.62.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 May 2012 20:35:04 +0200
Received: from syed_raihan by 65.200.62.4 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 May 2012 20:35:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 65.200.62.4 (Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:12.0) Gecko/20100101 Firefox/12.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198223>

Linus Torvalds <torvalds <at> linux-foundation.org> writes:

> 
> 
> On Wed, 5 Sep 2007, Dmitry Kakurin wrote:
> > 
> > When I first looked at Git source code two things struck me as odd:
> > 1. Pure C as opposed to C++. No idea why. Please don't talk about port,
> > it's BS.
> 
> *YOU* are full of bullshit.
> 
> C++ is a horrible language. It's made more horrible by the fact that a lot 
> of substandard programmers use it, to the point where it's much much 
> easier to generate total and utter crap with it. Quite frankly, even if 
> the choice of C were to do *nothing* but keep the C++ programmers out, 
> that in itself would be a huge reason to use C.
> 			Linus
> 

C++ has one weakness that is ABI compatibility among compilers.
Other than that Object Model does not make things horrible. 
I have seen 15 years old C++ application library which still 
uses old implementation to implement new enhancement/features 
that just works seamlessly and even an old dog can learn 
this old library written in C++.

I have seen C programmers constantly trying how they can mimic 
poly-morphism, inheritance and encapsulation in their C.
This is just *BS* - if you dont want C++ then dont use poly-morphism,
inheritance and encapsulation in your C code!
Or else just use C++ or Jave or C#.

Regards
Please note: I am really a Fan of Linus Torvalds since ever :)
Syed Raihan
