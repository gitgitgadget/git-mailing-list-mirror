From: Valdis.Kletnieks@vt.edu
Subject: Re: git guidance
Date: Fri, 07 Dec 2007 14:36:25 -0500
Message-ID: <11272.1197056185@turing-police.cc.vt.edu>
References: <20071129105220.v40i22q4gw4cgoso@intranet.digizenstudio.com> <200712071353.11654.a1426z@gawab.com> <m3prxiu3oo.fsf@roke.D-201>
            <200712072204.48410.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1197056185_3013P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Susi <psusi@cfl.rr.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jing Xue <jingxue@digizenstudio.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Al Boldi <a1426z@gawab.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 20:36:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0j0K-0006OI-Eb
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 20:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756910AbXLGTgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 14:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754416AbXLGTgh
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 14:36:37 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:51500 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756874AbXLGTgg (ORCPT <RFC822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 14:36:36 -0500
Received: from turing-police.cc.vt.edu (turing-police.cc.vt.edu [127.0.0.1])
	by turing-police.cc.vt.edu (8.14.2.Alpha0/8.14.2.Alpha0) with ESMTP id lB7JaPHs011274;
	Fri, 7 Dec 2007 14:36:25 -0500
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
In-Reply-To: Your message of "Fri, 07 Dec 2007 22:04:48 +0300."
             <200712072204.48410.a1426z@gawab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67448>

--==_Exmh_1197056185_3013P
Content-Type: text/plain; charset=us-ascii

On Fri, 07 Dec 2007 22:04:48 +0300, Al Boldi said:

> Because WORKFLOW C is transparent, it won't affect other workflows.  So you 
> could still use your normal WORKFLOW B in addition to WORKFLOW C, gaining an 
> additional level of version control detail at no extra cost other than the 
> git-engine scratch repository overhead.
> 
> BTW, is git efficient enough to handle WORKFLOW C?

Imagine the number of commits a 'make clean; make' will do in a kernel tree, as
it commits all those .o files... :)


--==_Exmh_1197056185_3013P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFHWaC5cC3lWbTT17ARAqJ5AKCatWQmDqbqcBGr/xUrB5a4nlNhsACg277z
4cy3yUcj5tOMBQgmvY7hQQo=
=uvAi
-----END PGP SIGNATURE-----

--==_Exmh_1197056185_3013P--
