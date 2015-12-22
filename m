From: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.7.0 round 2
Date: Tue, 22 Dec 2015 23:15:45 +0800
Message-ID: <CANYiYbEp5_3ieiOy3rcyy_McDgF1o=8ixQ7DB-jAsds-yD6uzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 16:15:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBOfH-00018z-ME
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 16:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813AbbLVPPr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Dec 2015 10:15:47 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36228 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298AbbLVPPq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2015 10:15:46 -0500
Received: by mail-wm0-f46.google.com with SMTP id p187so112993559wmp.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 07:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HNc1NCUTjSvliNg5gETF9pFP1Kw89chDkOsQHNQVrWk=;
        b=F1HAgZbAyKCZ/C180aWfkyMJyMBKgO9qLmt04nCwIhG7M7lnopVBljKRUdib+qTGLX
         DyO4RSEysTzXWdp7qCHkrzDCp/f2e5EF8yaSrHiGDRKM1qmjFEDu9Pb1hM8C9k8LrzQE
         9/8F1GbKqcw3iXzn+x05Izs6FBD3nfTXIEMk1RDu3VSW/TsGOM8ctfSrCb5R9ssodrae
         N6J6iurXsF0VcDeW5yNrdhaef6os87cr5aSsUbtWnmzHxbc/VBVrQ/fImA8MULPtsZW9
         MRS7dH0r2jOVR8QubqR9NVE/0QkY/jBMnGlbzDrXRDdO+PFiD+bWqGN6ZK2HcpA4VSTD
         Lelg==
X-Received: by 10.28.5.5 with SMTP id 5mr30128861wmf.94.1450797345518; Tue, 22
 Dec 2015 07:15:45 -0800 (PST)
Received: by 10.194.83.226 with HTTP; Tue, 22 Dec 2015 07:15:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282867>

Hi guys,

Another two new messages need to be translated, so let's start Git l10n
for Git v2.7.0 round 2.

    l10n: git.pot: v2.7.0 round 2 (2 new, 2 removed)

    Generate po/git.pot from v2.7.0-rc1-44-g1d88dab for git v2.7.0 l10n=
 round 2.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
