From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Sun, 25 Jul 2010 11:47:47 +1000
Message-ID: <AANLkTikEo=Qw56WCxkFdmGqQcQoiTsnBy+Dt6zHpkOii@mail.gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 
	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 
	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 
	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> 
	<4C49B31F.8000102@xiplink.com> <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com> 
	<AANLkTinhd2DYh7WXzMvhMkqp98fYtTWWuQi0RSL9Rome@mail.gmail.com> 
	<AANLkTimLayG_HFxGdq+Tt8hU_MApBpSdHHiYPxcakpRJ@mail.gmail.com> 
	<AANLkTikx5EtQ0yvdkqN1Q1QAudFZfbd+_jpoa9ztLrz1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Sun Jul 25 03:48:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcqKH-0003sj-Vy
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 03:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041Ab0GYBsL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 21:48:11 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46490 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab0GYBsJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jul 2010 21:48:09 -0400
Received: by pzk26 with SMTP id 26so614154pzk.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 18:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=FLfKgHGRP15oB1yVok0EhAmBFRoQoN2z8jo1n1HPjNA=;
        b=D86/syKiStTkT/5Qb6dbQPl780pBDoA+8REj3+v1F/yPADPAtDtTE0OXkByiYGmBE6
         7f7u+7v6FQqBwNyWYh0qf1uD61vo4NDkdSHryONFMkEJ20B2IdlNwaKmmRMuBkU0Otvg
         RVeAv+RbK2EtybCpUuEOpdxc0lT0JvMgaqVr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TUHLzESCwSISOx0LhdLl7f7t37UN/DMBSprIUfNbWzdtWu7KR+gAGAxYZRaKY6zrog
         zcZoyGCLQKAgJqxS+90Zb9Cat0w4QHGznm9O/hN5BVf9NgfTFYwEdogT6TKX5Nnr+3DF
         H27mDDFq6CyEgqzYajYrN2rLEpLnQTLjVQo14=
Received: by 10.142.164.3 with SMTP id m3mr6597914wfe.297.1280022488384; Sat, 
	24 Jul 2010 18:48:08 -0700 (PDT)
Received: by 10.142.98.1 with HTTP; Sat, 24 Jul 2010 18:47:47 -0700 (PDT)
In-Reply-To: <AANLkTikx5EtQ0yvdkqN1Q1QAudFZfbd+_jpoa9ztLrz1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151702>

On Sun, Jul 25, 2010 at 5:40 AM,  <skillzero@gmail.com> wrote:
>>> (although just having all those objects in
>>> the .git directory still slows it down quite a bit).
>>
>> You're the second person who has mentioned this today (the first one
>> was to me in a private email). =C2=A0I'd like to understand this bet=
ter.
>
> What I'm basing this on is that even when I'm using a sparse checkout
> such that I have only a small subset of the files in my working
> directory, git status seems singifncantly slower for me than an
> equivalent git repository that only has that subset of files. That's
> not very scientific, but that's what made me think just having a larg=
e
> .git directory with lots of objects/history slows down git status eve=
n
> if the working copy doesn't have a lot of files.

Hmm... I recall I experienced some slower operations on webkit with
sparse checkout too.

>
> I will try to experiment and see if I can narrow it down with some re=
al numbers.

Yes, I'd appreciate that.

By the way, how hard is it to use git-replace to implement narrow clone=
?
--=20
Duy
