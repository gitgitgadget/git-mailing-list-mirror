From: Ivan Lyapunov <dront78@gmail.com>
Subject: Re: git log - crash and core dump
Date: Wed, 17 Apr 2013 14:23:40 +0400
Message-ID: <CANKwXW2gLo7o7DmQQvmGtMDUOjQVHAJZYcyRS5N11q+KQY9Dcw@mail.gmail.com>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
 <516D93C4.1000100@lsrfire.ath.cx> <7v61zml0ow.fsf@alter.siamese.dyndns.org>
 <516DBE2E.4060201@lsrfire.ath.cx> <7vzjwyi0ba.fsf@alter.siamese.dyndns.org>
 <CANKwXW2h1+CGw2M3CmeXzXAX+wdCPgs5Ff_bGvTgYVpkwpijUw@mail.gmail.com>
 <CANKwXW0WkZXJMi+6T8ymvTi5-JpRfrn_xKmjGw-FsXpaCGuK5g@mail.gmail.com>
 <20130417082701.GP2278@serenity.lan> <CANKwXW10tA+qNZ21YYcZxFLL4fWVRhq42nrkSogtmwAMTgPAzQ@mail.gmail.com>
 <20130417134311.56ea1b191270647dc9ede1df@domain007.com> <CANKwXW1heci+D5ZO3aF+dMN9davRawuZuKz0bf2n3iRiMjjgHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 17 12:24:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USPXN-0000N2-Mi
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 12:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965895Ab3DQKYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 06:24:21 -0400
Received: from mail-ve0-f181.google.com ([209.85.128.181]:38983 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965827Ab3DQKYV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 06:24:21 -0400
Received: by mail-ve0-f181.google.com with SMTP id pa12so1254467veb.26
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 03:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:content-type;
        bh=Hh/IhJpLa3L9BKvSXPEWwNjJqfYYkdsVyKK7XTMa0io=;
        b=JnqdVLeUYbx1i9qt4b6cibBMyB1twE/VrLgg3CWRq+jHNm0To23Zt8NOcYxm684DOs
         VSLORuaUQEFIx/lwkpvWydZqJLTepXEGGMghsTaEBN+gjcAuyummY+4z9R6c/LkOi6WI
         qHiOT+pm/9pZAziCH+zFNA0R31cuIMW0hXxr0MOHz1FhOPAWQmQSji/MnP4rm5s/e4pe
         YRHzq8JlQZ4DA03Dcvkq9SpU9h/pYIL473avzJZmP0kwhUYsB8nwsob9NVO1V1fBbYbV
         VQA/UgjPFTGz2AU5m3Z+9WMmMU1AvHi3lwQSQy6LYorUqDSgZkHLwKE+M0QnZcy67i8H
         3t1A==
X-Received: by 10.52.27.52 with SMTP id q20mr3868140vdg.16.1366194260416; Wed,
 17 Apr 2013 03:24:20 -0700 (PDT)
Received: by 10.58.231.161 with HTTP; Wed, 17 Apr 2013 03:23:40 -0700 (PDT)
In-Reply-To: <CANKwXW1heci+D5ZO3aF+dMN9davRawuZuKz0bf2n3iRiMjjgHg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221530>

missed a list sorry for dup

I ment the same because git changes the version too. Also
netbeans/eclipse upgrade are not synced, because of different
products. So the same ment only names, not versions. But in deep
search another repos I found the broken commits in Eclipse repo dated
by 13 march 2013. Can them produced because of previous broken
commits? And probably you can be right about java git wrappers can
produce this issues, I'll try to make a broken repo from scratch
later.
Ivan

2013/4/17 Ivan Lyapunov <dront78@gmail.com>:
> I ment the same because git changes the version too. Also
> netbeans/eclipse upgrade are not synced, because of different
> products. So the same ment only names, not versions. But in deep
> search another repos I found the broken commits in Eclipse repo dated
> by 13 march 2013. Can them produced because of previous broken
> commits? And probably you can be right about java git wrappers can
> produce this issues, I'll try to make a broken repo from scratch
> later.
> Ivan
