From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Wed, 15 May 2013 13:56:46 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1305151351130.20281@nerf07.vanv.qr>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net> <alpine.LNX.2.01.1305131542210.30808@nerf07.vanv.qr> <001d01ce500b$c7c08b70$5741a250$@scanmyfood.de> <alpine.LNX.2.01.1305132119220.2288@nerf07.vanv.qr> <CAN0XMOL3rkYDinSCN2GLaRj7dOvbF=SdMRxM4PHCZ5h7g5Nkkw@mail.gmail.com>
 <51936218.9020306@ira.uka.de> <519370D3.3000306@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ralph_Hau=C3=9Fmann?= <ralph@scanmyfood.de>,
	Christian Stimming <stimming@tuhh.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	git <git@vger.kernel.org>, =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed May 15 13:56:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcaKE-0006WB-Cu
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 13:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758743Ab3EOL4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 07:56:50 -0400
Received: from ares07.inai.de ([5.9.24.206]:39032 "EHLO ares07.inai.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757452Ab3EOL4t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 07:56:49 -0400
Received: by ares07.inai.de (Postfix, from userid 25121)
	id 3495B96A1582; Wed, 15 May 2013 13:56:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by ares07.inai.de (Postfix) with ESMTP id 144BF96A07E8;
	Wed, 15 May 2013 13:56:46 +0200 (CEST)
In-Reply-To: <519370D3.3000306@web.de>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224399>


On Wednesday 2013-05-15 13:26, Jens Lehmann wrote:
>
>Hmm, I rather tend towards using "Repository" instead of "Archiv" too, as
>"Archiv" can mean anything from a tar-file to a git repository

It's exactly the reasoning I made in my git-glossary.txt sample
(of which the reasoning apparently has not made it into ralfth's
latest wiki, but that's the most essential part of a glossary IMHO).

>but I believe "Packdatei" would be a much better translation (especially as
>the translation of "pack(verb)" is "packen"). I find it natural that a file
>with the extension ".pack" is named Packdatei

While it's spoken Packdatei, the way to actually write it is
.pack-Datei or ".pack"-Datei.

>extension ".zip" is a "Zipdatei" (known by the Duden)

If that's how Duden specifies it, it's time to call wrong upon Duden.
It's ZIP-Datei, of course, and follows the same origin (".zip"-Datei).
The history of "ZIP-Datei" can be explained by way of MSDOS showing
the filename in the DIR command without the dot - which is also
why we do not pronounce the dot in ".zip"- or ".pack"-Datei.


>Yup, im my experience "committen" (to commit), "einchecken" (to check in),
>"auschecken" (to check out) und "taggen" (to tag) made it into our daily
>German language use. To avoid e.g. having past tenses look strange (like
>"committet")

Not so strange. We have other words with -tet.
bitten -> erbittete -> habe erbittet.
