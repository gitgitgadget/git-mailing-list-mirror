From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [wish] Revert changes in git gui
Date: Fri, 12 Dec 2014 10:28:54 +0100
Message-ID: <CAKPyHN2sur9KHVkLGq2WPzvc5hLD8BfK-hA7EyZ=-3DTZRTRQA@mail.gmail.com>
References: <54875263.1010407@grueninger.de>
	<548759C2.5030909@kdbg.org>
	<CAKPyHN2OSARgsYtC0MAxXqe=LZnBC9eq9BxkGme0QTRhnH9a1g@mail.gmail.com>
	<548AA6E6.5050805@grueninger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Christoph_Gr=C3=BCninger?= <foss@grueninger.de>
X-From: git-owner@vger.kernel.org Fri Dec 12 10:29:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzMX2-0001aa-SS
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 10:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934570AbaLLJ25 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Dec 2014 04:28:57 -0500
Received: from mail-la0-f43.google.com ([209.85.215.43]:49812 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933358AbaLLJ24 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 04:28:56 -0500
Received: by mail-la0-f43.google.com with SMTP id s18so5795016lam.30
        for <git@vger.kernel.org>; Fri, 12 Dec 2014 01:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=C9831D5CdyYjmIdqNEmBkOzeUkNF0e+48ErFI7eJxGk=;
        b=tU54PjA5ro2S+IMdvuh1rBCly8fW+7KleGKvWsByOwjQb5rYMpbGVdfA6wj/DSkZ4L
         DrO4P07Kzc85DfwY1N4elq6GtsOj3Ef5xde8Zg0VffM/tPwJBVxHf941NI5lpQ26OIX5
         pNoYixnGiQpnJHRULZuP75cbn7f5nuIVZjewb18RcOEHEvvbHLDamOA6Y7Q+c4yJ1PHP
         lkrz7j7OqSwV9E0Q1D7NcJgg7Mae6HL+DpCuJeCySMl9m9sfBPiVPgUd0RpNl82moDSB
         2u3X+/aKS8rrT9fDWab3nGmFnYPSa4hwm3+oRHJFKrWrfNPfnde5uICmUxPQXCb1tZrY
         Icpw==
X-Received: by 10.152.120.167 with SMTP id ld7mr14072207lab.77.1418376534652;
 Fri, 12 Dec 2014 01:28:54 -0800 (PST)
Received: by 10.112.43.176 with HTTP; Fri, 12 Dec 2014 01:28:54 -0800 (PST)
In-Reply-To: <548AA6E6.5050805@grueninger.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261346>

On Fri, Dec 12, 2014 at 9:27 AM, Christoph Gr=C3=BCninger <foss@gruenin=
ger.de> wrote:
> Hi Bert,
> your commit is more than half a year old. Do you intent to include th=
at
> into Git master? If not, what's the reason?

Thats a really odd question to a person who posted this patch to the
mailling list the fist place, isn't it? If anything you should have
asked the git gui developers and community, why they didn't show
interest to have this in master, right?

Bert

>
> Bye
> Christoph
>
