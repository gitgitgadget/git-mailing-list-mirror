From: Nikos Chantziaras <realnc@arcor.de>
Subject: "exclude" and ".gitignore" for everyone
Date: Mon, 01 Jun 2009 16:46:32 +0300
Organization: Lucas Barks
Message-ID: <h00m32$gs0$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 15:50:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB7tz-0001ve-2E
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 15:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbZFANuC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 09:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbZFANuB
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 09:50:01 -0400
Received: from main.gmane.org ([80.91.229.2]:52303 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752706AbZFANuB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 09:50:01 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MB7tr-0003Ul-91
	for git@vger.kernel.org; Mon, 01 Jun 2009 13:50:03 +0000
Received: from athedsl-388897.home.otenet.gr ([79.131.71.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Jun 2009 13:50:03 +0000
Received: from realnc by athedsl-388897.home.otenet.gr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Jun 2009 13:50:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: athedsl-388897.home.otenet.gr
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120468>

Hello.

I'm a first-time Git user.  I found out how to ignore files with Git. 
For example I've put "*.[oa]" and "*~" in ./git/info/exclude.  However, 
the rest of the persons doing commits in the public repository might not 
have those entries.  Is everyone required to put those entries in 
"exclude" themselves or does Git allow for those to be automatically 
added next time they do a "git pull"?
