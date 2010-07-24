From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Sat, 24 Jul 2010 15:07:13 -0500
Message-ID: <AANLkTi=Qp5CNCe=V2LCH2_EcTkxSpJ6+EHkk_BmUr9+B@mail.gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 
	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 
	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 
	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> 
	<4C49B31F.8000102@xiplink.com> <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 22:15:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocl8X-0002rj-Kd
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 22:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030Ab0GXUPn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 16:15:43 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38200 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822Ab0GXUPm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jul 2010 16:15:42 -0400
Received: by gwb20 with SMTP id 20so1072300gwb.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 13:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=JmWwbNrePP4ts2QmQ+qnfkjZ+UePpM+x4XmBfYplAg4=;
        b=TSPHTCAQLqsap7PZa0LEighKUxnj35xroPLopokaBqi7Tw6fEz+fDuLy86MJ3aLJIk
         5WY+svnZ02wQPYSx/CD7YtfrHRbvNoTN3MXl9mXt7lOWab4Q1++1tznhaP6+q0m7MTzb
         fCUunALHdFBisCZHCMMu0nJM/Q/OCm86YHxAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sw8Km6RISB2Rtl7/N4hgeRroiEqfkm2yg0A8Nu3PdvLPyIviaD7/0tRYLS0IUignl3
         bqDV6m5xBpWddvbPzzEeUBVtEalBSbUQHBTZYpvVOmVVFqMFRvsYXZRUPM6Qr2UuWxjd
         GCDZ2JG62FmZ9E1NHpQcpvvr01uxkn2H8WwN0=
Received: by 10.150.75.5 with SMTP id x5mr4236713yba.99.1280002053212; Sat, 24 
	Jul 2010 13:07:33 -0700 (PDT)
Received: by 10.150.66.12 with HTTP; Sat, 24 Jul 2010 13:07:13 -0700 (PDT)
In-Reply-To: <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151668>

Heya,

On Fri, Jul 23, 2010 at 17:50, Avery Pennarun <apenwarr@gmail.com> wrot=
e:
> IMHO, the correct answer here is to have an inotify-based daemon prod
> at the .git/index automatically when files get updated, so that git
> itself doesn't have to stat/readdir through the entire tree in order
> to do any of its operations. =C2=A0(Windows also has something like i=
notify
> that would work.) =C2=A0If you had this, then git
> status/diff/checkout/commit would be just as fast with zillions of
> files as with 10 files. =C2=A0Sooner or later, if nobody implements t=
his, I
> promise I'll get around to it since inotify is actually easy to code
> for :)

=46rom what I've heard both SVN and Mercurial have something like that
and it's incredible unstable and icky and nasty and bad and will eat
your babies. Then again, I don't have any experience with inotify, so
if you say that it's all good and awesome, who am I to doubt that :).

--=20
Cheers,

Sverre Rabbelier
