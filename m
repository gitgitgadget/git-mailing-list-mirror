From: Robert Fitzsimons <robfitz@273k.net>
Subject: Re: [PATCH 3/3] gitweb: Allow search to be disabled from the config file.
Date: Sat, 23 Dec 2006 12:28:41 +0000
Message-ID: <20061223122841.GD11474@localhost>
References: <11668449162618-git-send-email-robfitz@273k.net> <11668449271631-git-send-email-robfitz@273k.net> <11668449274162-git-send-email-robfitz@273k.net> <emiomr$f4m$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 13:29:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy5zj-00065j-3g
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 13:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbWLWM2q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 07:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753526AbWLWM2q
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 07:28:46 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:50867 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbWLWM2q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 07:28:46 -0500
Received: from [194.125.99.166] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1Gy5zI-0004X9-Sw; Sat, 23 Dec 2006 12:28:29 +0000
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <emiomr$f4m$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35313>

> I'm not sure if it is worth disabling such not demanding in resources
> (contrary to pickaxe, blame and to some extent snapshot). Perhaps it would
> be better to simply paginate search result, like "history" view got
> paginated?

Yes that makes sense.  I'll withdraw this patch and try and come up with
a new one which can paginate search results.

Robert
