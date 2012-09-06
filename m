From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH/RFC] l10n: de.po: translate 2 new messages
Date: Thu, 6 Sep 2012 19:15:24 +0200
Message-ID: <CAN0XMO+y4DU5sTWv5dZwXBfER5hS6-U65r73jvQd9TC32YrDUA@mail.gmail.com>
References: <1346865100-10908-1-git-send-email-ralf.thielow@gmail.com>
	<87sjavcd8x.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jk@jk.gs, stimming@tuhh.de, git@vger.kernel.org,
	worldhello.net@gmail.com
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Sep 06 19:15:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9ffy-0003Fk-2P
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 19:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759281Ab2IFRP1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Sep 2012 13:15:27 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:42317 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755301Ab2IFRP0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 13:15:26 -0400
Received: by wibhi8 with SMTP id hi8so704359wib.1
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9Ot+qZyeTTlVGmNXgKFH5zRui2qnvxelOsCzvfb/2ts=;
        b=kIwfg8lRiCx9xg4I1OoP1x6Kyjj/zvbJGePsbZ/KZxVtCGDqhkeN9W0ukrDeDoafN0
         qxndYqVDf7ZZJuRls+Dwq/4ZqYEjEBPkeNleqS5tpiANUkqON/jyhFC50atvn5nSMG7a
         xgSY/284r9uYoOoYPoLSIqF5xdaJv7mmXLqV7B1n+OYrSBULZXbsIz4YXK3rWwt7a26b
         kVkNsf3y5AENgsy/6F/QZgsijFXt3P/eTsg30hhuOnZE3NE6R8+otLU7Nb1exp2my5NJ
         ZYPYbqgjue/9HtdYi5zMIKieNuQrUnc7s941yE6DLnxqWwVuEFiWVtNUnRLS7cWf8uBV
         155A==
Received: by 10.216.255.146 with SMTP id j18mr1551367wes.163.1346951724682;
 Thu, 06 Sep 2012 10:15:24 -0700 (PDT)
Received: by 10.194.23.201 with HTTP; Thu, 6 Sep 2012 10:15:24 -0700 (PDT)
In-Reply-To: <87sjavcd8x.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204904>

On Thu, Sep 6, 2012 at 6:44 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> "(the 'simple' mode was introduced in Git 1.7.11. Use the similar mo=
de\n"
>> "'current' instead of 'simple' if you sometimes use older versions o=
f Git)"
> [...]
>> +"(Der Modus 'simple' wurde in Git 1.7.11 eingef=C3=BChrt. Benutze d=
en gleichartigen"
>> +" Modus 'current' anstatt 'simple', falls du gelegentlich =C3=A4lte=
re Versionen von"
>> +" Git benutzt)"
>
> You translate "similar" as "gleichartig", which sounds too much like
> "the same" to me.  Perhaps "=C3=A4hnlich"?  Or is there no danger of
> confusing this in de_DE usage?
>
> Ack on the rest.
>

Yeah, "=C3=A4hnlich" is probably the better translation in this case. I=
'll change it.
Thanks
