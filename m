From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Has anyone looked at Gettext support for Git itself?
Date: Tue, 18 May 2010 08:12:29 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1005180810440.27004@ds9.cixit.se>
References: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 18 09:12:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEGyk-0000JR-Sj
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 09:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167Ab0ERHMd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 May 2010 03:12:33 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:38212 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752189Ab0ERHMd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 03:12:33 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o4I7CU7S027918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 18 May 2010 09:12:30 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o4I7CThM027914;
	Tue, 18 May 2010 09:12:30 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Tue, 18 May 2010 09:12:30 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147273>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:

> I couldn't find anything about this in the list archives. Have there =
been=20
> any discussions of adding internationalization support to Git itself?=
 I.e.=20
> the interface messages that the core Git utilities emit.

So far, it seems that most people using it has been the kind of people =
who=20
thing computers should speak only English.

I'd be happy to help out with a gettextization of Git, including doing =
a=20
Swedish translation. I've already translated gitk and git-gui to Swedis=
h=20
(and I use the translations in my day-to-day work), and would love to h=
ave=20
the rest of the command set speak the same language as me as well.

--=20
\\// Peter - http://www.softwolves.pp.se/
