From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git 1.1.6?
Date: Sat, 04 Feb 2006 20:50:40 -0800
Message-ID: <7vd5i2s927.fsf@assigned-by-dhcp.cox.net>
References: <43E55B69.1070601@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 05 05:50:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5brO-00011Z-Iu
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 05:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWBEEum (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 23:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWBEEum
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 23:50:42 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:19412 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030265AbWBEEum (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 23:50:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060205044910.RKQE20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Feb 2006 23:49:10 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43E55B69.1070601@zytor.com> (H. Peter Anvin's message of "Sat,
	04 Feb 2006 17:56:57 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15618>

"H. Peter Anvin" <hpa@zytor.com> writes:

> I see git-1.1.6 is out, but I haven't seen an announcement?  What's up?

Not much.

I was planning to do a 1.2.0 soon enough for 1.1.6 to matter in
practice, but that has plan been slipping for various reasons.

Changes between 1.1.5 and 1.1.6 are primarily docs and do not
affect functionality.

---

Fredrik Kuivinen:
      merge-recursive: Improve the error message printed when merge(1) isn't found.
      git-branch: Documentation fixes

J. Bruce Fields:
      git push -f documentation

Junio C Hamano:
      pre-commit sample hook: do not barf on the initial import
      GIT 1.1.6
