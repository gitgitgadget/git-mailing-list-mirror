From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: supports diff.context config for git-diff-tree
Date: Sat, 16 Feb 2013 07:52:23 +0800
Message-ID: <CAHtLG6TPs=Z2i8s3_dd_igztuvuqE5L93cTtBM4q1zDCzpU55w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 00:52:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6V5G-0001qJ-Mn
	for gcvg-git-2@plane.gmane.org; Sat, 16 Feb 2013 00:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071Ab3BOXwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 18:52:25 -0500
Received: from mail-vb0-f48.google.com ([209.85.212.48]:52499 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab3BOXwY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 18:52:24 -0500
Received: by mail-vb0-f48.google.com with SMTP id fc21so2484530vbb.35
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 15:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=dLZ+6cAtJiWWjVdo6DhTtwE1jzsxboVeVtgFy5oMh2o=;
        b=noIZ1bJup1KlKzFQd2QpXwvbGLDqQPQuOStd+XEIa1s/Hs0gQbsaN6WAVPzJl06vIQ
         OuFvjmwNrN+PhXBA0cbVzI86b+UlFS4PtmNL95kHMBdf59aJRKZgharbEYL445Ye6FFj
         Oqtqr2PguYCTi1ekYPPIRAfImXGmhZBjItuNDiKuwWXLa6TRva8z/bpI0YgqYjcMPGFe
         M0MSULFOOepXfQbRbpB+gE6mUyhJSdldRNGz+Lye836Mf8+Jucx0dqT2eGUEvT4ydtUF
         oGkvmHXXqRKIo895m7/YRZcipdI9CovgU8as6rekyguUF8ituKj+ybu56c1uhhwxlkjm
         reMg==
X-Received: by 10.52.19.51 with SMTP id b19mr4864237vde.131.1360972343581;
 Fri, 15 Feb 2013 15:52:23 -0800 (PST)
Received: by 10.221.6.201 with HTTP; Fri, 15 Feb 2013 15:52:23 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216366>

Dear Sir,

In git 1.8.1, git-diff supports diff.context config.
However, git-diff-tree does not support this.
Could you also add this to git-diff-tree?

Regards,
ch3cooli
