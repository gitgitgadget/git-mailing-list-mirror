From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: AW: [EGIT] [PATCH RFC v1 5/5] Use the ignore patterns cache to determine ignores
Date: Sun, 3 May 2009 15:17:33 +0200
Message-ID: <200905031517.33648.robin.rosenberg.lists@dewire.com>
References: <947431.4782.qm@web27806.mail.ukl.yahoo.com> <49FC401A.1030701@pelagic.nl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Struberg <struberg@yahoo.de>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Sun May 03 15:22:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0beP-0000Es-Vv
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 15:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbZECNRn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 May 2009 09:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752953AbZECNRm
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 09:17:42 -0400
Received: from mail.dewire.com ([83.140.172.130]:6881 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752709AbZECNRm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 May 2009 09:17:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 8803E80027D;
	Sun,  3 May 2009 15:17:36 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Mtvj5XPYD-Z; Sun,  3 May 2009 15:17:35 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id CB89C800277;
	Sun,  3 May 2009 15:17:35 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <49FC401A.1030701@pelagic.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118174>

l=F6rdag 02 maj 2009 14:44:10 skrev "Ferry Huberts (Pelagic)" <ferry.hu=
berts@pelagic.nl>:
> Mark Struberg wrote:
> > Ferry,
> >=20
> > I was just quickly hacking a rudimentary IgnoreRules class in jgit-=
core
> > [1] mainly for the purpose of not forgetting about handling ignores
> > finally ;)
> >=20
>=20
> I think there is no need to do that, I have that in my code already=20
> (although in a different form). My implementation reflects what C git=
 does.
>=20
> > I now saw you worked on introducing gitignore to EGIT, but wasn't a=
ble
> > to find any repo with your code but only a few old patches.
> >=20
>=20
> it's in my local repo. I have no public repo

Perhaps you could send the patches if they are useful for review. I kno=
w Mark is anxious
to get the patch train rolling.

If you do not want us to merge them yet add RFC to the subject prefix, =
though, I'm pretty sure we=20
won't merge the first version anyway...  Big or tricky patch sets rarel=
y pass on the first attempt.

-- robin
