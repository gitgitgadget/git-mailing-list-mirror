From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Announce: TortoiseGit 0.1 preview version
Date: Sun, 14 Dec 2008 05:09:38 -0800 (PST)
Message-ID: <m3d4fuewe0.fsf@localhost.localdomain>
References: <1976ea660812130033m2d54cc57tfe134fab0d687d71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?gb2312?b?wO7Wxw==?= <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 14:11:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBqkS-0005kE-1P
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 14:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbYLNNJl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Dec 2008 08:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752905AbYLNNJl
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 08:09:41 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:54433 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbYLNNJk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Dec 2008 08:09:40 -0500
Received: by ewy10 with SMTP id 10so2545594ewy.13
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 05:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=4Szzvh1xVHGVIq34JMkw2cIB5O09GNVFiEEXHfW5xV0=;
        b=lOnzVw8L4iEOjk1qRLt3h+oLrWicU9CrbEi4KfXiYEB8qPpZl//ZquRlKCmIcv+0jf
         o3nuztOL755SJmVGwzloHROl7UeiqbkcbUst347V/47g8IZWIIZGDKj+sPG76jFao2kJ
         Jz+nwpjehHDicN6YCShUnWj5W0Jui1jkBMxkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=MAfZvBRoT119pvfI+eJpVeM6H6Gk94Q+pKO9ZgcmRqXU39xE5quUmWUEXVPx3AmaZW
         qp03Hlj7eSd3G/AcJb85EZY3s5+DD9oOQB+I3gEMdp0Y/imdqcGZ+sYIH/MHpsRHWAGh
         QEtxMlizxYpa5UOIhxbPU2X/zcOCi/q3G5cxM=
Received: by 10.210.137.14 with SMTP id k14mr6507880ebd.175.1229260179036;
        Sun, 14 Dec 2008 05:09:39 -0800 (PST)
Received: from localhost.localdomain (abxb72.neoplus.adsl.tpnet.pl [83.8.251.72])
        by mx.google.com with ESMTPS id y37sm6033147iky.16.2008.12.14.05.09.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Dec 2008 05:09:38 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBED9YhH016956;
	Sun, 14 Dec 2008 14:09:35 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBED9S8N016953;
	Sun, 14 Dec 2008 14:09:28 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1976ea660812130033m2d54cc57tfe134fab0d687d71@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103078>

"=C0=EE=D6=C7" <lznuaa@gmail.com> writes:

> TortoiseGit is porting from TortoiseSVN.  It is explore extension.
> This version just finish a minimum set of TortoiseSVN porting

How it differs from GitCheetah project?

[...]
> Project Home Page at:
> http://code.google.com/p/tortoisegit/
>=20
> Source code at
> http://repo.or.cz/w/TortoiseGit.git
>=20
> It need msysgit 1.6.0.2.

Do you feel it is mature enough to be added to git wiki page
  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
just above "Git Extensions" entry?  Would you do it, or should
I do this?

--=20
Jakub Narebski
Poland
ShadeHawk on #git
