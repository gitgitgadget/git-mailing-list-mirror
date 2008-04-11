From: Heikki Orsila <shdl@zakalwe.fi>
Subject: Re: [PATCH] Add two core.sharedRepository options: group-readable and world-readable
Date: Fri, 11 Apr 2008 17:41:18 +0300
Message-ID: <20080411144118.GA31039@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 16:42:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkKS5-0000Jg-Sf
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 16:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759208AbYDKOlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 10:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758503AbYDKOlT
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 10:41:19 -0400
Received: from zakalwe.fi ([80.83.5.154]:53988 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758114AbYDKOlT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 10:41:19 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 6FCAB2C331; Fri, 11 Apr 2008 17:41:18 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79276>

Sorry, this is not a proper reply to my previous mail. I just subscribed 
to the list.

I want to add this patch was a replacement for an earlier one. See

	[PATCH] Add two core.sharedRepository options: group-readable
	and world-readable
	http://marc.info/?l=git&m=120792433430899&w=2
and
	[PATCH] Add core.sharedRepository == read-only-group
	http://marc.info/?l=git&m=120777054707525&w=2

'read-only-group' was renamed to 'group-readable', and 'world-readable' 
option was added, as per comments of Bjorn Steinbrick.

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
