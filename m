From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: [RFC PATCH] Rename "bury" back to "sink".
Date: Sat, 5 May 2007 13:35:47 -0400
Message-ID: <20070505173547.GA3540@pe.Belkin>
References: <20070504224639.26133.6157.stgit@gandelf.nowhere.earth> <20070505131352.GB3379@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@altern.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat May 05 19:35:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkOAi-0005PG-Gf
	for gcvg-git@gmane.org; Sat, 05 May 2007 19:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934073AbXEERft convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 5 May 2007 13:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934105AbXEERft
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 13:35:49 -0400
Received: from eastrmmtao101.cox.net ([68.230.240.7]:35572 "EHLO
	eastrmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934073AbXEERfs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 13:35:48 -0400
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070505173549.SGST19390.eastrmmtao101.cox.net@eastrmimpo01.cox.net>;
          Sat, 5 May 2007 13:35:49 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo01.cox.net with bizsmtp
	id vVbn1W00E0epFYL0000000; Sat, 05 May 2007 13:35:47 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1HkOAd-00018o-Mr; Sat, 05 May 2007 13:35:47 -0400
Content-Disposition: inline
In-Reply-To: <20070505131352.GB3379@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46270>

On Sat, May 05, 2007 at 03:13:53PM +0200, Karl Hasselstr=F6m wrote:
> On 2007-05-05 00:53:03 +0200, Yann Dirson wrote:
>=20
> > Well, it looks like the voices we heard on this naming issue were
> > quite equally cast towards each of the 2 name.
> >
> > Let my vote be to get back to "sink", so the user can easily pair
> > the command with "float". I expect that any previously-silent
> > majoity prefering "bury" will talk now, before Catalin decides if h=
e
> > wants this patch in the next release :)
>=20
> Well, my vote is still for "sink"! If it is to be called "stg bury",
> I'd have to vote for changing "stg float" to "stg unearth". :-)

Just my 2.5 cents:

float/sink are clearly related, while I wouldn't associate float/bury
at all.  Also, "bury" is sometimes euphemistic for "kill", so
bury/resurrect is a clear pair.  Anyway, "sink" makes perfect sense to
me.

-chris
