From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git cvsimport branches not consistent with CVS branches
Date: Sun, 8 Jul 2007 14:22:46 +0200
Message-ID: <200707081422.46466.robin.rosenberg.lists@dewire.com>
References: <46903396.1010507@heydon.com.au> <200707081253.06129.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0707081246040.4248@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Downing <bdowning@lavos.net>,
	Gordon Heydon <gordon@heydon.com.au>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 14:21:59 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7Vm2-0001rQ-Eu
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 14:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbXGHMVq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 8 Jul 2007 08:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbXGHMVq
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 08:21:46 -0400
Received: from [83.140.172.130] ([83.140.172.130]:26712 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbXGHMVq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 08:21:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 38CF38026DB;
	Sun,  8 Jul 2007 14:14:44 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19373-04; Sun,  8 Jul 2007 14:14:43 +0200 (CEST)
Received: from [10.9.0.8] (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id D4F81802663;
	Sun,  8 Jul 2007 14:14:43 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0707081246040.4248@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51877>

s=F6ndag 08 juli 2007 skrev Johannes Schindelin:
> Hi,
>=20
> On Sun, 8 Jul 2007, Robin Rosenberg wrote:
>=20
> > Corecode's fromcvs is pretty fast and incremental and AFAIK accurat=
e.
>=20
> The only problem is that it is a misnomer: it is not fromcvs, but fro=
mrcs,=20
> since you have to have access at the _files_. This is not always=20
> possible.

A small problem considering that fromcvs works and the other don't. My =
guess
is that fromcvs kan be "fixed" to do remote access much more easily tha=
n cvsimport
can be "fixed" to import an archive properly.

-- robin
