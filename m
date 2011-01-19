From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 2/3] git-gui: spelling fixes in russian translation
Date: Wed, 19 Jan 2011 03:07:36 +0300
Message-ID: <20110119000735.GA29212@dpotapov.dyndns.org>
References: <cover.1295295897.git.raa.lkml@gmail.com>
 <1c96343bbf6fb30e7453c3df7b49ea31667e0469.1295295897.git.raa.lkml@gmail.com>
 <20110117210828.GC27029@blimp.localdomain>
 <loom.20110118T083048-91@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: Alexey Shumkin <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Wed Jan 19 01:07:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfLaY-0004sM-8x
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 01:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625Ab1ASAHp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jan 2011 19:07:45 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35402 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407Ab1ASAHl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 19:07:41 -0500
Received: by ewy5 with SMTP id 5so148311ewy.19
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 16:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=WCW6d8VDvVDykbv11CaKFCswOTRU/sn7NzHsUjnwZ7k=;
        b=xoBu2dQ1OgGNbjbO/FGHElrKY/kT4ZKJKjaUyoAGyYiP5djD/mYZwHSKhwDofH3hhe
         o4B7tGCP8JbYO8hV1VjxpiQQ4mnPIVIDatf516b/RCvREXlH8aSqQK6TPGk6bNAnq3/J
         Y6jVnUDFYGBuzuuFwgSAfmpL54ppZwh+M5Vk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=JIKiDpWKegLQ2Vs5xKmyEMQKIUzz+D4Lv2mmm+pom/fNuQcR9hzOy6e/9ltV9Y3LFG
         /vQURg9tMaIkdriitKKqSzXP1BNFBcc9AnH5VWQjJjO6upm9U8+NKvsLopSZpWpVO8eN
         j7P6J1OAxvMs6PvLp6pmZhswJdhM+Cv+mxTIc=
Received: by 10.14.16.75 with SMTP id g51mr5523107eeg.45.1295395660573;
        Tue, 18 Jan 2011 16:07:40 -0800 (PST)
Received: from localhost (ppp22-69.pppoe.mtu-net.ru [81.195.22.69])
        by mx.google.com with ESMTPS id t5sm5015321eeh.8.2011.01.18.16.07.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Jan 2011 16:07:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <loom.20110118T083048-91@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165232>

On Tue, Jan 18, 2011 at 07:40:05AM +0000, Alexey Shumkin wrote:
> change this
> >  #, tcl-format
> >  msgid "File %s seems to have unresolved conflicts, still stage?"
> >  msgstr ""
> +"=E6=C1=CA=CC %s =CB=C1=D6=C5=D4=D3=D1 =D3=CF=C4=C5=D2=D6=C9=D4 =CE=C5=
=CF=C2=D2=C1=C2=CF=D4=C1=CE=CE=D9=C5 =CB=CF=CE=C6=CC=C9=CB=D4=D9.
> =F0=D2=CF=C4=CF=CC=D6=C9=D4=D8 =D0=CF=C4=C7=CF=D4=CF=D7=CB=D5 =CB "
>  "=D3=CF=C8=D2=C1=CE=C5=CE=C9=C0?"
> to
> +"=E6=C1=CA=CC %s, =CB=C1=D6=C5=D4=D3=D1, =D3=CF=C4=C5=D2=D6=C9=D4 =CE=
=C5=CF=C2=D2=C1=C2=CF=D4=C1=CE=CE=D9=C5 =CB=CF=CE=C6=CC=C9=CB=D4=D9.
> =F0=D2=CF=C4=CF=CC=D6=C9=D4=D8 =D0=CF=C4=C7=CF=D4=CF=D7=CB=D5 =CB "
>  "=D3=CF=C8=D2=C1=CE=C5=CE=C9=C0?"
>=20
> "=EB=C1=D6=C5=D4=D3=D1" - =D7=D7=CF=C4=CE=CF=C5 =D3=CC=CF=D7=CF, =CF=C2=
=CF=D3=CF=C2=CC=D1=C5=D4=D3=D1 =DA=C1=D0=D1=D4=D9=CD=C9

In the above sentence, '=CB=C1=D6=C5=D4=D3=D1' is not an introductory w=
ord, and thus
no comma is required. For details, see #2 at
http://ru.wiktionary.org/wiki/%D0%BA%D0%B0%D0%B6%D0%B5%D1%82%D1%81%D1%8=
=46

However, such use of '=CB=C1=D6=C5=D4=D3=D1' is more appropriate for co=
lloquial speech
than for documentation or even computer messages. Also, I have never se=
en
'unresolved conflicts' being translated as '=CE=C5=CF=C2=D2=C1=C2=CF=D4=
=C1=CE=CE=D9=C5 =CB=CF=CE=C6=CC=C9=CB=D4=D9'.
IMHO, the standard term is '=CE=C5=D2=C1=DA=D2=C5=DB=C5=CE=CE=D9=C5 =CB=
=CF=CE=C6=CC=C9=CB=D4=D9'. So my suggestion is:

=E6=C1=CA=CC %s =CD=CF=D6=C5=D4 =D3=CF=C4=C5=D2=D6=C1=D4=D8 =CE=C5=D2=C1=
=DA=D2=C5=DB=C5=CE=CE=D9=C5 =CB=CF=CE=C6=CC=C9=CB=D4=D9.



Dmitry
