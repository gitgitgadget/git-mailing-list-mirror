From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] Unicode: update of combining code points
Date: Tue, 15 Apr 2014 20:10:03 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1404152009020.29301@ds9.cixit.se>
References: <201404072130.15686.tboegi@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 15 21:16:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wa8q0-0001vb-4F
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 21:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbaDOTQA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2014 15:16:00 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:49850 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755063AbaDOTP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 15:15:58 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Apr 2014 15:15:58 EDT
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s3FJA5f6029631
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Apr 2014 21:10:05 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s3FJA3dQ029628;
	Tue, 15 Apr 2014 21:10:03 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <201404072130.15686.tboegi@web.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Tue, 15 Apr 2014 21:10:07 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246295>

Torsten B=C3=B6gershausen:

> diff --git a/utf8.c b/utf8.c
> index a831d50..77c28d4 100644
> --- a/utf8.c
> +++ b/utf8.c

Is there a script that generates this code from the Unicode database=20
files, or did you hand-update it?

--=20
\\// Peter - http://www.softwolves.pp.se/
