From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 7/9] removing eclipse project files
Date: Mon, 28 Sep 2009 08:34:44 +0200
Message-ID: <200909280834.45360.robin.rosenberg.lists@dewire.com>
References: <892492.1652.qm@web27801.mail.ukl.yahoo.com> <200909272152.33224.robin.rosenberg.lists@dewire.com> <2c6b72b30909271921y4b191f1fo42b1ffb5f08d3468@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Struberg <struberg@yahoo.de>,
	MatthiasSohn <matthias.sohn@sap.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"spearce@spearce.org" <spearce@spearce.org>
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 08:35:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ms9pQ-0005fH-UM
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 08:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbZI1Gez convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Sep 2009 02:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbZI1Gey
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 02:34:54 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:48271 "EHLO
	pne-smtpout2-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751877AbZI1Gey convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 02:34:54 -0400
Received: from sleipner.localnet (90.232.156.220) by pne-smtpout2-sn1.fre.skanova.net (7.3.140.3)
        id 4A2D61FD00AD7FEF; Mon, 28 Sep 2009 08:34:47 +0200
User-Agent: KMail/1.11.4 (Linux/2.6.28-11-generic; KDE/4.2.4; i686; ; )
In-Reply-To: <2c6b72b30909271921y4b191f1fo42b1ffb5f08d3468@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129227>

m=C3=A5ndag 28 september 2009 04:21:36 skrev Jonas Fonseca <jonas.fonse=
ca@gmail.com>:
> On Sun, Sep 27, 2009 at 15:52, Robin Rosenberg
> <robin.rosenberg.lists@dewire.com> wrote:
> > l=C3=B6rdag 26 september 2009 22:10:16 skrev Mark Struberg <struber=
g@yahoo.de>:
> >> And there is a lot more which imho cannot be set for a project. So=
 checking in the xml sounds like it is way more powerful isn't? And we =
would have this
> >
> > For JGit, not really. Everything that is not project settings shoul=
d be left as the default. The only reason is tool constraints. I'm not =
well versed
> > enough to tell what neatbeans does here.
>=20
> It is my impression that NetBeans has far better integration with
> maven. In terms of code formatting NetBeans supports
> exporting/importing project specific settings, but I have never
> personally used that.

I was thinking of (project) settings for controlling warnings/errors an=
d formatting.

-- robin
