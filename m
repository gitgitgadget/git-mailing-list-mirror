From: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Startup of Git 2.3.0 l10n round 1
Date: Tue, 13 Jan 2015 14:41:14 +0800
Message-ID: <CANYiYbGd__gA2aBB=P_GXPTNvwDv7LSiqjBG528Mq9-SZwjwTw@mail.gmail.com>
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
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Brian Gesiak <modocache@gmail.com>,
	Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 07:41:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAvAF-00081W-QE
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 07:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbbAMGlR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jan 2015 01:41:17 -0500
Received: from mail-wi0-f175.google.com ([209.85.212.175]:52161 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbbAMGlP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jan 2015 01:41:15 -0500
Received: by mail-wi0-f175.google.com with SMTP id l15so19056444wiw.2
        for <git@vger.kernel.org>; Mon, 12 Jan 2015 22:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9cYyhfFPVWEMpq/8kbpXjOaSDnIentS1q6HUadshVao=;
        b=vtD2NhpbFV2QCVQw4wQ8uTuRT6WNBZCvkId4rg8rOSD9tohKpF6XhFexPzzFotRvjy
         1a354D1zDppCHP1/B6EN6UpWsykeFZENNVuUniqxHnTnvej6jrC36efSfj2dFjWbe9xw
         l7NtpEfJb7ts5GbghLExND0/UIh5sQ/dvH9QuPpu3qXIZJhkrIrSCb5RRYQh0OQrHBNb
         1TC8hsn8T7LkiKzK++mdq9HIV3pyhFvvyiAtXQTQCRiIk0Q8EbH3D0OiHksh4vZUfPtd
         taXxq8bNVFRzUrqMXLWSKf8tCD/hI4m7ZdeUz+QmPVsv+Z/C9jMrlpbxcZ95VEUe0Dt0
         rNQQ==
X-Received: by 10.180.216.36 with SMTP id on4mr3883298wic.27.1421131274369;
 Mon, 12 Jan 2015 22:41:14 -0800 (PST)
Received: by 10.194.29.129 with HTTP; Mon, 12 Jan 2015 22:41:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262326>

Hi,

Since Git v2.3.0-rc0 had already been released, it's time to start new =
round
of git l10n. This time there are 13 new messages need to be translated =
since
last update for v2.2.0:

    l10n: git.pot: v2.3.0 round 1 (13 new, 11 removed)

    Generate po/git.pot from v2.3.0-rc0 for git v2.3.0 l10n round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
