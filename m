From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Some guilt fixes
Date: Sat,  6 Jan 2007 23:04:50 -0300
Message-ID: <11681354924120-git-send-email-vonbrand@inf.utfsm.cl>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 03:05:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3NPJ-0004HF-BZ
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 03:05:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbXAGCFA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 21:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbXAGCFA
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 21:05:00 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:60701 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932313AbXAGCE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 21:04:58 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0724sEu005578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 6 Jan 2007 23:04:56 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0724rod023997;
	Sat, 6 Jan 2007 23:04:53 -0300
Received: (from vonbrand@localhost)
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8/Submit) id l0724qQV023996;
	Sat, 6 Jan 2007 23:04:52 -0300
To: Josef Sipek <jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.5.0.rc0.g244a7
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Sat, 06 Jan 2007 23:04:56 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36118>


The following two patches clean guilt up a bit.
The first one cleans up the Makefiles, the second one
runs the tests on the files at hand, not the installed ones
(if they exist at all).

Please consider placing a file giving contact information (and how to
participate in its development) under Documentation.

I understand you have to point explicitly at the COPYING file in each
of the files in the package to make the license stick. Please check
this.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
