From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] builtin-blame: Reencode commit messages according to git-log rules.
Date: Wed, 22 Oct 2008 22:12:54 +0200
Organization: At home
Message-ID: <gdo1a3$akl$1@ger.gmane.org>
References: <1224622557-6669-1-git-send-email-angavrilov@gmail.com> <20081022082016.GA18473@sigill.intra.peff.net> <7vd4hsv46z.fsf@gitster.siamese.dyndns.org> <20081022191415.GA31568@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 22:11:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksk2s-0006Fe-Sh
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 22:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbYJVUJy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Oct 2008 16:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754148AbYJVUJy
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 16:09:54 -0400
Received: from main.gmane.org ([80.91.229.2]:46816 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245AbYJVUJx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 16:09:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ksk1c-0005rr-5x
	for git@vger.kernel.org; Wed, 22 Oct 2008 20:09:48 +0000
Received: from abxd135.neoplus.adsl.tpnet.pl ([83.8.253.135])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 20:09:48 +0000
Received: from jnareb by abxd135.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 20:09:48 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abxd135.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98896>

Jeff King wrote:

>> Do people build with NO_EXTERNAL_GREP on older Solaris?
>=20
> Yep. See:
>=20
> =A0 http://repo.or.cz/w/git/gitbuild.git?a=3Dblob;f=3Djk/solaris/conf=
ig.mak;hb=3Dplatform
>=20
> for the gory details (boy, I wish we had nice PATH_INFO-based gitweb
> URLs...).

Currently you can use path_info URL for blob_plain

  http://repo.or.cz/w/git/gitbuild.git/platform:/jk/solaris/config.mak

Soon (thanks to Giuseppe patches) you would be able to use

  http://repo.or.cz/w/git/gitbuild.git/blob/platform:/jk/solaris/config=
=2Emak

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
