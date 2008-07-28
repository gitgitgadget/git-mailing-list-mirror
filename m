From: Eric Raible <raible@gmail.com>
Subject: Re: gitk crashing on Windows.
Date: Mon, 28 Jul 2008 16:29:38 +0000 (UTC)
Message-ID: <loom.20080728T162025-946@post.gmane.org>
References: <g6kmqf$q9p$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 18:31:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNVd1-0005dU-9c
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 18:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278AbYG1Q3w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2008 12:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754616AbYG1Q3w
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 12:29:52 -0400
Received: from main.gmane.org ([80.91.229.2]:45367 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454AbYG1Q3v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 12:29:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KNVbW-0003Yr-6t
	for git@vger.kernel.org; Mon, 28 Jul 2008 16:29:46 +0000
Received: from 12.96.234.114 ([12.96.234.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 16:29:46 +0000
Received: from raible by 12.96.234.114 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 16:29:46 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.96.234.114 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9) Gecko/2008052906 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90473>

Jurko Gospodneti=C4=87 <jurko.gospodnetic <at> docte.hr> writes:

>=20
>    Hi.
>=20
>    When you run gitk from a git repository on Windows it starts up an=
d=20
> starts updating its 'Row X/Y' output labels. This lasts for a few=20
> seconds but if you terminate the application before this updating is=20
> complete you get a Windows message stating:
>=20
>    'Wish Application has encountered a problem and needs to close. We=
=20
> are sorry for the inconvenience.'
>=20
>    and the standard 'Send Error Report'/'Don't Send' buttons.
>=20
>    Hope this helps.
>=20
>    Best regards,
>      Jurko Gospodneti=C4=87

Though I can't find the relevant commit at the moment
I believe that this is one already fixed in the latest
from git://repo.or.cz/git/mingw/4msysgit.git.

- Eric
