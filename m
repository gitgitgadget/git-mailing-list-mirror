From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Wed, 15 May 2013 19:28:12 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1305151924240.8332@nerf07.vanv.qr>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net> <alpine.LNX.2.01.1305131542210.30808@nerf07.vanv.qr> <001d01ce500b$c7c08b70$5741a250$@scanmyfood.de> <alpine.LNX.2.01.1305132119220.2288@nerf07.vanv.qr> <CAN0XMOL3rkYDinSCN2GLaRj7dOvbF=SdMRxM4PHCZ5h7g5Nkkw@mail.gmail.com>
 <51936218.9020306@ira.uka.de> <519370D3.3000306@web.de> <alpine.LNX.2.01.1305151351130.20281@nerf07.vanv.qr> <51937F2D.90608@web.de> <alpine.LNX.2.01.1305151502220.15513@nerf07.vanv.qr> <5193AA61.2040205@ira.uka.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ralph_Hau=C3=9Fmann?= <ralph@scanmyfood.de>,
	Christian Stimming <stimming@tuhh.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	git <git@vger.kernel.org>, =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 15 19:28:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcfUx-0006z7-Jc
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 19:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759733Ab3EOR2P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 May 2013 13:28:15 -0400
Received: from ares07.inai.de ([5.9.24.206]:40403 "EHLO ares07.inai.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756698Ab3EOR2P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 13:28:15 -0400
Received: by ares07.inai.de (Postfix, from userid 25121)
	id CB7D496A1587; Wed, 15 May 2013 19:28:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by ares07.inai.de (Postfix) with ESMTP id AB97896A07E8;
	Wed, 15 May 2013 19:28:12 +0200 (CEST)
In-Reply-To: <5193AA61.2040205@ira.uka.de>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224427>


On Wednesday 2013-05-15 17:31, Holger Hellmuth (IKS) wrote:
>>>
>>> I actually had the '-' in there too until I tried to look up "Zip-D=
atei"
>>> in the Duden. While I don't get the leading '.' (I cannot remember =
having
>>> seen that anywhere, AFAIK the file extensions are always used witho=
ut the
>>> dot), I'm not a grammar expert and will be fine either way.
>>
>> In UNIX-land, extension seemed to always include the dot.
>> In DOS-land, it's without (inherited from VMS too, perhaps?)
>> As such, either way to write it is acceptable.
>
> Even in unix-land no one adds a dot because usually the extension is =
named
> after the data format, only that the file extension is used as the co=
mmon
> abbreviation (at least that is my interpretation). Compare with jpeg.=
 You often
> write jpeg-Datei instead of jpg-Datei because the data format is call=
ed jpeg.

That too is correct, and actually a third way of describing files.
=46or example, .doc/.xls-Datei in speech is very seldom, if at all; MS
Office output has had generally been called Word-Datei,
Excel-Tabelle/-Datei and so on.

What I meant however is that the extension is ".jpg" (or .jpeg) from
a programming aspect (like, when na=C3=AFvely trying to figure out the
filetype) as in
  ($name, $ext) =3D (/^[^\.]+(\..+)?/)
