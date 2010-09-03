From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC maint-1.7.1 0/4] instaweb 1.7.1 fixes for Debian
	squeeze
Date: Thu, 2 Sep 2010 18:09:26 -0700
Message-ID: <20100903010926.GA16089@dcvr.yhbt.net>
References: <20100812131152.2333.9604.reportbug@octopus.hi.pengutronix.de> <20100902221211.GA4789@burratino> <20100902223624.GA9613@dcvr.yhbt.net> <20100902235237.GA6466@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 03:09:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrKmu-0001oK-Nw
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 03:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817Ab0ICBJ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 21:09:28 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33748 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752773Ab0ICBJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 21:09:27 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id B917C1F541;
	Fri,  3 Sep 2010 01:09:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100902235237.GA6466@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155231>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Eric Wong wrote:
> >> Uwe Kleine-K=F6nig wrote:
> >>> when I start git instaweb on a git repository, I get a crippled v=
iew
> >>> (no style sheets, no images) that doesn't include the current pro=
ject.
> [...]
> > The stylesheet is important and should be fixed.  I don't care abou=
t the
> > logo and favicon (warning: I've never been a fan of logos/icons,
> > needless noise IMHO), but if you're willing to help maintain it the=
n
> > it's fine by me.
>=20
> Thanks, Eric; that makes sense.  How about this?

Untested, but everything looks reasonable to me, thanks!

--=20
Eric Wong
