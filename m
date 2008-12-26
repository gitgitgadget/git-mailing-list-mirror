From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH] Add a commit.signoff configuration variable to always
	use --signoff.
Date: Fri, 26 Dec 2008 23:10:33 +0100
Message-ID: <20081226221033.GA841@chistera.yi.org>
References: <1230296219-16408-1-git-send-email-dato@net.com.org.es> <20081227070228.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 26 23:13:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGKwF-0005A0-6B
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 23:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbYLZWKh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Dec 2008 17:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753014AbYLZWKg
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 17:10:36 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:1446
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbYLZWKg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 17:10:36 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id A9790801BF66
	for <git@vger.kernel.org>; Fri, 26 Dec 2008 23:10:34 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LGKt7-0000GU-Mg
	  for git@vger.kernel.org; Fri, 26 Dec 2008 23:10:33 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20081227070228.6117@nanako3.lavabit.com>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103957>

* Nanako Shiraishi [Sat, 27 Dec 2008 07:02:28 +0900]:

> There was a discussion in
> "http://thread.gmane.org/gmane.comp.version-control.git/32503/focus=3D=
32522"
> about automatically adding S-o-b line.

Ah, thanks for the pointer.

> Even though Junio said in his response "it certainly is a
> possibility", another solution that he referred to as "cleaner and
> more useful" in his message was made available in version 1.5.3 after
> this discussion.

Oh, a template file? I certainly hadn't thought of that, though I'd
still like to hear if my patch would be suitable for inclusion, because
it's much more straightforward to use (and to discover).

Thanks,

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
- I love you, Shirley, I'm not ashamed to say.
- If you love me, then you'll want me to be happy. Even if I'm not with=
 you.
- I don't love you that much.
                -- Denny Crane and Shirley Schmidt
