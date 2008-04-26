From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Welcome to Git's GSoC 2008!
Date: Sat, 26 Apr 2008 13:29:45 -0400
Message-ID: <20080426172945.GD29771@spearce.org>
References: <20080422013201.GA4828@spearce.org> <m3d4odq3w1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 19:30:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpoEP-0008Ej-2z
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 19:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476AbYDZR3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 13:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754614AbYDZR3t
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 13:29:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60639 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbYDZR3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 13:29:48 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JpoDU-0007zp-FU; Sat, 26 Apr 2008 13:29:40 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4453D20FBAE; Sat, 26 Apr 2008 13:29:45 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <m3d4odq3w1.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80382>

Jakub Narebski <jnareb@gmail.com> wrote:
> I have found three another Git-related Google Summer of Code 2008
> projects by other organizations:
> 
>     Git plugin for Anjuta IDE  (GNOME)

This project was new to me; prior to your message I did not know
about it.  Thanks.

>     KDevelop DVCS support      (KDE)

I contacted this student/mentor pair and offered them our mailing
list address if they have questions.  Apparently the project is
trying to create some common DVCS abstractions but wants to use
Git as the first supported tool.

>     Git# implementation        (Mono Project)

I was talking to one of the two students on #git the other day.
Robin and I both think they are probably better off just taking jgit
and compiling it with ikvm so it runs on the Mono CLR.  From there
they can build their interface in C#.  Excluding the copyright header
in every source file, jgit is about 24,300 lines of code right now.
That's a lot to write in a summer, especially if you don't know
Git as well as say I do.

There is some concern from people who are close to the summer of code
program that two students working on the same project this summer may
result in one's success being dependent upon the other's success.
This sort of dependency is not permitted under the Summer of Code
rules, as it can be quite unfair to an otherwise successful student.

It will be interesting to see how everyone's project turns out at
the end of the summer.

-- 
Shawn.
