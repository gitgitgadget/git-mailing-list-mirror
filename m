From: Alec Warner <antarus@gentoo.org>
Subject: Re: irc usage..
Date: Wed, 31 May 2006 09:54:48 -0400
Message-ID: <447DA028.3040606@gentoo.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>	 <Pine.LNX.4.64.0605221312380.3697@g5.osdl.org>	 <447231C4.2030508@gentoo.org> <447B6D85.4050601@gentoo.org>	 <46a038f90605291521q37f34209wd923608bdebb9084@mail.gmail.com>	 <447B7669.8050805@gentoo.org>	 <46a038f90605301531g4f8b37c7qab9a717833c64ebc@mail.gmail.com>	 <Pine.LNX.4.64.0605301604130.24646@g5.osdl.org>	 <46a038f90605301804u3beabf4ct97c8a0ea6ef7b995@mail.gmail.com>	 <447D043D.1020609@gentoo.org> <46a038f90605302305g7a969a62r277af1724b912069@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Wed May 31 15:55:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlRAT-0006hS-6O
	for gcvg-git@gmane.org; Wed, 31 May 2006 15:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWEaNzN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 09:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbWEaNzN
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 09:55:13 -0400
Received: from jeeves.egr.msu.edu ([35.9.37.127]:15254 "EHLO egr.msu.edu")
	by vger.kernel.org with ESMTP id S965022AbWEaNzM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 May 2006 09:55:12 -0400
Received: from [35.9.140.215] (tokyo.dhcp.egr.msu.edu [35.9.140.215])
	(authenticated bits=0)
	by egr.msu.edu (8.13.6/8.13.4) with ESMTP id k4VDskIe012819
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 31 May 2006 09:54:51 -0400 (EDT)
User-Agent: Thunderbird 1.5.0.2 (X11/20060514)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605302305g7a969a62r277af1724b912069@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21063>

Martin Langhoff wrote:
> On 5/31/06, Donnie Berkholz <spyderous@gentoo.org> wrote:
>> We've got a guy who got a Summer of Code project to work on CVS
>> migration, so this could be something along his lines.
> 
> He'll want a fast box to wrangle with this repo ;-)
> 
> 
> martin

I have a dual opteron with 4gb of ram "on loan" from work :)

It still dies though, using git cvsimport or parsecvs.

I talked to Keith Packard about adding support to parsecvs for recording 
the actual changed changesets, but I haven't yet started on implementing 
that since he isn't using cvsps in parsecvs.

I also haven't had a chance to look at the git-cvsimport sources yet, 
was hoping to get to that later this week.
