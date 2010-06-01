From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Recovering from commit --amend in rebase --interactive
Date: Tue, 1 Jun 2010 11:40:09 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1006011136590.2352@ds9.cixit.se>
References: <alpine.DEB.2.00.1006011022030.2352@ds9.cixit.se> <4C04D78A.2090103@panasas.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 12:40:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJOtU-0004ol-LN
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 12:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313Ab0FAKkR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 06:40:17 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:44438 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751364Ab0FAKkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 06:40:16 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o51Ae9DN018048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 1 Jun 2010 12:40:09 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o51Ae9Wp018045;
	Tue, 1 Jun 2010 12:40:09 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <4C04D78A.2090103@panasas.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Tue, 01 Jun 2010 12:40:09 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148108>

Boaz Harrosh:

> The prints are clear enough.

The problem is that you stop reading them after a while. I've been usin=
g=20
rebase actively for a couple of years, so I don't necessary pay much=20
attention to what it says anymore.

And besides, if I forget to do the edits in another xterm, the help tex=
t is=20
usually gone by the time I need to continue anyway...

> What?!? no, why. Just empty out the message at editor and save. It wi=
ll=20
> abort any commit and do nothing.

Oh. That's useful to know next time it happens :-)


Jan Kr=FCger:

> It might be easy to miss, but it's there, right in the editor:
>
> # Please enter the commit message for your changes. Lines starting
> # with '#' will be ignored, and *an empty message aborts the commit*.
> (Emphasis added)

Indeed. There goes thinking you know what you do after having used the=20
tools for a long time... :-)

--=20
\\// Peter - http://www.softwolves.pp.se/
