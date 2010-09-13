From: Thomas Klausner <tk@giga.or.at>
Subject: Mailing list headers: Date:<TAB> instead of Date:<SPACE>
Date: Mon, 13 Sep 2010 17:02:45 +0200
Message-ID: <20100913150245.GT22527@danbala.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 17:13:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvAin-0003PZ-4f
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 17:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474Ab0IMPNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 11:13:23 -0400
Received: from danbala.ifoer.tuwien.ac.at ([128.130.168.64]:54732 "EHLO
	danbala.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab0IMPNW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 11:13:22 -0400
X-Greylist: delayed 636 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Sep 2010 11:13:22 EDT
Received: by danbala.tuwien.ac.at (Postfix, from userid 116)
	id 7478A3903BE; Mon, 13 Sep 2010 17:02:45 +0200 (MEST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156097>

Hi!

I just subscribed to this list and tried reading it in tin.

tin didn't recognize the mails. With help of a tin developer I tracked
it down and found that the mails from this mailing list come with
Date:<TAB>$DATE, i.e. "Date:	Mon, 13 Sep 2010 08:15:48 +0100 (CET)"
instead of
Date:<SPACE>$DATE, i.e. "Date: Mon, 13 Sep 2010 08:15:48 +0100 (CET)"

While this doesn't seem to be forbidden by the RFC, I think it is
at least uncommon, and here it causes trouble. Could you please change
this?

Thanks,
 Thomas
