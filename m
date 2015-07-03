From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 65 new messages
Date: Fri, 3 Jul 2015 17:59:25 +0200
Message-ID: <CAN0XMO+c8q2P8b=UdwAcutOGUHUhNpiY9hTX+ZQAAt1dgF4w1A@mail.gmail.com>
References: <1435938622-6199-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Phillip Sz <phillip.szelat@gmail.com>,
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
	=?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 03 17:59:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB3NE-0007U8-5Y
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 17:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288AbbGCP72 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jul 2015 11:59:28 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:36247 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754956AbbGCP70 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jul 2015 11:59:26 -0400
Received: by wguu7 with SMTP id u7so91792246wgu.3
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 08:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=S+CMTNLwOqbquiUF9z+O67HiaPNQFxNybsaU0UV0XUY=;
        b=TKSSAmGyfV8GLTomkNhAXe0RuKlA+k1bhmbnvg6sN2fF3eJ0TmYM73F84Got0u+EA1
         vGEhz6tLt3SnvwUdrZTW6XWaWsZ/Qzq5vMoSeBirTIJagx+u51NVVQXT7w66W5dxBTM7
         hfbM3Yao+Eatc7IAah+1aAWoCukBW3CZVwc4HOPH974ZP4DDNIezyj7r3U/Blg/1tFIj
         N12B9csc/kPLd9c9dXgDuNqFdS9591jWaMHyWa8hITDYQhjvmZyRpw6IFkYLuXwQWBvy
         u8MtClP1Br9Lpi8fIi+i6eVAM/6VpuVUWp/FEFKC6zUyL2V2nxNxSHkmNDHppglgK95c
         RhUw==
X-Received: by 10.180.106.195 with SMTP id gw3mr28629184wib.25.1435939165748;
 Fri, 03 Jul 2015 08:59:25 -0700 (PDT)
Received: by 10.194.152.197 with HTTP; Fri, 3 Jul 2015 08:59:25 -0700 (PDT)
In-Reply-To: <1435938622-6199-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273294>

Am 3. Juli 2015 um 17:50 schrieb Ralf Thielow <ralf.thielow@gmail.com>:
> Translate 65 new messages came from git.pot update
> in 64f23b0 (l10n: git.pot: v2.5.0 round 1 (65 new,
> 15 removed))".
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  #: dir.c:1945
>  msgid "Untracked cache is disabled on this system."
> -msgstr ""
> +msgstr "Cache f=C3=BCr unversionierten Dateien ist auf diesem System=
 deaktiviert."
>

Just saw this typo, should be "unversionierte Dateien". Will be fixed
in a reroll.
