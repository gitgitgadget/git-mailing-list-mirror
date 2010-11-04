From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] diff,difftool: Don't use the {0,2} notation in usage strings
Date: Thu, 4 Nov 2010 18:22:38 +0100
Message-ID: <AANLkTi=mhbxQZEZYn6cCu_O2xaE87U9OU=TQiX2CKSar@mail.gmail.com>
References: <20101021222129.GA13262@burratino> <20101024155121.GA9503@headley>
 <AANLkTimpJbuZAPfvVOedstV7=UiLiDMnDaYWQLVNQ+Yc@mail.gmail.com>
 <87wrp12p00.fsf@gmail.com> <AANLkTinyPkGmsgbGM9qpXMNcZRzOXvtjDDEkJ-i3nWXz@mail.gmail.com>
 <87fwvl2d4d.fsf@gmail.com> <87hbfxgg86.fsf_-_@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 18:23:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE3Wn-00078D-9L
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 18:23:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075Ab0KDRXA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 13:23:00 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33051 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab0KDRW7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 13:22:59 -0400
Received: by ywc21 with SMTP id 21so1581613ywc.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=rBNsZLe0QXi/Ixjexjvor/eevXNkuVvuUayyo37qbMM=;
        b=cpYZml9MoJ0gzdeDRo4RY7m9LvzIGu4/KgVPMrpOPclBJzZfy1yoZH5wnOAz0kF2G6
         bHa2a4KTwIHkkfqJKgVYL8czLnUicVNNu59NGNwRAR2L22+wJMyElQUgWplLiLmhUcED
         wxOj2q2eS7TlsA09CzsTF/YfVo7hhhSi29/Ws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sFaoF2fuQ7ZjOCEM2VbW+ZpsHJWR5PoUMMo8gyjxtxhPwmuNbSPNbr93fwAdvawoIi
         NqeO8Ve4EpJmJlnAFkVOyUMTs6tesHCm+W3KBSNfMfCC9fLQ3RG8alUlaED6U3yC07Pe
         vIVsyA2Bs5K9+5ELnjch7g1m+PnPhf++h1NYE=
Received: by 10.151.98.2 with SMTP id a2mr1641144ybm.426.1288891378611; Thu,
 04 Nov 2010 10:22:58 -0700 (PDT)
Received: by 10.150.58.11 with HTTP; Thu, 4 Nov 2010 10:22:38 -0700 (PDT)
In-Reply-To: <87hbfxgg86.fsf_-_@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160737>

Heya,

2010/11/4 =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>:
> This was the only occurence of that usage, and square brackets are
> sufficient and already well-established for that purpose.
>
> Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>

Not sure if it's appropriate for Documentation patches, but fwiw:

Acked by: Sverre Rabbelier <srabbelier@gmail.com>

--=20
Cheers,

Sverre Rabbelier
