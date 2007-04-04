From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] wt-status: show author info if status.showauthor is set
Date: Wed, 04 Apr 2007 15:28:38 +0200
Organization: At home
Message-ID: <ev08vq$fib$2@sea.gmane.org>
References: <20070322104021.GJ29341@mellanox.co.il> <7v7it7kkl9.fsf@assigned-by-dhcp.cox.net> <20070404060213.GB31984@mellanox.co.il> <20070404062447.GA4136@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 15:30:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ5Z0-0008Vp-Aa
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 15:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785AbXDDNaK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 4 Apr 2007 09:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753803AbXDDNaK
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 09:30:10 -0400
Received: from main.gmane.org ([80.91.229.2]:60984 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753801AbXDDNaH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 09:30:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HZ5Yo-0002Fz-Pl
	for git@vger.kernel.org; Wed, 04 Apr 2007 15:30:02 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 15:30:02 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 15:30:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43737>

Jeff King wrote:

> On Wed, Apr 04, 2007 at 09:02:13AM +0300, Michael S. Tsirkin wrote:
>=20
>> - Maybe put Author: (or From:? and maybe Subject:?) line in the pre-=
formatted
>> =A0 commit message, and let the user edit them?
>=20
> Personally I think it's just clutter, but hey, it's off by default. O=
f
> course what is the chance that you've turned on status.showauthor in
> your ~/.gitconfig, but you don't have your identity set up properly? =
:)

It can be turned on in /etc/gitconfig (and of course user.name cannot).
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
