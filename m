From: Petr Baudis <pasky@suse.cz>
Subject: Re: topgit patches
Date: Thu, 26 Feb 2009 00:22:37 +0100
Message-ID: <20090225232237.GO12275@machine.or.cz>
References: <20090225195856.GA12372@pengutronix.de> <20090225212309.GM12275@machine.or.cz> <20090225231550.GA19741@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "martin f. krafft" <madduck@debian.org>
To: Uwe =?iso-8859-2?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Feb 26 00:24:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcT6n-0006h9-LR
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 00:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756532AbZBYXWn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 18:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755480AbZBYXWm
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 18:22:42 -0500
Received: from w241.dkm.cz ([62.24.88.241]:37850 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753667AbZBYXWm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 18:22:42 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 7E99524C067; Thu, 26 Feb 2009 00:22:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090225231550.GA19741@pengutronix.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111511>

  Hi,

On Thu, Feb 26, 2009 at 12:15:50AM +0100, Uwe Kleine-K=F6nig wrote:
> On Wed, Feb 25, 2009 at 10:23:09PM +0100, Petr Baudis wrote:
> >   I'm unfortunately not actively using topgit right now and I have =
no
> > time to maintain it or review patches. :-( Martin seems to be in si=
milar
> > situation. So, would you like push access to the main repository? ;=
-)
> Well, I already wondered if there is someone using topgit apart from =
me.
> :-)

  hehe, i think there are still quite a few people, though the initial
surge of interest fell a bit, understandably.

> If you give me push access I'd only push the first three patches to
> master and maybe create a pu branch for the linearize method.

  I wouldn't be so conservative, IMHO it's better to liberally test new
features rather than let them bitrot, in such a small project, but of
course it's up to you.

  What's your repo.or.cz username?

--=20
				Petr "Pasky" Baudis
The average, healthy, well-adjusted adult gets up at seven-thirty
in the morning feeling just terrible. -- Jean Kerr
