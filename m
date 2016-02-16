From: Cameron W <cameron_w55@outlook.com>
Subject: Git Submodule auto-update
Date: Tue, 16 Feb 2016 01:24:01 +0000 (UTC)
Message-ID: <loom.20160216T022310-849@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 02:30:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVUT2-00071b-P2
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 02:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbcBPBaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 20:30:11 -0500
Received: from plane.gmane.org ([80.91.229.3]:48300 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726AbcBPBaK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 20:30:10 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aVUSs-0006vE-Hx
	for git@vger.kernel.org; Tue, 16 Feb 2016 02:30:07 +0100
Received: from 203.8.18.100 ([203.8.18.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 02:30:06 +0100
Received: from cameron_w55 by 203.8.18.100 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 02:30:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 203.8.18.100 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.97 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286302>

I apologize if this is a dumb or repeated question.

Is there a way to have a submodule automatically 'update' on pull of the 
parent repository, WITHOUT requiring each user/committer to change any 
settings (hooks or git config aliases)?

Ideally, a setting I can change at the repository level and then commit 
and apply to all users who clone the repository.

Thanks. 
