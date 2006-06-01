From: Alec Warner <antarus@gentoo.org>
Subject: Re: irc usage..
Date: Wed, 31 May 2006 21:42:41 -0400
Organization: Gentoo
Message-ID: <447E4611.7000309@gentoo.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>	 <447B6D85.4050601@gentoo.org>	 <46a038f90605291521q37f34209wd923608bdebb9084@mail.gmail.com>	 <447B7669.8050805@gentoo.org>	 <46a038f90605301531g4f8b37c7qab9a717833c64ebc@mail.gmail.com>	 <Pine.LNX.4.64.0605301604130.24646@g5.osdl.org>	 <46a038f90605301804u3beabf4ct97c8a0ea6ef7b995@mail.gmail.com>	 <447D043D.1020609@gentoo.org>	 <46a038f90605302305g7a969a62r277af1724b912069@mail.gmail.com>	 <447DA028.3040606@gentoo.org> <46a038f90605311503o1526c664qe61b0f3f40929b92@mail.gmail.com>
Reply-To: antarus@gentoo.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Donnie Berkholz <spyderous@gentoo.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 01 03:44:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlcDz-0000hp-Fx
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 03:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWFABm7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 21:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbWFABm7
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 21:42:59 -0400
Received: from jeeves.egr.msu.edu ([35.9.37.127]:55952 "EHLO egr.msu.edu")
	by vger.kernel.org with ESMTP id S965149AbWFABm6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 May 2006 21:42:58 -0400
Received: from [69.176.143.70] (69-176-143-70.dov.spartan-net.net [69.176.143.70])
	(authenticated bits=0)
	by egr.msu.edu (8.13.6/8.13.4) with ESMTP id k511gct1027012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 31 May 2006 21:42:41 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060528)
X-Accept-Language: en-us, en
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605311503o1526c664qe61b0f3f40929b92@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21101>

Martin Langhoff wrote:
> On 6/1/06, Alec Warner <antarus@gentoo.org> wrote:
> 
>> I have a dual opteron with 4gb of ram "on loan" from work :)
>>
>> It still dies though, using git cvsimport or parsecvs.
> 
> 
> The machine I am running this is more constrained than that, and it
> doesn't die. It just takes maybe 30hs. Make sure it's not a bad cvs
> binary you got there (latest from gentoo seems to leak memory).
> 
> And if it's still dying... give us some more details ;-)
> 
> cheers,
> 
> 
> martin

After reading the whole thread on this, I've using a git checkout of 
git, cvsps-2.1 and cvs-1.11.12, running overnight in verbose mode with 
screen.  Hopefully will have a repo in the morning ;)
