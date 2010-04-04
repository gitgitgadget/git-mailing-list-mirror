From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Is there interest in reading ~/.gitconfig.d/* and
 /etc/gitconfig.d/*?
Date: Sun, 04 Apr 2010 09:24:15 +0200 (CEST)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1004040922500.30612@perkele.intern.softwolves.pp.se>
References: <z2s51dd1af81004011420ka5d3a800kf6b3e4591527fc12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 04 09:24:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyKC0-0004Lk-16
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 09:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483Ab0DDHYT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Apr 2010 03:24:19 -0400
Received: from smtp.getmail.no ([84.208.15.66]:59803 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751436Ab0DDHYS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 03:24:18 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L0C006GVCKGG2B0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 04 Apr 2010 09:24:16 +0200 (MEST)
Received: from perkele ([84.215.142.63]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L0C00CHHCKFGX20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 04 Apr 2010 09:24:16 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.4.4.71237
Received: by perkele (Postfix, from userid 501)	id 30EC22FC00; Sun,
 04 Apr 2010 09:24:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 2E2EC2FBFF; Sun, 04 Apr 2010 09:24:15 +0200 (CEST)
In-reply-to: <z2s51dd1af81004011420ka5d3a800kf6b3e4591527fc12@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143916>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:

> However, I'd like to ask if there's any interest in getting a proper =
&=20
> documented patch for this. If so I can submit a proper patch, if not =
I can=20
> just continue to patch my Git build with my hack.

I'd be interested. I also maintain my .gitconfig in a version control s=
ystem=20
(sadly not Git itself, because I don't have it available on all hosts I=
 have=20
the files checked out on), and would like to be able to store the=20
host-specific settings out of the way (specifically for me that is=20
user.email).

--=20
\\// Peter - http://www.softwolves.pp.se/
