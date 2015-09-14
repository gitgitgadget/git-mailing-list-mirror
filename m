From: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.6.0 round 2
Date: Tue, 15 Sep 2015 07:06:13 +0800
Message-ID: <CANYiYbGqhgq=VwDm=oNyfMuK9ZaTSqVhY2rDU6hevCjTzYunVw@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Sep 15 01:06:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbcpX-0002FT-P9
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 01:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbbINXGQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Sep 2015 19:06:16 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37476 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbbINXGP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Sep 2015 19:06:15 -0400
Received: by wicfx3 with SMTP id fx3so4302509wic.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 16:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/2VeuFBuOYcudHOF4e37LiywWXfD/VYoUW/IKN5GZWc=;
        b=gSwTqnngJI3GMuhG7IdPDW5W3KFpWC0b/me/WQLF4vAd3a7KGbkzEesZg03BgoYrXC
         U43nGwDuGx9L9ZQyT8ki1LgSgNXisofI/uI6zDqi0QwBuoOTXRFqBpwTdIGK89gibxst
         rFXen8uMaoOU0leq80YwtUhi1Upr/R3B/zFEabn5ccklwQIsu9odu+jODAUmfJzDyWfy
         gf9X4c7fVT/LtzV+Nm8HDoMaaZYWm2ZNPYXaJ0FwG+yz6SE9Lnk8JOnJZzq8ETvxSzfn
         MSwZotn2DA62FGKiD/0YH3RkI2KCIhpTlkF2lMgtyEKSbyOSD5ntgiD2IFZ7FCdaPtPL
         LBiA==
X-Received: by 10.180.75.243 with SMTP id f19mr853429wiw.52.1442271973891;
 Mon, 14 Sep 2015 16:06:13 -0700 (PDT)
Received: by 10.194.76.230 with HTTP; Mon, 14 Sep 2015 16:06:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277875>

Hi,

Git v2.6.0-rc2 had been released, and introduced three i18n improvement=
s.
Please update your translations based on this commit:

    l10n: git.pot: v2.6.0 round 2 (3 improvements)

    Introduce three i18n improvements from the following commits:

    * tag, update-ref: improve description of option "create-reflog"
    * pull: don't mark values for option "rebase" for translation
    * show-ref: place angle brackets around variables in usage string

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
