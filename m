From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 65 new messages
Date: Mon, 6 Jul 2015 08:06:34 +0200
Message-ID: <CAN0XMOJXq6bM+9dpvrZgu7wd3iE93raFLReij1WCc1kkP=MYJA@mail.gmail.com>
References: <1435938622-6199-1-git-send-email-ralf.thielow@gmail.com>
	<55992F6B.7040000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
	=?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>
To: Phillip Sz <phillip.szelat@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 08:06:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBzY9-0006EA-70
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 08:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbbGFGGh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jul 2015 02:06:37 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38005 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbbGFGGg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jul 2015 02:06:36 -0400
Received: by wibdq8 with SMTP id dq8so142637870wib.1
        for <git@vger.kernel.org>; Sun, 05 Jul 2015 23:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5JJzKmVnVSkuvIpLjsNXEc/0xsnQ2DnLE2wurAjjf8w=;
        b=Y2g2tMXQ+x89P50MD71zNw8p5SSmCmqcptcLP1AM8JCqe7rkfc8GQoNDoMjhY8RTTJ
         zBqXZ7cYvPRHkYMJVCKHpg7nqNlFopIKu+FCSSLAetMbLdYDXW1gVj1QUgtC/cyCGWAX
         uh4Y8yZwNT3tA8aHjmNP0UHYmK2WVN3hgvypkRWRKc7XCdQIKQ8r+m300Z5A9hAocmsF
         1ZIA/RJtF77kJZS450+0s1QbRA1o3uVz4tF6qF1Qdk/EJ6yBC496sw3EY+AEgHqkIKX1
         22554ZyyJ1i40PRGDAP8v2NJhILH47r8n07IJsPT+RBBRMdpESkg6ARws4YX8OoEXqAc
         Yb4A==
X-Received: by 10.194.23.106 with SMTP id l10mr97132531wjf.1.1436162795055;
 Sun, 05 Jul 2015 23:06:35 -0700 (PDT)
Received: by 10.194.152.197 with HTTP; Sun, 5 Jul 2015 23:06:34 -0700 (PDT)
In-Reply-To: <55992F6B.7040000@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273376>

Hi Phillip,

Thanks for review!

2015-07-05 15:21 GMT+02:00 Phillip Sz <phillip.szelat@gmail.com>:
>>  #: help.c:214
>>  msgid "git commands available from elsewhere on your $PATH"
>>  msgstr "Vorhandene Git-Kommandos irgendwo in Ihrem $PATH"
>>
>
> What do you think about "Git-Kommandos sind anderwo verf=C3=BCgbar in=
 Ihrem
> $PATH"?
>

This message is the title of a listing of git commands, that are
available from $PATH but not located in git's exec path.

Vorhandene Git-Kommandos in '/usr/libexec/git-core'

  add                       merge-octopus
=2E..

Vorhandene Git-Kommandos irgendwo in Ihrem $PATH

  imerge
=2E..

What about changing it to
"Vorhandene Git-Kommandos anderswo in Ihrem $PATH"?
