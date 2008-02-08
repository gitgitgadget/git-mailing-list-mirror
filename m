From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 08 Feb 2008 22:35:03 +0100
Organization: At home
Message-ID: <foihu9$110$1@ger.gmane.org>
References: <200802081828.43849.kendy@suse.cz> <alpine.LSU.1.00.0802081905580.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 22:36:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNatH-0000j4-35
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 22:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbYBHVfV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Feb 2008 16:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbYBHVfV
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 16:35:21 -0500
Received: from main.gmane.org ([80.91.229.2]:40583 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563AbYBHVfT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 16:35:19 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JNasK-0007lo-R4
	for git@vger.kernel.org; Fri, 08 Feb 2008 21:35:12 +0000
Received: from abws186.neoplus.adsl.tpnet.pl ([83.8.242.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 21:35:12 +0000
Received: from jnareb by abws186.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 21:35:12 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abws186.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73153>

Johannes Schindelin wrote:
> On Fri, 8 Feb 2008, Jan Holesovsky wrote:

>> +=A0=A0=A0=A0=A0struct stat st;
>> +=A0=A0=A0=A0=A0const char remote_alt_file_name[] =3D "info/remote_a=
lternates";
>=20
> <bikeshedding>maybe remote-alternates (note the dash instead=20
> of the underscore)</bikeshedding>

Why not in info/alternates?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
