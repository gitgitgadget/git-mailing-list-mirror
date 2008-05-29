From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git-add--interactive: manual hunk editing mode
Date: Thu, 29 May 2008 17:37:51 +0200
Message-ID: <200805291737.53291.trast@student.ethz.ch>
References: <200805232221.45406.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 17:39:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1kCy-00016F-AM
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 17:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbYE2Phg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 11:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbYE2Phg
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 11:37:36 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:53780 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352AbYE2Phf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 11:37:35 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 29 May 2008 17:37:33 +0200
Received: from vpn-global-dhcp3-183.ethz.ch ([129.132.210.183]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 29 May 2008 17:37:33 +0200
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <200805232221.45406.trast@student.ethz.ch>
Content-Disposition: inline
X-OriginalArrivalTime: 29 May 2008 15:37:33.0458 (UTC) FILETIME=[E9AFFF20:01C8C1A1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83211>

You wrote:
> Adds a new option 'e' to the 'add -p' command loop that lets you
> discard or keep one hunk line at a time.  This is useful if there are
> no unchanged lines in the middle of the hunk, so 's' will not work,
> but you would still like to split it.

Any news on this?  I would greatly appreciate criticism if something
is wrong or inadequate :-)

Thanks,
Thomas

-- 
Thomas Rast
trast@student.ethz.ch
