From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: [PATCH 2/5] l10n: de.po: translate "track" as "folgen"
Date: Mon, 7 May 2012 14:37:39 +0200
Message-ID: <CAN0XMO+q7r4nu4scSE=KY6Vv35sU9qzfp6Pcw_oUopfDFp6LGg@mail.gmail.com>
References: <1336160906-20708-1-git-send-email-ralf.thielow@googlemail.com>
	<1336160906-20708-3-git-send-email-ralf.thielow@googlemail.com>
	<1543115.9YNtu9coLS@cs-pc>
	<87obq08fq5.fsf@thomas.inf.ethz.ch>
	<CAN0XMOJgp-i=nd_7ygX=WuaegK6zMRypxRYH8nfGw6FLPAA1Fg@mail.gmail.com>
	<878vh46v1g.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Stimming <stimming@tuhh.de>, jk@jk.gs,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 07 14:37:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRNCE-000772-JY
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 14:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756531Ab2EGMhm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 08:37:42 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59507 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636Ab2EGMhl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 08:37:41 -0400
Received: by yhmm54 with SMTP id m54so4066909yhm.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 05:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=QYaOXhc3a7rFday6iJ7GWNChwgwiBV+nwGk5CX27HPc=;
        b=vlrG3CKcKT5ScfCnxZ+qXM8qrAmviT4BQGyVmI/ZwH28KuKbgCnLLfn8pxql6VCP5U
         bLqjsrOBbkOLh2sIf8GnugK+68V7NcHeDR5Ur9rzp7LS27JD1gfaKUFp95fWnY4hx0Rz
         3Rk2ABnnDATbg1Q3AAZ50P7v+0mALDSrmmEZAy5kUfemX1HL/uBNTz+7UWy8Ykm2/FE5
         fCyOOY7JUnnXOKuUsEYsgfiPipxvOpmHKTYh5HKsUXBy1HOfAJXV77L/kViCWX6blyPq
         mKPizaT9ulPJ2flhsXthZNWtCU3rwspGNw4VUo9kDwOzlNytImqxfn7pw/7/3i5B1Oys
         u57Q==
Received: by 10.236.153.36 with SMTP id e24mr18893211yhk.66.1336394259281;
 Mon, 07 May 2012 05:37:39 -0700 (PDT)
Received: by 10.146.218.6 with HTTP; Mon, 7 May 2012 05:37:39 -0700 (PDT)
In-Reply-To: <878vh46v1g.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197264>

On Mon, May 7, 2012 at 2:21 PM, Thomas Rast <trast@student.ethz.ch> wro=
te:
>> I personally prefer "beobachten" for tracked files/contents and, as =
you
>> said, "folgen" in the remote-tracking sense. But I wouldn't use
>> "ignoriert" because it has another meaning in git.
>
> But that fits right in, doesn't it? =C2=A0Files can be tracked, untra=
cked, or
> untracked-and-ignored.
>
> Or am I missing something?

No, you don't.
In order to distinguish between untracked and untracked-and-ignored
I would use "ignoriert" only when files are ignored by a .gitignore fil=
e,
not when they are just untracked.

Ralf
