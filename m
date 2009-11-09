From: Dmitry Smirnov <divis1969@gmail.com>
Subject: Re: Git drawbacks?
Date: Mon, 9 Nov 2009 07:53:24 +0000 (UTC)
Message-ID: <loom.20091109T084539-720@post.gmane.org>
References: <loom.20091106T160709-387@post.gmane.org> <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com>  <loom.20091106T180313-750@post.gmane.org> <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com> <alpine.DEB.2.00.0911061051540.3216@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 09 08:53:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7P4T-0007KR-Kn
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 08:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763AbZKIHxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 02:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753668AbZKIHxm
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 02:53:42 -0500
Received: from lo.gmane.org ([80.91.229.12]:54799 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753497AbZKIHxl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 02:53:41 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N7P4M-0007JN-I6
	for git@vger.kernel.org; Mon, 09 Nov 2009 08:53:46 +0100
Received: from 212.92.145.7 ([212.92.145.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 08:53:46 +0100
Received: from divis1969 by 212.92.145.7 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 08:53:46 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.92.145.7 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.27 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132449>

 <david <at> lang.hm> writes:

> going back to the initial poster's comments. if the android repo is 1G, 
> eliminating the history will probably have significantly less impact than 
> you expect it to. 

Do you have 2 or more copies of the same repository at the same time?
If yes, can I skip cloning new copy from network? 
Or even skip cloning it at all? 
Is it possible with Git to chekout into two (few) working trees?
