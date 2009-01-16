From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: I've added Dulwich to the Git Wiki
Date: Sat, 17 Jan 2009 00:04:33 +0100
Message-ID: <20090116230433.GA10391@chistera.yi.org>
References: <alpine.DEB.1.00.0901162329340.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jelmer@samba.org, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 17 00:06:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNxlJ-0006Fc-OI
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 00:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757582AbZAPXEh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 18:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755747AbZAPXEh
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 18:04:37 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:4026
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712AbZAPXEg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 18:04:36 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 5B77B801C0E0;
	Sat, 17 Jan 2009 00:04:35 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LNxju-0002j6-1e; Sat, 17 Jan 2009 00:04:34 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901162329340.3586@pacific.mpi-cbg.de>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106004>

* Johannes Schindelin [Fri, 16 Jan 2009 23:42:38 +0100]:

> Hi people,

> just got aware of the Dulwich project, which purports to be a pure Py=
thon=20
> Git engine.

Interesting.

> Jelmer, is there a chance you can export the Bazaar repository into a=
=20
> public Git repository?  The Bazaar web-frontend does not even allow m=
e to=20
> download a snapshot.

Unfortunately, the Dulwich repository contains Git repositories within,
so the resulting repository is not valid. I guess one could drop those
when converting.

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
                                Listening to: Radiohead - House Of Card=
s
