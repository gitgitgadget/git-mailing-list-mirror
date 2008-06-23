From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [jgit PATCH] Paper bag fix quoting for SSH transport commands
Date: Mon, 23 Jun 2008 04:30:54 +0200
Message-ID: <200806230430.54639.robin.rosenberg.lists@dewire.com>
References: <20080622013640.GA18629@spearce.org> <200806221954.08919.robin.rosenberg.lists@dewire.com> <20080622221545.GF11793@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 04:35:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAbuD-0004OM-ED
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 04:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbYFWCeu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Jun 2008 22:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752699AbYFWCet
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 22:34:49 -0400
Received: from av9-2-sn3.vrr.skanova.net ([81.228.9.186]:55845 "EHLO
	av9-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbYFWCet convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jun 2008 22:34:49 -0400
Received: by av9-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 31E2D38229; Mon, 23 Jun 2008 04:34:48 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av9-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 06EBC38216; Mon, 23 Jun 2008 04:34:48 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id B9FED37E45;
	Mon, 23 Jun 2008 04:34:47 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080622221545.GF11793@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85831>

m=C3=A5ndagen den 23 juni 2008 00.15.45 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > As for pushing and signing. One way is for you (Shawn) and me is
> > to sign-off and push each other's patches. I pushed this one.
>=20
> Given that repo.or.cz doesn't show reflogs, I take it this is only
> a way to make sure at least someone has reviewed the patch before
> it goes into the main tree, since we both have write access?  I
> can live with that.
We'll try that (unless we need pushing desperately).

-- robin
