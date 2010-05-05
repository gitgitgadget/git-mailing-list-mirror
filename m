From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Re-submitting patches
Date: Wed, 5 May 2010 17:28:01 -0400
Message-ID: <19425.58081.592591.319107@winooski.ccs.neu.edu>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain>
	<20100505005153.GC25390@coredump.intra.peff.net>
	<4BE115EF.8010306@viscovery.net>
	<20100505070131.GA11265@coredump.intra.peff.net>
	<19425.9169.537598.876589@winooski.ccs.neu.edu>
	<7v1vdql4c9.fsf@alter.siamese.dyndns.org>
	<19425.54504.163875.379151@winooski.ccs.neu.edu>
	<loom.20100505T225117-534@post.gmane.org>
	<19425.56291.689142.569365@winooski.ccs.neu.edu>
	<19425.56411.745112.753594@winooski.ccs.neu.edu>
	<20100505212437.GA26487@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 23:28:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9m8Z-0000uH-Qw
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 23:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758599Ab0EEV2F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 May 2010 17:28:05 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:50783 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758593Ab0EEV2D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 May 2010 17:28:03 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O9m8P-00084k-JZ; Wed, 05 May 2010 17:28:01 -0400
In-Reply-To: <20100505212437.GA26487@progeny.tock>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146422>

On May  5, Jonathan Nieder wrote:
> Hi Eli,
>=20
> Eli Barzilay wrote:
> > On May  5, Eli Barzilay wrote:
>=20
> >> (*sigh*)  That's correct, I fixed this, but improperly remade the
> >> patch.
> >
> > Is there some convention for sending a fixed patch?
>=20
> With a small patch like this one, you can just send the fixed patch
> as a reply to the thread.  Putting =E2=80=9C[PATCH v2]=E2=80=9D in th=
e subject would
> make it clear that this is the newer and better version.

Ah -- it's the "v2" that I missed, thanks.


> With larger patches, doing that too often can overload people.
> My preferred solution: describe the changes as soon as you want, but
> then take some time to polish them before resubmitting.  This gives
> people time to breathe. ;-)

Yes, I'd be much more careful if this was not a quick thing.  (BTW, it
would be nice if there is a way to get various publishing commands
like `format-patch' and `pull' to spit out some warning if there are
uncommitted changes -- that would have prevented me from sending the
bogus one.)

--=20
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay=
:
                    http://barzilay.org/                   Maze is Life=
!
