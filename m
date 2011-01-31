From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/2] Documentation/branch: split description into subsections
Date: Mon, 31 Jan 2011 02:55:41 +0100
Message-ID: <AANLkTin0M=K2OS2SmFWBGj3nasVzQY91Uectz+B1vsCm@mail.gmail.com>
References: <AANLkTin3Tfcf=WJHJdSA9TwhFXQfaMrnm5+YEWWjo=qj@mail.gmail.com>
 <20110130160556.GI5713@localhost.localdomain> <20110130213258.GA10039@burratino>
 <20110130213355.GB10039@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Melo_de_Sampaio?= <jpmelos@gmail.com>,
	GIT Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 03:04:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pjj8L-0005vg-3t
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 03:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352Ab1AaCEa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jan 2011 21:04:30 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45958 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab1AaCE3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jan 2011 21:04:29 -0500
Received: by ywe10 with SMTP id 10so1783886ywe.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 18:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=fDqjOHpxWMr1vGky/0/tLNBASZaMZYU57bxzkm0BOao=;
        b=Jqk2Hkr+bU4nXSX7WpKqFafEM8JjVlJ0qwS1LcSRpAbgoYmhV2ZNtGYB/V+qtvda5a
         2+NTwkhv2ITBM4cpm3tjY5JNlKDmSKBxqy/uy+y8W62Tl9eMmb4+1i5URrYcPUYrBZz5
         dQsO+X+CEmCUknNreAsVSR3YiN1wF9xi6YQvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gAs2Ms/kHp5mbiiGTzroQ96S3nuF5oXJFThuSTJ6LempE30l1ixTbBpZjqG3cSKDt9
         vtPkcu4xypkEZTznF16l6j191Tcha2SMHwCrfZdV50jsQcNoepBVGF5LqCDnIwQAXDSs
         186Rg/oJJS1r0/vqBzZIADAYqsaFaaAMB/Y7g=
Received: by 10.151.48.3 with SMTP id a3mr7332932ybk.283.1296439468469; Sun,
 30 Jan 2011 18:04:28 -0800 (PST)
Received: by 10.150.51.6 with HTTP; Sun, 30 Jan 2011 17:55:41 -0800 (PST)
In-Reply-To: <20110130213355.GB10039@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165714>

Heya,

2011/1/30 Jonathan Nieder <jrnieder@gmail.com>:
> Add headings for each form of the "git branch" command. =C2=A0Hopeful=
ly
> this will make the description easier to read straight through withou=
t
> getting lost and help technical writers to see what needs improvement
> in the treatment of each form.

I like it. Thought for the future: it would be nice if at a sprint or
such we can read through and fix the rest of the documentation in a
similar way.

--=20
Cheers,

Sverre Rabbelier
