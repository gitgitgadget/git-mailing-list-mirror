From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT PATCH] Refresh history when "Refresh" is clicked in the history viewer.
Date: Mon, 25 Feb 2008 01:11:13 +0100
Message-ID: <200802250111.15172.robin.rosenberg@dewire.com>
References: <1203895097-3742-1-git-send-email-rogersoares@intelinet.com.br> <200802242340.09606.robin.rosenberg@dewire.com> <47C206AF.8050904@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Mon Feb 25 01:13:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTQy8-0006uN-Hf
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 01:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759951AbYBYAMI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Feb 2008 19:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757885AbYBYAMH
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 19:12:07 -0500
Received: from [83.140.172.130] ([83.140.172.130]:15193 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755586AbYBYAMA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 19:12:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 37C42802677;
	Mon, 25 Feb 2008 01:11:58 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4-0R-aVVfKmC; Mon, 25 Feb 2008 01:11:53 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id D4D4C80019B;
	Mon, 25 Feb 2008 01:11:52 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <47C206AF.8050904@intelinet.com.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74977>

m=C3=A5ndagen den 25 februari 2008 skrev Roger C. Soares:
>=20
> Robin Rosenberg escreveu:
> > Looks ok, but what is the effect of refresh, besides possibly worki=
ng around
> > other bugs? I would expect to to refresh with the selected resource=
 as "filter",
> > but it doesn't.
> >  =20
> If you checkout a branch in gitk or commit something using git-gui or=
=20
> git command line, egit will be out of sync. Refresh updates the histo=
ry=20
> view to the current status.
Ok, thanks. I'll publish this. =20

> I'm not sure I understand what you were expecting, what do you mean b=
y=20
> "filter"?

History is filtered using the selected item in the project explorer and
options from the buttons in the history brower.
