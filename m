From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT] How to deal with important modifications
Date: Sun, 29 Mar 2009 10:45:05 +0100
Message-ID: <200903291145.06135.robin.rosenberg.lists@dewire.com>
References: <1238261528.6971.10.camel@localhost> <49CEA861.4070700@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Sun Mar 29 11:46:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnrbI-0003wx-Rb
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 11:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbZC2JpL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Mar 2009 05:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbZC2JpL
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 05:45:11 -0400
Received: from mail.dewire.com ([83.140.172.130]:11240 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376AbZC2JpK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Mar 2009 05:45:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B30C1148897E;
	Sun, 29 Mar 2009 11:45:07 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ud24JxSYEozi; Sun, 29 Mar 2009 11:45:06 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id D1DE0800784;
	Sun, 29 Mar 2009 11:45:06 +0200 (CEST)
User-Agent: KMail/1.11.1 (Linux/2.6.27-14-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <49CEA861.4070700@pelagic.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115003>

l=F6rdag 28 mars 2009 23:44:49 skrev "Ferry Huberts (Pelagic)" <ferry.h=
uberts@pelagic.nl>:
> Yann Simon wrote:
> > Hi,
> >=20
> > I am working on the synchronization view. It is not 100% functional=
 yet.
> > The view is not updated when a local file is modified for example.
> > As the modifications are getting important, I was wondering how to =
deal
> > with it. Should I continue my work an send all the patches when
> > finished?
> >=20
> > To have an overview of the modifications:
> > http://github.com/yanns/egit/commit/18c4a928d53345802a8c9641dcb2d45=
7ebbe2cbc
> > http://github.com/yanns/egit/commit/9fab398fa1b7b6efa9532b3c09e5bcf=
cc8bb9419
> >=20
> > Or should I begin to send patches, but by not activating the functi=
on
> > yet?
> > (It could be a way to have other people to help contributing.)
> >=20
> > Yann
> Yann,
>=20
> I was asking myself the same questions about my work on ignores and
> chose to send it out early, being half completed. Don't know if that =
was
> right, did not receive feedback yet, but it's only been 2 days with
> Eclipsecon wrapping up on friday.

That's not the reason you haven't received a response. Basically, the l=
arger
a set of patches is, more time is needed.

> If you keep a seperate changeset in which you activate your work and
> split up the changesets in manageable pieces it's easier for others t=
o
> review your work and comment on it.

Indeed. Small patches can be reviewed more quickly if they introduce we=
ll
defined changes and especially good is if they make sense of their own.

Think about how you would like the changes presented if you were to rev=
iew
them without knowing anything in advance.

-- robin
