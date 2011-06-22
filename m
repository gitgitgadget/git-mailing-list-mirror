From: sandy2010 <sandeeptt@yahoo.com>
Subject: Re: Migration from CVS to GIT - Multiple directories in CVS repo to
 a single Git repo
Date: Wed, 22 Jun 2011 03:21:27 -0700 (PDT)
Message-ID: <1308738087757-6503654.post@n2.nabble.com>
References: <1308733591425-6503493.post@n2.nabble.com> <4E01B44C.7090003@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 12:21:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZKYv-0003Wa-Mm
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 12:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756158Ab1FVKV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 06:21:29 -0400
Received: from sam.nabble.com ([216.139.236.26]:48255 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837Ab1FVKV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 06:21:28 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <sandeeptt@yahoo.com>)
	id 1QZKYp-0001ns-Oh
	for git@vger.kernel.org; Wed, 22 Jun 2011 03:21:27 -0700
In-Reply-To: <4E01B44C.7090003@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176231>

I did not understand when you say "Make a single repository out of them
first". You mean single Git repository? Infact, my requirement is same. Can
I have a single git repository "/git/Testsuites" which will contain suite1
and suite2 directories? Provided suite1 and suite2 are no git repositories.

--
View this message in context: http://git.661346.n2.nabble.com/Migration-from-CVS-to-GIT-Multiple-directories-in-CVS-repo-to-a-single-Git-repo-tp6503493p6503654.html
Sent from the git mailing list archive at Nabble.com.
