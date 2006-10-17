From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 19:18:38 -0400
Message-ID: <BAYC1-PASMTP05863EBDBCACA3C4F20E1CAE0E0@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610170119.09066.jnareb@gmail.com>
	<45346290.6050300@utoronto.ca>
	<200610171120.09747.jnareb@gmail.com>
	<1161078035.9020.73.camel@localhost.localdomain>
	<Pine.LNX.4.64.0610170921540.3962@g5.osdl.org>
	<1161124078.9020.88.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 18 01:18:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZyCr-0004pc-VT
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 01:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWJQXSm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 19:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWJQXSl
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 19:18:41 -0400
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:46621 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751087AbWJQXSk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 19:18:40 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 17 Oct 2006 16:18:39 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GZxGg-0007XQ-F9; Tue, 17 Oct 2006 18:18:38 -0400
To: Robert Collins <robertc@robertcollins.net>
Message-Id: <20061017191838.1c36499b.seanlkml@sympatico.ca>
In-Reply-To: <1161124078.9020.88.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Oct 2006 23:18:39.0820 (UTC) FILETIME=[946750C0:01C6F242]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 18 Oct 2006 08:27:58 +1000
Robert Collins <robertc@robertcollins.net> wrote:

> Be as blunt as you want. You're expressing an opinion, and thats fine. I
> happen to think that we're right : users appear to really appreciate
> this bit of the UI, and I've not yet seen any evidence of confusion
> about it - though I will admit there is the possibility of that
> occurring.

Yeah, but it's an opinion that is based on a huge real world project with
hundreds of developers.  If Bazaar is ever used in a project of that
size it may just see the same type of issues as Bk.  As has been mentioned
elsewhere, Git users really appreciate the short forms it provides for
referencing commits, so much so that there is no reason to invent a
new (unstable) numbering system or attempt to hide the true underlying
commit identities.

Just out of curiosity is there a Bazaar repo of the Linux kernel available
somewhere?

Sean
