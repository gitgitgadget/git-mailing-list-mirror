From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: Re: Newbie: Do I need to download the entire repo to work on just
	1 file?
Date: Mon, 23 Mar 2009 00:10:02 +0100
Message-ID: <20090322231002.GA12974@vidovic>
References: <BLU121-W15DB0E5CEBC1DA697E5ED8B4950@phx.gbl> <fabb9a1e0903221600j22cf028fl903aef8076e53777@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 00:11:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlWpS-0004Dg-Tp
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 00:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbZCVXKO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 19:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531AbZCVXKN
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 19:10:13 -0400
Received: from out2.laposte.net ([193.251.214.119]:8122 "EHLO out1.laposte.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752976AbZCVXKM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 19:10:12 -0400
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8203.laposte.net (SMTP Server) with ESMTP id 5350DE000090;
	Mon, 23 Mar 2009 00:10:03 +0100 (CET)
Received: from ? (91-165-135-230.rev.libertysurf.net [91.165.135.230])
	by mwinf8203.laposte.net (SMTP Server) with ESMTP id F016BE00008D;
	Mon, 23 Mar 2009 00:10:02 +0100 (CET)
X-ME-UUID: 20090322231002983.F016BE00008D@mwinf8203.laposte.net
Content-Disposition: inline
In-Reply-To: <fabb9a1e0903221600j22cf028fl903aef8076e53777@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-me-spamlevel: not-spam
X-me-spamrating: 40.000000
X-me-spamcause: OK, (-200)(0000)gggruggvucftvghtrhhoucdtuddrvdekuddrfeduucetggdotefuucfrrhhofhhilhgvmecuoehnohhnvgeqnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114197>


On Mon, Mar 23, 2009 at 12:00:59AM +0100, Sverre Rabbelier wrote:
>=20
> Heya,
>=20
> On Sun, Mar 22, 2009 at 23:08, Anthony Rasmussen <evoluenta@hotmail.c=
om> wrote:
> > Do I have to download the entire rep onto my laptop in order to do =
this? =A0I have read and read, but I am quite confused :)

Please, wrap your lines to something convenient (72-80 characters max).

> Yes, you do

No, you don't. Why not use the '--depth <depth>' option of 'git clone' =
?

--=20
Nicolas Sebrecht
