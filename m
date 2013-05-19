From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Sun, 19 May 2013 18:06:48 +0200
Message-ID: <CAN0XMO+TG7uXGPjqQZXX5KetQkf63gRtSdMxFK8r_40Dr4BGLQ@mail.gmail.com>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net>
	<alpine.LNX.2.01.1305131542210.30808@nerf07.vanv.qr>
	<001d01ce500b$c7c08b70$5741a250$@scanmyfood.de>
	<alpine.LNX.2.01.1305132119220.2288@nerf07.vanv.qr>
	<CAN0XMOL3rkYDinSCN2GLaRj7dOvbF=SdMRxM4PHCZ5h7g5Nkkw@mail.gmail.com>
	<51936218.9020306@ira.uka.de>
	<519370D3.3000306@web.de>
	<CAN0XMOJ7hRwTAR+i8_C2z2NmmcycLQkiya0ayfWS0vAw3-zqkg@mail.gmail.com>
	<51949D65.7050001@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Jan Engelhardt <jengelh@inai.de>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ralph_Hau=C3=9Fmann?= <ralph@scanmyfood.de>,
	Christian Stimming <stimming@tuhh.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	git <git@vger.kernel.org>, =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun May 19 18:07:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue68S-0000V2-UZ
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 18:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871Ab3ESQGv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 12:06:51 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:43771 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908Ab3ESQGt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 12:06:49 -0400
Received: by mail-wi0-f174.google.com with SMTP id c10so1474965wiw.1
        for <git@vger.kernel.org>; Sun, 19 May 2013 09:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=z4HMarHBv8GQCoQUswYBdyT0eDaQKPdj593ucz0HV4o=;
        b=N5Gz3iD6EJ68My6xorw1AkvgjGHGeldB+kPsp0drA/vT3GohGDpmQuztC7x7xn7J8/
         acGdUxmAnyGINFv+JWNOZo4wfC4Z5/oSnlHTveCUoxLNj0xbTFVeET9ge60mVIfIX44Y
         lyfPRHT/jQQh4ApuT+T9SwUg6X3aS5GGu4YL9AuJ9KblUn+dzEeQ+4djSoqnqWEuo6ZT
         suKUvtppsx21sYe3IrAhCalA9neF5S8qTta+jSW42kSFEduVW/fLWz/JF5BJrApkvlbl
         cTKvR1jVF2jA03gHLsxVliI6xm5d7V5I+3p7h9TF4ck0qcsG1GJq2wX+usAyW63d4Obr
         bk3A==
X-Received: by 10.180.21.167 with SMTP id w7mr6504302wie.2.1368979608198; Sun,
 19 May 2013 09:06:48 -0700 (PDT)
Received: by 10.194.237.5 with HTTP; Sun, 19 May 2013 09:06:48 -0700 (PDT)
In-Reply-To: <51949D65.7050001@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224897>

2013/5/16 Holger Hellmuth (IKS) <hellmuth@ira.uka.de>:
>
>> +    bare repository        =3D blo=C3=9Fes Repository
>
>
> Since "blo=C3=9Fes Rep." does not convey any sensible meaning to a ge=
rman reader
> (at least it doesn't to me) it might as well be "bare". Also bare is =
used as
> parameter to commands
>
>
>> +    remote tracking branch =3D externer =C3=9Cbernahmezweig
>
>
> Anyone used to the english client will switch as soon as he has to re=
ad
> this. No idea how to improve that though except to just use the engli=
sh
> terms like the pro git translation does.
>
>
>> +    upstream branch        =3D -||-
>
>
> Use upstream as it is used as parameter to commands
>
>> +    fetch =3D anfordern
>
> fetch =3D fetch
>>
>> +    pull  =3D zusammenf=C3=BChren
>
> pull =3D pull
>>
>> +    push  =3D versenden
>
> push =3D push
>
> established vocabulary used in stack programming as well as in vcs. S=
hould
> not be translated.
>

I think the messages would become a bit too G+E when we'd say something
like "Das Fetchen in den Branch...", "Fetche von %s". Some for merge as
a verb.

>> +    clean(verb)        =3D
>
> clean(verb) =3D s=C3=A4ubern/aufr=C3=A4umen
>>
>> +    clean(noun)        =3D
>
> clean(noun) =3D S=C3=A4uberung
>
> "aufr=C3=A4umen" is the better verb but there is no noun for it.
>
>
>> +    whitespace         =3D Leerzeichen (FIXME?) (maybe "Leerraum")
>
> whitespace =3D whitespace
>
> There is no german word for whitespace
>
>
>> +Still being worked out:
>> +
>> +    prune              =3D veraltete(n) Zweig(e) entfernen
>> +    checkout(verb)     =3D auschecken
>> +
>> +    git add      =3D hinzuf=C3=BCgen
>
>
> "mittels "git add" hinzuf=C3=BCgen" if you want to emphasize that you=
 add
> something with the command
>
>
>> +
>> +    merge conflict =3D Merge-Konflikt
>> +    3-way merge    =3D 3-Wege-Merge
>> +    paths          =3D Pfade
>> +
>> +    symbolic link =3D symbolische Verkn=C3=BCfung
>> +    path =3D Pfad
>> +    link =3D Verkn=C3=BCpfung
>> +
>> +    reflog =3D Referenzprotokoll
>> +    partial commit =3D teilweise committen, partiell committen
>
>
> As a noun, "Teil-Commit"
>
>
>> +
>> +    reset =3D neu setzen (maybe "umsetzen"?)
>
>
> "zur=C3=BCcksetzen"
>
>

I'll send a new version to the list later.

Thanks
