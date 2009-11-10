From: Dmitry Smirnov <divis1969@gmail.com>
Subject: Re: Git drawbacks?
Date: Tue, 10 Nov 2009 09:08:30 +0000 (UTC)
Message-ID: <loom.20091110T100345-116@post.gmane.org>
References: <loom.20091106T160709-387@post.gmane.org>  <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com>  <loom.20091106T180313-750@post.gmane.org>  <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com>  <alpine.DEB.2.00.0911061051540.3216@asgard.lang.hm>  <loom.20091109T084539-720@post.gmane.org>  <20091109154816.GH27126@dpotapov.dyndns.org>  <loom.20091109T170054-451@post.gmane.org> <28c656e20911091047r353e9451hd856b99541fbd5ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 10:09:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7miq-0002vY-4v
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 10:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbZKJJI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 04:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753222AbZKJJI4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 04:08:56 -0500
Received: from lo.gmane.org ([80.91.229.12]:38445 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257AbZKJJIz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 04:08:55 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N7mib-0002pt-2k
	for git@vger.kernel.org; Tue, 10 Nov 2009 10:08:53 +0100
Received: from 212.92.145.7 ([212.92.145.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 10:08:53 +0100
Received: from divis1969 by 212.92.145.7 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 10:08:53 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.92.145.7 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.27 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132554>

B Smith-Mannschott <bsmith.occs <at> gmail.com> writes:
 
> You don't have to wait to comitting to your own branches, but do make
> sure to run your usual builds and tests before pushing or asking
> another to pull changes from you.

Perhaps, I was not clear in my questions. 
I do not want to build and test to complete before I get back to my stashed
or commited changes. I.e. I need to have 2 working trees (perhaps different, but 
from the same repository): one for build/test and one for another task.

Dmitry
