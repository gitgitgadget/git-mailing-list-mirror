From: =?UTF-8?Q?Matthias_R=c3=bcster?= <matthias.ruester@gmail.com>
Subject: Re: [PATCH v2] l10n: de.po: translate 68 new messages
Date: Mon, 28 Dec 2015 20:32:18 +0100
Message-ID: <56818E42.5010508@gmail.com>
References: <567D9577.9050809@gmail.com>
 <1451072298-5412-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	magnus.goerlitz@googlemail.com
To: Ralf Thielow <ralf.thielow@gmail.com>, phillip.szelat@gmail.com
X-From: git-owner@vger.kernel.org Mon Dec 28 20:32:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDdXE-0001gp-MR
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 20:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbbL1TcK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2015 14:32:10 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:32999 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbbL1TcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 14:32:09 -0500
Received: by mail-wm0-f45.google.com with SMTP id f206so17524285wmf.0
        for <git@vger.kernel.org>; Mon, 28 Dec 2015 11:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=6On7DzA30nfrJp5/tbH0GTn9WSaZ19lsTFZ0WNozk+E=;
        b=B0UpFgjhXoRpdc/xLV7uDzLj0sxVYPewnTbC9JjOqQzrvG7C39dcwTFFY0QsHjPMhN
         kfAihbs3k/JIgf14nHiKAf+i/0UNyJlXdlQGNED9cNOV7ty+V3D60+mPVQXSS/O9Xnwa
         FKpPMDWhivlkiw1Er5RYi235g/4HksR/hl6j9ANDiyU1SCFLtdwkT5oMW2HuI6s4Ko1F
         r1S92fvzafnFMMOmUHuLWEcNrad5O5ha7+64IPQ8kRWqlhz7KOeqTGgLFYVbZOronFj5
         2VXFvZIlnQSG4jKWvT+6c2da+wr0aMhZbWaUxvFgPLkmlGbkhyR8F3TZLD0Gm0gYnLDx
         sQ7A==
X-Received: by 10.28.11.74 with SMTP id 71mr62750842wml.101.1451331128049;
        Mon, 28 Dec 2015 11:32:08 -0800 (PST)
Received: from [192.168.0.37] (ip5f5afadd.dynamic.kabel-deutschland.de. [95.90.250.221])
        by smtp.googlemail.com with ESMTPSA id pn6sm58104850wjb.15.2015.12.28.11.32.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Dec 2015 11:32:07 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <1451072298-5412-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283044>

Hi Ralf,

>   #: builtin/submodule--helper.c:273
>   msgid "fatal: submodule--helper subcommand must be called with a su=
bcommand"
> -msgstr ""
> +msgstr "fatal: submodule-helper muss mit einem Unterkommando aufgeru=
fen werden"
>
>   #: builtin/submodule--helper.c:280
>   #, c-format
>   msgid "fatal: '%s' is not a valid submodule--helper subcommand"
> -msgstr ""
> +msgstr "fatal: '%s' ist kein g=C3=BCltiges Unterkommando von submodu=
le-helper"

submodule--helper (at both lines: one minus sign is missing)

Everything else looks great!

Acked-by: Matthias R=C3=BCster <matthias.ruester@gmail.com>


Kind regards,
Matthias
