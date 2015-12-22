From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 68 new messages
Date: Tue, 22 Dec 2015 21:15:33 +0100
Message-ID: <CAN0XMOKsyTKevF0kB3zK-JB=nXMWhgoHdeJk66L=BeEYQOmzxA@mail.gmail.com>
References: <1450805964-7734-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Phillip Sz <phillip.szelat@gmail.com>,
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
	Magnus G <magnus.goerlitz@googlemail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 22 21:15:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBTLP-0002ND-8n
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 21:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbbLVUPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 15:15:35 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36130 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbbLVUPe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 15:15:34 -0500
Received: by mail-lf0-f68.google.com with SMTP id p203so13470494lfa.3
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 12:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qfznjhKraGNm8imZLg2yDsic4RWxa1U5D6dBWyHFMCU=;
        b=QujgBiQzwaqUYK9YPnChjlYoKJ9iRDh3dCd2uHR2DTmTquAgOwd+e8LSaV6FSdcSlG
         kNJBfg4nbIn9UgZz6YSNqzqFU6+H6byzPf4i1T0Q6Y9ngJAlyUXRyx35Xh3ZT97xQ3gg
         AB253qCbhZrA1lrvrB9gp+logQ8OxwWl3spbxURD9rQlfdc5ALPr3rbKgxjZIVM6kZGW
         MAknxkvrKWu3bPqR93wDrCr3zSppBf9Qd0oPXWT8WyFUezj9z2mH7swAd5AWYwKFv7rm
         0oXzUS9l9NbShsNOFBuE5LeObbN04WV/70RPyCWD6TgmzPO1O/8GTdJCri5IZfKGvoby
         YgBg==
X-Received: by 10.25.37.198 with SMTP id l189mr9227231lfl.111.1450815333063;
 Tue, 22 Dec 2015 12:15:33 -0800 (PST)
Received: by 10.25.216.212 with HTTP; Tue, 22 Dec 2015 12:15:33 -0800 (PST)
In-Reply-To: <1450805964-7734-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282904>

Am 22. Dezember 2015 um 18:39 schrieb Ralf Thielow <ralf.thielow@gmail.com>:
>  #: builtin/tag.c:25
> -#, fuzzy
>  msgid ""
>  "git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]\n"
>  "\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"
>  msgstr ""
>  "git tag -l [-n[<Nummer>]] [--contains <Commit>] [--points-at <Objekt>]\n"
> -"\t\t[<Muster>...]"
> +"\t\t[--format=<Muster>] [--[no-]merged [<Commit>]] [Muster>...]"
>

Should be "<Muster>".  Will be fixed in v2.
