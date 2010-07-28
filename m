From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] SubmittingPatches: Cite the 50 char subject limit
Date: Wed, 28 Jul 2010 20:15:43 +0000
Message-ID: <AANLkTimu35sWvQhCVDEQvT5Qswbgqxcnji_D0uR=heVm@mail.gmail.com>
References: <1280326285-10203-1-git-send-email-avarab@gmail.com>
	<7vzkxb4j1v.fsf@alter.siamese.dyndns.org>
	<AANLkTimieHJaw1UmKtQvS4=2i8TrmR5A5zFO13NaNBo=@mail.gmail.com>
	<7861092D-582B-4918-AF3D-BF595B195673@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 22:15:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeD2c-00043X-Id
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 22:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766Ab0G1UPp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 16:15:45 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64362 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab0G1UPo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 16:15:44 -0400
Received: by gyg10 with SMTP id 10so1854189gyg.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 13:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1gy1hWvMD4klKtrToxwUtD7PrT9rkcB60tYI9ZjfSIo=;
        b=huD7sbED/JuMYmn0WhlCe5bC/5QwDBSVbFT/0AEbDd86XfnvuRmDeivq0aZhyHhNL1
         +p7tkz/n3i1ExmweWlXSQeRgvsMX+NfIV0/L1AM4OfeZp5d9yAwcQ6t+VhddxQwzbfRV
         004OBpLAH0dmlbBp7SYmA6ePGlOlmROn5Xa20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=O9ZQjgIGGIOr9EvRidTHuHytYkkc7RCqx0uTx2usucedufbZVfl9+m1DEz18etIIZN
         4kMcDNiUbX4V+K+7GwyFUum5ayZMQ83ABJ03a6w2dfnCasUYXQL63nAnLItrp4q+l9Bk
         FxmVnNw5fQwdaHdFvWBRDn5YVzO/Wl7Ga7k0k=
Received: by 10.231.19.3 with SMTP id y3mr11319771iba.156.1280348143066; Wed, 
	28 Jul 2010 13:15:43 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 28 Jul 2010 13:15:43 -0700 (PDT)
In-Reply-To: <7861092D-582B-4918-AF3D-BF595B195673@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152116>

On Wed, Jul 28, 2010 at 19:49, Joshua Juran <jjuran@gmail.com> wrote:
> On Jul 28, 2010, at 12:25 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
wrote:
>
>> On Wed, Jul 28, 2010 at 17:23, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>
>>> Hmph, we probably would want to do s/50 character/&s/ in the two ma=
nual
>>> pages.
>>
>> I'm not sure if "with a single short (less than 50 character) line" =
is
>> is grammatically correct with "characters", since "characters line"
>> wouldn't make sense.
>>
>> On the other hand that sentence violates the rule that when you put
>> something in parens your sentence should still make sense with
>> s/[()]//g, "a single short less than 50 character line" is pushing i=
t.
>
> If the number of characters is less than 50, then there are fewer tha=
n 50
> characters.
>
> This is a short line of fewer than 50 characters.

I don't understand the context of that remark or what you're replying
to.

I meant that I found the "single short (less than 50 character) line"
bit in git-commit.txt, gittutorial.txt and user-manual.txt odd to
read.

What did you mean?
