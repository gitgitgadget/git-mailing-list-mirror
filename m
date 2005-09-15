From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
Date: Thu, 15 Sep 2005 09:07:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509150905070.26803@g5.osdl.org>
References: <7255.1126583985@kao2.melbourne.sgi.com>
 <1126674993.5681.9.camel@localhost.localdomain> <1126745323.7199.3.camel@localhost.localdomain>
 <Pine.LNX.4.58.0509142018410.26803@g5.osdl.org> <43290486.5020301@zytor.com>
 <7v7jdibwqq.fsf@assigned-by-dhcp.cox.net> <u5tvf12sp1v.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 18:10:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFwGh-0005PN-JT
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 18:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506AbVIOQHT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 15 Sep 2005 12:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030507AbVIOQHT
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 12:07:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24753 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030506AbVIOQHS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 12:07:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8FG7EBo029384
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Sep 2005 09:07:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8FG768K008669;
	Thu, 15 Sep 2005 09:07:11 -0700
To: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
In-Reply-To: <u5tvf12sp1v.fsf@lysator.liu.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8613>



On Thu, 15 Sep 2005, David K=E5gedal wrote:
>
> On my Debian system, there is a "sensible-pager" which does a
> ${PAGER:-pager}, and "pager" which is a symlink to an installed pager
> (using the 'alternatives' system).  So a Debian package should
> probably use one of those.

Ok, this is now indisputable proof that Debian people are insane.

They have "sensible-pager", but not "less"?

Guys, somebody should visit a few Debian people with a baseball bat tha=
t=20
is painted bright neon yellow, and has "CLUEBAT" written in big purple=20
letters on it. And beat them to a quivering pulp.

There's "being flexible", and there's "being a total ass". Debian is be=
ing=20
a total ass.

		Linus
