From: "Scott Chacon" <schacon@gmail.com>
Subject: Git Documentation
Date: Mon, 21 Jul 2008 20:35:13 -0700
Message-ID: <d411cc4a0807212035v68c2ed95m93b77c1e61cfec9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 22 05:36:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL8fh-00075Y-Hx
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 05:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbYGVDfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 23:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753278AbYGVDfP
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 23:35:15 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:33209 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbYGVDfN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 23:35:13 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1675919rvb.1
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 20:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=+nrqR+k+4AyCOllCwUBRKxe/X3Itdl2R7QQakbbYZKg=;
        b=PJxndU1PbcxN/geqE5mLZO3PA/ISSbjwB5zivL3elPOHkNPjxhSEfGp+JpybD0Pi2K
         puCqoqIxVOXRvkTl2k+gDC9JveiFGLB2+X/OG1RlmWKZkBE2jOTaPkh1FFQZTx+v807h
         g6uwaT9I00vwMtsWZ4NTKl3jD1xFH5Ym+jhHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=GcRHdKOleTCUhjXShBTJ5wjyW4JaUxT0ko9E3ReBWA33W7L87hqbCQmJUYd7QkMgFM
         Vho+Hb2wJqgppqJnevJlTgbolU9M45DetgOXINpwA2a0ohMZESvIJU1KvJTIoVnZw4le
         59eZkNAA+rfwvThhp1F+xWfkJ8/OIWcE5EuCE=
Received: by 10.115.19.16 with SMTP id w16mr3340664wai.102.1216697713477;
        Mon, 21 Jul 2008 20:35:13 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Mon, 21 Jul 2008 20:35:13 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89431>

Hey all,

I'm starting a project to host a really nice, user-friendly, easy to
use Git learning materials website for Git newbies to get new users
started and make it as easy to learn as possible.  I'll be redoing or
editing some of my screencasts from gitcasts.com and starting an open
book at github and putting it all in one place for new users to get
started easily.  Anyone will be free to submit changes, additions,
etc.

If anyone has any tips on how they think git should be taught, issues
they are asked a lot, problems newbies tend to have, something they
wish there were a screencast for or was better documented, etc -
please do contact me so I can incorporate it.  I would contribute to
git itself, but my C-foo is seriously wanting, so if by teaching
people properly I can free up some time for you guys, I would love to
do so.

Please let me know if you have any pointers or think anything should
really be better documented for end-users.  I plan to do a lot of
graphics, screencasts and whatever else makes it as simple as
possible.

Thanks, and thanks again for git.

Scott Chacon
