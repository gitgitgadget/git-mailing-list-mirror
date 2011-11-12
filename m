From: Jvsrvcs <jvsrvcs@gmail.com>
Subject: Where to put a git repo?
Date: Fri, 11 Nov 2011 16:03:18 -0800 (PST)
Message-ID: <1321056198289-6987137.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 01:06:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RP171-0001ou-Oi
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 01:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554Ab1KLADT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 19:03:19 -0500
Received: from sam.nabble.com ([216.139.236.26]:59481 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760Ab1KLADT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 19:03:19 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <jvsrvcs@gmail.com>)
	id 1RP142-0004JX-9Y
	for git@vger.kernel.org; Fri, 11 Nov 2011 16:03:18 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185294>


We are in the process of setting up a git repo on a Windows 2003 box.
(For speed, we need our build box and git repo on the same machine and build
will not work on Linux as a result of the Installer software we are married
to at the moment).

Using cygwin, where would be the best place (windows path) to put a git
repo?

Is there a convention typically used on Linux system as to where to put the
repo (path)?

We simply want to follow the convention if there is any.

--
View this message in context: http://git.661346.n2.nabble.com/Where-to-put-a-git-repo-tp6987137p6987137.html
Sent from the git mailing list archive at Nabble.com.
