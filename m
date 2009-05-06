From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH 1/2] Allow monitor/unintersting objects to be null
Date: Wed, 6 May 2009 23:10:12 +0200
Message-ID: <200905062310.12895.robin.rosenberg.lists@dewire.com>
References: <1241642224-6914-1-git-send-email-alex.blewitt@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: Alex Blewitt <alex.blewitt@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 23:10:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1oNq-0004jd-9n
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 23:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697AbZEFVKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 17:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754669AbZEFVKV
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 17:10:21 -0400
Received: from mail.dewire.com ([83.140.172.130]:25487 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752248AbZEFVKU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 17:10:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 36C6614A8B58;
	Wed,  6 May 2009 23:10:15 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I+DOmflZ-JjO; Wed,  6 May 2009 23:10:14 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id CD03F149167C;
	Wed,  6 May 2009 23:10:14 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1241642224-6914-1-git-send-email-alex.blewitt@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118390>


Besides all comments by Shawn. Please set the prefix to EGIT PATCH or JGIT PATCH
so the C Git people that are not interested in JGit know this isn't for them.

If you add this to your .git/config you will get the prefix automagically when generating
the patches.

[format]
        subjectprefix = EGIT PATCH

-- robin
