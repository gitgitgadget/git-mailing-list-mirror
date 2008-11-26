From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Extra pair of double quotes in "git commit" output?
Date: Wed, 26 Nov 2008 16:07:13 +0100
Organization: At home
Message-ID: <ggjolt$t7t$1@ger.gmane.org>
References: <20081126064906.6117@nanako3.lavabit.com> <20081125232521.GC30942@coredump.intra.peff.net> <adf1fd3d0811251606t7f49eb84y53075427859bd26a@mail.gmail.com> <20081126133422.GA1761@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 16:08:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5Lzn-0003Fc-GU
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 16:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbYKZPGr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Nov 2008 10:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbYKZPGr
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 10:06:47 -0500
Received: from main.gmane.org ([80.91.229.2]:36987 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068AbYKZPGq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 10:06:46 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L5LyW-0002SV-Sw
	for git@vger.kernel.org; Wed, 26 Nov 2008 15:06:44 +0000
Received: from abwq245.neoplus.adsl.tpnet.pl ([83.8.240.245])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 15:06:44 +0000
Received: from jnareb by abwq245.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 15:06:44 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwq245.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101739>

Jeff King wrote:
> On Wed, Nov 26, 2008 at 01:06:34AM +0100, Santi B=E9jar wrote:
>=20
>> Maybe just use the output of "git branch -v":
>>=20
>> master d9a5491 foo: bar
>>=20
>> or even literally:
>>=20
>> * master d9a5491 [ahead 1] foo: bar
>>=20
>> or to make the separation more evident:
>>=20
>> [master d9a5491] foo: bar
>=20
> Out of those suggestions, I find only the final one aesthetically
> acceptable. Nobody else has weighed in, so maybe they don't care. Or
> maybe they are just on vacation due to the (American) holiday.

+1 for the last one.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
