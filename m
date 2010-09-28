From: Tuomo <tuo.tie@gmail.com>
Subject: Another way to compare tools: is it possible to transfer full history?
Date: Tue, 28 Sep 2010 13:44:53 +0000 (UTC)
Message-ID: <loom.20100928T153519-936@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 15:50:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0aZS-0000bA-Ni
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 15:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817Ab0I1NuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 09:50:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:54312 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753131Ab0I1NuF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 09:50:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P0aZI-0000WK-3o
	for git@vger.kernel.org; Tue, 28 Sep 2010 15:50:04 +0200
Received: from esprx02x.nokia.com ([192.100.124.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 15:50:04 +0200
Received: from tuo.tie by esprx02x.nokia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 15:50:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 192.100.124.219 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.8) Gecko/20100722 Firefox/3.6.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157423>

I have seen lots of comparisons between source control tools, 
but have not found a comparison that would explain the fundamental differences 
and similarities in a way that would really let me choose. 
So I decided to try a new approach: if one tries to transfer the full history 
of an application or a larger product/project, which features can I rely on 
finding in any decently recent tool?

Let's start from Git vs. Mercurial: is it possible to move the whole history 
of an application (with or without submodules) from Git to Mercurial? 
From Mercurial to Git? 
If it is not always possible, what is the feature that might completely 
prevent the whole attempt? If partial transfer is possible, what information 
might be missing in the result?

I am not interested in whether it is easy or fast in practice. 
I am only interested in the concepts and finding equivalent classes 
for the tools or at least their core concepts.
