From: Melchior FRANZ <mfranz@aon.at>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 1 Nov 2007 22:26:19 +0100
Message-ID: <200711012226.20441@rk-nord.at>
References: <20071022063222.GS14735@spearce.org> <7v4pg5btis.fsf@gitster.siamese.dyndns.org> <20071101211848.GG2387@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 22:27:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InhZY-0000JX-5O
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556AbXKAV02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754471AbXKAV01
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:26:27 -0400
Received: from warsl404pip8.highway.telekom.at ([195.3.96.102]:9966 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753821AbXKAV00 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:26:26 -0400
Received: (qmail 4999 invoked from network); 1 Nov 2007 21:26:22 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL602.highway.telekom.at
Received: from m3459p006.adsl.highway.telekom.at (HELO server.lan) ([88.117.80.70])
          (envelope-sender <mfranz@aon.at>)
          by smarthub94.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 1 Nov 2007 21:26:22 -0000
Received: from localhost (localhost [IPv6:::1])
	by server.lan (Postfix) with ESMTP id 0127916136AD3
	for <git@vger.kernel.org>; Thu,  1 Nov 2007 22:26:22 +0100 (CET)
User-Agent: KMail/1.9.8
In-Reply-To: <20071101211848.GG2387@thunk.org>
X-PGP: http://members.aon.at/mfranz/melchior.franz
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63006>

* Theodore Tso -- Thursday 01 November 2007:
> Looks like it came from Cogito's cg-clean.  No one else has it as far
> as I know, [...]

Not built-in. But there are cvs-clean and svn-clean scripts
floating around (and part of KDE), which can be quite useful.
The svn-clean script prompts the user with the number of files
it is about to delete, and asks for confirmation.

m.
