From: Michail Anastasopoulos <manast@gmx.de>
Subject: Git for Product Line Engineering
Date: Thu, 8 Jan 2009 09:01:46 +0000 (UTC)
Message-ID: <loom.20090108T085342-994@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 10:07:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKqqi-00037Q-0l
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 10:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016AbZAHJFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 04:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753956AbZAHJFK
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 04:05:10 -0500
Received: from main.gmane.org ([80.91.229.2]:41552 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753563AbZAHJFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 04:05:03 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LKqp4-0003de-FF
	for git@vger.kernel.org; Thu, 08 Jan 2009 09:05:02 +0000
Received: from pax.iese.fraunhofer.de ([153.96.133.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Jan 2009 09:05:02 +0000
Received: from manast by pax.iese.fraunhofer.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Jan 2009 09:05:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 153.96.133.33 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5 (.NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104903>

Hello,
I was wondering if anyone of you has applied git to manage the evolution of a
product line. In such a context management of software reuse and permanent
variation becomes necessary.

I think that the distributed character of git as well the easier handling of
branches could be very beneficial in such a context.

Yet I was wondering how the relations between reusable and reused things could
be managed?

If for example I am the maintainer of a library in a product line context I want
to know who pulls from me and whether my library had to undergo any
product-specific changes in any of the other repositories that belong to my
product line.

Regards,
Michalis
