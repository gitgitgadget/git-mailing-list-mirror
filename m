From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 02/18] Change style of some regular expressions to make
 them clearer
Date: Fri, 7 Jun 2013 11:40:43 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1306071140080.9741@ds9.cixit.se>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr> <1370547263-13558-3-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 07 12:41:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uku6M-0002wD-8Q
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 12:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033Ab3FGKkx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 06:40:53 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:55007 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752152Ab3FGKkx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 06:40:53 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id r57Aeior014435
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 7 Jun 2013 12:40:44 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id r57AehcV014432;
	Fri, 7 Jun 2013 12:40:44 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1370547263-13558-3-git-send-email-celestin.matte@ensimag.fr>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Fri, 07 Jun 2013 12:40:44 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226619>

C=C3=A9lestin Matte:

> - Use {}{} instead of /// when slashes or used inside the regexp so a=
s not to
> escape it.

I guess that should read "...when slashes *are* used inside..."?

--=20
\\// Peter - http://www.softwolves.pp.se/
