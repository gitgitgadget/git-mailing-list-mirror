From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: git-gui translators: final message update request
Date: Mon, 8 Dec 2008 08:36:28 -0800
Message-ID: <20081208163628.GG31551@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 17:38:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9j7a-00013n-4F
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 17:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbYLHQga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 11:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754215AbYLHQga
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 11:36:30 -0500
Received: from george.spearce.org ([209.20.77.23]:38581 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbYLHQg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 11:36:29 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9E1B838200; Mon,  8 Dec 2008 16:36:28 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102554>

Many of the translations have been updated for git-gui 0.12.
Since my last request to update translations we also picked up one
new message string:

+#: lib/transport.tcl:64
+#, tcl-format
+msgid "Mirroring to %s"
+msgstr ""
+

I've updated the po template and would appreciate a final pass from
any translators before I make the 0.12.0 tag.  I'd like to tie up
0.12 by this weekend if we can, so its in 1.6.1-rc3, and 1.6.1 final.

-- 
Shawn.
