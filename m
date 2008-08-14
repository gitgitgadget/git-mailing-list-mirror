From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Add some new icons, and apply them where appropriate
Date: Fri, 15 Aug 2008 00:02:40 +0200
Message-ID: <200808150002.40762.robin.rosenberg.lists@dewire.com>
References: <48A33C8E.6050008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Tor Arne =?iso-8859-1?q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:04:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTkwB-0004up-Su
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbYHNWDx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 18:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbYHNWDx
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:03:53 -0400
Received: from av11-1-sn2.hy.skanova.net ([81.228.8.183]:51975 "EHLO
	av11-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbYHNWDw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2008 18:03:52 -0400
Received: by av11-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id 01D6F382D7; Fri, 15 Aug 2008 00:03:50 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av11-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id DE4F137EFD; Fri, 15 Aug 2008 00:03:50 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id C6B4A37E42;
	Fri, 15 Aug 2008 00:03:50 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <48A33C8E.6050008@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92411>

onsdagen den 13 augusti 2008 21.57.02 skrev Tor Arne Vestb=F8:
> These icons are based on look of the existing CVS and
> SVN plugins, only with a Git branding (gray, red, green).
>=20
> Having the same look and feel as the other team plugins
> will probably help us in being distributed as part of
> the Eclipse platform.
>=20
> Signed-off-by: Tor Arne Vestb=F8 <torarnv@gmail.com>

Looks nice, but please remove the icons that are not actually used from=
 the
patch. I also wonder also whether the sharing icon should have a networ=
k-like
symbol. Connecting a project to a git repo involves no networking unlik=
e
most other SCMs.

Welcome to the project, btw!

-- robin
