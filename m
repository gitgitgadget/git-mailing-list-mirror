From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 0/3] Update send-email cc-cmd documentation
Date: Mon, 20 Jul 2015 19:26:26 +0100
Message-ID: <1437416790-5792-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 20:26:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHFlz-0006vW-Fk
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 20:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbbGTS02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 14:26:28 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:41122 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753207AbbGTS01 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2015 14:26:27 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BtHQBiPK1VPHMBFlxcgkFRAYgNgVm1M4YKBAKBME0BAQEBAQEHAQEBAUABP4UAIxiBAgoaiEXJCI9vEQFRhDIFlFKNZI8riBmBCWYBAQgCgig9gT6BPgEBAQ
X-IPAS-Result: A2BtHQBiPK1VPHMBFlxcgkFRAYgNgVm1M4YKBAKBME0BAQEBAQEHAQEBAUABP4UAIxiBAgoaiEXJCI9vEQFRhDIFlFKNZI8riBmBCWYBAQgCgig9gT6BPgEBAQ
X-IronPort-AV: E=Sophos;i="5.15,509,1432594800"; 
   d="scan'208";a="614509311"
Received: from host-92-22-1-115.as13285.net (HELO localhost) ([92.22.1.115])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 20 Jul 2015 19:26:27 +0100
X-Mailer: git-send-email 2.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274344>

This mini series updates captures the details of how to use the
cc-cmd option of send-email, following my abortive attempts to
use a simple 'cat cc-cmd' invocation.

The alternative text for 'auto-cc' has been somewhat guesses at.

I haven't tested how well it lays out when docbook'ed.

The series could be squashed together..

Philip Oakley (3):
  doc: convert send-email option headings to nouns
  doc: send-email; expand on the meaning of 'auto-cc'
  doc: give examples for send-email cc-cmd operation

 Documentation/git-send-email.txt | 54 +++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 9 deletions(-)

-- 
2.4.2.windows.1.5.gd32afb6
