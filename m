From: Michal Nazarewicz <mina86@tlen.pl>
Subject: Re: Write and Submit Your First Kernel Patch
Date: Fri, 23 Oct 2009 21:41:33 +0200
Message-ID: <87vdi5uccy.fsf@erwin.mina86.com>
References: <dc1d0f40910231146y14028f4el9753debdf334103@mail.gmail.com>
	<87zl7hudn4.fsf@erwin.mina86.com>
	<dc1d0f40910231219l600d3579i57c7580fe798d445@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: linux-newbie@vger.kernel.org, kernel-janitors@vger.kernel.org,
	git@vger.kernel.org
To: Kevyn-Alexandre =?utf-8?Q?Par=C3=A9?= 
	<kevyn.alexandre.pare@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 21:41:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1Q1I-0002iu-Ff
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 21:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132AbZJWTlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 15:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753121AbZJWTlk
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 15:41:40 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:35548 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097AbZJWTli (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 15:41:38 -0400
Received: by fxm18 with SMTP id 18so10625826fxm.37
        for <multiple recipients>; Fri, 23 Oct 2009 12:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :references:x-url:x-pgp-fp:x-pgp:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=jhHh2i/Wx+mmMeDZnnRR0bK/bESUYteVesJujdSzcWc=;
        b=B1ckIBVOpzZa9tZPLXHYiFN555895b4K+l6g60Zhb0B44ht+JKHsi5qLoRl8S8I/Fz
         ny+HjHhb0rMlbO+HPj+QWdT8Sg34D0QcTRAwsj5V+VRzcTec278YVfaK5Br3QFAHDsIE
         qYqiCGyFhPyuohkHht8m0hgAwOPigiGQamGTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:references:x-url:x-pgp-fp:x-pgp:date
         :in-reply-to:message-id:user-agent:mime-version:content-type;
        b=ZS6NHwuC0im98Exp+B6BXf6IbHHzUg/uuciV2ekhH7uPXR1LmUzeha0DQfLa0f+SKt
         suPFh7NarCr5K/UD5er+Hv3IPjKRWt7SmuRkr5847eFrEO/6sPWSbOGbsWz8lXhg/5Dd
         LlsT7Xlfu4XYpmvxZ0sMbqpxtck2Xesj2R4VY=
Received: by 10.204.162.143 with SMTP id v15mr4499207bkx.50.1256326901656;
        Fri, 23 Oct 2009 12:41:41 -0700 (PDT)
Received: from erwin.piotrekn (aaru70.neoplus.adsl.tpnet.pl [83.5.206.70])
        by mx.google.com with ESMTPS id 13sm643240bwz.6.2009.10.23.12.41.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Oct 2009 12:41:40 -0700 (PDT)
X-Url: http://mina86.com/
X-PGP-FP: 9134 06FA 7AD8 D134 9D0C  C33F 532C CB00 B7C6 DF1E
X-PGP: B7C6DF1E
In-Reply-To: <dc1d0f40910231219l600d3579i57c7580fe798d445@mail.gmail.com>
	("Kevyn-Alexandre =?utf-8?Q?Par=C3=A9=22's?= message of "Fri, 23 Oct 2009
 15:19:32
	-0400")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (Slckware Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131121>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>> Kevyn-Alexandre Par=C3=A9 <kevyn.alexandre.pare@gmail.com> writes:
>>> 0001-Staging-comedi-driver-fix-coding-style.patch:27: ERROR: trailing w=
hitespace
>>> 0001-Staging-comedi-driver-fix-coding-style.patch:35: ERROR: trailing w=
hitespace
>>> 0001-Staging-comedi-driver-fix-coding-style.patch:43: ERROR: trailing w=
hitespace
>>> 0001-Staging-comedi-driver-fix-coding-style.patch:53: ERROR: trailing w=
hitespace
>>>
>>> I have done a step by step explanation of what I have done:
>>> http://kapare.blogspot.com/2009/09/write-and-submit-your-first-kernel.h=
tml>>
>>> It seem to me that the whitespace are added after I do this command:
>>> git format-patch -s -n master..mybranch

> On Fri, Oct 23, 2009 at 3:13 PM, Michal Nazarewicz <mina86@tlen.pl> wrote:
>> Do "git rebase --whitespace=3Dfix master" and git will try to fix whites=
paces.

Kevyn-Alexandre Par=C3=A9 <kevyn.alexandre.pare@gmail.com> writes:
> thx Michal,
>
> But the problem remain:

If I'm not mistaken "git rebase --whitespace=3Dfix master" should do the
trick.  I'm out of good ideas if it does not.  Best I can advice is to
fix the patch by hand -- just edit it in some decent editor and remove
trailing whitespaces from those lines.

=2D-=20
Best regards,                                         _     _
 .o. | Liege of Serenly Enlightened Majesty of      o' \,=3D./ `o
 ..o | Computer Science,  Michal "mina86" Nazarewicz   (o o)
 ooo +--<mina86*tlen.pl>--<jid:mina86*jabber.org>--ooO--(_)--Ooo--

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkriBvEACgkQUyzLALfG3x535wCfXiB4Rz1/uNltpt4jPUd2fn8c
aAoAnAhCF4je11wA2ABlNjfxYkiwsqwO
=0e6t
-----END PGP SIGNATURE-----
--=-=-=--
