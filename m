From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH v3] Add a commit.signoff configuration option to always
	use --signoff in commit
Date: Fri, 2 Jan 2009 13:46:50 +0100
Message-ID: <20090102124650.GA2395@chistera.yi.org>
References: <20081227120128.GA11322@chistera.yi.org> <1230549405-10000-1-git-send-email-dato@net.com.org.es> <7v4p0l1ik2.fsf@gitster.siamese.dyndns.org> <20090101221817.GA29267@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 13:48:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIjRs-0001m3-Fy
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 13:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757559AbZABMq6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jan 2009 07:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757500AbZABMq6
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 07:46:58 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:1410
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757452AbZABMq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 07:46:57 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id D33C9801BF8F;
	Fri,  2 Jan 2009 13:46:54 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LIjQQ-0000dc-J9; Fri, 02 Jan 2009 13:46:50 +0100
Content-Disposition: inline
In-Reply-To: <20090101221817.GA29267@chistera.yi.org>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104377>

* Adeodato Sim=C3=B3 [Thu, 01 Jan 2009 23:18:17 +0100]:

> * Junio C Hamano [Tue, 30 Dec 2008 13:04:13 -0800]:

> > They actually started making me think
> > that commmit.signoff might be more trouble than it is worth.

> I am beginning to think the same myself, and I'm okay with letting go=
=2E
> If somebody has a sensible plan, I can invest some time on implementi=
ng
> it, but I'll reckon it all tastes too messy at the moment.

> Thanks for your time.

Oh, I see you merged the last version into pu. I don't know if that
means it'd be bad for me to abandon now, but as said, if somebody helps
me figure out things, I'm open to continue working on it.

I just don't want to be pushing for inclusion of something of
sub-standard (UI) quality.

Cheers,

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
Will you just stand still?
                -- Luke Danes
