From: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.5.0 round 2
Date: Tue, 14 Jul 2015 07:54:48 +0800
Message-ID: <CANYiYbHNFCBoXnr0BTXg5BW+xZou0O1b6XH=p1cpb4uDA8B41g@mail.gmail.com>
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
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 01:54:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEnYk-0002Lw-BP
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 01:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbbGMXyu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jul 2015 19:54:50 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:36669 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbbGMXyt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jul 2015 19:54:49 -0400
Received: by wgxm20 with SMTP id m20so124872396wgx.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2015 16:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0c1pg55I4/N86Ly8AF1PblCev40ktqXxljdcJuJ2czA=;
        b=nH6cFAHtXlcrJ75BDT8PSv68OqJZaRgX4dp4SlPOZBwLZIzb1t3gtzENS4dQ2qV0uC
         0EfX+CIzSTZuyEizRwtqjAQVNbaa42AkCKRisgwsdKM+5cXOInkwrlVemny+VWCyN6aQ
         TEj4tysmeDbiuuPTNcchHJIrF4Nxyf4KM0gtqBKjTnnvitJpAIua6iUl46y/SVijV8Ww
         RhyE72BpYeylkdbqXwexzP8SIbxIHHPuGJyx0QcYIle1vwop54aj8u+Qsr7jEKu7afnv
         CwqVxzbdZSUp7TuP1Ly04z3cGor9mrncQZftcizfiJXQX8dHsMa3aeU/VOoyAoa43K/g
         JKAw==
X-Received: by 10.180.149.206 with SMTP id uc14mr28747011wib.12.1436831688261;
 Mon, 13 Jul 2015 16:54:48 -0700 (PDT)
Received: by 10.194.65.106 with HTTP; Mon, 13 Jul 2015 16:54:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273935>

Hi,

Thanks to all the l10n teams, and the 1st round of translations for Git=
 2.5.0
has been merged.  While there are some new messages need to be
translated for the new released Git v2.5.0-rc2, let's start new round o=
f l10n.
The l10n window has less than 2 weeks for us, see: http://tinyurl.com/g=
itcal .

This time there are 9 updated messages need to be translated since last
update:

    l10n: git.pot: v2.5.0 round 2 (9 new, 5 removed)

    Generate po/git.pot from v2.5.0-rc2 for git v2.5.0 l10n round 2.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
