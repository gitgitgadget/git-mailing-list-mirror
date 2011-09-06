From: Valentin Haenel <valentin@fsfe.org>
Subject: question about interactive.singlekey
Date: Tue, 6 Sep 2011 22:50:11 +0200
Message-ID: <20110906205011.GC1747@kudu.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git-List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 06 22:58:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R12ik-0001tF-3J
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 22:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891Ab1IFU6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 16:58:09 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:36304 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab1IFU6H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 16:58:07 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Sep 2011 16:58:07 EDT
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p86KoCXP013736
	for <git@vger.kernel.org>; Tue, 6 Sep 2011 22:50:12 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p86KoB0G013731
	for git@vger.kernel.org; Tue, 6 Sep 2011 22:50:11 +0200
X-Authentication-Warning: kudu.in-berlin.de: esc set sender to valentin@fsfe.org using -f
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180836>

Hi,

i have recently installed debian on my laptop. I discovered that the
'interactive.singlekey' setting does not seem to work. On my desktop,
which has been debian for a while it does work. These are both debian
stable and have the exact same version of git v1.7.2.5, but
perhaps slightly different packages of other software installed. Does
the 'interactive.singlekey' setting perhaps need additional libraries
which were forgotten in the debian package dependencies?

Any ideas on where to look are greatly appreciated.

V-
