From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] po/hi.po: Add Hindi Translation
Date: Sun, 5 Sep 2010 19:07:08 +0000
Message-ID: <AANLkTinL+uG5V2G81yROxyNSapkZ-8mfMEE4SBdh--A-@mail.gmail.com>
References: <1283711267-27679-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 21:07:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsKYf-00036D-LA
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 21:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516Ab0IETHK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 15:07:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41699 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459Ab0IETHJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 15:07:09 -0400
Received: by iwn5 with SMTP id 5so3488100iwn.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 12:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ESMMX8GZwndTOebb49PY2ULqkMGURXO8bk6tZ3AtvHI=;
        b=pMnwDVnRRINIIgj6dBsvM2Dw8hHYbadUtLqiH7+QJT6T+hh6+Sgt/rRmhLHpfJWeon
         akDrczWovWwNylND5vbDroZALcJXVlEoK3PQXXU6ELr5S8kGAAu0ketN1RkremrYrXti
         +j796rpSOOVmlzwXba2VNawQ5zqhNuuI3CAXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rvNa14sF2hIv5rCHvHJ12OPGbdHmoJ5ekzNWm31Li5ahR5U/R3jMyx2eX3HLgLGGNm
         A61QySStHKIwif+zKWvUwMR91oxikMNmMyVIbY1+Kio3xiig+/rij1BBxaChN/lkHlxA
         PEzX0khEdp24YXqKG3Esrs4JqXGGJDzCzW4Cg=
Received: by 10.231.148.20 with SMTP id n20mr4895854ibv.196.1283713628247;
 Sun, 05 Sep 2010 12:07:08 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sun, 5 Sep 2010 12:07:08 -0700 (PDT)
In-Reply-To: <1283711267-27679-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155475>

On Sun, Sep 5, 2010 at 18:27, Ramkumar Ramachandra <artagnon@gmail.com>=
 wrote:
> Translate a few Git messages to Standard Hindi. It uses a phonetic
> script called Devanagari. Focus especially on transforming grammar an=
d
> tense in a sane manner to serve as a guideline for future translators=
=2E
>
> Note that Devanagari rendering is broken on many applications by
> default at this time- the latest Emacs, Vim and Chrome render it
> incorrectly.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> Cc: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> =C2=A0Note that I don't know Hindi well myself- I read the grammar ru=
les,
> =C2=A0looked up some dictionaries, and used peer review to focus on f=
ew
> =C2=A0high-quality translations. The grammar/ tense transformation fr=
om
> =C2=A0English is especially non-trivial. I'd encourage an expert Hind=
i
> =C2=A0speaker to contribute to this.

I don't know Hindi either, but the gettext headers and everything else
about this looks OK. Thanks for contributing to translation.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
