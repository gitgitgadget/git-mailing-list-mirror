From: Kevin Ballard <kevin@sb.org>
Subject: Re: Manual hunk edit mode + emacs + ^G == garbage
Date: Thu, 14 Oct 2010 02:47:11 -0700
Message-ID: <53E15760-FFC2-490F-8DA6-C5BD687089D5@sb.org>
References: <39CB17A9-2717-491B-8E01-F3E855F90649@sb.org> <AANLkTimM92SdY_+v5JcOx2kYbDKBJJzBofFm0FLF_S6K@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 11:47:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6KPA-00045U-UU
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 11:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755079Ab0JNJrQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 05:47:16 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38491 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961Ab0JNJrP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 05:47:15 -0400
Received: by qwa26 with SMTP id 26so1529700qwa.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 02:47:14 -0700 (PDT)
Received: by 10.224.28.139 with SMTP id m11mr3433473qac.123.1287049634697;
        Thu, 14 Oct 2010 02:47:14 -0700 (PDT)
Received: from [10.0.1.14] (c-24-130-32-253.hsd1.ca.comcast.net [24.130.32.253])
        by mx.google.com with ESMTPS id i70sm2471666yha.22.2010.10.14.02.47.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 02:47:13 -0700 (PDT)
In-Reply-To: <AANLkTimM92SdY_+v5JcOx2kYbDKBJJzBofFm0FLF_S6K@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159040>

On Oct 14, 2010, at 2:37 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:

> On Wed, Oct 13, 2010 at 21:37, Kevin Ballard <kevin@sb.org> wrote:
>=20
>> I've been having a rather strange problem using manual hunk edit mod=
e (`git add -p`, e)
>=20
> Aside from this bug you might want to check out magit.el, it's a much
> nicer hunk edit more for Emacs than running git add -p in an Emacs
> terminal is.

Except I don't run it in an emacs terminal. I run it in my regular term=
inal, and only launch emacs when I need to in order to edit a hunk or w=
hatnot.

BTW, it also appears that this happens in the normal `git commit` edito=
r as well, I just hadn't noticed before since I rarely need to type ^G =
when writing a commit message.

-Kevin Ballard