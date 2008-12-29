From: Joe Casadonte <jcasadonte@northbound-train.com>
Subject: Re: git clone - failing on cygwin with git:// but not with ssh://
Date: Mon, 29 Dec 2008 14:54:35 +0000 (UTC)
Message-ID: <loom.20081229T145004-85@post.gmane.org>
References: <ud4fdxn08.fsf@terrapin.northbound-train.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 16:01:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHJcX-00051v-Ps
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 16:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbYL2PAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 10:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbYL2PAG
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 10:00:06 -0500
Received: from main.gmane.org ([80.91.229.2]:35186 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbYL2PAF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 10:00:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LHJb8-0004YM-BY
	for git@vger.kernel.org; Mon, 29 Dec 2008 15:00:02 +0000
Received: from dsl092-238-209.phl1.dsl.speakeasy.net ([66.92.238.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 15:00:02 +0000
Received: from jcasadonte by dsl092-238-209.phl1.dsl.speakeasy.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 15:00:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.92.238.209 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104102>

Joe Casadonte <jcasadonte <at> northbound-train.com> writes:

> The same test machine has cloned from a different linux server via the
> git protocol just fine.
> 
> Any ideas?  Thanks for the help!

Does anyone know of more logging I can try to help diagnose the issue?  Despite
the SSH work-around, this is really hampering me....
