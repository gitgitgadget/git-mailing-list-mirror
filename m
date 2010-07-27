From: Alex <ajb44.geo@yahoo.com>
Subject: Re: question (possibly) on git subtree/submodules
Date: Tue, 27 Jul 2010 10:56:22 +0000 (UTC)
Message-ID: <loom.20100727T125434-697@post.gmane.org>
References: <xotjlj92i9gr.fsf@leonardo.pit.corp.google.com> <4C49C9C6.3080409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 27 12:56:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odhpu-0003zf-Uv
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 12:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756096Ab0G0K4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 06:56:34 -0400
Received: from lo.gmane.org ([80.91.229.12]:33878 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755664Ab0G0K4d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 06:56:33 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Odhpm-0003vf-Gb
	for git@vger.kernel.org; Tue, 27 Jul 2010 12:56:30 +0200
Received: from no-reverse.redstone-isp.net ([127.0.0.1])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 12:56:30 +0200
Received: from ajb44.geo by no-reverse.redstone-isp.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 12:56:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.44.20.129 (Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151932>

Chris Packham <judge.packham <at> gmail.com> writes:

> The short answer is no. Nothing git has currently will let you clone a
> subset of files. 

Isn't that what 'sparse checkout' does?
(http://www.kernel.org/pub/software/scm/git/docs/git-read-tree.html#_sparse_checkout)

Alex
