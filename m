From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH 2/5] l10n: de.po: translate "track" as "folgen"
Date: Mon, 07 May 2012 13:28:33 +0200
Message-ID: <20120507132833.Horde.UUP4Oz1l-NpPp7HhlwfXEJA@webmail.tu-harburg.de>
References: <1336160906-20708-1-git-send-email-ralf.thielow@googlemail.com>
 <1336160906-20708-3-git-send-email-ralf.thielow@googlemail.com>
 <1543115.9YNtu9coLS@cs-pc> <87obq08fq5.fsf@thomas.inf.ethz.ch>
 <CAN0XMOJgp-i=nd_7ygX=WuaegK6zMRypxRYH8nfGw6FLPAA1Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>, jk@jk.gs, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Mon May 07 13:28:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRM7Y-00056M-KZ
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 13:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756148Ab2EGL2s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 07:28:48 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:42784 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576Ab2EGL2r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 07:28:47 -0400
Received: from mail.tu-harburg.de (mail.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id q47BSX5P024944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 7 May 2012 13:28:34 +0200
Received: from webmail.tu-harburg.de (webmail.rz.tu-harburg.de [134.28.202.69])
	(user=alucst mech=PLAIN bits=0)
	by mail.tu-harburg.de (8.13.8/8.13.8) with ESMTP id q47BSX96003349
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 7 May 2012 13:28:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2012-19;
	t=1336390113; bh=q4hagD095YkY3uD0MKn1qe25fX1etAbN4kl+rzqyQys=;
	h=Date:Message-ID:From:To:Cc:Subject:References:In-Reply-To:
	 Content-Type:MIME-Version:Content-Transfer-Encoding;
	b=dOjA6JVcqXY3EesuKurWGkWU3ULoTVfKaLXxWQDvPmKyETCUE88qpWVmavgGRsOYT
	 s5LAqny4TGKSydQ/imdnmw3eDnoX1B7D5hQSpCUGlnFzeOxlup8VDJEyg+07G/b6lf
	 q1jFQOsThEczpevMRbPI9+quE0hKs/J6dHIuQ9nk=
Received: from hansjoerg.sick.de (hansjoerg.sick.de [91.207.92.112]) by
 webmail.tu-harburg.de (Horde Framework) with HTTP; Mon, 07 May 2012 13:28:33
 +0200
In-Reply-To: <CAN0XMOJgp-i=nd_7ygX=WuaegK6zMRypxRYH8nfGw6FLPAA1Fg@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.20)
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197260>


Zitat von Ralf Thielow <ralf.thielow@googlemail.com>:

> On Mon, May 7, 2012 at 12:09 PM, Thomas Rast <trast@inf.ethz.ch> wrot=
e:
>>
>> Good point. =C2=A0In addition, both "folgen" and "verfolgen" have th=
e problem
>> that several derived words sound funny; e.g. "verfolgt" and "folgend=
".
>>
>> How about "beobachten" (for the English readers, roughly "observe") =
or
>> "beachten" ("pay attention to") for this meaning of tracking? =C2=A0=
The
>> latter even forms a nice group with "unbeachtet" and "ignoriert".
>>
>> You could use "folgen" in the remote-tracking sense instead?
>
> Good suggestions.
>
> I personally prefer "beobachten" for tracked files/contents

Indeed, very good suggestions. Thanks.

> and, as you
> said, "folgen" in the remote-tracking sense. But I wouldn't use
> "ignoriert" because it has another meaning in git.

Yes, absolutely. Agreed. Thanks a lot.

Regards,

Christian
