From: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
Subject: Re: git reset --hard w/o touching every file
Date: Sat, 01 Nov 2008 16:03:50 -0400
Message-ID: <geicn8$ss8$1@ger.gmane.org>
References: <gegn38$lku$1@ger.gmane.org> <20081101110529.GC3819@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 01 21:05:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwMin-0008KA-KX
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 21:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbYKAUEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 16:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbYKAUEF
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 16:04:05 -0400
Received: from main.gmane.org ([80.91.229.2]:43939 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930AbYKAUEE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 16:04:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KwMhT-0005P9-9Q
	for git@vger.kernel.org; Sat, 01 Nov 2008 20:03:59 +0000
Received: from lily.mit.edu ([18.243.2.157])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 20:03:59 +0000
Received: from edwardzyang by lily.mit.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 20:03:59 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: lily.mit.edu
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20081101110529.GC3819@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99768>

Pierre Habouzit wrote:
> git checkout HEAD -- <list of the files>

What if I do not know a priori which files *do* need to be updated? Is
there a command that I can get this information from? Also, I may not
necessarily be checking out HEAD.
