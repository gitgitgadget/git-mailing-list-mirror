From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 7 Jan 2008 22:03:23 +0100
Message-ID: <200801072203.23938.robin.rosenberg.lists@dewire.com>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Steffen Prohaska <prohaska@zib.de>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 07 22:04:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBz8a-0007qd-1k
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 22:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbYAGVDd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2008 16:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752940AbYAGVDd
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 16:03:33 -0500
Received: from [83.140.172.130] ([83.140.172.130]:8439 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752574AbYAGVDc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 16:03:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B2B79802893;
	Mon,  7 Jan 2008 22:03:30 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wgaNjhCrgnVq; Mon,  7 Jan 2008 22:03:30 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 191A0802641;
	Mon,  7 Jan 2008 22:03:30 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <alpine.LSU.1.00.0801071915470.10101@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69806>

m=C3=A5ndagen den 7 januari 2008 skrev du:
> Problem.  There is not a single "right".  It really depends on the=20
> project.

Indeed, but the most common SCM's detect binary files automatically,=20
either by suffix  or content analysis, so I think that is what user's e=
xpect.
It will be right for more projects that the current behaviour.

-- robin
