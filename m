From: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Startup of Git 2.0.0 l10n round 1
Date: Sat, 19 Apr 2014 16:13:34 +0800
Message-ID: <CANYiYbEeJ=WLm9CptdQwX7Xzj9r1kSDUeOkZpSm5H+X3k1h6Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 10:13:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbQPC-0002m3-OA
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 10:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbaDSINm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Apr 2014 04:13:42 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:53037 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbaDSINg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2014 04:13:36 -0400
Received: by mail-we0-f181.google.com with SMTP id q58so2251262wes.12
        for <git@vger.kernel.org>; Sat, 19 Apr 2014 01:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WjOlH7CLl6DlzD0GRsy898txib5XO2iAOn4mci7RaCw=;
        b=RSw/S/QL0CWiOSrV/a+T8Yle5a3UBMDZ807PKQbJl1ugxFCZiqpUdjcv2+oy+lMGSZ
         FEON03ZMbyzZ6P4YD8IssQK++wFwPFEz0L6HJr+tljhlSaYhsPEk/ozTd40bEf4qYuKn
         ziWHeOPuzSlqvc7RGvhfM6Tl9XqW/ibQZlyBgwHJV29Rawg9nV1f5Q3w6zxecMYibDxq
         PBLqOFiDai+GUHYbCeTDjtep79DRL4p/G7zBc9tXAYgnJIkNJAx8e/YBz//3TZYY7BNE
         /+fH8H88qmrSEyqEa2E3Dzh1PazMhdgNIE6CNPsimyYWzH/XxPBtxddPLI93u1tHajQY
         JM6g==
X-Received: by 10.194.92.177 with SMTP id cn17mr19905655wjb.18.1397895214590;
 Sat, 19 Apr 2014 01:13:34 -0700 (PDT)
Received: by 10.217.58.65 with HTTP; Sat, 19 Apr 2014 01:13:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246508>

Hi,

Since Git v2.0.0-rc0 had already been released, it's time to start new =
round
of git l10n. This time there are 45 new messages need to be translated =
since
last update for v1.9.0:

    l10n: git.pot: v2.0.0 round 1 (45 new, 28 removed)

    Generate po/git.pot from v2.0.0-rc0 for git v2.0.0 l10n round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
