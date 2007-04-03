From: Jamie Border <jborder@gmail.com>
Subject: StGit patchname numeric prefix?
Date: Tue, 03 Apr 2007 12:49:36 +0100
Message-ID: <87odm5r833.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 14:30:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYi9Z-0005Aj-Sd
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 14:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965584AbXDCMaM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 08:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965573AbXDCMaL
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 08:30:11 -0400
Received: from public2-cosh5-6-cust175868.cosh.static.ntl.com ([80.6.88.252]:29670
	"EHLO jamieb-laptop.bellfruit.local" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S965558AbXDCMaK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Apr 2007 08:30:10 -0400
X-Greylist: delayed 2429 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Apr 2007 08:30:09 EDT
Received: from jamieb by jamieb-laptop.bellfruit.local with local (Exim 4.63)
	(envelope-from <jborder@gmail.com>)
	id 1HYhW4-0004Tq-FB
	for git@vger.kernel.org; Tue, 03 Apr 2007 12:49:36 +0100
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.0 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43621>

Hello.

Is there a switch to have stgit prepend a numeric prefix to the patch name?

I'm trying to stg uncommit -n <large_number> from a repository, and due to the excellent log messages, half of the patches get called 'empty-log-message'.

I'm sure when I played with stg a while ago I found a switch to do that.

I'm probably wrong, though.

Cheers

Jamie
