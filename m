From: supadhyay <supadhyay@imany.com>
Subject: Tags/Branches missing in GIT
Date: Tue, 17 Apr 2012 22:54:50 -0700 (PDT)
Message-ID: <1334728490216-7475869.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 18 07:54:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKNqx-0003Ae-P5
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 07:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945Ab2DRFyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 01:54:51 -0400
Received: from sam.nabble.com ([216.139.236.26]:35419 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769Ab2DRFyu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 01:54:50 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <supadhyay@imany.com>)
	id 1SKNqs-0007cc-7H
	for git@vger.kernel.org; Tue, 17 Apr 2012 22:54:50 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195839>

Hi All,

I have migrated our version control from CVS to Git (with the help of this
link  http://cvs2svn.tigris.org/cvs2git.html) and from git I do clone to
gitolite on the same server.

Now when end user verify their code in GIT (using Tortoisegit/Egit) they
found differences in number of tags and brances. Some of CVS tags/brances
are not exists in GIT and some of the new tags created by GIT which is not
in CVS.


Can any one please update me this is known issue or not and how to resolve
this ?


Thanks in advance...



--
View this message in context: http://git.661346.n2.nabble.com/Tags-Branches-missing-in-GIT-tp7475869p7475869.html
Sent from the git mailing list archive at Nabble.com.
