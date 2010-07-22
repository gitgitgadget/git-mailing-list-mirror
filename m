From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Running git on Windows command line
Date: Fri, 23 Jul 2010 01:00:01 +0200
Message-ID: <AANLkTilaaSl7gXnu6ctU8CKn5GMp9pf7aSYmLoVAIA5H@mail.gmail.com>
References: <1A9EA7E081C3FE46A0F446FFB66D10EB939B8A@FL01EXMB01.trad.tradestation.com>
	<AANLkTimXZtlRKlAVuFH5TzzQ1z19ddYazIRKIgGALMpZ@mail.gmail.com>
	<1A9EA7E081C3FE46A0F446FFB66D10EB939D37@FL01EXMB01.trad.tradestation.com>
	<AANLkTin-RMEOfc7FlfnQfTgzxMfV-Vq6r5ahkP6P6_SJ@mail.gmail.com>
	<1A9EA7E081C3FE46A0F446FFB66D10EB939DAC@FL01EXMB01.trad.tradestation.com>
	<AANLkTil69VdTLldEcInFcYLwcStFnEEkoBCAWS1kd-S6@mail.gmail.com>
	<1A9EA7E081C3FE46A0F446FFB66D10EB939E1D@FL01EXMB01.trad.tradestation.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 01:00:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc4kP-0001iQ-Ky
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 01:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555Ab0GVXAF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jul 2010 19:00:05 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38873 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab0GVXAE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jul 2010 19:00:04 -0400
Received: by wyf19 with SMTP id 19so1071468wyf.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 16:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=Rbgs3hzIY7gFkbQQ0WClLZFin7gXbrYXzFAvvL3NA6U=;
        b=QC8IZVt2ZdBn+hFr393Hps7D5Cwx+0nozJGX9MUM7xDg1v9zd4OvVkzM/7OecsnVJ7
         zB1MyS76LLZy3+52GFydxC7cjJgMc3cGs5XYfChRkd4frG+tpl8eL/wqe8LNLptGjQmF
         x5B9buF1J8eRjFFft0/qtspR3MXnaS6EVnbWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=Yms86PaZgILYGzLuHTTGDZW6kQl12U+mofB41tuCEkO1i5ADWdbSv/zhpGAcTxnfEY
         3TzuC53l4FlMGDhiJvmZmMveQ9Pypg351uigfwjjukR9PPv6SWA0WuXSndyygVuynacc
         Febmw9r8WrMxQKTuS9XZ5LkEEGGX8X4TLyHDI=
Received: by 10.216.231.230 with SMTP id l80mr2602851weq.53.1279839601091; 
	Thu, 22 Jul 2010 16:00:01 -0700 (PDT)
Received: by 10.216.70.67 with HTTP; Thu, 22 Jul 2010 16:00:01 -0700 (PDT)
In-Reply-To: <1A9EA7E081C3FE46A0F446FFB66D10EB939E1D@FL01EXMB01.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151492>

On Fri, Jul 23, 2010 at 12:32 AM, John Dlugosz
<JDlugosz@tradestation.com> wrote:
>
>> I'm aware of all this, but I don't think you're hearing me: the reas=
on
>> why the behavior has changed for you is very likely to be you having
>> switched package. Yes, the naming is confusing.
>>
>> --
>> Erik "kusma" Faye-Lund
>
> No, I've only/always installed Git-1.*preview*.exe. =A0I still have t=
he downloaded files.
>

OK. In that case, I think you're in better luck if you send an e-mail
to to msysgit mailing list.

--=20
Erik "kusma" Faye-Lund
