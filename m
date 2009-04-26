From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Add core.trustlowlevelstat for diffs in dev,ino,uid and gid
Date: Mon, 27 Apr 2009 00:02:42 +0200
Message-ID: <200904270002.42489.robin.rosenberg.lists@dewire.com>
References: <1240743317-10117-1-git-send-email-robin.rosenberg@dewire.com> <7vocujjm5r.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0904261159190.7331@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>, spearce@spearce.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 27 10:42:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyCTI-000137-7M
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 00:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbZDZWCx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2009 18:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbZDZWCx
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 18:02:53 -0400
Received: from mail.dewire.com ([83.140.172.130]:21208 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbZDZWCw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2009 18:02:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id EDBDB14A8B34;
	Mon, 27 Apr 2009 00:02:44 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gCmSVl-ZcB3T; Mon, 27 Apr 2009 00:02:44 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 5886514A8B33;
	Mon, 27 Apr 2009 00:02:44 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <alpine.LFD.2.00.0904261159190.7331@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117614>

s=F6ndag 26 april 2009 21:25:13 skrev Linus Torvalds <torvalds@linux-fo=
undation.org>:
>=20
> On Sun, 26 Apr 2009, Junio C Hamano wrote:
> >=20
> > I had a similar patch that disables inum checking in my private tre=
e for
> > different reasons of my own; the set of fields your patch ignores i=
s a
> > compatible superset of, and I think makes more sense than, what I w=
as
> > planning to do, so no objections from me on this _optional_ feature=
=2E
>=20
> Maybe we should just remove those checks entirely?

Blessed-by: Robin Rosenberg <robin.rosenberg@dewire.com>

-- robin
