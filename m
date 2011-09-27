From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: "Resetting" a repository
Date: Tue, 27 Sep 2011 09:22:11 -0700
Message-ID: <861uv27y6k.fsf@red.stonehenge.com>
References: <4E81EAA7.5030708@myword.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitlist <gitlist@myword.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 27 18:22:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8aQn-0002re-IH
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 18:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487Ab1I0QWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 12:22:49 -0400
Received: from lax-gw06.mailroute.net ([199.89.0.106]:44335 "EHLO
	mail.mroute.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751398Ab1I0QWs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 12:22:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by lax-gw06.mroute.net (Postfix) with ESMTP id 2DB5FC653;
	Tue, 27 Sep 2011 16:22:36 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by lax-gw06.mroute.net (Postfix) with ESMTP id 8A195C650;
	Tue, 27 Sep 2011 16:22:17 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 0E2CA1437; Tue, 27 Sep 2011 09:22:12 -0700 (PDT)
x-mayan-date: Long count = 12.19.18.13.9; tzolkin = 8 Muluc; haab = 17 Chen
In-Reply-To: <4E81EAA7.5030708@myword.co.uk> (gitlist@myword.co.uk's message
	of "Tue, 27 Sep 2011 16:24:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182249>

>>>>> "gitlist" == gitlist  <gitlist@myword.co.uk> writes:

gitlist> I have a project with a test repository and a live repository (and a
gitlist> development repository).

You haven't mentioned what kind of access you have to the two repos.
Are they both bare remote repos?  Or can you just rsync one over the
other?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
