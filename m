From: Federico Mena Quintero <federico@novell.com>
Subject: [PATCH 0/4] Make the documentation consistent for --track and
	--notrack
Date: Mon, 17 Sep 2007 20:04:53 -0500
Message-ID: <1190077493.22387.54.camel@cacharro.xalalinux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 03:02:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXRTv-0005Y1-1U
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 03:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbXIRBCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 21:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753174AbXIRBCV
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 21:02:21 -0400
Received: from jericho.provo.novell.com ([137.65.248.124]:19741 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbXIRBCV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 21:02:21 -0400
Received: from [164.99.193.124] ([164.99.193.124])
	by jericho.provo.novell.com with ESMTP; Mon, 17 Sep 2007 19:02:12 -0600
X-Mailer: Evolution 2.11.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58516>

Hi,

Here is the patchset I sent before, hopefully in a format more palatable
to the list.

The first three patches try to improve the documentation for git-branch
and git-checkout, adding docs for --track and --notrack to
git-branch.txt, and improving the ones that were in git-checkout.txt.

The last patch is for git-pull.sh; it gives the user a hint of what to
do when there's no branch configured to merge from.

  Federico
