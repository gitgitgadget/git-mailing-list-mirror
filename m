From: Valentin Haenel <valentin@fsfe.org>
Subject: [QUESTION] '--color-words' for 'git add -p'?
Date: Fri, 29 Apr 2011 18:42:10 +0200
Message-ID: <20110429164210.GA14937@kudu.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git-List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 18:47:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFqr2-0001M8-Lp
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 18:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760156Ab1D2Qrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 12:47:39 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:47644 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757732Ab1D2Qrj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 12:47:39 -0400
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Apr 2011 12:47:39 EDT
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p3TGgAlP020385
	for <git@vger.kernel.org>; Fri, 29 Apr 2011 18:42:10 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p3TGgAjY020384
	for git@vger.kernel.org; Fri, 29 Apr 2011 18:42:10 +0200
X-Authentication-Warning: kudu.in-berlin.de: esc set sender to valentin@fsfe.org using -f
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172472>

Hi,

is it possible to use some kind of magic to get 'git add -p' to display
diff with '--color-words' option? I tried GIT_DIFF_OPTS but w/o success.

thx

V-
