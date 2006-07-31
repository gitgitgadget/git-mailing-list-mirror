From: Alexander ZVYAGIN <Alexander.Zvyagin@cern.ch>
Subject: File version at a specific date?
Date: Mon, 31 Jul 2006 19:56:00 +0200
Message-ID: <200607311956.00679.Alexander.Zvyagin@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Keywords: CERN SpamKiller Note: -49 Charset: west-latin
X-From: git-owner@vger.kernel.org Mon Jul 31 19:56:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7bzu-00033O-6Y
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 19:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWGaR4E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 13:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbWGaR4E
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 13:56:04 -0400
Received: from cernmx03.cern.ch ([137.138.166.166]:22210 "EHLO
	cernmxlb.cern.ch") by vger.kernel.org with ESMTP id S1030233AbWGaR4D
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 13:56:03 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws; s=beta; d=cern.ch; q=dns; 
	h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding;
	b=ObMRIzcDt1TxryUOl12mvG+p5cboa4FJoJJGKHPDG2HD3rFqhdAjWMGAU+zOPMvRkIKcp/N8oFGgcNe08mqN8VyCXEcKxfPbH6aWk/I8fzZJ5baMVWEWy7CB3PxgUL8F;
X-Filter: CERNMX03 CERN MX v2.0 060718.1314 Release
Received: from cernfe04.cern.ch ([137.138.28.245]) by cernmxlb.cern.ch with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 31 Jul 2006 19:56:01 +0200
Received: from na58pc052.cern.ch ([137.138.201.72]) by cernfe04.cern.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 31 Jul 2006 19:56:01 +0200
To: git@vger.kernel.org
User-Agent: KMail/1.7.1
Content-Disposition: inline
X-OriginalArrivalTime: 31 Jul 2006 17:56:01.0141 (UTC) FILETIME=[9582D250:01C6B4CA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24532>

Hi,

I failed to find in the documentation how to look to a file content
at some moment in a past.

Something like this:
$ git checkout master~2 Makefile
when I specify not the revisions numbers ago the file was (~2),
but the time, for example "2005-12-12 00:00:00" or something like this.

Where should I look at?

Thanks in advance!
Alexander.
