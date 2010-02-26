From: Steve Folly <steve@spfweb.co.uk>
Subject: Retrospectively add alternates to a repository?
Date: Fri, 26 Feb 2010 23:54:07 +0000 (UTC)
Message-ID: <loom.20100227T004822-959@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 00:54:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlA0o-0001x6-8g
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 00:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966601Ab0BZXyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 18:54:21 -0500
Received: from lo.gmane.org ([80.91.229.12]:52967 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966469Ab0BZXyU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 18:54:20 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NlA0h-0001tk-9l
	for git@vger.kernel.org; Sat, 27 Feb 2010 00:54:19 +0100
Received: from cpc1-haye16-0-0-cust629.haye.cable.virginmedia.com ([92.234.82.118])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 00:54:19 +0100
Received: from steve by cpc1-haye16-0-0-cust629.haye.cable.virginmedia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 00:54:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 92.234.82.118 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_2; en-gb) AppleWebKit/531.21.8 (KHTML, like Gecko) Version/4.0.4 Safari/531.21.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141161>

Hi,

I have a local mirror of a remote repository (to save time
cloning over a slow network).  But before I created the
local mirror I already cloned the remote repo directly.

Is it possible to retrospectively add an alternates spec
to this local repository (the equivalent of doing what 
--reference does during the clone)?

Thanks for any help.

Regards,
Steve
