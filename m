From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-ftp: retry, sftp support
Date: Mon, 18 Jul 2011 00:57:35 -0700 (PDT)
Message-ID: <m3vcv0yqb4.fsf@localhost.localdomain>
References: <CACPiFCL22yr096_nNfjvfP_bkJRC7HA65GUF12wedzV=cz-_kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?Ren=E9_Moser?= <mail@renemoser.net>,
	Timo Besenreuther <timo.besenreuther@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 09:57:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qiihz-0006U4-E4
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 09:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216Ab1GRH5i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 03:57:38 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:43191 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745Ab1GRH5h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2011 03:57:37 -0400
Received: by fxd18 with SMTP id 18so6215456fxd.11
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 00:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=TPylwJpGuZISHU3m6RTYmuMrcXsQO73H6wKGiQ9l8bI=;
        b=Y7KyVox/Hod2jzeDxxLYLc8xQELuWUnt2NsTBKdVJFJuytpVoc6JSDgxenGpmGSqga
         raH4JRLNILeK+5LvkHpd4hBcStWBRlJg6FiyxJZv/7+krwslwa0Je1lxXcEQYLf8JJKI
         qkKPkpyQzv++WLuoG6HMlKhe63IWunsxMKhD4=
Received: by 10.223.69.65 with SMTP id y1mr9761146fai.60.1310975856387;
        Mon, 18 Jul 2011 00:57:36 -0700 (PDT)
Received: from localhost.localdomain (abvm165.neoplus.adsl.tpnet.pl [83.8.210.165])
        by mx.google.com with ESMTPS id d6sm2780921fak.34.2011.07.18.00.57.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jul 2011 00:57:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6I7vKSt011423;
	Mon, 18 Jul 2011 09:57:30 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p6I7v3CG011416;
	Mon, 18 Jul 2011 09:57:03 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CACPiFCL22yr096_nNfjvfP_bkJRC7HA65GUF12wedzV=cz-_kg@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177356>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Ren=E9, Timo,
>=20
> Thanks for git-ftp -- it has saved me from going crazy with low cost
> hosting setups that only support ftp.

Could you give us a link?  It isn't in git core, is it?

How git-ftp differs from ftp / ftps remote helper (git-remote-ftp etc.)=
?


--=20
Jakub Nar=EAbski
