From: Brock Peabody <brock.peabody@gmail.com>
Subject: Re: help with distributed workflow/signoff
Date: Wed, 14 Jul 2010 17:49:42 +0000 (UTC)
Message-ID: <loom.20100714T193832-914@post.gmane.org>
References: <loom.20100714T180615-173@post.gmane.org> <20100714171614.GA2799@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 14 19:50:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ65z-0007hh-UT
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 19:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756870Ab0GNRuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 13:50:05 -0400
Received: from lo.gmane.org ([80.91.229.12]:32991 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754508Ab0GNRuD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 13:50:03 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OZ65h-0007Vn-7s
	for git@vger.kernel.org; Wed, 14 Jul 2010 19:49:54 +0200
Received: from proxy-ny2.bloomberg.com ([199.172.169.87])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 19:49:53 +0200
Received: from brock.peabody by proxy-ny2.bloomberg.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 19:49:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 199.172.169.87 (Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.6) Gecko/20100625 Firefox/3.6.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151023>

Hi Jonathan,

Thanks for your quick, informative response.  This is the information I was
hoping to get - how the tool is used by its primary audience.  It's going to
take me a while to fully absorb it, but I suspect (as Avery points out in his
reply) that this type of workflow is less workable when there are fewer
reviewers and more patches, most of which are accepted as-is.

Nevertheless, I want to make sure that we keep in mind the way the tool is meant
to be used when choosing our new workflow, rather than trying to force it into a
mold inspired by svn.  It would probably do us no harm to be forced to have
fewer, more well considered patches.

Cheers,
Brock
