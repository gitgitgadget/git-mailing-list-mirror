From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: timestamps not git-cloned
Date: Sat, 29 Nov 2008 10:22:31 +0100
Message-ID: <20081129092231.GA32630@cuci.nl>
References: <e3f230850811271908g1be6b3f9t3e678081088de06b@mail.gmail.com> <87tz9sv3rb.fsf@jidanni.org> <20081129085406.GA20428@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jidanni@jidanni.org, dhruvakm@gmail.com, git@vger.kernel.org
To: Chris Frey <cdfrey@foursquare.net>
X-From: git-owner@vger.kernel.org Sat Nov 29 10:33:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6MCI-0008NW-7z
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 10:33:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbYK2Jbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 04:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbYK2Jbo
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 04:31:44 -0500
Received: from aristoteles.cuci.nl ([212.125.128.18]:44166 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbYK2Jbn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 04:31:43 -0500
X-Greylist: delayed 551 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Nov 2008 04:31:43 EST
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 619565465; Sat, 29 Nov 2008 10:22:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081129085406.GA20428@foursquare.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101901>

Chris Frey wrote:
>On Fri, Nov 28, 2008 at 01:06:00PM +0800, jidanni@jidanni.org wrote:
>> I hate it when I get some latest WhizBang.tgz, only to untar it to
>> find all the files' dates the same, when in fact the README hasn't
>> been touched in seven years, but you can't tell that from ls -l. I
>> recall some content tracker was involved.

>If this is the important bit, perhaps git-archive could be changed
>to create tarballs with file timestamps based on their commit dates.

Based on the principle of least surprise, I'd consider this a rather good
idea.
-- 
Sincerely,
           Stephen R. van den Berg.

To people that say "I could care less" - well, why don't you?
