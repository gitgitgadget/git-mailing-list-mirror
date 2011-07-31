From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: File Systems and a Theory of Edits
Date: Sun, 31 Jul 2011 18:39:37 -0400
Message-ID: <CADo4Y9gYCfWD3hfc8h0_Q_VCof4+=G-oX4HZyK+LFy3kRVZk+A@mail.gmail.com>
References: <CADo4Y9hG=-Bye5g7OWROJNbbUOcnH0hj0f3csws5V+YzEUKAMg@mail.gmail.com>
	<CACBZZX48aDN_Njm+qMvovfz1tjdhnmXe5-bbJe=0_Q3LbLWoPA@mail.gmail.com>
	<4E350F15.9050009@lsrfire.ath.cx>
	<CADo4Y9gU_Z73gCPCESvVZhLOJUJg+mTqHkeqpNv2L8xLJvKxEQ@mail.gmail.com>
	<CADo4Y9gECLJ45g_r-uZBRnfEVXBRw2EoF2HkRu=0-eJ2YCuBLA@mail.gmail.com>
	<CAMOZ1BtrgO1XhJfR2-1Mpd8Ytrz4pjVyhbPdbNxDP84hhiip+A@mail.gmail.com>
	<CADo4Y9i=PYBv33Jnu2osQX_FL97ng9FZ8TFeMMuc5CDGUhu1Gg@mail.gmail.com>
	<m2sjpmt7lq.fsf@igel.home>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 00:39:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qneff-000224-Tp
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 00:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab1GaWjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jul 2011 18:39:40 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63878 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071Ab1GaWjj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2011 18:39:39 -0400
Received: by ewy4 with SMTP id 4so2591045ewy.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 15:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=5DJTyaq64b3cdQkPHNI2xu3oH7OCAFFbd6sx5qZWY5c=;
        b=WclUgmL4D4oMxQBGdFF13aLw2vPHty5MvVaYnV9UWj8rgLQUuewB7grK6DfF8qk1iQ
         A3ME0KX3hegAgOBLvguvFFv8WTQ/s8NaOLOulaCobbbeubVMqs5BOu9DVdMaRrWkbk3g
         t19oaPkWsw6l4YKG/cSZVcLXQvXHKzUr1jtkk=
Received: by 10.14.16.231 with SMTP id h79mr1386571eeh.0.1312151977892; Sun,
 31 Jul 2011 15:39:37 -0700 (PDT)
Received: by 10.14.53.3 with HTTP; Sun, 31 Jul 2011 15:39:37 -0700 (PDT)
In-Reply-To: <m2sjpmt7lq.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178284>

I shall check it out.  Thanks!  -Mike

On Sun, Jul 31, 2011 at 6:20 PM, Andreas Schwab <schwab@linux-m68k.org>=
 wrote:
> Michael Nahas <mike.nahas@gmail.com> writes:
>
>> 3 working trees would be even better. =A0I've been wondering if I ca=
n
>> make another working trees by creating a .git/ directory and
>> symlinking to the .git/objects and ./git/refs of my current
>> repository.
>
> Have you looked at git-new-workdir?
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756 =A001D3 44D5 214B 82=
76 4ED5
> "And now for something completely different."
>
