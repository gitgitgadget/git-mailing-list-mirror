From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: svn2git question: error: unknown switch `t'
Date: Mon, 20 Sep 2010 19:30:15 +0000
Message-ID: <AANLkTi=X3NqcURV8GSmZiq5CbVwikFF5skFt_t6gkSp9@mail.gmail.com>
References: <4E10ACF241081344B9702AA8C6440440C5B14FB331@MX01A.corp.emc.com>
	<AANLkTik_ouA-AD+tmGEvvcJeZqVj4Rge=hcoJ5Bqgt-R@mail.gmail.com>
	<4E10ACF241081344B9702AA8C6440440C5B14FB337@MX01A.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: nolan.ring@emc.com
X-From: git-owner@vger.kernel.org Mon Sep 20 21:30:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxm4N-0003vz-9Y
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 21:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757296Ab0ITTaS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 15:30:18 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49155 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757137Ab0ITTaR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 15:30:17 -0400
Received: by gwj17 with SMTP id 17so1411478gwj.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 12:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=enmSpBDnvEg9/cD+yg1NBJO4cOye2Z5x9ajwrRPbSug=;
        b=w25Bf24vDZzhU2e4g2asGtsD18q1y5JNpEkXOd5rkAQ2UjaZQLwU3PoeEyBjqaFOAG
         +17isMM9O28c69+HcXJjUvcwKwP2UG2SGEWCj2MG9Oe8E85kD5+vRP7LNUbCGTQiP3mX
         mbTOQBPHjEHTNGMK9uMv3WeHzINKpsctesAx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=L6q7TegqiYfGeT87WFKjUVLWHKUjtoS+Q0e8iblX+7bACBgHi9S+MPKuVMr+VLYe9t
         HhZXHaIXbq5khbgNPl2rUlrY/3ffchycK9d2AsOsbT/1iu0LKrtiJCFOHCcAs+JXQjx/
         ayhwmEGZKo9MGhc1MNFmQhTm2PDeRwo8Njydg=
Received: by 10.101.167.5 with SMTP id u5mr9948049ano.6.1285011015848; Mon, 20
 Sep 2010 12:30:15 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 20 Sep 2010 12:30:15 -0700 (PDT)
In-Reply-To: <4E10ACF241081344B9702AA8C6440440C5B14FB337@MX01A.corp.emc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156654>

On Mon, Sep 20, 2010 at 19:19,  <nolan.ring@emc.com> wrote:
> Hmmm, guess it wasn't that obvious to me!! :-)
>
> I have 1.6.0.2 installed, which does support the --track option; did =
a later git support -t as well as --track?
>
>> git --version
> git version 1.6.0.2
>
> Is there some way to know what version of git the svn2git I have inst=
alled supports? =C2=A0And any way to get a version of svn2git that supp=
orts the one I have.

You should just upgrade Git instead, using an old version of a
conversion tool is generally a Bad Idea.
