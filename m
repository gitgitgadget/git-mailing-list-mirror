From: Eric Raible <raible+git@gmail.com>
Subject: Re: git am from scratch
Date: Thu, 19 Mar 2009 16:16:10 +0000 (UTC)
Message-ID: <loom.20090319T161324-959@post.gmane.org>
References: <200903191609.24812.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 17:20:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkKxh-0005Ni-62
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 17:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbZCSQQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 12:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753391AbZCSQQ7
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 12:16:59 -0400
Received: from main.gmane.org ([80.91.229.2]:44325 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206AbZCSQQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 12:16:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LkKuv-0000vs-Ra
	for git@vger.kernel.org; Thu, 19 Mar 2009 16:16:56 +0000
Received: from adsl-75-24-106-84.dsl.pltn13.sbcglobal.net ([adsl-75-24-106-84.dsl.pltn13.sbcglobal.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 16:16:25 +0000
Received: from raible+git by adsl-75-24-106-84.dsl.pltn13.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 16:16:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 75.24.106.84 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.48 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113789>

Andreas Gruenbacher <agruen <at> suse.de> writes:

> When the first commit is added by hand instead, git am will import the rest 

Or:
git init && git commit --allow-empty -m'initial'
