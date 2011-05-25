From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (May 2011, #11; Tue, 24)
Date: Wed, 25 May 2011 13:46:20 +0200
Message-ID: <BANLkTi=qt6SER_1i=QuRZu0u4PjbxSkS0w@mail.gmail.com>
References: <7vboyr7oxh.fsf@alter.siamese.dyndns.org>
	<4DDCA0D2.2070604@viscovery.net>
	<BANLkTi=5koa_f_xqaGvKPrEnKMh7ziOT0g@mail.gmail.com>
	<4DDCD9F8.9080105@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 25 13:46:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPCXi-00072f-PG
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 13:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636Ab1EYLqV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 07:46:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43504 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab1EYLqV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2011 07:46:21 -0400
Received: by fxm17 with SMTP id 17so5296400fxm.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 04:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Nfl848ZKWiUbDkLds/1g2xcCg23fxwDFRcAqcPILv9U=;
        b=NjPJje1dvjWX9Z+CEhTbu+RH44ouD5Ef3ygR5zyAfFxVNGQwpIvKVroM67COFz4BpI
         udAoE4PUDLBBwEl7Rq4m07/0OwGQJn0dnc2sYnBlu6ZHSYvEATC1VEsBsaWGLkwz1/kz
         uW48xynZbn8K1qAdzCu8zpc5UJ/WL3lW8aCRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lYcZK761+ZIUvPOiW7G9/pIm115Yv2aNG3pgZ2ceA14X+yt1vYt2IpDrsn4QiWl6JK
         MLPj+vJJPy3MinnVCZXCPiMndIMX/RHcdW1RW67wRZNE7JRaX2W46jo3E33oz+IITwEE
         JPJsvIMbjBwy5HyoOAyeHuJjrExRqxr6FTeWs=
Received: by 10.223.55.201 with SMTP id v9mr922154fag.76.1306323980083; Wed,
 25 May 2011 04:46:20 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Wed, 25 May 2011 04:46:20 -0700 (PDT)
In-Reply-To: <4DDCD9F8.9080105@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174388>

On Wed, May 25, 2011 at 12:29, Johannes Sixt <j.sixt@viscovery.net> wro=
te:
> Am 5/25/2011 11:36, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:

>> But I'll just fix the Windows issue soon and submit a new series for
>> inclusion in next.
>
> Thanks! I just wanted to be sure that ab/i18n-scripts does not end up=
 in
> master in a state that leaves Windows in limbo.

Me neither. I just read from your mail that master was in limbo now.

I'll fix the Windows issues before the i18n-ification of the scripts
lands in master.
