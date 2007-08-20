From: Paul Mackerras <paulus@samba.org>
Subject: New branch/tag list feature in gitk
Date: Tue, 21 Aug 2007 08:23:12 +1000
Message-ID: <18122.5200.729680.362444@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 00:23:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INFee-0002j2-8b
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 00:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbXHTWXV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 18:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbXHTWXV
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 18:23:21 -0400
Received: from ozlabs.org ([203.10.76.45]:41913 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbXHTWXU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 18:23:20 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 892F4DDE1E; Tue, 21 Aug 2007 08:23:19 +1000 (EST)
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56265>

I just pushed out an update to gitk that adds a new feature: under the
File menu there is now a "List references" entry that pops up a window
containing a list of the heads, tags and other references that appear
in the graph pane, sorted by name.  Clicking on a list entry selects
that commit in the main window.

Paul.
