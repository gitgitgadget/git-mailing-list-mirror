From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [RFC] l10n: de.po: translate 29 new messages
Date: Tue, 03 Jul 2012 22:03:50 +0200
Organization: Alumni Technische =?UTF-8?B?VW5pdmVyc2l0w6R0?= Hamburg-Harburg
Message-ID: <2021839.rMjHRWft8I@cs-pc>
References: <1341335086-6767-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch, jk@jk.gs, worldhello.net@gmail.com,
	git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 23:04:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAH6-0007t0-SZ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757273Ab2GCVEI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jul 2012 17:04:08 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:50858 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab2GCVEG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jul 2012 17:04:06 -0400
X-Greylist: delayed 3594 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jul 2012 17:04:06 EDT
Received: from mail.tu-harburg.de (mail.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id q63K3uG7001150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 3 Jul 2012 22:03:56 +0200
Received: from cs-pc.localnet (e182110175.adsl.alicedsl.de [85.182.110.175])
	(user=alucst mech=LOGIN bits=0)
	by mail.tu-harburg.de (8.13.8/8.13.8) with ESMTP id q63K3tCk014686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Jul 2012 22:03:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2012-27;
	t=1341345836; bh=UtYG5ftEejzTPAoFeWwbg+UUphxCI7ZaKXeIQ7HT/Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=DspXUjqnDUYpFkkGG11RTm9E87OBaa3oTLbE4gO1LWNWs4dFmAuj6Hyh4WEVQ2YAr
	 mSznTfGXyNzPE6rUeeVi+v4f2eqezCQH+4QlazfvyOuEEIpD2PiWyBofSSJyUrntOF
	 iY2npyijtFfXdfjhJnCQsfhyzCqvAKt4fClv49Ws=
User-Agent: KMail/4.7.3 (Linux/3.0.0-22-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <1341335086-6767-1-git-send-email-ralf.thielow@gmail.com>
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200945>

Hi Ralf,

very good. I have a few remarks, though, on particularly chosen word=20
translations:

Am Dienstag, 3. Juli 2012, 19:04:46 schrieb Ralf Thielow:
>  #: wt-status.c:874 wt-status.c:884
> -#, fuzzy
>  msgid "You are currently rebasing."
> -msgstr "Du befindest dich auf keinem Zweig."
> +msgstr "Du bist gerade beim Neuaufbau."

Is "rebase" =3D "Neuaufbau"? My last thought on this wording was "rebas=
e" =3D=20
"Umpflanzen".

>  #: wt-status.c:889
>  msgid "You are currently splitting a commit during a rebase."
> -msgstr ""
> +msgstr "Du teilst gerade eine Version w=E4hrend eines Neuaufbaus auf=
=2E"

Maybe
"Du teilst gerade eine Version auf w=E4hrend eines Neuaufbaus."

>  #: wt-status.c:909
>  msgid "You are currently cherry-picking."
> -msgstr ""
> +msgstr "Du f=FChrst gerade \"cherry-pick\" aus."

I thought "cherry-pick" =3D "pfl=FCcken", or is there a different gloss=
ary choice?

Thanks!

Christian
