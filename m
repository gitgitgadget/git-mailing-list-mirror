From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Which msysGit version corresponds to which official Git version?
Date: Sat, 24 May 2008 17:26:02 +0200
Message-ID: <3F512BCF-1D2E-46B0-84E5-4807753A2618@zib.de>
References: <48380E05.9020103@dirk.my1.cc>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sat May 24 17:26:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzvdh-0002lx-20
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 17:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbYEXPZg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 May 2008 11:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754308AbYEXPZg
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 11:25:36 -0400
Received: from mailer.zib.de ([130.73.108.11]:36891 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753225AbYEXPZf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 May 2008 11:25:35 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m4OFPSmA001536;
	Sat, 24 May 2008 17:25:33 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db90617.pool.einsundeins.de [77.185.6.23])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m4OFPNRX023020
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 24 May 2008 17:25:24 +0200 (MEST)
In-Reply-To: <48380E05.9020103@dirk.my1.cc>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82817>


On May 24, 2008, at 2:45 PM, Dirk S=FCsserott wrote:

> I'm using msysGit. Upon shell startup it says
> "Welcome to Git (version 1.5.5-preview20080413)".
> That's the latest msysGit version.
>
> git --version says "git version 1.5.5.1015.g9d258"
>
> I'd like to know which official Git version (as cloned
> from git://git.kernel.org/pub/scm/git/git.git) corresponds
> to my msysGit version.

It's not in official git.git.  msysgit is based on official
git 1.5.5, i.e. tag v1.5.5 (9d8318051).  msysGit adds, however,
a lot of commits that are (not yet) in official git.git.


> git checkout 9d258 didn't work.
>
> Any hints? Is there a Website or another mailing
> list for msysGit?

http://code.google.com/p/msysgit/

	Steffen
