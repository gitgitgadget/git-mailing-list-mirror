From: David Lang <david@lang.hm>
Subject: Re: An interesting opinion on DVCS/git
Date: Tue, 3 Mar 2015 16:53:34 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1503031642340.26501@nftneq.ynat.uz>
References: <54F2CD12.8050609@gmail.com> <CAGZ79kZ8CrjwVh3+OHSV1tv+fRXaDZ_diOO5E7QnSLZ=HTFSfg@mail.gmail.com> <CAJo=hJuKL3akaG3Xh8mH5iij_dAdMkBW8fQgvreOsUHV517gpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-1130144495-1425430414=:26501"
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 04 01:53:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSxZH-0005Ru-Rc
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 01:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756989AbbCDAxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 19:53:38 -0500
Received: from mail.lang.hm ([64.81.33.126]:59739 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756337AbbCDAxh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 19:53:37 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id t240rY65004057;
	Tue, 3 Mar 2015 16:53:34 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <CAJo=hJuKL3akaG3Xh8mH5iij_dAdMkBW8fQgvreOsUHV517gpw@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264713>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-1130144495-1425430414=:26501
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 3 Mar 2015, Shawn Pearce wrote:

> On Sun, Mar 1, 2015 at 7:29 PM, Stefan Beller <sbeller@google.com> wrote:
>> bitquabit.com/post/unorthodocs-abandon-your-dvcs-and-return-to-sanity
>
> Indeed, a DVCS like Git or Hg does not fit everyone. And neither do
> centralized systems like Subversion. Choice is good.
>
> However... I found some passages troubling for Git, e.g.:
>
> ---snip---
> Git is so amazingly simple to use that APress, a single publisher,
> needs to have three different books on how to use it. It’s so simple
> that Atlassian and GitHub both felt a need to write their own online
> tutorials to try to clarify the main Git tutorial on the actual Git
> website. It’s so transparent that developers routinely tell me that
> the easiest way to learn Git is to start with its file formats and
> work up to the commands.
> ---snap---
>
> We have heard this sort of feedback for years. But we have been unable
> to adequately write our own documentation or clean up our man pages to
> be useful to the average person who doesn't know why the --no-frobbing
> option doesn't disable the --frobinator option to the
> --frobbing-subcommand of git frob.  :(
>
> http://git-man-page-generator.lokaltog.net/ shouldn't exist and
> shouldn't be funny. Yet it does. :(

As for the different online tutorials, I'll point out that every university that 
supports it's students using Thunderbird has it's own version of a tutorial on 
how to use and configure Thunderbird. The question is if they are coverying 
their one use case of how to use git with their service, or if they are trying 
to duplicate the git documentation.


There are two reasons for having multiple books out for a piece of software

1. the software is horribly complicated to use, even for beginners

2. the software is extremely powerful, to to understand all the different 
advanced options, and when to use them, takes a lot of explination

In the case of git, there's a bit of both.

Part of the problem is that there are so many different ways to use it (all in 
common use) that there isn't one simple set of insructions that will be right in 
all the different use cases (thus the value of services that force users to 
operate in one specific model providing a tutorial in how to use it with their 
service)

At this point, Internet Lore says "git is hard to use", and if you approach any 
software with that attitude, you will find lots of things to point at to justify 
your opinion.

I'm not saying that there isn't room for improvement, I'm just saying that the 
evidence provided is not as one-sided as they make it sound.

David Lang
--680960-1130144495-1425430414=:26501--
