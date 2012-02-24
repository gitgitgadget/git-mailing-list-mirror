From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [Not A BugReport] git tag -a / git show
Date: Sat, 25 Feb 2012 00:14:39 +0100
Message-ID: <m2fwdzzuw0.fsf@igel.home>
References: <b05f03b381140ca57a7d03a934f605bd@rom1v.com>
	<7vsji0yprw.fsf@alter.siamese.dyndns.org>
	<1330113528.2727.5.camel@rom-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Romain Vimont =?utf-8?Q?=28=C2=AEom=29?= <rom@rom1v.com>
X-From: git-owner@vger.kernel.org Sat Feb 25 00:14:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S14Lg-0004bY-9X
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 00:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346Ab2BXXOp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 18:14:45 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:36529 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264Ab2BXXOn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 18:14:43 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3TvpDK1NCpz3hhVp;
	Sat, 25 Feb 2012 00:14:39 +0100 (CET)
X-Auth-Info: XNU+QoM3vkoDMe8K1OGan+no+iRdjy/tbzkLa8WpTUo=
Received: from igel.home (ppp-93-104-155-43.dynamic.mnet-online.de [93.104.155.43])
	by mail.mnet-online.de (Postfix) with ESMTPA id 7ED9E1C00343;
	Sat, 25 Feb 2012 00:14:42 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 4C594CA299; Sat, 25 Feb 2012 00:14:39 +0100 (CET)
X-Yow: A wide-eyed, innocent UNICORN, poised delicately in a MEADOW filled with
 LILACS, LOLLIPOPS & small CHILDREN at the HUSH of twilight??
In-Reply-To: <1330113528.2727.5.camel@rom-laptop> ("Romain Vimont
 =?utf-8?Q?=5C=22=28=C2=AEom=29=5C=22=22's?=
	message of "Fri, 24 Feb 2012 20:58:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191499>

Romain Vimont "(=C2=AEom)" <rom@rom1v.com> writes:

> To what other type of object can you apply a tag ?

Any.  Take a look at the junio-gpg-pub tag in git's repository, or the
v2.6.11-tree tag in Linus's kernel repository.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
