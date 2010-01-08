From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: Re: [RESEND PATCH] french translation of gitk
Date: Fri, 8 Jan 2010 14:22:18 +0100
Message-ID: <20100108142218.386bf6a2@eleanor>
References: <20091202112403.52abcd75@eleanor>
	<c558c59b3fe779e8577fe06233d3da5d2711127f.1259795550.git.ni.s@laposte.net>
	<20091229223758.GB12965@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>,
	Maximilien Noal <noal.maximilien@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Moulard <thomas.moulard@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Guy Brand <gb@unistra.fr>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Fri Jan 08 14:26:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTErH-0001Ai-9w
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 14:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467Ab0AHN00 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jan 2010 08:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368Ab0AHN00
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 08:26:26 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:51045 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134Ab0AHN0Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 08:26:25 -0500
Received: by ewy19 with SMTP id 19so11922870ewy.21
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 05:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=64wHcuJLco16gqCg7u4vkwhmIpm6WOaEd3tXprprd1k=;
        b=ThqZRVvkRe7+gX6BTSAFqkDfVQpsy12oQ2dBsoGxEobZALZiSfcBuTHIg3xmp0z8kA
         F3vIDox4U0vGblC510hTQfZzWdISqr8QkM70yoGq1XhpiD1WMWvFqFsmLi6z/BJCS0HQ
         OUFbvW+OlymZOwvCUumW7SNNqA4g+/G3/YVMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=c00LWwUcPynIXz1O8grraPzSWkxEgHvoEgWvJscl7pt/DQOJLXwwLeaF+by8Mgncna
         wil1gU3zTLKbsXPuWbz9bxnNCBmi1DC59rTWF2DrXnV2PWsGe84/GY/Xl4P8KEHB0RId
         peTEpKBSM/sJKHADtKmPZEcZ98kjKkk2Pud7Q=
Received: by 10.213.24.24 with SMTP id t24mr317436ebb.16.1262957182411;
        Fri, 08 Jan 2010 05:26:22 -0800 (PST)
Received: from eleanor (cxr69-1-87-88-216-137.dsl.club-internet.fr [87.88.216.137])
        by mx.google.com with ESMTPS id 16sm1582299ewy.14.2010.01.08.05.26.21
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 Jan 2010 05:26:22 -0800 (PST)
In-Reply-To: <20091229223758.GB12965@vidovic>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136432>

Hi all,=20
Thank Nicolas for beeing the ambassador this translation :-)

Le Tue, 29 Dec 2009 23:39:39 +0100,
Nicolas Sebrecht <nicolas.s.dev@gmx.fr> a =C3=A9crit :

> Hi,
>=20
> I may be wrong but I think this patch wasn't merged and I didn't see =
any
> comment on it.
>=20
> Could you please merge this patch?
>=20
>=20
> -- >8 --
> Subject: [PATCH] gitk: french translation
> From: Emmanuel Trillaud <etrillaud@gmail.com>
>=20
> Signed-off-by: Emmanuel Trillaud <etrillaud@gmail.com>
> Signed-off-by: Thomas Moulard <thomas.moulard@gmail.com>
> Signed-off-by: Guy Brand <gb@unistra.fr>
> Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
> ---
[snip]

I got the following errors when trying to 'make' gitk with your latest =
patch :

$ LANG=3DC make
Generating catalog po/fr.msg
msgfmt --statistics --tcl po/fr.po -l fr -d po/
po/fr.po:23:24: invalid multibyte sequence
po/fr.po:23:28: invalid multibyte sequence
po/fr.po:23:66: invalid multibyte sequence
po/fr.po:27:38: invalid multibyte sequence
po/fr.po:31:16: invalid multibyte sequence
po/fr.po:31:22: invalid multibyte sequence
po/fr.po:36:17: invalid multibyte sequence
po/fr.po:36:26: invalid multibyte sequence
po/fr.po:36:40: invalid multibyte sequence
po/fr.po:36:44: invalid multibyte sequence
po/fr.po:37:9: invalid multibyte sequence
po/fr.po:46:17: invalid multibyte sequence
po/fr.po:46:26: invalid multibyte sequence
po/fr.po:46:40: invalid multibyte sequence
po/fr.po:46:44: invalid multibyte sequence
po/fr.po:46:76: invalid multibyte sequence
po/fr.po:51:16: invalid multibyte sequence
po/fr.po:51:22: invalid multibyte sequence
po/fr.po:63:23: invalid multibyte sequence
po/fr.po:63:32: invalid multibyte sequence
msgfmt: too many errors, aborting
make: *** [po/fr.msg] Error 1

This is obviously an encoding problem.

My LANG is 'fr_FR.UTF-8' if it is relevant.

The file generate by :
iconv --from-code ISO_8859-1 --to-code UTF-8 --output po/fr.po po/fr.po
work as expected.
Don't the *.po files need to be in utf8?

Best regards

Emmanuel
