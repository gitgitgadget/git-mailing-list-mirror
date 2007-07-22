From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH 3/5] Internationalization of git-gui
Date: Sun, 22 Jul 2007 14:16:42 +0200
Message-ID: <200707221416.42908.stimming@tuhh.de>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <20070722074740.GY32566@spearce.org> <7vodi4sw1e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 14:16:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICaMg-0004Zx-S6
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 14:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760200AbXGVMQo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 08:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759562AbXGVMQn
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 08:16:43 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:36529 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759259AbXGVMQm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 08:16:42 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6MCGXnj006020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sun, 22 Jul 2007 14:16:33 +0200
Received: from [192.168.2.102] (p5490117A.dip0.t-ipconnect.de [84.144.17.122])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6MCGV5M023002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Jul 2007 14:16:32 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <7vodi4sw1e.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53258>

Am Sonntag, 22. Juli 2007 10:05 schrieb Junio C Hamano:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > Christian Stimming <stimming@tuhh.de> wrote:
> >> Subject: [PATCH] Initial German translation for testing of i18n.
> >> diff --git a/po/de.po b/po/de.po
> >> new file mode 100644
> >> index 0000000..0592836
> >> --- /dev/null
> >> +++ b/po/de.po
> >> @@ -0,0 +1,265 @@
> >> +# Translation of git-gui to German.
> >> +# Copyright (C) 2007 Linux Torvalds
> >
> > I didn't realize Linus wrote German.  ;-)
> >
> > Or are you assigning the copyright to Linus, much as other chunks
> > of Git are copyrighted by Linus?
>
> The convention for xx.po, judging from the way template pot file
> is written out, is to name the package's copyright holder, not
> translation's, on that line.  

Exactly. That line should say that even though I have been the author of 
de.po, I still assign copyright (or the assign-able parts of it) to the 
package's copyright owner, which in this case is Linus. As Junio says, this 
is a suggestion from gettext, and I'd simply follow it here.

> So Linus does not have to have anything to do with the German part, 
> but I think the appropriate name to place there is yours.

s/yours/his/ ? Otherwise this sentence sounds like a contradiction to the 
previous one...

Christian
