From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Which module contains SVN/Core.pm in CPAN
Date: Mon, 18 Feb 2008 03:40:38 -0800 (PST)
Message-ID: <389581.75818.qm@web31805.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 18 12:47:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR4TS-0005mN-8h
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 12:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755637AbYBRLrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 06:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756747AbYBRLrT
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 06:47:19 -0500
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:41871 "HELO
	web31805.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755604AbYBRLrT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Feb 2008 06:47:19 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Feb 2008 06:47:19 EST
Received: (qmail 46627 invoked by uid 60001); 18 Feb 2008 11:40:38 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=guY+vCBVDH5od5j4Q9vqt7qMTso00qr5kbvavnJEqP+D7Ivfro9UY9WF6AWxxPRIZaQXYYVJpvn/nic8Gp10nfXuS+8pOQlIAqlaW9TQQAs9EBiVawlNIObDPKlxe3E4DW7FEeByAoKvKBRFRGSkKouBEL3CDGdXU2yFleGrlRQ=;
X-YMail-OSG: zzprDeMVM1nheNygQI77QW1d0Yr99yAJU958gSLAFzxw1ZtJB8_NABrjzlBhgtCRLSLQhbhOxEurZVyiznnADnRXsIFFY7SU_crtz8lX7JRAtJuISao-
Received: from [71.80.239.35] by web31805.mail.mud.yahoo.com via HTTP; Mon, 18 Feb 2008 03:40:38 PST
X-Mailer: YahooMailWebService/0.7.162
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74268>

Example:

$git-svn clone ...
Can't locate SVN/Core.pm in @INC (@INC contains: ...

"i /SVN" gives a hefty list.

Which module(s) in CPAN gives the minimal set to run "git-svn"?

Thanks,
   Luben
