From: Kazuki Tsujimoto <kazuki@callcc.net>
Subject: Re: [BUG] realloc failed
Date: Fri, 27 May 2011 22:59:15 +0900
Message-ID: <20110527225913.075B.BA9123DE@callcc.net>
References: <7v8vtyy1ft.fsf@alter.siamese.dyndns.org> <7v4o4my11c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 15:59:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPxZN-0002hS-3E
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 15:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628Ab1E0N7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 09:59:12 -0400
Received: from callcc.net ([173.230.149.188]:47762 "EHLO mx01.callcc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794Ab1E0N7L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 09:59:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx01.callcc.net (Postfix) with ESMTP id C76B026B18
	for <git@vger.kernel.org>; Fri, 27 May 2011 22:59:10 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at callcc.net
Received: from mx01.callcc.net ([127.0.0.1])
	by localhost (mx01.callcc.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SzxndJIozUxW for <git@vger.kernel.org>;
	Fri, 27 May 2011 22:59:10 +0900 (JST)
Received: from [192.168.0.128] (p6eb203.tkyoac00.ap.so-net.ne.jp [218.110.178.3])
	by mx01.callcc.net (Postfix) with ESMTPSA id 36F87266C2
	for <git@vger.kernel.org>; Fri, 27 May 2011 22:59:10 +0900 (JST)
In-Reply-To: <7v4o4my11c.fsf@alter.siamese.dyndns.org>
X-Mailer: Becky! ver. 2.56.04 [ja]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174622>

Subject: Re: [BUG] realloc failed
From: Junio C Hamano <gitster@pobox.com>
Date: Sun, 22 May 2011 12:34:14 -0700

> Just for your future reference.
> ...snip...

Thanks for useful information, and reviewing the patch.
I got it.

-- 
Kazuki Tsujimoto
