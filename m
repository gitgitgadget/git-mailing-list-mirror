From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 0/9] i18n: add PO files to po/
Date: Wed, 5 Oct 2011 14:44:12 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1110051442140.24631@ds9.cixit.se>
References: <1317668297-2702-1-git-send-email-avarab@gmail.com> <20111003220659.GA19537@elie> <CACBZZX5uz5cdoWebYOY-Omu0drnQasJB-12DMZyZ_NX17jzhmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?ISO-8859-2?Q?Marcin_Cie=B6lak?= <saper@saper.info>,
	Sam Reed <sam@reedyboy.net>,
	Jan Engelhardt <jengelh@medozas.de>,
	=?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	=?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c?= <pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 05 15:50:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBRrG-0006Ee-Fj
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 15:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934776Ab1JENt5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 09:49:57 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:37207 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934775Ab1JENt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 09:49:56 -0400
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Oct 2011 09:49:56 EDT
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p95DiD4t009683
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 5 Oct 2011 15:44:13 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id p95DiC3X009679;
	Wed, 5 Oct 2011 15:44:12 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <CACBZZX5uz5cdoWebYOY-Omu0drnQasJB-12DMZyZ_NX17jzhmg@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 05 Oct 2011 15:44:13 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182847>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:

> While we could set up some "i18n maintainer" infrastructure why not j=
ust=20
> have people submit patches to the list like we do for every other fil=
e in=20
> git?

As mentioned, that infrastructure already exists in Translation Project=
 -=20
http://translationproject.org/html/welcome.html

Submit the POT file at "string freeze" before a stable release, and pul=
l the=20
translated PO files when the release happens. TP handles the rest.

--=20
\\// Peter - http://www.softwolves.pp.se/
