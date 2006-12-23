From: Robert Fitzsimons <robfitz@273k.net>
Subject: Re: [PATCH 1/3] gitweb: Use rev-list pattern search options.
Date: Sat, 23 Dec 2006 03:46:29 +0000
Message-ID: <20061223034629.GC11474@localhost>
References: <11668449162618-git-send-email-robfitz@273k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Sat Dec 23 04:46:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxxq8-0003Kd-2z
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 04:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWLWDqU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 22:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbWLWDqU
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 22:46:20 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:59834 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbWLWDqT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 22:46:19 -0500
Received: from [194.125.99.166] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1Gxxpr-00072Z-6o; Sat, 23 Dec 2006 03:46:11 +0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <11668449162618-git-send-email-robfitz@273k.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-2, required 7, autolearn=disabled,
	RCVD_IN_NERDS_IE -2.00)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35259>

I forgot the --compose flag on these.

The patch 1 is just a rewrite to take advantage of the native search
support in rev-list, patch 2 and 3 are a slight change in functionality.

Robert
