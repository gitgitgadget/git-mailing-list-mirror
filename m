From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Invalid html output repo.or.cz (alt-git.git)
Date: Sat, 16 Feb 2008 14:00:37 +0100
Message-ID: <20080216130037.GA14571@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Feb 16 14:01:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQMfb-0003Y0-Ob
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 14:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbYBPNAl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Feb 2008 08:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbYBPNAl
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 08:00:41 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:50525 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbYBPNAk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 08:00:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id DD0B0680B59A;
	Sat, 16 Feb 2008 14:00:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rUatpiZrdk1B; Sat, 16 Feb 2008 14:00:37 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id B9A3868018CD; Sat, 16 Feb 2008 14:00:37 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74043>

http://repo.or.cz/w/alt-git.git?a=3Dshortlog

fails to load in my Seamonkey browser (Debian stable):

XML Parsing Error: not well-formed
Location: http://repo.or.cz/w/alt-git.git?a=3Dshortlog
Line Number 561, Column 33:<td><i><span title=3D"Uwe Kleine-K<span clas=
s=3D"cntrl">\e</span>,Av<span class=3D"cntrl">\e</span>(Bnig">Uwe Klein=
e ...</span></i></td>
--------------------------------^

mfg Martin K=F6gler
