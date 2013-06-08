From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git exile Issues
Date: Sat, 8 Jun 2013 07:32:40 +0000 (UTC)
Message-ID: <loom.20130608T092931-803@post.gmane.org>
References: <CAFabFLZTW9nXj_5Y-Sq_vJQiygydez=_oC-2+4QHUrALtp9KeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 08 09:33:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlDe2-0007OH-OQ
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 09:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382Ab3FHHc6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 03:32:58 -0400
Received: from plane.gmane.org ([80.91.229.3]:49175 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282Ab3FHHc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 03:32:58 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UlDdw-0007Ij-2Q
	for git@vger.kernel.org; Sat, 08 Jun 2013 09:32:56 +0200
Received: from egq218.neoplus.adsl.tpnet.pl ([83.21.80.218])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 09:32:56 +0200
Received: from jnareb by egq218.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 09:32:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.21.80.218 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.22 (KHTML, like Gecko) Ubuntu Chromium/25.0.1364.160 Chrome/25.0.1364.160 Safari/537.22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226787>

Sudhir Kumar <smalikphy <at> gmail.com> writes:

>=20
> Hey Git Experts,
>=20
> I need your advice. I have lot of png/jpg images in my codebase (whic=
h
> is currently under git) which causes the repo size to be very heavy.
> We have migrated these images to a storage server using git exile
> technique. This has been working fine so far (with some glitches) on
> unix platform. However to make it work on windows has been a big pain=
=2E
> I got it work to some extent that I can pull stuff from storage and
> replace the references here but its not complete. Also it made the
> other commands like git status to be very slow. Does anybody have don=
e
> this before? If so can you please share your experience on it?

Hmmm... I wonder if alternatives to git-exile, i.e. git-annex and
git-media (perhaps also other tools; the list on Git Wiki is woefully
incomplete and not up to date) would perform better...

--=20
Jakub Nar=C4=99bski
