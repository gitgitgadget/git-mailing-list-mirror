From: Brock Peabody <brock.peabody@gmail.com>
Subject: Re: help with distributed workflow/signoff
Date: Wed, 14 Jul 2010 21:46:46 +0000 (UTC)
Message-ID: <loom.20100714T232116-579@post.gmane.org>
References: <loom.20100714T180615-173@post.gmane.org> <AANLkTimdVvKYPQn84IQvk7yxMo-gtrjWWqzN-ypXV78X@mail.gmail.com> <loom.20100714T195109-665@post.gmane.org> <AANLkTilo4TnMQcr7p1dfAeQ4tESHjO4Nbr8274hqxOnD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 14 23:47:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ9nI-0003Co-6S
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 23:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757260Ab0GNVrB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 17:47:01 -0400
Received: from lo.gmane.org ([80.91.229.12]:34808 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756985Ab0GNVrA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 17:47:00 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OZ9n6-00036l-O9
	for git@vger.kernel.org; Wed, 14 Jul 2010 23:46:57 +0200
Received: from proxy-nj1.bloomberg.com ([69.191.241.47])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 23:46:56 +0200
Received: from brock.peabody by proxy-nj1.bloomberg.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 23:46:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 69.191.241.47 (Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.6) Gecko/20100625 Firefox/3.6.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151038>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab <at> gmail.com> writes:

> Well, consider that even if you push most patches through, the peer
> review you get from having a setup similar to Git's own might very
> well be worth it. Everyone makes mistakes, having a second set of
> eyeballs to look at your code eliminates a lot of that.
>=20
> That may not be acceptable to your corporate culture, but consider
> that most big corporations (e.g. Google) do detailed code review
> before anything gets commited to the master repository.

Yes, that's a good point.  We are trying to improve our code review pro=
cesses,
and I think switching to git is going to help with that down the road. =
 I don't
want to make the switch to git and a heavier (if better) process at the=
 same
time, however, as it would decrease the chance of either being accepted=
=2E
