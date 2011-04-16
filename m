From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Applicatioin of contribution for Git Chinese version
Date: Sat, 16 Apr 2011 18:55:40 +0200
Message-ID: <BANLkTintJ6FsYAQ1iV1kygwOdtsFtCs3EA@mail.gmail.com>
References: <559debc.6920e.12f5f0bdfc0.Coremail.cyrus_evans@163.com>
	<BANLkTi=29fvnLYVnsjpYXfaB20=H6D6fcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: "Cyrus.Evans" <cyrus_evans@163.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 18:55:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QB8mi-0001Lw-LD
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 18:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab1DPQzq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Apr 2011 12:55:46 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57164 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab1DPQzm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2011 12:55:42 -0400
Received: by fxm17 with SMTP id 17so2323874fxm.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 09:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jfCMfWvYL2IkE5/pkYzz33tOnOjUKTdJG9Q8zweVLcM=;
        b=b0D42wTOHtbXXgWYfuduxpSVeGjWU9ayP4EOacnbBdbNMkk/4wgseENDPRoOU6uVQY
         0keYVVPK4qXE9b7T9IPxlgHMYz5B7/VKOMb/9EwCPWPfkWdw657BLUrshKvcr551OiYQ
         Sejlt9+ufRQeasHid5mIH4jrnU3g9DU62Cg1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ksRphUhawmNlqlUuo6Eu6S0QNaapWROiD1zjZpmotgV4367zY/HJoSbeNbwx0pGEJ+
         V6amNDY8V89nJIUsTVmvQUJ6L2kXC8wto1aTLIE0RBGOn1CEVUGUD6H02DFIagGWEhaP
         ym0OSaYhYraoLKFdKuF4RzGiB4pQGT5ANJx1M=
Received: by 10.223.60.81 with SMTP id o17mr3235394fah.48.1302972940714; Sat,
 16 Apr 2011 09:55:40 -0700 (PDT)
Received: by 10.223.105.201 with HTTP; Sat, 16 Apr 2011 09:55:40 -0700 (PDT)
In-Reply-To: <BANLkTi=29fvnLYVnsjpYXfaB20=H6D6fcg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171682>

On Sat, Apr 16, 2011 at 18:34, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:

> In particular I was thinking of using some web interface for
> translation, but that would probably be hard to work out with
> accounting for who did what, which would play badly with Git's signof=
f
> policies.

It was clear from talking on IRC that having them use PO wouldn't get
anywhere.

So I've created https://translations.launchpad.net/git-i18n

It has strings from git's master + the shellscript translations.

I've set the translation policy to "open", so anyone can contribute
there. We can figure out the legal mumbo-jumbo later.

Translating there will work once the Launchpad people review & accept
the POT file I uploaded. I have no idea how long that takes.
