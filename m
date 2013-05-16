From: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Thu, 16 May 2013 10:48:37 +0200
Message-ID: <51949D65.7050001@ira.uka.de>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net> <alpine.LNX.2.01.1305131542210.30808@nerf07.vanv.qr> <001d01ce500b$c7c08b70$5741a250$@scanmyfood.de> <alpine.LNX.2.01.1305132119220.2288@nerf07.vanv.qr> <CAN0XMOL3rkYDinSCN2GLaRj7dOvbF=SdMRxM4PHCZ5h7g5Nkkw@mail.gmail.com> <51936218.9020306@ira.uka.de> <519370D3.3000306@web.de> <CAN0XMOJ7hRwTAR+i8_C2z2NmmcycLQkiya0ayfWS0vAw3-zqkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Jan Engelhardt <jengelh@inai.de>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?B?UmFscGggSGF1w59tYW5u?= <ralph@scanmyfood.de>,
	Christian Stimming <stimming@tuhh.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	git <git@vger.kernel.org>,
	=?UTF-8?B?SmFuIEtyw7xnZXI=?= <jk@jk.gs>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 10:48:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UctrZ-0007yH-4O
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756854Ab3EPIsd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 May 2013 04:48:33 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:39791 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755427Ab3EPIsa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 May 2013 04:48:30 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1UctrC-0005yY-Rd; Thu, 16 May 2013 10:48:21 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 587 
	id 1UctrC-0006Gg-JN; Thu, 16 May 2013 10:48:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAN0XMOJ7hRwTAR+i8_C2z2NmmcycLQkiya0ayfWS0vAw3-zqkg@mail.gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1368694101.314095000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224511>


> +    bare repository        =3D blo=C3=9Fes Repository

Since "blo=C3=9Fes Rep." does not convey any sensible meaning to a germ=
an=20
reader (at least it doesn't to me) it might as well be "bare". Also bar=
e=20
is used as parameter to commands

> +    remote tracking branch =3D externer =C3=9Cbernahmezweig

Anyone used to the english client will switch as soon as he has to read=
=20
this. No idea how to improve that though except to just use the english=
=20
terms like the pro git translation does.

> +    upstream branch        =3D -||-

Use upstream as it is used as parameter to commands

> +    fetch =3D anfordern
fetch =3D fetch
> +    pull  =3D zusammenf=C3=BChren
pull =3D pull
> +    push  =3D versenden
push =3D push

established vocabulary used in stack programming as well as in vcs.=20
Should not be translated.

> +    clean(verb)        =3D
clean(verb) =3D s=C3=A4ubern/aufr=C3=A4umen
> +    clean(noun)        =3D
clean(noun) =3D S=C3=A4uberung

"aufr=C3=A4umen" is the better verb but there is no noun for it.

> +    whitespace         =3D Leerzeichen (FIXME?) (maybe "Leerraum")
whitespace =3D whitespace

There is no german word for whitespace

> +Still being worked out:
> +
> +    prune              =3D veraltete(n) Zweig(e) entfernen
> +    checkout(verb)     =3D auschecken
> +
> +    git add      =3D hinzuf=C3=BCgen

"mittels "git add" hinzuf=C3=BCgen" if you want to emphasize that you a=
dd=20
something with the command

> +
> +    merge conflict =3D Merge-Konflikt
> +    3-way merge    =3D 3-Wege-Merge
> +    paths          =3D Pfade
> +
> +    symbolic link =3D symbolische Verkn=C3=BCfung
> +    path =3D Pfad
> +    link =3D Verkn=C3=BCpfung
> +
> +    reflog =3D Referenzprotokoll
> +    partial commit =3D teilweise committen, partiell committen

As a noun, "Teil-Commit"

> +
> +    reset =3D neu setzen (maybe "umsetzen"?)

"zur=C3=BCcksetzen"
