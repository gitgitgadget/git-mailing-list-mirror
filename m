From: Carlo <mr.spoon21@gmail.com>
Subject: Git for collaborative web development
Date: Thu, 26 Mar 2009 18:51:18 +0000 (UTC)
Message-ID: <loom.20090326T184207-345@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 19:56:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmukt-0006hX-RE
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 19:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758255AbZCZSzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 14:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758039AbZCZSzH
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 14:55:07 -0400
Received: from main.gmane.org ([80.91.229.2]:45079 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757494AbZCZSzG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 14:55:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LmujH-00074e-26
	for git@vger.kernel.org; Thu, 26 Mar 2009 18:55:03 +0000
Received: from 89-97-102-218.ip17.fastwebnet.it ([89.97.102.218])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 18:55:03 +0000
Received: from mr.spoon21 by 89-97-102-218.ip17.fastwebnet.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 18:55:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 89.97.102.218 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.7) Gecko/2009030422 Ubuntu/8.04 (hardy) Firefox/3.0.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114809>

Hi,
I'm going to work on a web project with a friend. We will host our code on a
server and my idea was to set up a git repository (maybe using gitosis) so that
we could work on our machines and push the changes to the server.

He said that it would be complicated, because if he's going to try some changes
to show me on the fly he just can't. I mean, he would like to work on the code
directly on the server, so that he can change the code, save and I can just
refresh the page from my browser and see what he did.

Using git he should save, commit, add, push... so it's a bit longer.

Is there a nice compromise? Or a better way to use git for such a task or web
development in general?

Thanks for your help,
bye.
