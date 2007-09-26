From: Mike Hommey <mh@glandium.org>
Subject: grafts not appearing in manual pages
Date: Wed, 26 Sep 2007 22:24:41 +0200
Organization: glandium.org
Message-ID: <20070926202441.GA31848@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 22:25:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IadRn-0007tP-GS
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 22:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbXIZUZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 16:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752349AbXIZUZS
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 16:25:18 -0400
Received: from vawad.err.no ([85.19.200.177]:46065 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752092AbXIZUZR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 16:25:17 -0400
Received: from aputeaux-153-1-12-240.w82-124.abo.wanadoo.fr ([82.124.181.240] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IadRb-0002AJ-QT
	for git@vger.kernel.org; Wed, 26 Sep 2007 22:25:16 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IadR3-0008I6-U0
	for git@vger.kernel.org; Wed, 26 Sep 2007 22:24:42 +0200
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59245>

Hi,

The only occurrence of grafts in the manual pages is in the
git-filter-branch one. I somehow feel this is wrong not to see it
described more "formally" in the manual pages.

I wouldn't mind writing a small something, except I have no idea what
would be the most appropriate place to talk about it... Does anyone have
such an idea ?

Cheers,

Mike
