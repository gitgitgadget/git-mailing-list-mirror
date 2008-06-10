From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 00/12] Extensions in core needed by PackWriter
Date: Tue, 10 Jun 2008 23:09:51 +0200
Message-ID: <200806102309.52196.robin.rosenberg@dewire.com>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 23:16:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6BCf-0006Yw-UG
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 23:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758865AbYFJVPY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2008 17:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758859AbYFJVPX
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 17:15:23 -0400
Received: from [83.140.172.130] ([83.140.172.130]:28249 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757306AbYFJVPV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 17:15:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 822F68030B5;
	Tue, 10 Jun 2008 23:15:19 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4cnfTDxjz52D; Tue, 10 Jun 2008 23:15:18 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 82A1F8030AF;
	Tue, 10 Jun 2008 23:15:18 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84548>

m=E5ndagen den 2 juni 2008 23.24.31 skrev Marek Zawirski:
> Hello,
>=20
> Here is my first GSoC series - some work from the last week.
> It's actually not a PackWriter, but some changes in existing jgit cor=
e
> related to PackWriting. Some of these added methods/refactors are not=
 yet
> used within this series, but are used in my dirty branch in PackWrite=
r
> which is under-development, even somewhat usable.
>=20
> Series start with formatting stuff, as some old files were not
> appropriatelly formatted.
>=20
> This series is also available at my corechanges branch:
> http://repo.or.cz/w/egit/zawir.git?a=3Dshortlog;h=3Drefs/heads/corech=
anges
> It's based on Shawn's bsd branch, with new BSD-style license, but I c=
an
> rebase if really needed.
>=20
> If you want to track some PackWriter (itself) development you may wan=
t to
> have a look at my dirty branch:
> http://repo.or.cz/w/egit/zawir.git?a=3Dshortlog;h=3Drefs/heads/dirty
>=20
> That's all. Although Shawn already reviewed some old version of this =
patches,
> I'm still interested in your comments.

This patchset is in master (merged)

Thanks.

-- robin
