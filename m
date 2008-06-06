From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] This patch is to allow 12 different OS's to compile
	and run git.
Date: Fri, 6 Jun 2008 22:15:51 +0200
Message-ID: <20080606201551.GB31040@leksak.fem-net>
References: <Pine.LNX.4.64.0806061330180.18454@xenau.zenez.com> <87bq2ez72u.fsf@jeremyms.com> <Pine.LNX.4.64.0806061359080.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 22:17:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4iN0-0008F3-08
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 22:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759088AbYFFUQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 16:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758559AbYFFUQK
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 16:16:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:60557 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754087AbYFFUQI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 16:16:08 -0400
Received: (qmail invoked by alias); 06 Jun 2008 20:16:06 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp030) with SMTP; 06 Jun 2008 22:16:06 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/VanwTHSvVgmDHnfKmrvn6cnawLbp+hXBRvv6vhd
	2xYBP+X6L+fBBr
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K4iLn-00019C-VM; Fri, 06 Jun 2008 22:15:52 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0806061359080.18454@xenau.zenez.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84104>

Hi,

>         Developer's Certificate of Origin 1.1

It's not necessary, or even unwanted, to copy&paste this into the
commit message.

The Signed-off-by: line
> Signed-off-by: Boyd Lynn Gerber <gerberb@zenez.com>
is enough.
So just use the Signed-off-by line and not the whole DCO.

As Documentation/SubmittingPatches says:
----
The sign-off is a simple line at the end of the explanation for
the patch[...].
[...]
if you can certify the below:

        Developer's Certificate of Origin 1.1
	[...]

then you just add a line saying

        Signed-off-by: Random J Developer <random@developer.example.org>
----

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
