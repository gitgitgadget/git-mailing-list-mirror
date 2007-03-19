From: "Raimund Bauer" <ray@softwarelandschaft.com>
Subject: RE: [wishlist] graphical diff
Date: Mon, 19 Mar 2007 09:14:58 +0100
Organization: Softwarelandschaft
Message-ID: <001001c769fe$af8f4400$0b0aa8c0@abf.local>
References: <Pine.LNX.4.63.0703182342110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "'git'" <git@vger.kernel.org>
To: "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
	"'Robin Rosenberg'" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 09:15:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTD1Q-0003cu-Tg
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 09:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbXCSIPF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 19 Mar 2007 04:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbXCSIPF
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 04:15:05 -0400
Received: from s15211414.onlinehome-server.info ([87.106.16.196]:53735 "EHLO
	s15211414.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751904AbXCSIPC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 04:15:02 -0400
Received: (qmail 25165 invoked from network); 19 Mar 2007 09:20:21 +0100
Received: from host-62-245-155-90.customer.m-online.net (HELO swl011) (62.245.155.90)
  by s15211414.onlinehome-server.info with SMTP; 19 Mar 2007 09:20:21 +0100
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <Pine.LNX.4.63.0703182342110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42598>

On Monday, March 19, Johannes Schindelin wrote:
> > s=F6ndag 18 mars 2007 14:16 skrev Raimund Bauer:
> > > I think it would be really helpful (especially for=20
> newbies like me)=20
> > > to have an option like
> > >=20
> > > git diff --gui [revisions] <singe path spec>
>=20
> And how do you set _what_ gui you want? Everybody has her pet=20
> diff-viewer=20
> (mine is less, BTW).

Maybe with a git.gui config option (like merge.tool)?
Or by specifying on the commandline:

git diff --gui=3D<my-gui-differ> ...

And <my-gui-differ> =3D xxdiff | kompare | tkdiff | ...

--=20
best regards

  Ray
