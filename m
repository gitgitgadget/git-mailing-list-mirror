From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [RFC] l10n: de.po: translate 76 new messages
Date: Fri, 3 Aug 2012 14:28:54 +0200
Message-ID: <CAN0XMOJJ=B-Uq+hv6fkTtA0vNs=XRf03_+dgymV8ESXA4tw0+A@mail.gmail.com>
References: <1343927525-3338-1-git-send-email-ralf.thielow@gmail.com>
	<87y5lw73m8.fsf@thomas.inf.ethz.ch>
	<CAN0XMOLp_m4jUKv_=qfXdYx4jDJMBYQtY2-19sfC_7LzfY6uXA@mail.gmail.com>
	<874nok5fxk.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jk@jk.gs, stimming@tuhh.de, git@vger.kernel.org,
	worldhello.net@gmail.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 03 14:29:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxH03-0004tm-C6
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 14:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775Ab2HCM26 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Aug 2012 08:28:58 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:63784 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760Ab2HCM24 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2012 08:28:56 -0400
Received: by wibhq12 with SMTP id hq12so74608wib.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 05:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=rX1D7PJ7OpWppUvW6Gc44L8PgXlF9eRy0cv1V6nyYIM=;
        b=dB6bcIFMSS/+G0yPfuSpcIJYkTTxSYjrIcl1yFmbQD1WHeCpw0XOKzjsVBBnwj0yHL
         zQsJ7c7G2gJRQk/zUQGiYFGs7xPDjghcPzxnx3rmHj59XmhatPI4513AsJ1awCGL2Daq
         JIPxvsbPCA/1YSukBsoKGlpLI/ZVkjJ7neWLqTVWdiQY/uUMFUPk/HEUvGXxwv5K6+ZY
         8rAj0NeJdXbHCg1VV7yUgnKjYjmvWcmQrOffTCLhPHjUFPlc4bC5EdtCVw7kRDPzzUBm
         Osa3mn1mgmY0dWOblyvPpOegGma1Q2503T7pj9YhGO8T07EiNXlq7i1kqHzswERNmAMh
         tcxA==
Received: by 10.180.96.3 with SMTP id do3mr4068379wib.5.1343996934721; Fri, 03
 Aug 2012 05:28:54 -0700 (PDT)
Received: by 10.194.26.33 with HTTP; Fri, 3 Aug 2012 05:28:54 -0700 (PDT)
In-Reply-To: <874nok5fxk.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202832>

On Fri, Aug 3, 2012 at 2:16 PM, Thomas Rast <trast@student.ethz.ch> wro=
te:
>>>
>>>   KONFLIKT (rename/delete): foo gel=C3=B6scht in bar und renamed in=
 quux. Stand ...
>>
>> Gah, I misunderstood the values of the placeholders. The reason why =
I haven't
>> translate "delete" or "rename" is because they're part of the
>> "KONFLIKT (%s/delete)"
>> messages, aren't they? Translate it all would solve the problem. Tha=
nks
>
> Well, it's a bit confusing.  AFAICS the verb (rename/modify) goes int=
o
> the parens at the start, and the participle (renamed/modified) goes i=
nto
> the fourth %s.  So if you decided to *not* translate the
> "(rename/delete)" conflict description, you would have to translate
> "renamed" (to fit it into the sentence) but not "rename".
>
> Which would be really hard to maintain.  So let's not do that.  I thi=
nk
> it's better if you translate them all.
>

That's what i meant. Sorry if I was unclear.
