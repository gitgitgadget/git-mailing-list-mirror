From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Announce: TortoiseGit 0.1 preview version
Date: Mon, 15 Dec 2008 14:56:27 +0100
Message-ID: <200812151456.27750.jnareb@gmail.com>
References: <1976ea660812130033m2d54cc57tfe134fab0d687d71@mail.gmail.com> <m3d4fuewe0.fsf@localhost.localdomain> <1976ea660812140529k1499b410u4437645be0dc7dfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Li Frank" <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 14:57:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCDxK-0001Mi-RN
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 14:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbYLON4d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Dec 2008 08:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821AbYLON4d
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 08:56:33 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:34108 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbYLON4c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 08:56:32 -0500
Received: by ewy10 with SMTP id 10so3032601ewy.13
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 05:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lUJoQ7ZqoNJGUxdVUajPTucZzHe4q5m79YCfZvFaUHA=;
        b=J6wOe014Jk4ayawiJR68oP3tg2hSUBpLMr9ieZl7+xzGQh2nkgm190qPNXpgfrr7KH
         xGnEyWcVVloJ5P8VR5fdnx2SoMGwcFkDTyVtNY6OI3EzTALkW1jENuxK+KevUcnVpbdH
         z+QcQPZWMrt7ldttycDS7fQhMC6kPxTueovTc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Cz/mZ5HgcNr8NGXQImN7K9iHKDecuxKetBOl6GkvBAhTh3jV8l2metzbXrymFZurWK
         cfowcnRvN2hbQaGI+zq2jpu3QfEMAAQPbKJQiiXUwb5UwXplvZT2tyabtwtzgqLvS5b+
         ugBmxRZhwOp47ORZOvJkCyiv0cyy99ZOrH4pM=
Received: by 10.210.131.6 with SMTP id e6mr7782118ebd.77.1229349390926;
        Mon, 15 Dec 2008 05:56:30 -0800 (PST)
Received: from ?192.168.1.11? (abva128.neoplus.adsl.tpnet.pl [83.8.198.128])
        by mx.google.com with ESMTPS id 5sm531132eyh.37.2008.12.15.05.56.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Dec 2008 05:56:29 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1976ea660812140529k1499b410u4437645be0dc7dfc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103164>

On Sun, 14 Dec 2008, Li Frank wrote:

>=20
> 2008/12/14 Jakub Narebski <jnareb@gmail.com>:
>> "=C0=EE=D6=C7" <lznuaa@gmail.com> writes:
>>
>>> TortoiseGit is porting from TortoiseSVN.  It is explore extension.
>>> This version just finish a minimum set of TortoiseSVN porting
>>
>> How it differs from GitCheetah project?
> GitCheetah just show git-gui &git-bash at context menu!
>=20
> TortoiseGit is full porting from TortoiseSVN. Overlay icon can show
> modified file, add file and conflicted file whith different icon.
>=20
> TortoiseGit can commit change, show log, checkout ... at Context menu=
!
> It is full git fontend.

>> [...]
>>> Project Home Page at:
>>> http://code.google.com/p/tortoisegit/
>>>
>>> Source code at
>>> http://repo.or.cz/w/TortoiseGit.git
>>>
>>> It need msysgit 1.6.0.2.
>>
>> Do you feel it is mature enough to be added to git wiki page
>>  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
>> just above "Git Extensions" entry?  Would you do it, or should
>> I do this?
>=20
> TortoiseGit is in very early stage. I just implement min set feature
> and not mature . I hope there are more and more people involve this
> project and make it mature as TortoiseSVN.

I have added information about TortoiseGit to git wiki at
http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-803ff1eef7a32=
fd1d8fe86713de343af18605047

Please correct it if the information there (copy below) is wrong.
=46eel free to extend this short info.

Hopefully this way more people would find your project, and be able
to contribute to it.


  =3D=3D=3D TortoiseGit =3D=3D=3D
 =20
  TortoiseGit[1] (gitweb[2]) by Li Frank is a port of TortoiseSVN[3]
  to Git.  It is Microsoft Windows shell (Explorer) extension, written
  in C++.  TortoiseGit is in very early stages of development,
  implementing currently only minimal set of features.

  [1] http://code.google.com/p/tortoisegit/
  [2] http://repo.or.cz/w/TortoiseGit.git
  [3] http://tortoisesvn.tigris.org/

--=20
Jakub Narebski
Poland
