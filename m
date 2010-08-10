From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: With feature branches, what is ever committed directly to master
Date: Tue, 10 Aug 2010 15:02:32 -0400
Message-ID: <AANLkTin0VgH8CvnUn_tCJPTkhh7Ce-tYWo52qouoVvRN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 21:02:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oiu5v-0002iF-UP
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 21:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932916Ab0HJTCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 15:02:36 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57148 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932903Ab0HJTCe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 15:02:34 -0400
Received: by fxm13 with SMTP id 13so915774fxm.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 12:02:32 -0700 (PDT)
Received: by 10.239.145.196 with SMTP id t4mr957297hba.37.1281466952672; Tue, 
	10 Aug 2010 12:02:32 -0700 (PDT)
Received: by 10.239.179.5 with HTTP; Tue, 10 Aug 2010 12:02:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153138>

I realize there are a lot of different Git workflows but I'm wondering
how others in this community do it.

We're using our "master" branch from our central repo (Beanstalk) as a
dev branch and we have stable branches for various release versions of
our software.

We've not made as heavy use of feature branches yet as we should have.
Once we do start using them more regularly, what kind of stuff is ever
committed directly to "master" or is master typically the place where
things are merged into from other stable/features branches?

Is "master" really even unstable at that point?

Thanks in advance! I realize this question is pretty open-ended.
