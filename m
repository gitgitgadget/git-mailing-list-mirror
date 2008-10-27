From: html-kurs@gmx.de
Subject: Can't merge
Date: Mon, 27 Oct 2008 17:52:47 +0100
Message-ID: <20081027165247.141110@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 17:57:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuVLz-0006po-6T
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 17:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbYJ0Qwu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2008 12:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbYJ0Qwu
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 12:52:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:34293 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751650AbYJ0Qwt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 12:52:49 -0400
Received: (qmail 13464 invoked by uid 0); 27 Oct 2008 16:52:47 -0000
Received: from 213.83.3.2 by www070.gmx.net with HTTP;
 Mon, 27 Oct 2008 17:52:48 +0100 (CET)
X-Authenticated: #4107867
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX184NKonP6s4wECI1QVEX9oG/Rdnc/Qd7/BDJC221Z
 2Y4YFMaeSGee0pW+TDXbxTW4J5+zxwFo1iVw== 
X-GMX-UID: u5hgCHFDfW47R2H0SWVob0ZudmllcgWb
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99244>

Hi,

I've run in trouble when trying to merge a branch:
I've got a branch "foo".
I checkout master.
> git diff foo=20
shows many diffs.
But=20
> git merge foo
says:
Already up-to-date.

I'm using version 1.6.0.2

Any idea what I'm doing wrong?

TIA,
Martin

--=20
Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt? Der kann`s mit all=
en: http://www.gmx.net/de/go/multimessenger
