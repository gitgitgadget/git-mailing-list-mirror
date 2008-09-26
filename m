From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [ANNOUNCE] Git-1.6.0.2-preview20080923
Date: Fri, 26 Sep 2008 10:27:59 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0809261026000.10516@ds9.cixit.se>
References: <82166911-C34F-439C-A2F3-CEBD7346A1D6@zib.de>
 <691F01A6-CA78-46DA-8388-C8339A3F0F04@zib.de> <B463062F-DD48-44A7-B2BB-8E5E0D177616@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Sep 26 11:29:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj9dX-0006yg-Fj
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 11:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbYIZJ2I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Sep 2008 05:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbYIZJ2G
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 05:28:06 -0400
Received: from ds9.cixit.se ([193.15.169.228]:34016 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbYIZJ2F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 05:28:05 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m8Q9S0Y1030743
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 26 Sep 2008 11:28:00 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m8Q9RxWc030738;
	Fri, 26 Sep 2008 11:27:59 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <B463062F-DD48-44A7-B2BB-8E5E0D177616@zib.de>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Fri, 26 Sep 2008 11:28:00 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96841>

Hi!

Steffen Prohaska:

> I updated the installer to Git-1.6.0.2-preview20080923.

One issue that I see is that the installer does not seem to clean up
the previously installed version on upgrade. I installed over the
previous version to C:\Git, and I now have two git-add.exe files:

 Directory of c:\git\bin

2008-06-22  18:41           925=A0184 git-add.exe


 Directory of c:\git\libexec\git-core

2008-09-23  07:55           881=A0664 git-add.exe

--=20
\\// Peter - http://www.softwolves.pp.se/
