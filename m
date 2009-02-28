From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] gitk: make use of themed widgets where available
Date: Sat, 28 Feb 2009 00:59:55 +0000 (UTC)
Message-ID: <loom.20090228T005845-825@post.gmane.org>
References: <87ljrre7nr.fsf@users.sourceforge.net> <fabb9a1e0902271647n36152700p101a92d793dabb41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 02:11:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdDjy-0006Ei-Bg
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 02:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbZB1BKJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 20:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbZB1BKI
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 20:10:08 -0500
Received: from main.gmane.org ([80.91.229.2]:40247 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbZB1BKH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 20:10:07 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LdDiM-0004pR-Fq
	for git@vger.kernel.org; Sat, 28 Feb 2009 01:10:02 +0000
Received: from 92-238-221-8.cable.ubr21.aztw.blueyonder.co.uk ([92.238.221.8])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 01:10:02 +0000
Received: from patthoyts by 92-238-221-8.cable.ubr21.aztw.blueyonder.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 01:10:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 92.238.221.8 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-GB; rv:1.9.0.1) Gecko/2008070208 Firefox/3.0.1 (.NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111731>

Sverre Rabbelier <srabbelier <at> gmail.com> writes:

>=20
> Heya,
>=20
> On Sat, Feb 28, 2009 at 01:18, Pat Thoyts
> <patthoyts <at> users.sourceforge.net> wrote:
> > =C2=A0 =C2=A0This patch improves the appearence of gitk on Windows =
XP and Vista
> > =C2=A0 =C2=A0by making use of the themed widgets that are provided =
in Tk 8.5
> > =C2=A0 =C2=A0and above. For good Vista support 8.6 will be needed.
>=20
> Screenies with before/after? :D
>=20

After (on Vista) http://www.patthoyts.tk/screenshots/gitk-vista.png

Pat Thoyts
