From: gbhumphrey <greg_spam@gbhumphrey.com>
Subject: git log decipher
Date: Wed, 20 Jul 2011 18:39:11 -0700 (PDT)
Message-ID: <1311212351172-6605124.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 21 03:39:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjiEP-00042i-TU
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 03:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724Ab1GUBjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 21:39:12 -0400
Received: from sam.nabble.com ([216.139.236.26]:33790 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531Ab1GUBjM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 21:39:12 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <greg_spam@gbhumphrey.com>)
	id 1QjiEJ-0007hV-6D
	for git@vger.kernel.org; Wed, 20 Jul 2011 18:39:11 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177571>

Hi so in the .git/logs/refs/heads there are log files, i'm tryign to decipher
the timestamp, at least I think it's a time stamp. An entry looks like this:
a391d7a96af8c06a626eec23565ceccef81bc350
fdfb6d8c87521d56d8a6034e8575304013ecdd6c Greg Humphrey &lt;XXX@XXXX.com&gt;
1307594233 -0700	merge US199: Merge made by recursive.

The "1307594233 -0700" seems to be a timestamp, but I'm not sure what
format, anyone have any ideas how to convert to a human readable?



--
View this message in context: http://git.661346.n2.nabble.com/git-log-decipher-tp6605124p6605124.html
Sent from the git mailing list archive at Nabble.com.
