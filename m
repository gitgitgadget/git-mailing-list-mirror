From: "Gerald Ruescher" <GRuescher@dspace.de>
Subject: Problem cloning Linus' tree via http
Date: Tue, 17 Apr 2007 16:04:13 +0100
Message-ID: <18A49CF3586FC14290887ECC63C9141F0104D04B@exchange2003.dspace.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 16:35:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdom1-0006NS-8B
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 16:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbXDQOfJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 17 Apr 2007 10:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbXDQOfJ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 10:35:09 -0400
Received: from mail-mx400.dspace.de ([80.66.6.100]:3287 "EHLO
	mail-mx400.dspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030413AbXDQOfH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2007 10:35:07 -0400
X-Greylist: delayed 1854 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Apr 2007 10:35:07 EDT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem cloning Linus' tree via http
Thread-Index: AceBAajH8Hugi8XdRIWcxMhbCMr9VA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44773>

Hi Folks,=20

stupid newbie question:=20

I'm trying to clone Linus' kernel tree using git 1.5.1.
Since I'm behind a firewall which blocks the git port I use:=20

   git clone http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux-2.6.git=20

At first everything is fine and git happily seems to download the tree.=
=20
After a while however, git exits with the following error message:=20

   error: Couldn't get http://www.kernel.org/pub/scm/linux/kernel/git/t=
orvalds/linux-2.6.git/refs/tags/v2.6.11 for tags/v2.6.11
   The requested URL returned error: 404=20
   error: Could not interpret tags/v2.6.11 as something to pull=20
   rm: cannot remove directory `/cygdrive/c/home/git/linux-2.6/.git/clo=
ne-tmp': Directory not empty=20

Any hint what I did wrong? =20

Many thanks in advance,=20
Gerald=20


_______________________________________________=20
Gerald R=FCscher=20
Software Development Engineer=20
Core Real-Time Implementation=20
dSPACE GmbH Tel.: +49 5251 1638-1826=20
Technologiepark 25 Fax: +49 5251 16198-1826=20
33100 Paderborn http://www.dspace.de=20
Germany mailto:GRuescher@dspace.de=20
_______________________________________________=20
