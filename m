From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CRLF problems with Git on Win32
Date: Fri, 11 Jan 2008 21:18:49 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801112116180.31053@racer.site>
References: <C3AC3E6F.10D42%jefferis@gmail.com> <alpine.LFD.1.00.0801101556380.3148@woody.linux-foundation.org> <7EAB1DA8-627D-455E-AA23-C404FDC615D9@zib.de> <alpine.LFD.1.00.0801110756260.3148@woody.linux-foundation.org> <D36EB89D-11A3-4EAF-BC1C-6100383FCBFC@zib.de>
 <alpine.LFD.1.00.0801110924380.3148@woody.linux-foundation.org> <930EC77A-73D1-4DDD-81D4-BF22B248FCB6@zib.de> <alpine.LFD.1.00.0801111005360.3148@woody.linux-foundation.org> <14E7B5D5-B1B8-4532-A471-106B14B912B8@zib.de> <alpine.LFD.1.00.0801111103420.3148@woody.linux-foundation.org>
 <20080111195022.GC29189@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 22:19:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDRHm-0004aX-FT
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 22:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760180AbYAKVS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 16:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760157AbYAKVS6
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 16:18:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:40044 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759379AbYAKVS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 16:18:57 -0500
Received: (qmail invoked by alias); 11 Jan 2008 21:18:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 11 Jan 2008 22:18:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19QLMZ/atlQiF2qFdiV1uKr5LVsjCVhO/NXXjvkQY
	H8fWMyZ0m1FQVj
X-X-Sender: gene099@racer.site
In-Reply-To: <20080111195022.GC29189@uranus.ravnborg.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70204>

Hi,

On Fri, 11 Jan 2008, Sam Ravnborg wrote:

> On Fri, Jan 11, 2008 at 11:16:02AM -0800, Linus Torvalds wrote:
> 
> > (Every place I've ever been at, people who had a choice would never 
> > ever develop under Windows, so I've never seen any real mixing - even 
> > when some parts of the project were DOS/Windows stuff, there was a 
> > clear boundary between the stuff that was actually done under Windows)
> 
> The reality I see is the other way around as common practice.

Not in my world.

I see a few people who are stuck to Windows, but they are so because they 
are lazy.  They do not ever do something interesting with computers in 
their free time, and while working, they only do what they are told to do.

That might sound cynical, but you will have to _show_ me different 
examples to make me reconsider.

And no, my work with msysgit did a poor job to convince me otherwise.

Ciao,
Dscho
