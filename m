From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-archive and core.eol
Date: Sun, 09 Jan 2011 13:52:16 +0100
Message-ID: <4D29AF80.5060008@lsrfire.ath.cx>
References: <AANLkTi=kfE88F7dY5F_xtbEuh9DyUcN+ymeXqLMWztGQ@mail.gmail.com> <4D28683B.4020400@lsrfire.ath.cx> <AANLkTi==eqwrwq-P6czDvOH5GDEi6WgvRUuZ2dMoiK7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>, eyvind.bernhardsen@gmail.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sun Jan 09 13:52:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pbul8-0004e9-At
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 13:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791Ab1AIMwY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jan 2011 07:52:24 -0500
Received: from india601.server4you.de ([85.25.151.105]:47491 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab1AIMwX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jan 2011 07:52:23 -0500
Received: from [192.168.2.104] (p4FFDBBDE.dip.t-dialin.net [79.253.187.222])
	by india601.server4you.de (Postfix) with ESMTPSA id 93AC02F806D;
	Sun,  9 Jan 2011 13:52:22 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTi==eqwrwq-P6czDvOH5GDEi6WgvRUuZ2dMoiK7e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164849>

Am 08.01.2011 18:28, schrieb Erik Faye-Lund:
> Really? I haven't looked through what the test actually does (I'm out
> sick right now, and don't have many working brain-cells), but every
> single test fails for me:
[...]
> $ git --version
> git version 1.7.4.rc1.3196.gfd693
>=20
> (This is the current 'devel'-branch from
> git://repo.or.cz/git/mingw/4msysgit.git)

I cloned it, but even though it reports a different version string for
me we probably use the same (fd6937e0e6ccb78eb4347c427248e25c2d6739c8):

	$ ./git version
	git version 1.7.3.4.3902.gfd693

And all the tests succeed for me (on Windows Vista Home Premium x64)
with that one.

I'm especially interested in how the setup step manages to fail for you=
=2E
 But first, get well soon!

Ren=E9
