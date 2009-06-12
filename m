From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (Jun 2009, #01; Fri, 12)
Date: Fri, 12 Jun 2009 16:19:01 +0200
Message-ID: <4A3263D5.7030704@drmicha.warpmail.net>
References: <7v1vppbyud.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 16:20:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF7by-0007Ff-8D
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 16:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757010AbZFLOT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 10:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754550AbZFLOT5
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 10:19:57 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:58399 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756592AbZFLOT4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jun 2009 10:19:56 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id CA856360268;
	Fri, 12 Jun 2009 10:19:57 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 12 Jun 2009 10:19:57 -0400
X-Sasl-enc: 7SvDAmTqgAlnH/g6yYymea6SMxRwkqzEwF5xordAJn4Q 1244816397
Received: from localhost.localdomain (p5485995C.dip0.t-ipconnect.de [84.133.153.92])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 21A5A18DCB;
	Fri, 12 Jun 2009 10:19:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090609 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7v1vppbyud.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121424>

Junio C Hamano venit, vidit, dixit 12.06.2009 11:11:

> * mg/pushurl (Tue Jun 9 18:01:38 2009 +0200) 5 commits
>  - builtin-remote: Make "remote -v" display push urls
>  - builtin-remote: Show push urls as well
>  - technical/api-remote: Describe new struct remote member pushurl
>  - t5516: Check pushurl config setting
>  - Allow push and fetch urls to be different
> 
> Will merge to 'next' soon.

I'll rewrite the commit message of 5/5 as we discussed. Sorry for the
lag, I'm in the middle of switching from Fedora 10 to 11 (while being
sick for other reasons) ...

Michael
