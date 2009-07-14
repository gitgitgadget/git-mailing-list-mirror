From: Theodore Tso <tytso@mit.edu>
Subject: Re: Truly decentralised use of git?
Date: Tue, 14 Jul 2009 10:21:40 -0400
Message-ID: <20090714142140.GA6772@mit.edu>
References: <200907140811.24174.Karlis.Repsons@gmail.com> <adf1fd3d0907140222t6762d4f7s417f56905492cbba@mail.gmail.com> <200907141323.02151.Karlis.Repsons@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	git@vger.kernel.org
To: =?utf-8?Q?K=C4=81rlis?= Repsons <karlis.repsons@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 16:22:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQiuA-0000Oc-M7
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 16:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776AbZGNOVy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2009 10:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754674AbZGNOVx
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 10:21:53 -0400
Received: from thunk.org ([69.25.196.29]:56750 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754498AbZGNOVv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 10:21:51 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1MQit5-0004xN-DM; Tue, 14 Jul 2009 10:21:44 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1MQit2-0002W7-Nu; Tue, 14 Jul 2009 10:21:40 -0400
Content-Disposition: inline
In-Reply-To: <200907141323.02151.Karlis.Repsons@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123249>

On Tue, Jul 14, 2009 at 01:22:58PM +0000, K=C4=81rlis Repsons wrote:
>=20
> I am sorry, another thing was of my interest.
> My unknown is the technical realisation - how can particular reposito=
ry be=20
> made available for easy pulling from it? Right now with IPv4 most nor=
mal=20
> workstations are not accessible directly, because they are behind rou=
ters.
> That situation should be better with IPv6, but I haven't tried to use=
 it.
> I hope, question is now clarified.

The easist thing to do is to set up and then push your repository to a
public git hosting site, such as repo.or.cz, gitorious.org, or
github.com.  Repositories are lightweight enough that all of these
offer free repository hosting services.

							- Ted
