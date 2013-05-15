From: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Wed, 15 May 2013 12:23:20 +0200
Message-ID: <51936218.9020306@ira.uka.de>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net> <alpine.LNX.2.01.1305131542210.30808@nerf07.vanv.qr> <001d01ce500b$c7c08b70$5741a250$@scanmyfood.de> <alpine.LNX.2.01.1305132119220.2288@nerf07.vanv.qr> <CAN0XMOL3rkYDinSCN2GLaRj7dOvbF=SdMRxM4PHCZ5h7g5Nkkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Engelhardt <jengelh@inai.de>, Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?B?UmFscGggSGF1w59tYW5u?= <ralph@scanmyfood.de>,
	Christian Stimming <stimming@tuhh.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	git <git@vger.kernel.org>,
	=?UTF-8?B?SmFuIEtyw7xnZXI=?= <jk@jk.gs>, jens.lehmann@web.de
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 12:45:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcZCt-0003wK-Dl
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 12:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486Ab3EOKpI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 May 2013 06:45:08 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:57778 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754276Ab3EOKpH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 May 2013 06:45:07 -0400
X-Greylist: delayed 1307 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 May 2013 06:45:07 EDT
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1UcYrP-0003Xe-Ew; Wed, 15 May 2013 12:23:13 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 587 
	id 1UcYrP-0000HQ-4x; Wed, 15 May 2013 12:23:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAN0XMOL3rkYDinSCN2GLaRj7dOvbF=SdMRxM4PHCZ5h7g5Nkkw@mail.gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1368613393.850215000
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1368614706.541570000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224396>

Am 14.05.2013 19:51, schrieb Ralf Thielow:
> - repository =3D Projektarchiv
> - bare repository =3D blo=C3=9Fes Projektarchiv
> + repository =3D Projektarchiv, (or just Repository?)
> + bare repository =3D blo=C3=9Fes Projektarchiv (-||-), (reines, pure=
s Repository)

I would vote for Repository or if it needs to be translated, simply=20
Archiv. Neither Projektarchiv nor Archiv is commonly used by me but=20
Archiv is shorter and not everything in a repository is a project.

> I'm not sure about using "Repository". I think "Projektarchiv" is
> actually good enough.
>
> - committer =3D Eintragender
> - tagger =3D Markierer
> + committer =3D Eintragender (or Committer, Commit-Ersteller)
> + tagger =3D Markierer (or Tagger, Tag-Ersteller)
> ...[each usage of commit and tag]...

Both "commit" and "tag" are used in commands so with the exception of=20
the place where they are defined the english words should be used. I=20
think Commit-/Tag-Ersteller actually sounds fine and german enough so n=
o=20
one notices there is an english word in there ;-)


> + branch =3D Zweig (or Branch)
>
> I think "Zweig" is already fine.

Same reason, branch is used as a command and should not be translated.=20
But "Zweig" is a really natural and together with "Baum" fitting=20
translation, so I'm conflicted here.
