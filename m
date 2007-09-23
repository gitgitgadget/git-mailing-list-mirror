From: Hanspeter Kunz <hp@edelkunz.ch>
Subject: git-send-email is omitting author and date lines
Date: Mon, 24 Sep 2007 00:13:53 +0200
Message-ID: <1190585633.29937.44.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 00:43:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZaAA-0008PQ-9w
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 00:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815AbXIWWmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 18:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753642AbXIWWmp
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 18:42:45 -0400
Received: from seamus.madduck.net ([213.203.238.82]:55523 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbXIWWmp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 18:42:45 -0400
X-Greylist: delayed 1726 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Sep 2007 18:42:44 EDT
Received: from [192.168.2.102] (84-72-80-233.dclient.hispeed.ch [84.72.80.233])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: hp@edelkunz.ch)
	by seamus.madduck.net (postfix) with ESMTP id 51DCA4064CC
	for <git@vger.kernel.org>; Mon, 24 Sep 2007 00:14:00 +0200 (CEST)
X-Mailer: Evolution 2.10.3 
X-Virus-Scanned: ClamAV 0.91.2/4372/Sun Sep 23 23:35:33 2007 on seamus.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58990>

Hi,

sorry if this is a stupid question, but I'm new to git.

When sending a patch to myself using `git-send-email` I realized that
the lines containing the author and the date (lines 5 and 6 in the patch
file) were not in the sent email.

Is this on purpose? And if so, why?

Thanks,
Hp.
