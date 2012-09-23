From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: Message from 'git-rebase'; German translation
Date: Sun, 23 Sep 2012 19:29:03 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1209231924500.3904@nerf07.vanv.qr>
References: <1527028.GPe6zkelBV@blacky> <CAN0XMO+Dd9S7j9Ujudcy+O3GwwBX1CvRPQTYWxymmEu=2bg7ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sascha Cunz <sascha-ml@babbelbox.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 19:30:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFq0E-000701-VT
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 19:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177Ab2IWR3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2012 13:29:07 -0400
Received: from ares07.inai.de ([5.9.24.206]:59095 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754084Ab2IWR3G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 13:29:06 -0400
Received: by seven.medozas.de (Postfix, from userid 25121)
	id 6EAAD96A0FAB; Sun, 23 Sep 2012 19:29:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by seven.medozas.de (Postfix) with ESMTP id 4E47C96A0C9C;
	Sun, 23 Sep 2012 19:29:03 +0200 (CEST)
In-Reply-To: <CAN0XMO+Dd9S7j9Ujudcy+O3GwwBX1CvRPQTYWxymmEu=2bg7ww@mail.gmail.com>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206246>


On Sunday 2012-09-23 17:04, Ralf Thielow wrote:
>>
>> Original:
>> ... and I wonder if you are in the middle of another rebase.
>>
>> German git translation:
>> ... und es w=C3=A4re verwunderlich, wenn ein Neuaufbau bereits im Ga=
nge ist.
>
>We try to avoid translating terms like "I wonder if.." and similar as
>"ich wundere mich", because it's very unusual in German messages
>of computer programs.


Even "I wonder if" is unusual, since programs normally don't have
any personality.


>Translators should have the freedom to reword
>terms a bit to make a more optimal translation, but the meaning must
>not be lost, and I can't say that this is the case.
>Translate the term "in the middle of"  word-by-word would result in
>"in der Mitte eines", which can be interpreted as a place somewhere
>or that an action is in progress. To avoid a possible confusion, we
>decided to translate this term as "im Gange sein" ("be in progress") i=
n
>the whole translation. I also think that "in der Mitte einer Zusammenf=
=C3=BChrung
>sein" doesn't sound really good. It tends to mean a place, not an acti=
on.

Why not just write
    ...und es scheint, dass gerade ein Rebase durchgef=C3=BChrt wird.


>> Original:
>> I am stopping in case you still have something valuable there.
>>
>> German git translation:
>> Es wird angehalten, falls bereits etwas N=C3=BCtzliches vorhanden is=
t.
>>
>> I wanted to point out that "etwas N=C3=BCtzliches" is more "somethin=
g useful" that
>> "something valuable". But the more I thought about it, the more it s=
tarted to

In fact, "still" is not "bereits" but "noch". Do I smell somebody
fed this through an automatic translation program?

Maybe I should dig up the (real) original .po files and see what
I wrote there.
