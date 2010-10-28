From: longphant <longphant@yahoo.com>
Subject: Re: How git detects changes during commit?
Date: Thu, 28 Oct 2010 10:23:57 -0700 (PDT)
Message-ID: <1288286637497-5683536.post@n2.nabble.com>
References: <1288211811436-5680208.post@n2.nabble.com> <20101027205441.GA8242@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 28 19:24:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBWCt-0005z1-Ri
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 19:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934022Ab0J1RX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 13:23:59 -0400
Received: from kuber.nabble.com ([216.139.236.158]:48723 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933999Ab0J1RX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 13:23:58 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <longphant@yahoo.com>)
	id 1PBWCj-0002X7-GH
	for git@vger.kernel.org; Thu, 28 Oct 2010 10:23:57 -0700
In-Reply-To: <20101027205441.GA8242@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160188>


Thanks, that is a lot of help. I am a complete noob to version control, so I
was wondering if you could give me a noobie tutorial of how it works. Does
git lstat each file that is committed and then check the time of last
modification? Or does it lstat the directory?
-- 
View this message in context: http://git.661346.n2.nabble.com/How-git-detects-changes-during-commit-tp5680208p5683536.html
Sent from the git mailing list archive at Nabble.com.
