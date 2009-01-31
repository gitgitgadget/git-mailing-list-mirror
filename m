From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: Re: understanding index
Date: Sat, 31 Jan 2009 23:07:12 +0100
Message-ID: <20090131220712.GE29748@ultras>
References: <20090131111011.GA29748@ultras> <20090131124022.GB29748@ultras> <adf1fd3d0901310409y28dc493ak358749e0c29154cc@mail.gmail.com> <20090131201920.GC29748@ultras> <adf1fd3d0901311257j1501d222nc24514b013bd13f3@mail.gmail.com> <20090131210939.GD29748@ultras>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 31 23:14:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTO6V-0007c1-Cy
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 23:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbZAaWMw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jan 2009 17:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752324AbZAaWMw
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 17:12:52 -0500
Received: from out2.laposte.net ([193.251.214.119]:19806 "EHLO
	out1.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752124AbZAaWMw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 17:12:52 -0500
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8206.laposte.net (SMTP Server) with ESMTP id 4D0907000087
	for <git@vger.kernel.org>; Sat, 31 Jan 2009 23:12:49 +0100 (CET)
Received: from ? (91-164-156-12.rev.libertysurf.net [91.164.156.12])
	by mwinf8206.laposte.net (SMTP Server) with ESMTP id 13BB17000084
	for <git@vger.kernel.org>; Sat, 31 Jan 2009 23:12:48 +0100 (CET)
X-ME-UUID: 20090131221249809.13BB17000084@mwinf8206.laposte.net
Content-Disposition: inline
In-Reply-To: <adf1fd3d0901311257j1501d222nc24514b013bd13f3@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-me-spamlevel: not-spam
X-me-spamrating: 40.000000
X-me-spamcause: OK, (-100)(0000)gggruggvucftvghtrhhoucdtuddrvdektddrjeehucetggdotefuucfrrhhofhhilhgvmecuoehnohhnvgeqnecuuegrihhlohhuthemuceftddtnecuucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107952>


On Sat, Jan 31, 2009 at 09:57:29PM +0100, Santi B=E9jar wrote:

> By default git reset only acts on the head of the branch and the inde=
x, so with:
>=20
> git reset HEAD foo
>=20
> what you are saying is, use the HEAD as the head of the branch (don't
> change my branch), but put in the index the state of foo in HEAD, so
> in brief reset the index state of foo.

Thank you all for the explanations.

--=20
Nicolas Sebrecht
