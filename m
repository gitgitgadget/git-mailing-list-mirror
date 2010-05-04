From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Shell aliases & paths
Date: Tue, 4 May 2010 19:20:47 -0400
Message-ID: <19424.43983.410231.385807@winooski.ccs.neu.edu>
References: <19424.34226.564684.613674@winooski.ccs.neu.edu>
	<20100504211122.GA15091@progeny.tock>
	<19424.36914.867693.327548@winooski.ccs.neu.edu>
	<20100504223028.GA15548@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 01:20:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9RQ8-0000Gs-Iz
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 01:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934597Ab0EDXUu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 19:20:50 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:41348 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933684Ab0EDXUt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 19:20:49 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O9RPz-0002eB-Dc; Tue, 04 May 2010 19:20:47 -0400
In-Reply-To: <20100504223028.GA15548@progeny.tock>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146358>

On May  4, Jonathan Nieder wrote:
> Eli Barzilay wrote:
> > On May  4, Jonathan Nieder wrote:
>=20
> >> Maybe a new GIT_PATHNAME_PREFIX environment variable would help.
> >
> > Yeah, I was searching the environment for something like that, and
> > was surprised when I didn't find any shred of the original path in
> > there.  (In any case, I'd like to see something like that,
> > although it's too late for me to use it since I need a solution
> > that works now...)
>=20
> Care to write a patch?  But yeah, sounds like for now you=E2=80=99re
> screwed. :(

Right, I already need to move to a script instead, so less motivation.
(And a ssubversion->git move certainly filled my quota of doing
non-work things...)

--=20
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay=
:
                    http://barzilay.org/                   Maze is Life=
!
