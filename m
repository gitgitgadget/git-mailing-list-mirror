From: git_user101 <m.aqadjanimemar@student.ru.nl>
Subject: Re: Error: Unable to append to logs/HEAD: Permission denied
Date: Mon, 17 May 2010 01:17:27 -0700 (PDT)
Message-ID: <1274084247216-5064104.post@n2.nabble.com>
References: <1274051912050-5063068.post@n2.nabble.com> <4BF0F63A.1080005@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 17 10:17:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODvW4-0007cQ-UU
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 10:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293Ab0EQIRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 04:17:31 -0400
Received: from kuber.nabble.com ([216.139.236.158]:54445 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998Ab0EQIRa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 04:17:30 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <m.aqadjanimemar@student.ru.nl>)
	id 1ODvVv-0007Pz-7d
	for git@vger.kernel.org; Mon, 17 May 2010 01:17:27 -0700
In-Reply-To: <4BF0F63A.1080005@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147218>


yes!
This is about a shared repository that is allowed to be accessed by its
owner and group.
The group consists of some machine users.
Users have different accounts and modify the git-repository by own account.


-- 
View this message in context: http://git.661346.n2.nabble.com/Error-Unable-to-append-to-logs-HEAD-Permission-denied-tp5063068p5064104.html
Sent from the git mailing list archive at Nabble.com.
