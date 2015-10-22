From: Kannan Goundan <kannan@cakoose.com>
Subject: Re: Make
Date: Thu, 22 Oct 2015 23:46:28 +0000 (UTC)
Message-ID: <loom.20151023T013752-72@post.gmane.org>
References: <loom.20151016T001449-848@post.gmane.org> <xmqq7fmnhg4x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 23 01:47:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpPZd-000539-Co
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 01:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966049AbbJVXrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 19:47:03 -0400
Received: from plane.gmane.org ([80.91.229.3]:43643 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966010AbbJVXqp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 19:46:45 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZpPZ8-0004TW-KK
	for git@vger.kernel.org; Fri, 23 Oct 2015 01:46:39 +0200
Received: from 205.189.0.114 ([205.189.0.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Oct 2015 01:46:38 +0200
Received: from kannan by 205.189.0.114 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Oct 2015 01:46:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 205.189.0.114 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:41.0) Gecko/20100101 Firefox/41.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280079>

Thanks for the explanation.  I didn't realize some projects don't want to
initialize all their submodules, but the explicit opt-in idea you described
sounds nice.

I've seen cases where people will financially "sponsor" feature development
in open source projects.  Is there any precedent for this in the Git
project?  Is it ok to use this mailing list to ask about such things?
