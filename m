From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT] [PATCH v1 1/1] Add an ignored icon
Date: Tue, 24 Feb 2009 08:06:38 +0100
Message-ID: <200902240806.38710.robin.rosenberg.lists@dewire.com>
References: <cover.1235415747.git.ferry.huberts@pelagic.nl> <ec97c536d418f465befba2a7f30f82f0d75004f8.1235415747.git.ferry.huberts@pelagic.nl> <49A33862.90507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tor Arne =?iso-8859-1?q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 08:08:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbrOp-00058w-PD
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 08:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbZBXHGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 02:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753148AbZBXHGs
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 02:06:48 -0500
Received: from mail.dewire.com ([83.140.172.130]:10426 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753010AbZBXHGr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 02:06:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E5E72147E9CE;
	Tue, 24 Feb 2009 08:06:40 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e4gQyKhs3hYB; Tue, 24 Feb 2009 08:06:40 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 3E1F78026EC;
	Tue, 24 Feb 2009 08:06:40 +0100 (CET)
User-Agent: KMail/1.11.0 (Linux/2.6.27-12-generic; KDE/4.2.0; i686; ; )
In-Reply-To: <49A33862.90507@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111227>

tisdag 24 februari 2009 00:59:30 skrev Tor Arne Vestb=F8 <torarnv@gmail=
=2Ecom>:
> Ferry Huberts wrote:
> > Add an ignored icon to the label decorations page and make
> > sure that it is actually decorated: from now on do not ignore
> > ignored resources during decoration.
>=20
> The reason this was not added in the original series was because that=
's
> kind of the point of ignoring a resource -- you don't want any
> information about it. Also, none of the other team plugins provide
> decorations for ignored resources-

"Ignored" in this context does not mean unimportant.  It means we will
not track it in git, which is quite important.

-- robin
