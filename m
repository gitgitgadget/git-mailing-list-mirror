From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 99 new messages
Date: Sat, 28 Mar 2015 21:09:30 +0100
Message-ID: <CAN0XMOL7WcwQk6YKp6GqqXad6kWe60MwmH4hNQ4sD1QnH0K0qQ@mail.gmail.com>
References: <1427571482-7508-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Phillip Sz <phillip.szelat@gmail.com>,
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
	=?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 28 21:09:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ybx3B-0000Sm-CO
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 21:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbbC1UJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2015 16:09:33 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:36628 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbbC1UJc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2015 16:09:32 -0400
Received: by wgra20 with SMTP id a20so131567746wgr.3
        for <git@vger.kernel.org>; Sat, 28 Mar 2015 13:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7AznS7Ht/Yhm2enqgvxwer5/b5PaXUwwtyTydGHh6TI=;
        b=Qm0C6Eq27FEzrvst1W/L1Hj8Nw67OhgtQaBG1eRrgvcCW99SgmhaxA++0Q7iVHdEmk
         RdJ4UpJ1V9Fre4p+tO+ZqHFcGRYIo0ZsnsZgwv8FARdV9hGUQWDqq7sOj+04jX1r937m
         WOOF7hficuVBva3XJaajR8k7mcq+KN/xNfdP0SM70LqNopc0Y23z/hIWaO9Zufmt0P+L
         1ZIQZvXlRXGFDNzWOTDnLEcgSDI9xsUeiCq65v0/CfdaElYSe+2kN53KnjwpnmTBuoL8
         3fkD4YkejvB2AFROxWFwSsGm5F+oP8uxOO0rnBgyp3zB7d8m4dqoEuhgN/pxUlnePEr3
         ulTA==
X-Received: by 10.180.97.106 with SMTP id dz10mr8220206wib.33.1427573370890;
 Sat, 28 Mar 2015 13:09:30 -0700 (PDT)
Received: by 10.194.72.5 with HTTP; Sat, 28 Mar 2015 13:09:30 -0700 (PDT)
In-Reply-To: <1427571482-7508-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266424>

2015-03-28 20:38 GMT+01:00 Ralf Thielow <ralf.thielow@gmail.com>:
>
>  #: builtin/rm.c:17
> -#, fuzzy
>  msgid "git rm [<options>] [--] <file>..."
> -msgstr "git rm [Optionen] [--] [<Datei>...]"
> +msgstr "git rm [<Optionen>] [--] [<Datei>...]"
>

The <file> argument is not optional. Will be fixed in a reroll.
