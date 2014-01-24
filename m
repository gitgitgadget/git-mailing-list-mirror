From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 27 new messages
Date: Sat, 25 Jan 2014 06:29:48 +0800
Message-ID: <CANYiYbFu1JSayZMdaLg2qAiNaNebgzQkSK7SyMNhFan1wzWzOw@mail.gmail.com>
References: <1390511452-6553-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <tr@thomasrast.ch>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Git List <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 23:29:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6pG6-0001D0-Jp
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 23:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbaAXW3u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jan 2014 17:29:50 -0500
Received: from mail-we0-f177.google.com ([74.125.82.177]:51469 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbaAXW3t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jan 2014 17:29:49 -0500
Received: by mail-we0-f177.google.com with SMTP id x55so3169537wes.8
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 14:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jvckKEopuEqx5rDTcfJa/x7UtzYNwXW30ULArSw8raQ=;
        b=y94Bxblm2lms6I2ixboTvVEMttzW3cken+4mJBt/JHe/1A3vp4+jjxeGkBBk3iwIHA
         VAnLCHkIVE8DlJzMY9NOe5601yk4qltpcm96OdyE0/ZIg7st6q9rbYL5vLxBmQACWXUO
         Rr8ld7hKVZPtuIEJO34lbeQvtsCXCT/dVmV2fvq8kChQ7W4sqWKqjeS5AtsIK4RQvebc
         SltS5f9jXbx2s99QkxQmy0tuAmnkJzrCO9IMnJDn85wviwwZ6eBXDADbVWt0xFb3VhHG
         ecfL1LB2Fx2kgmWbZPQoLTXZgJQm1vLxqSlQUa/tMPSxewHcWIvQpP6STC/EM46gwXVe
         oxbg==
X-Received: by 10.194.104.39 with SMTP id gb7mr33757wjb.69.1390602588927; Fri,
 24 Jan 2014 14:29:48 -0800 (PST)
Received: by 10.194.71.162 with HTTP; Fri, 24 Jan 2014 14:29:48 -0800 (PST)
In-Reply-To: <1390511452-6553-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241048>

2014/1/24 Ralf Thielow <ralf.thielow@gmail.com>:
> Translate 27 new messages came from git.pot update in
> df49095 (l10n: git.pot: v1.9 round 1 (27 new, 11 removed).
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  po/de.po | 90 ++++++++++++++++++++++++++++++++----------------------=
----------
>  1 file changed, 45 insertions(+), 45 deletions(-)
>
>  #: wt-status.c:275
> -#, fuzzy
>  msgid "new file"
> -msgstr "neue Datei:   %s"
> +msgstr "neue Datei:"
>
>  #: wt-status.c:277
>  msgid "copied"
> -msgstr ""
> +msgstr "kopiert"
>
>  #: wt-status.c:279
> -#, fuzzy
>  msgid "deleted"
>  msgstr "gel=F6scht"
>
>  #: wt-status.c:285
> -#, fuzzy
>  msgid "typechange"
> -msgstr "Typ=E4nderung: %s"
> +msgstr "Typ=E4nderung:"
>
>  #: wt-status.c:287
> -#, fuzzy
>  msgid "unknown"
> -msgstr "unbekannt:    %s"
> +msgstr "unbekannt:"
>
>  #: wt-status.c:289
> -#, fuzzy
>  msgid "unmerged"
> -msgstr "zusammenf=FChren"
> +msgstr "nicht zusammengef=FChrt"
>

Inconsistent ending colons, some have and some not.


--=20
Jiang Xin
