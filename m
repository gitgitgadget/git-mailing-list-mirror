From: =?utf-8?Q?Ralph_Hau=C3=9Fmann?= <ralph@scanmyfood.de>
Subject: AW: English/German terminology, git.git's de.po, and pro-git
Date: Mon, 13 May 2013 20:57:55 +0200
Message-ID: <001d01ce500b$c7c08b70$5741a250$@scanmyfood.de>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net> <alpine.LNX.2.01.1305131542210.30808@nerf07.vanv.qr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "'Ralf Thielow'" <ralf.thielow@gmail.com>,
	"'Christian Stimming'" <stimming@tuhh.de>,
	"'Sven Fuchs'" <svenfuchs@artweb-design.de>,
	"'Ralph Haussmann'" <ralph@scanmyfood.de>, <git@vger.kernel.org>,
	=?utf-8?Q?'Jan_Kr=C3=BCger'?= <jk@jk.gs>
To: "'Jan Engelhardt'" <jengelh@inai.de>,
	"'Thomas Rast'" <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 13 21:03:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uby2D-0005GL-BH
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 21:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467Ab3EMTDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 15:03:39 -0400
Received: from dd10500.kasserver.com ([85.13.133.64]:45612 "EHLO
	dd10500.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab3EMTDi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 15:03:38 -0400
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 May 2013 15:03:38 EDT
Received: from Samsung (HSI-KBW-46-223-8-190.hsi.kabel-badenwuerttemberg.de [46.223.8.190])
	by dd10500.kasserver.com (Postfix) with ESMTPSA id 18DC12DC05B6;
	Mon, 13 May 2013 20:58:02 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.01.1305131542210.30808@nerf07.vanv.qr>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQKRpDahy+M4aP1Sw4p1lJ3ucmyYEwEddEXql3PiEjA=
Content-Language: de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224192>

Hi,

My vote is G+E, too. 

lb1a, Florian Breisch and I are working on the german translation of the 
pro-git book (hosted on git-scm.com). We use the repository [1] to share 
our work. If someone wants to help us, JOIN US!

The current translation of pro-git is mixed, Ger and G+E. For example, 
the translation of "annotated tag" is "Annotated Tag", "kommentierter Tag" 
and also "kommentierte Markierung".  I agree with the opinion of Jan 
Engelhardt that german terms should be used if they are commonly 
used in technical context ("tree"=> "Baum" but "tag" should be "Tag" 
in german, too).

There is a glossary for the pro-git book (see [2]) but it is not up-to-date 
and it is also mixed. Therefor I would like to avoid using this glossary. 
I like the idea of a shared wiki (git de.po and pro-git). 
I suggest a single page as overview and single pages for 
complicated terms. Maybe we can use our GitHub wiki (see also [3]).

 So long

Ralph

[1] https://github.com/progit-de/progit

[2] https://github.com/progit/progit/blob/master/de/NOTES

[3] https://github.com/progit-de/progit/wiki/Glossar
