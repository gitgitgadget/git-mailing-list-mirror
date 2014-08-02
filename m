From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 0/1] doc: format-patch
Date: Sat,  2 Aug 2014 16:46:22 +0100
Message-ID: <1406994383-5076-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 17:46:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDbVt-0003yD-EB
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 17:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846AbaHBPqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2014 11:46:24 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:24496 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754547AbaHBPqX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Aug 2014 11:46:23 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhEXAFsH3VMCYJjrPGdsb2JhbABagwwBAVERAUUBgiawJpk8D4dMDHcXBQEBAQE4NoRgIxiBAgoaiFkJxwSPTDWEHQWdWZZZPDABAQ
X-IPAS-Result: AhEXAFsH3VMCYJjrPGdsb2JhbABagwwBAVERAUUBgiawJpk8D4dMDHcXBQEBAQE4NoRgIxiBAgoaiFkJxwSPTDWEHQWdWZZZPDABAQ
X-IronPort-AV: E=Sophos;i="5.01,786,1400022000"; 
   d="scan'208";a="468372692"
Received: from host-2-96-152-235.as13285.net (HELO localhost) ([2.96.152.235])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 02 Aug 2014 16:46:21 +0100
X-Mailer: git-send-email 1.9.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254702>

Following the discussion at [1], I decided that while I felt the
documentation changes were OK, the commit message need more explanation
to cover the points raised in the discussion. Thus the only changes
are to the commit message.

In addition I'll separately cover the point raised about the DWIM
description in gitrevisions(7). I'd also picked up that <refspecs>
aren't covered by it either.

Philip

[1] http://thread.gmane.org/gmane.comp.version-control.git/254652

Philip Oakley (1):
  doc: format-patch: don't use origin as a branch name

 Documentation/git-format-patch.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
1.9.4.msysgit.0
