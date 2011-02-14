From: =?iso-8859-1?Q?PICCA_Fr=E9d=E9ric-Emmanuel?= 
	<frederic-emmanuel.picca@synchrotron-soleil.fr>
Subject: RE: Mercurial over Git no success
Date: Mon, 14 Feb 2011 22:24:42 +0100
Message-ID: <606CC410B038E34CB97646A32D0EC0BF03888300@venusbis.synchrotron-soleil.fr>
References: <1297717305.19327@davidwbrown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <david@davidwbrown.name>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 14 22:45:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp6EV-0005ST-8c
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 22:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280Ab1BNVpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 16:45:18 -0500
Received: from dns.synchrotron-soleil.fr ([195.221.0.3]:53438 "EHLO
	sucette.synchrotron-soleil.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750882Ab1BNVpR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 16:45:17 -0500
X-Greylist: delayed 1188 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Feb 2011 16:45:17 EST
Received: from localhost (unknown [127.0.0.1])
	by sucette.synchrotron-soleil.fr (Postfix) with ESMTP id 4CE3A2D094;
	Mon, 14 Feb 2011 21:25:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at synchrotron-soleil.fr
Received: from sucette.synchrotron-soleil.fr ([127.0.0.1])
	by localhost (sucette.synchrotron-soleil.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M2PKTuRDEk6T; Mon, 14 Feb 2011 22:25:26 +0100 (CET)
Received: from venusbis.synchrotron-soleil.fr (venusbis.synchrotron-soleil.fr [195.221.0.152])
	by sucette.synchrotron-soleil.fr (Postfix) with ESMTP id 7159A2D084;
	Mon, 14 Feb 2011 22:25:26 +0100 (CET)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Mercurial over Git no success
Thread-Index: AcvMjUL+C//N4Qr6TtWoOXhP2FctywAAFTwO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166775>

apt-get install git-core git-gui gitk

would be a good starting point

See you

Frederic


-----Original Message-----
From: git-owner@vger.kernel.org on behalf of david@davidwbrown.name
Sent: Mon 2/14/2011 10:01 PM
To: git@vger.kernel.org
Subject: Mercurial over Git no success
 
Hello Gitters, long ago when first starting the project I'm currently running at my company I looked around for a VCS/SCM that would be anywhere better than: CVS/SVN. At first I looked at Git but could not get a version to run on my Ubuntu box. So, I had to settle for Hg. Now, that I'm several months into the web app dev I'm responsible for the hired help has convinced me to switch to Git. Now, I'm back at the same old problem I had months ago that forced me to give up on using Git. Unlike a lot of Unix/Linux based software the usual:

./configure
make
make install

Does not work for building Git on my local Ubuntu box (10.10 BTW). Some non-innocuous error condition as follows:

cannot find zlib.h

Pls advise. David.
