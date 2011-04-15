From: Tim Smith <tzs@eacceleration.com>
Subject: Re: Gitbox
Date: Fri, 15 Apr 2011 12:21:38 -0700
Message-ID: <98FEC064-DE91-4F66-9BCB-C1BC27B8F4D6@eacceleration.com>
References: <BANLkTikfCDm-5Yde=2Cm-ROc1dcMwopvOg@mail.gmail.com> <4238CC86-13A5-4DB8-B8B2-BC3AA2F2DA5E@gmail.com> <4DA654D4.5040104@medialab.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 21:30:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAoiN-0004ka-7E
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 21:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754395Ab1DOT3x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Apr 2011 15:29:53 -0400
Received: from hmkgw.eacceleration.com ([138.210.79.211]:49583 "EHLO
	hmkgw.eacceleration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119Ab1DOT3x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2011 15:29:53 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Apr 2011 15:29:52 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hmkvm-svcml147.hostmark.eacceleration.com (Postfix) with ESMTP id 5B3EB281BDA2
	for <git@vger.kernel.org>; Fri, 15 Apr 2011 19:21:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
	hmkvm-svcml147.hostmark.eacceleration.com
Received: from hmkgw.eacceleration.com ([127.0.0.1])
	by localhost (hmkvm-svcml147.hostmark.eacceleration.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UDt7Jy2kp3hl for <git@vger.kernel.org>;
	Fri, 15 Apr 2011 19:21:38 +0000 (UTC)
Received: from timsmith2.hostmark.eacceleration.com (timsmith2.hostmark.eacceleration.com [10.5.0.77])
	by hmkvm-svcml147.hostmark.eacceleration.com (Postfix) with ESMTP id D273B281BDA0
	for <git@vger.kernel.org>; Fri, 15 Apr 2011 19:21:38 +0000 (UTC)
In-Reply-To: <4DA654D4.5040104@medialab.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171634>


When GPLv2 talks about works "based on" another work, they mean works t=
hat are "derivative works" under copyright law. This is mentioned expli=
citly in section 0.

GPLv2 also uses the term "derived from", which it does not define and i=
s not a term of copyright law.

Copyright law gives the copyright owner certain exclusive rights. No on=
e else is allowed to do those things without permission from the copyri=
ght owner. The GPLv2 (and most other free software licenses) are design=
ed to give you that permission. They serve strictly to remove restricti=
ons, not to add them.

Contrast to a typical commercial software EULA, which might grant to yo=
u some permissions, but also will try to stop you from doing things tha=
t you are normally allowed to do. For instance, copyright law places no=
 limit on the number of backup copies you can make of software you purc=
hase. All that it requires (at least in the US) is that if you transfer=
 ownership of your copy of the software to someone else you either dest=
roy all your backups, or transfer them with the software. The typical E=
ULA will make you agree to only keep one backup copy.

The FSF is quite clear that they intend the GPLv2 to not be a EULA. It =
only extends rights to you, it does not take any away. Accordingly, whe=
n trying to decide what an undefined term like "derived from" means in =
the context of GPLv2, you should look to copyright law. This makes it c=
lear that they are using "derived" from to mean the same thing that cop=
yright law means by a "derivative work".

Gitbox is not a derivative work of Git. The only thing Gitbox is doing =
that requires permission from the Git copyright owners is distributing =
an unmodified copy of Git with Gitbox. As long as Gitbox obeys the GPL =
by making the corresponding Git source available in a way allowed under=
 GPLv2, they have permission. End of story.

They tried to clear up some of this confusing in GPLv3:

> To =93modify=94 a work means to copy from or adapt all or part of the=
 work in a fashion requiring copyright permission, other than the makin=
g of an exact copy. The resulting work is called a =93modified version=94=
 of the earlier work or a work =93based on=94 the earlier work.



--=20
--Tim Smith
