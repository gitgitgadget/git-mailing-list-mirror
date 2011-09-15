From: Stephen Bash <bash@genarts.com>
Subject: Re: vcs-svn and friends
Date: Thu, 15 Sep 2011 10:06:36 -0400 (EDT)
Message-ID: <27874151.17649.1316095596748.JavaMail.root@mail.hq.genarts.com>
References: <CAFfmPPOBZ6cXG51mDHbj2VRDzjvH46Q7=_LvUWeMq0SGR40S1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: David Michael Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 16:06:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4CaX-0002Yu-C1
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 16:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755957Ab1IOOGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 10:06:44 -0400
Received: from hq.genarts.com ([173.9.65.1]:7002 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752757Ab1IOOGo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 10:06:44 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id B274315C8002;
	Thu, 15 Sep 2011 10:06:42 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qpD9pNuXujvV; Thu, 15 Sep 2011 10:06:36 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id C922D15C8001;
	Thu, 15 Sep 2011 10:06:36 -0400 (EDT)
In-Reply-To: <CAFfmPPOBZ6cXG51mDHbj2VRDzjvH46Q7=_LvUWeMq0SGR40S1g@mail.gmail.com>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181468>

----- Original Message -----
> From: "David Michael Barr" <davidbarr@google.com>
> Sent: Wednesday, September 14, 2011 9:53:53 PM
> Subject: Fwd: vcs-svn and friends
> 
> Thanks to the work of Dmitry, we now have a simple front-end
> that exercises the yet unmerged changes to vcs-svn that Jonathan
> and I authored a few months ago.

For those of us interested but out of the loop, does this mean you have a working example where I can point it at a SVN repo and see what happens?  Having done our SVN to Git conversion last year, I know our repo has a lot of the common SVN screw cases (non-branching copies, partial merges, mis-merges, *lots* of retagging, changes committed to tags, etc.) so if it's relatively easy to setup a test I'm happy to run one.

Thanks,
Stephen
