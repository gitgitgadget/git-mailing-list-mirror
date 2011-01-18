From: Alexey Shumkin <zapped@mail.ru>
Subject: Re: [PATCH 2/3] git-gui: spelling fixes in russian translation
Date: Tue, 18 Jan 2011 07:40:05 +0000 (UTC)
Message-ID: <loom.20110118T083048-91@post.gmane.org>
References: <cover.1295295897.git.raa.lkml@gmail.com> <1c96343bbf6fb30e7453c3df7b49ea31667e0469.1295295897.git.raa.lkml@gmail.com> <20110117210828.GC27029@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 18 08:40:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pf6B0-0005Jr-S5
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 08:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823Ab1ARHkS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jan 2011 02:40:18 -0500
Received: from lo.gmane.org ([80.91.229.12]:37086 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673Ab1ARHkR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 02:40:17 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Pf6Aq-0005H3-F0
	for git@vger.kernel.org; Tue, 18 Jan 2011 08:40:16 +0100
Received: from 212.34.37.3 ([212.34.37.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 08:40:16 +0100
Received: from zapped by 212.34.37.3 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 08:40:16 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.34.37.3 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.10 (KHTML, like Gecko) Chrome/8.0.552.215 Safari/534.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165191>

change this
>  #, tcl-format
>  msgid "File %s seems to have unresolved conflicts, still stage?"
>  msgstr ""
+"=D0=A4=D0=B0=D0=B9=D0=BB %s =D0=BA=D0=B0=D0=B6=D0=B5=D1=82=D1=81=D1=8F=
 =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=BD=D0=B5=D0=BE=D0=
=B1=D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BA=D0=
=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D1=8B.
=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C =D0=BF=D0=BE=
=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BA=D1=83 =D0=BA "
 "=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E?"
to
+"=D0=A4=D0=B0=D0=B9=D0=BB %s, =D0=BA=D0=B0=D0=B6=D0=B5=D1=82=D1=81=D1=8F=
, =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=BD=D0=B5=D0=BE=D0=
=B1=D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BA=D0=
=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D1=8B.
=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C =D0=BF=D0=BE=
=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BA=D1=83 =D0=BA "
 "=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E?"

"=D0=9A=D0=B0=D0=B6=D0=B5=D1=82=D1=81=D1=8F" - =D0=B2=D0=B2=D0=BE=D0=B4=
=D0=BD=D0=BE=D0=B5 =D1=81=D0=BB=D0=BE=D0=B2=D0=BE, =D0=BE=D0=B1=D0=BE=D1=
=81=D0=BE=D0=B1=D0=BB=D1=8F=D0=B5=D1=82=D1=81=D1=8F =D0=B7=D0=B0=D0=BF=D1=
=8F=D1=82=D1=8B=D0=BC=D0=B8
Translation to English:
"=D0=9A=D0=B0=D0=B6=D0=B5=D1=82=D1=81=D1=8F" - is parenthesis so must b=
e isolated with commas
