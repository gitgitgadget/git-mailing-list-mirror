From: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.4.0 round 1
Date: Fri, 27 Mar 2015 14:21:59 +0800
Message-ID: <CANYiYbEZ72L6WhAVSiQ57zaf9m0yyAkTzd-Qkcc74WiBjszWPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 07:22:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbNem-0005NP-T5
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 07:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbbC0GWB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2015 02:22:01 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36750 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbbC0GWA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2015 02:22:00 -0400
Received: by wibg7 with SMTP id g7so14600424wib.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2015 23:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bLsWh7R5jaqorN+47roLZjPK2TlgBeT/5TI50eL5FNU=;
        b=rc3omtywQKR1Qs+qahhJ0IMImKn93nSBqAq1sueAYB/sBZpnEW8NtgtSRTsh/ZzazC
         Skcl9F1h+fFtxEhSpTVNR+DnlVPQ5uL9O2pGlctQZuOvPj+6+g58BNqbORSyfb4RdMv3
         LFZS7jY5n8URu1xOxLi2Fh1Y71wjtUxBbzi1LUKyjpBOhq6RT4k9yG9Z1HgGXpZ/+LtN
         qd0+dZnxQvCS0QOQbLESCBNgJ4BRcd/6lzQ0nZwQfzBn2pYN7vQ+AqP8GcYmduwyC6mz
         0Ms7YrQgyVQiL92SbRY2URwu/DJF1/vW6gaFoxyLyRPs3cKQcmrkZkaS4hfpH0WFi65g
         0Q/w==
X-Received: by 10.194.185.9 with SMTP id ey9mr35012371wjc.135.1427437319077;
 Thu, 26 Mar 2015 23:21:59 -0700 (PDT)
Received: by 10.194.234.33 with HTTP; Thu, 26 Mar 2015 23:21:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266364>

Hi,

Git v2.4.0-rc0 is released, and it's time to start new round of git l10=
n.
This time there are 99 updated messages need to be translated since
last update for v2.3.0:

    l10n: git.pot: v2.4.0 round 1 (99 new, 92 removed)

    Generate po/git.pot from v2.4.0-rc0 for git v2.4.0 l10n round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
