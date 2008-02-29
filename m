From: Paul Gardiner <osronline@glidos.net>
Subject: When to repack?
Date: Fri, 29 Feb 2008 10:55:41 +0000
Message-ID: <47C7E4AD.6030509@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: osronline@glidos.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 29 11:56:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV2uh-0001rA-51
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 11:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620AbYB2Kzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 05:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755708AbYB2Kzs
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 05:55:48 -0500
Received: from mk-outboundfilter-1.mail.uk.tiscali.com ([212.74.114.37]:16158
	"EHLO mk-outboundfilter-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755600AbYB2Kzr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Feb 2008 05:55:47 -0500
X-Trace: 51413606/mk-outboundfilter-1.mail.uk.tiscali.com/PIPEX/$ACCEPTED/pipex-customers/81.86.57.226
X-SBRS: None
X-RemoteIP: 81.86.57.226
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAI9zx0dRVjni/2dsb2JhbAAIrVY
X-IP-Direction: IN
Received: from 81-86-57-226.dsl.pipex.com (HELO [10.0.0.24]) ([81.86.57.226])
  by smtp.pipex.tiscali.co.uk with ESMTP; 29 Feb 2008 10:55:43 +0000
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75522>

There's advantage to repacking a repository after using git-fast-import.
If that repacked repository is then git-pushed to another, is there
any point in repacking the other afterwards? I'm guessing not, but
just checking.

P.
