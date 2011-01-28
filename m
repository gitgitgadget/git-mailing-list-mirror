From: vikram2rhyme <vikram2rhyme@gmail.com>
Subject: Why git tags are there in git?
Date: Fri, 28 Jan 2011 03:37:56 -0800 (PST)
Message-ID: <1296214676536-5969544.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 28 12:38:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pimeb-0001Vs-8R
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 12:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885Ab1A1Lh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 06:37:57 -0500
Received: from sam.nabble.com ([216.139.236.26]:42093 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963Ab1A1Lh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 06:37:57 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <vikram2rhyme@gmail.com>)
	id 1PimeK-0004Bf-Hl
	for git@vger.kernel.org; Fri, 28 Jan 2011 03:37:56 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165610>


Hello friends
I am wondering why the tags are there in git. As they are just pointer to
the commit
we can refer those commit by SHA sum only then why tagging? Moreover a
commit can
be tagged more than once that result in multiple tags pointing to the same
point in the history.
Is this a design flaw?
-- 
View this message in context: http://git.661346.n2.nabble.com/Why-git-tags-are-there-in-git-tp5969544p5969544.html
Sent from the git mailing list archive at Nabble.com.
