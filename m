From: "Dylan Martin" <dmartin@sccd.ctc.edu>
Subject: How do I..?
Date: Wed, 17 Dec 2008 15:16:59 -0800
Message-ID: <e1a4c7f60812171516h7b7bb1fem35dfc6f30747a740@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 00:18:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD5eq-0005DK-3K
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 00:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbYLQXRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 18:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbYLQXRD
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 18:17:03 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:40097 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbYLQXRB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 18:17:01 -0500
Received: by bwz14 with SMTP id 14so582567bwz.13
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 15:16:59 -0800 (PST)
Received: by 10.223.110.3 with SMTP id l3mr860523fap.49.1229555819551;
        Wed, 17 Dec 2008 15:16:59 -0800 (PST)
Received: by 10.223.109.143 with HTTP; Wed, 17 Dec 2008 15:16:59 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: 3e74a428b49eacb1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103410>

Sorry if this is a dumb question.  I've poked around the docs and
tried the google searches I could think of, but I don't even know what
kind of search terms one would use in trying to answer this.

I'm a sysadmin and I've got a big monolithic git repo of all my
scripts, documents, etc...  It used to be a CVS repo but I converted
it to git a while ago.
Before I switched to git, I played around with SVN a bit, and started
a few tiny SVN repos for various scripts I was working on.  So, I know
have one git repo with %90 of my stuff and a handful of SVN repos.
I'd like to be able to add the SVN repos as subdirectories inside my
git repo.  I've found lots of pages describing how to convert an SVN
repo into a _new_ git repo, but I haven't found anything yet about
importing the contents of an SVN repo as a subdirectory of an
_existing_ git repo.

-Thanks!
Dylan
