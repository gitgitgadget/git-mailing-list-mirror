From: =?gb2312?B?0vjGvQ==?= <yinping@kooxoo.com>
Subject: Is it possible for git to support binary differencing for binary files?
Date: Fri, 12 Oct 2007 00:37:43 +0800
Message-ID: <20071011163746.DEB147E6F@mail.kooxoo.com>
References: <Pine.LNX.4.64.0710111704570.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 11 19:00:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig1P6-00079l-OP
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 19:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbXJKRAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 13:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754776AbXJKRAr
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 13:00:47 -0400
Received: from mail.kooxoo.com ([60.28.194.208]:53013 "EHLO mail.kooxoo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702AbXJKRAr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 13:00:47 -0400
X-Greylist: delayed 1380 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Oct 2007 13:00:47 EDT
Received: from yinping (unknown [124.42.17.129])
	by mail.kooxoo.com (Postfix) with ESMTP id DEB147E6F
	for <git@vger.kernel.org>; Fri, 12 Oct 2007 00:37:46 +0800 (CST)
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcgMIOAzvXDMfbRLQJ2U0+6l8LXcUwAA1V8Q
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
In-Reply-To: <Pine.LNX.4.64.0710111704570.4174@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60615>

Hi. 
Storing binary files as deltas is helpful to keep source and binary files
together and in sync  So is it possible for git to do that as svn. This is
my only pain when using git.
