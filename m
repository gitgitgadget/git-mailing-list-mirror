From: Jeff King <peff@peff.net>
Subject: Re: Google Summer of Code 2012... and git wiki
Date: Thu, 1 Mar 2012 19:56:39 -0500
Message-ID: <20120302005638.GC21835@sigill.intra.peff.net>
References: <201203020027.41016.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 01:56:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Gni-00028K-P7
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 01:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757768Ab2CBA4n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 19:56:43 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34749
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156Ab2CBA4l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 19:56:41 -0500
Received: (qmail 11605 invoked by uid 107); 2 Mar 2012 00:56:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Mar 2012 19:56:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Mar 2012 19:56:39 -0500
Content-Disposition: inline
In-Reply-To: <201203020027.41016.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191991>

On Fri, Mar 02, 2012 at 12:27:40AM +0100, Jakub Narebski wrote:

> Google Summer of Code 2012 has started. =C2=A0The Git Development Com=
munity=20
> has time till March 9 to submit organization application.
>=20
> The problem (beside finding volunteer for the position of GSoC=20
> administrator) is that both GSoC application and ideas for GSoC=20
> projects were hosted on Git Wiki... but Git Wiki is still only parial=
ly=20
> functional, available only as static pages under changed URLs.

I can be GSoC administrator again if nobody else wants to do it (and
probably Shawn as co-admin again). On my todo list for tonight is
actually starting and posting a draft application.

I'm perfectly happy if somebody else wants to take over the position.
It's mostly boring, and aside from coordinating the proposal ranking
process, not even all that much work (the real work is done by the
mentors).

> I guess we can get by without having fully functional wiki for creati=
ng=20
> application (if we decide to apply), but it would need a forum to sen=
d=20
> ideas for GSoC projects and some place to publish them.  Editable wik=
i=20
> can work as both, though git mailing list and some static page (perha=
ps=20
> home pages for git project on GitHub?) could also work.

My plan was to just solicit feedback from the mailing list. Though I
think I may throw the work into a repo or even a GitHub wiki to make
small edits simpler for people who want to contribute. If last year is
any indication, about 3-4 people will come up with comments. So just
taking patches or incorporating their suggestions manually would
probably be acceptable.

> I don't know what are ETA on bringing Git Wiki fully up, but I doubt =
it=20
> would be possible at http://git.wiki.kernel.org -- it is more than tw=
o=20
> months since the event and wiki is not functional yet.  Perhaps it=20
> could be hosted at git-scm.com somewhere -  but it really should be=20
> true wiki, editable without need to use git.

=46WIW, I really like the GitHub wikis, because they are backed by git.=
 So
you can choose whether to use the web interface or not. And you can
write in a variety of markup languages, including mediawiki, though whe=
n
I tried importing the old git wiki many moons ago, I noticed that the
formatting of many of the pages was not quite right.

-Peff
