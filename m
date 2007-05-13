From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Segmentation fault in git-svn
Date: Sun, 13 May 2007 15:04:36 -0700
Message-ID: <46478B74.8010005@midwinter.com>
References: <4623F613.5010108@midwinter.com> <20070503123512.GA6500@xp.machine.xx> <20070513082118.GC1168@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Peter Baumann <waste.manager@gmx.de>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon May 14 00:04:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnMAo-0007X1-VQ
	for gcvg-git@gmane.org; Mon, 14 May 2007 00:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbXEMWEF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 18:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755415AbXEMWEF
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 18:04:05 -0400
Received: from tater.midwinter.com ([216.32.86.90]:59488 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753537AbXEMWEE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 18:04:04 -0400
Received: (qmail 20891 invoked from network); 13 May 2007 22:04:02 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO pinklady.local) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 13 May 2007 22:04:02 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <20070513082118.GC1168@muzzle>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47184>

I can confirm that the patch fixes the segfault for me too. Thanks!

-Steve
