From: hs_glw <greg@hra.net>
Subject: Re: Big Mess--How to use Git to resolve
Date: Sat, 17 Dec 2011 10:40:47 -0800 (PST)
Message-ID: <1324147247781-7104493.post@n2.nabble.com>
References: <1324125130643-7103964.post@n2.nabble.com> <86iplf2oy5.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 19:40:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbzBm-0006dj-Ad
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 19:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648Ab1LQSkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 13:40:49 -0500
Received: from sam.nabble.com ([216.139.236.26]:53013 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398Ab1LQSks (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 13:40:48 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <greg@hra.net>)
	id 1RbzBf-0002WX-PQ
	for git@vger.kernel.org; Sat, 17 Dec 2011 10:40:47 -0800
In-Reply-To: <86iplf2oy5.fsf@red.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187388>

Randal, thank you for the comprehensive answer.  I have one follow-up:  we
have the working files, then in our installation files we have .PL files
that are worked on by some iteration of "make" to insert paths both into
.cgi files and config files, should these installation files be setup as a
branch? or is there a more correct way of implementing this?

--
View this message in context: http://git.661346.n2.nabble.com/Big-Mess-How-to-use-Git-to-resolve-tp7103964p7104493.html
Sent from the git mailing list archive at Nabble.com.
