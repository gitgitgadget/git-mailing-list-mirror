From: jidanni@jidanni.org
Subject: Re: timestamps not git-cloned
Date: Fri, 28 Nov 2008 13:06:00 +0800
Message-ID: <87tz9sv3rb.fsf@jidanni.org>
References: <e3f230850811271908g1be6b3f9t3e678081088de06b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: dhruvakm@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 28 06:07:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5vZh-0007VD-Uu
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 06:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbYK1FGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 00:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbYK1FGF
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 00:06:05 -0500
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:43799 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750730AbYK1FGE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Nov 2008 00:06:04 -0500
Received: from jidanni1.jidanni.org (122-127-33-127.dynamic.hinet.net [122.127.33.127])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 6EED0D26D6;
	Thu, 27 Nov 2008 21:06:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101862>

>>>>> "d" == dhruva  <dhruvakm@gmail.com> writes:

d> Also, if you clone from systems across time zones, what time do you
d> expect to set on the files.

I'm just used to tar, cpio, scp -a, rsync -a, ar, etc. using 'date +%s'
seconds internally, so no timezone problem.

I hate it when I get some latest WhizBang.tgz, only to untar it to
find all the files' dates the same, when in fact the README hasn't
been touched in seven years, but you can't tell that from ls -l. I
recall some content tracker was involved.

Of course I'll allowing you to know my delicate first day impressions.
I'm sure as I grow older I will learn the difference between content
tracker and archiver.
