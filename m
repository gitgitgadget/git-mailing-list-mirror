From: =?UTF-8?Q?Ma=C3=AFeul?= <maieul@maieul.net>
Subject: Merging one file only
Date: Sun, 21 Aug 2011 13:33:39 -0700 (PDT)
Message-ID: <1313958819073-6709333.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 21 22:34:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvEiv-0006Z5-Hr
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 22:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453Ab1HUUdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 16:33:39 -0400
Received: from sam.nabble.com ([216.139.236.26]:40087 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689Ab1HUUdj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 16:33:39 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <maieul@maieul.net>)
	id 1QvEiB-0001Ja-3Y
	for git@vger.kernel.org; Sun, 21 Aug 2011 13:33:39 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179811>

Hello,

my problem is :
- I have 2 branches : "master" and "sty"
- In the branch sty, I have commit that i don't want to merge on the branch
master. The only file that I want merge are the *dtx files.

My question is : how can i do to merge *dtx files from "sty" to "master", 
and have log of commit on the *dtx ? Is it possible ?

Thank a lot !!



--
View this message in context: http://git.661346.n2.nabble.com/Merging-one-file-only-tp6709333p6709333.html
Sent from the git mailing list archive at Nabble.com.
