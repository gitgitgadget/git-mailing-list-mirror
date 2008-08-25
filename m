From: Eric Raible <raible@gmail.com>
Subject: Re: [PATCH] Add a reference to gitk localbranc remote/branch in gittutorial
Date: Mon, 25 Aug 2008 20:12:03 +0000 (UTC)
Message-ID: <loom.20080825T200956-169@post.gmane.org>
References: <20080825215023.11822a20@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 25 22:13:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXiRB-0006HD-SA
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 22:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754387AbYHYUMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 16:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753996AbYHYUMN
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 16:12:13 -0400
Received: from main.gmane.org ([80.91.229.2]:60714 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753206AbYHYUMM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 16:12:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KXiQ7-0001QT-Az
	for git@vger.kernel.org; Mon, 25 Aug 2008 20:12:11 +0000
Received: from 12.96.234.114 ([12.96.234.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 20:12:11 +0000
Received: from raible by 12.96.234.114 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 20:12:11 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.96.234.114 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.1) Gecko/2008070208 Firefox/3.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93665>

Paolo Ciarrocchi <paolo.ciarrocchi <at> gmail.com> writes:

> +Alice can also use gitk to browse that Bob did:

s/that/what/ ?

> +------------------------------------------------
> +alice$ gitk master origin/master
> +------------------------------------------------

I think that you meant:

alice$ gitk master..origin/master

right?
