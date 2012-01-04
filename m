From: Victor Engmark <victor.engmark@terreactive.ch>
Subject: Auto-refresh git-gui
Date: Wed, 4 Jan 2012 10:15:47 +0100
Message-ID: <20120104091547.GC3484@victor>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 04 10:42:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiNMx-0003O0-Vj
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 10:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867Ab2ADJms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 04:42:48 -0500
Received: from gate.terreactive.ch ([212.90.202.121]:58280 "EHLO
	mail.terreactive.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab2ADJmq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 04:42:46 -0500
X-Greylist: delayed 1611 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jan 2012 04:42:46 EST
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-terreActive-From: victor.engmark@terreactive.ch
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187915>

Is there some way to make `git-gui` rescan automatically when anything
in the repository changes? That would enable a more fluid workflow when
combined with other Git tools.

Use cases:
* "Dashboard" functionality to keep track of changes without having to
run `git status` all the time.
* `git` / `git-gui` introduction: See what happens live while working
with the other tool.

-- 
Victor Engmark
terreActive AG
Kasinostrasse 30
CH-5001 Aarau
Tel: +41 62 834 00 55
Fax: +41 62 823 93 56
www.terreactive.ch

Wir sichern Ihren Erfolg - seit 15 Jahren
