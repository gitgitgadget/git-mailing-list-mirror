From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-bugzilla
Date: Sun, 16 Nov 2008 17:23:28 -0800 (PST)
Message-ID: <m3iqqnkuwh.fsf@localhost.localdomain>
References: <492089EA.60205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?Steve_Fr=E9cinaux?= <nudrema@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 02:24:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1sr9-0003ED-IW
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 02:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368AbYKQBXc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Nov 2008 20:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754367AbYKQBXc
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 20:23:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:36298 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354AbYKQBXc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Nov 2008 20:23:32 -0500
Received: by ug-out-1314.google.com with SMTP id 39so294392ugf.37
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 17:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=F3LG1jd2cDhTH4FEGfYEWdulhZsq0QzRUr5YrnzsXT0=;
        b=DsfOoc9HyACX23S2cw0zDKjPVd4BJbaX7roAm6setB/8YxL1KyBDVUMrnuKMKWr9+R
         Tgj1iMm1AR6nN6CfNv2PEypihbtuncJeKtX6ty2dtaog3wcO2BZ2R71SswzUK6pUp58c
         Aq0SGx9n3dvMUiLZQo4S93tFEN7Fjmj9BV+Gg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=QHbrVjuOdwVrRTxDtDikgoPMETPNmOp9rogK3mSVVwZzZta5eTxpH5/fU9NXFSN7FV
         r9yKgi2RZ5Fl+3mIF7wIlo9sERtfdAa/W91asqX7m4LowXe3OQxL2o0PA6YUMSh8+Cxo
         Ixt/oF+CVY3DYpfmwt95aOpFV5g9+R07O2+EY=
Received: by 10.67.28.14 with SMTP id f14mr1032097ugj.79.1226885009757;
        Sun, 16 Nov 2008 17:23:29 -0800 (PST)
Received: from localhost.localdomain (abwi102.neoplus.adsl.tpnet.pl [83.8.232.102])
        by mx.google.com with ESMTPS id l20sm1883688uga.14.2008.11.16.17.23.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Nov 2008 17:23:28 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mAH1NSBk011383;
	Mon, 17 Nov 2008 02:23:28 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mAH1NRLG011380;
	Mon, 17 Nov 2008 02:23:27 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <492089EA.60205@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101190>

Steve Fr=E9cinaux <nudrema@gmail.com> writes:

> Here is a chunk of code I wrote a few time ago, to post patches to
> bugzilla, modelled mostly after git-format-patch/git-send-email.
>=20
> You can find it there:
> http://code.istique.net/?p=3Dgit-bugzilla.git
>=20
> It is written in perl and requires WWW::Mechanize.
[...]

Added to http://git.or.cz/gitwiki/InterfacesFrontendsAndTools

Thanks.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
