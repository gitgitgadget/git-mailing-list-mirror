From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] Prefer $EMAIL over auto-generated user@hostname.
Date: Fri, 6 Jul 2007 17:11:45 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070706151145.GA15341@informatik.uni-freiburg.de>
References: <468E59B3.7080007@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: torvalds@linux-foundation.org, gitster@pobox.com,
	mkraai@beckman.com, madcoder@debian.org, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jul 06 17:12:11 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6pTe-0002Mc-Bg
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 17:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756396AbXGFPMH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 6 Jul 2007 11:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755917AbXGFPMG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 11:12:06 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:56531 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752613AbXGFPMF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jul 2007 11:12:05 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1I6pTU-0003ey-7D; Fri, 06 Jul 2007 17:12:00 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l66FBlIV015616;
	Fri, 6 Jul 2007 17:11:47 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l66FBjrG015615;
	Fri, 6 Jul 2007 17:11:45 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	torvalds@linux-foundation.org, gitster@pobox.com,
	mkraai@beckman.com, madcoder@debian.org, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <468E59B3.7080007@nrlssc.navy.mil>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51762>

Hello Brandon,

Brandon Casey wrote:
>  	struct passwd *pw =3D NULL;
> +        char *email;
Indention error. Otherwise it looks good (just from reading the patch).

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

Set the I_WANT_A_BROKEN_PS environment variable to force BSD syntax ...
	-- manpage of procps
