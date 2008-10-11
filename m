From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [Gitk Patch 0/6]
Date: Sat, 11 Oct 2008 13:14:39 +0200
Message-ID: <200810111314.39512.robin.rosenberg.lists@dewire.com>
References: <1223532590-8706-1-git-send-email-robin.rosenberg@dewire.com> <18672.4878.128010.174357@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Oct 11 13:41:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kocqi-0004ZW-4l
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 13:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbYJKLkU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Oct 2008 07:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbYJKLkT
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 07:40:19 -0400
Received: from [83.140.172.130] ([83.140.172.130]:11377 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751933AbYJKLkS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Oct 2008 07:40:18 -0400
X-Greylist: delayed 1453 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Oct 2008 07:40:18 EDT
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5C97B8006B1;
	Sat, 11 Oct 2008 13:16:03 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eKBIQdSMJquI; Sat, 11 Oct 2008 13:15:53 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id EA9CE80008B;
	Sat, 11 Oct 2008 13:15:52 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <18672.4878.128010.174357@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97973>

l=F6rdagen den 11 oktober 2008 04.44.30 skrev Paul Mackerras:
> Robin Rosenberg writes:
>=20
> > (This is a resend to include gitk maintainer Paul Mackerras)
>=20
> Thanks.
>=20
> > I finally got tired of pressing Alt and some letter to activate men=
us in Gitk.=20
> > For example in "any" program you can press Alt-F to have the File m=
enu drop=20
> > down and then select the underscored character to select the wanted=
 menu.
> >=20
> > This series makes it possible. Friends of TCL may think my solution=
 is too
> > hack-ish. It doesn't fix all of the similary problem (mostly button=
) but=20
> > that is the subject of later patches as it looks like it requires o=
ther
> > means.
>=20
> It'll do for a first cut, but there would be a nicer way to do it, I
> think.
>=20
> Also, I think patches 2 and 4 should be combined into one, as should
> patches 5 and 6.  I'll do that and apply the series as 4 commits,
> unless you have an objection.
I split the commits to simplify review. My thought about squashing woul=
d
be different, but I have no strong opinions here. I was thinking 1+2, 4=
+5, 3+5, 6

-- robin
