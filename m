From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: [PATCH 0/5] de.po suggested updates
Date: Wed, 2 May 2012 19:52:37 +0200
Message-ID: <CAN0XMOKBArgEJ1wE3A_rfoGQuJoJ1HX5LGG_JQVBZOEq7OF=ww@mail.gmail.com>
References: <87d36n2f2r.fsf@thomas.inf.ethz.ch>
	<cover.1335966202.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 02 19:52:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPdjJ-0003zs-Ei
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 19:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491Ab2EBRwl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 13:52:41 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45442 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755424Ab2EBRwk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2012 13:52:40 -0400
Received: by yenm10 with SMTP id m10so441020yen.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 10:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=0nip4QIKSCt9hDSKg9BbO+bqX0EnBa3tB0c/trntunM=;
        b=Qr7+2IW7D4QfehZt9Mtap0pOtVZqN5bT1N3xcyoHUisz9HTkMVGn4RgMy+usCuSzUe
         XicS0gG6tFimJp7IIuMqcwD0aD/vaj98jAAD1W664Ie72tXYMEgHCoiusfDucoQSki9U
         +QwWLCWNvdEiYXsASLPPzq5w87b6cfZPepIScawpeo6YOJlp3WddOlPbEVy+0PvDItrw
         fBtunW7X6ZvXTTbwLD6HVbIWAXDV4KKAZwbbfFdmkMiKAi5ait9oqWQuP3LYrn9RLH1m
         EI4hd6L7bc16bmCzH0cjU9b3LAEP8hcqvWc793PUJZzE5NsDkb6Iw2eqpYlfdUtwSMVT
         WMZg==
Received: by 10.236.182.131 with SMTP id o3mr32221152yhm.113.1335981157390;
 Wed, 02 May 2012 10:52:37 -0700 (PDT)
Received: by 10.146.203.1 with HTTP; Wed, 2 May 2012 10:52:37 -0700 (PDT)
In-Reply-To: <cover.1335966202.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196848>

> [2/5] does away with the "bare"->"leer" issue that I used as an
> =C2=A0 =C2=A0 =C2=A0example earlier. =C2=A0There's precedent in git-g=
ui :-( This does
> =C2=A0 =C2=A0 =C2=A0raise the question if it's kosher to patch both g=
it and git-gui
> =C2=A0 =C2=A0 =C2=A0at the same time, but if we want to keep the tran=
slations in
> =C2=A0 =C2=A0 =C2=A0sync it probably won't be the last such patch.
>
> [3/5] collects all the "obvious" stuff
>
> [4/5] and [5/5] gather the less-obvious stuff -- keep what you like.

Looks good.

I applied 2-4 and most of the 5th (i'll comment it for itself)  on my
maint branch.

Thanks
