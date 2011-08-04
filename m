From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: gitweb highligh generate illegal char when the content had utf-8 chars
Date: Thu, 4 Aug 2011 15:35:41 +0530
Message-ID: <CALkWK0kOTXyevPy0Ys+pWwGjr2NSo3+ifhWuPVU+=FL=LC=J7A@mail.gmail.com>
References: <20110804053123.GA13198@greatfirst.com> <CALkWK0kURz_Rax-JOPT2sW1x4VrqWk=KDjUzzw4apacDo1UTyg@mail.gmail.com>
 <CANQwDwcR5sS3-m6SifQbjU1VoS5bxRRGJNZZj0U+zp=zsoGbLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
To: zzs <zzs213@126.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 12:06:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qouoc-0006aF-2F
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 12:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057Ab1HDKGG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Aug 2011 06:06:06 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50829 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab1HDKGD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2011 06:06:03 -0400
Received: by wyf22 with SMTP id 22so403230wyf.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 03:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=8CBqeYQVR4w4fc9gkP31bUttcQnJBNqNuWbelttbLD4=;
        b=xOSEkU4TNvR6M20KwNynIn0PeI+TtPaf7QSocF3TvFZETBvZcODxcfcXhSNmdrdLNZ
         /7jITwQvEmxWrYX/IaHGVm0XPet4YRVnGu/saX4JRh49i+vjQE37dT2PS1O+vEEmB7wO
         5szsOYz28HndyEJSKZvZ1LmRoMvdRZ33mKgaA=
Received: by 10.216.188.207 with SMTP id a57mr522975wen.94.1312452362127; Thu,
 04 Aug 2011 03:06:02 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Thu, 4 Aug 2011 03:05:41 -0700 (PDT)
In-Reply-To: <CANQwDwcR5sS3-m6SifQbjU1VoS5bxRRGJNZZj0U+zp=zsoGbLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178715>

Hi,

Jakub Nar=C4=99bski writes:
> This looks correct.

Thanks Jakub.

>> zzs writes:
>>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>>> index dab89f2..48def38 100755

Please submit a nicely formatted patch with proper signoff so that we
can consider this for inclusion.  Refer to
Documentation/SubmittingPatches for more details.

Thanks.

-- Ram
