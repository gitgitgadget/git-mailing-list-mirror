From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Git Bug report
Date: Thu, 6 Oct 2011 03:09:40 +0200
Message-ID: <20111006010940.GR2208@goldbirke>
References: <1317763443.17036.15.camel@skyplex> <20111005072235.GA12600@kolya>
	<7vlisz8jur.fsf@alter.siamese.dyndns.org>
	<20111006003318.GA9015@goldbirke>
	<7vobxv3q49.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Federico Lucifredi <federico@canonical.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 03:14:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBcXJ-0001zf-Rk
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 03:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935623Ab1JFBJn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 21:09:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:51920 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935061Ab1JFBJn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 21:09:43 -0400
Received: from localhost6.localdomain6 (p5B131283.dip0.t-ipconnect.de [91.19.18.131])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0MWBZZ-1ReMX70kRt-00X1WP; Thu, 06 Oct 2011 03:09:40 +0200
Content-Disposition: inline
In-Reply-To: <7vobxv3q49.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:7PRO2RNbuUhXBAmBBZVjlKw3lrEr5NQrlb8W6TzZ2oA
 wQARzDDOLaTHYPsgvRHE1t6bIozNsfQ50hNEbrnau4we5lGZS+
 7hvA5/J8i6t9vBQuRq+S5cFJvOyydUD09kDTYu7EzYMnjbMdq1
 c++EQJ0BcikRDponG3igdrfjfEhbP5hVAn2VJx3NwH1TCOu8KU
 FSu1lRV56S07SlahFHwi0CTfHaoeV02qTmtZ1ZMwn3ieFOTbLr
 UBbjOh1oCahbYs79I07uepBio3XuQw9u+FPIdEhr8NtoffHhNd
 CN+MaGFYjr0AyfSoUzW4GJnSEZfO05IMizhPzsUDDPX9W8u2wo
 bOZJBcqhBqqJzfEPMZx4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182913>

On Wed, Oct 05, 2011 at 05:44:54PM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > And what about unreadable .git files?
>=20
> Having then inside a working tree is so sick that I do not think it
> deserves consideration.

I'm not sure why is this any different than having a .git directory
that is not a repository inside a working tree.

> Please don't troll immediately after a big release.

I didn't mean to troll; it just happened that I came across this issue
this weekend while trying to optimize the bash completion code...
