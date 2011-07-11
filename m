From: frankkany <frankkany@gmail.com>
Subject: git remote show origin (URL)
Date: Mon, 11 Jul 2011 09:08:25 -0700 (PDT)
Message-ID: <1310400505376-6571492.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 18:08:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgJ28-0002wo-Ab
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 18:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757959Ab1GKQI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 12:08:27 -0400
Received: from sam.nabble.com ([216.139.236.26]:58424 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653Ab1GKQI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 12:08:26 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <frankkany@gmail.com>)
	id 1QgJ21-00070X-CW
	for git@vger.kernel.org; Mon, 11 Jul 2011 09:08:25 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176860>

On box (A), when using "git remote show origin", I'm used to seeing something
like the following next to the FETCH/PUSH URL:
"git@somegitrepo.com:somefolder/someproject.git"

The URL is actually pingable.

On box (B), when using "git remote show origin" on an unfamiliar project,
the FETCH/PUSH URL is: "hidden-repos:repositories/mysteryproject.git".

How can I find where the actual url/directory where "hidden-repos" is
pointing?

Thanks,

Frank




--
View this message in context: http://git.661346.n2.nabble.com/git-remote-show-origin-URL-tp6571492p6571492.html
Sent from the git mailing list archive at Nabble.com.
