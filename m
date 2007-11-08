From: "Yossi Leybovich" <sleybo@mellanox.co.il>
Subject: missing object on git-gc
Date: Thu, 8 Nov 2007 02:59:02 +0200
Message-ID: <6C2C79E72C305246B504CBA17B5500C9029A3071@mtlexch01.mtl.com>
References: <6C2C79E72C305246B504CBA17B5500C902535D9C@mtlexch01.mtl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 01:59:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipvjy-0006OP-7a
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 01:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbXKHA7L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Nov 2007 19:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbXKHA7K
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 19:59:10 -0500
Received: from mail.mellanox.co.il ([194.90.237.44]:43732 "EHLO mellanox.co.il"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751100AbXKHA7J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Nov 2007 19:59:09 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from sleybo@mellanox.co.il)
	with SMTP; 8 Nov 2007 02:59:05 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <6C2C79E72C305246B504CBA17B5500C902535D9C@mtlexch01.mtl.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: missing object on git-gc
Thread-Index: Acghddb+IbjZqwHASKKlNyglUjUavAAK7Yug
x-pineapp-mail-mail-from: sleybo@mellanox.co.il
x-pineapp-mail-rcpt-to: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63919>

I am running the git-gc tool over my repository and get the following e=
rror:
=A0
> git-gc
=2E..
deltifying 3308 objects...
error: corrupt loose object '<sha1>'
fatal: object <sha1> cannot be read .
error: failed to run repack
=A0
when sha1 is 40 bytes number=20
=A0
Does any one know how I can solve thus issue?
=A0
Thanks
YOssi =20
