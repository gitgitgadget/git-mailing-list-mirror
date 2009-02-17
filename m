From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT PATCH v2 00/12] Support customizable label decorations
Date: Tue, 17 Feb 2009 06:52:36 +0100
Message-ID: <200902170652.36701.robin.rosenberg@dewire.com>
References: <1234377614-23798-1-git-send-email-torarnv@gmail.com> <200902162157.28316.robin.rosenberg@dewire.com> <4999ED97.7050502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Tor Arne =?iso-8859-1?q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 06:54:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZIuJ-0003a8-8n
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 06:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbZBQFwo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Feb 2009 00:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbZBQFwo
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 00:52:44 -0500
Received: from mail.dewire.com ([83.140.172.130]:4673 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbZBQFwn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2009 00:52:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 6CD04802657;
	Tue, 17 Feb 2009 06:52:38 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ORKCdQShnWTF; Tue, 17 Feb 2009 06:52:37 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id E35E48006BC;
	Tue, 17 Feb 2009 06:52:37 +0100 (CET)
User-Agent: KMail/1.11.0 (Linux/2.6.27-11-generic; KDE/4.2.0; i686; ; )
In-Reply-To: <4999ED97.7050502@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110313>

m=E5ndag 16 februari 2009 23:49:59 skrev Tor Arne Vestb=F8 <torarnv@gma=
il.com>:
> Robin Rosenberg wrote:
> > onsdag 11 februari 2009 19:40:02 skrev Tor Arne Vestb=F8 <torarnv@g=
mail.com>:
> >> Known issues are:
> >>
> >>   - If a project has a repository more than one level above the
> >>     project directory decorations will fail.
> >=20
> > That one *is* annoying. My biggest projects don't get decorations n=
ow...
>=20
> Ouch. I thought that was a rather rare situation, given that we only =
let
> users create new repos either in the project or the project parent.
Legacy, but some reasons make sense.

> I'll whip something up :)
>=20
> How has the series held up this past week in the update manager? Any
642 or 461 downloads (depending on how you count). It's hard to say if =
different
if some downloads are from multiple or single users.

> complaints from users or other things I should be aware of?
One :)

-- robin
