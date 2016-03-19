From: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [Q] updates to gitk, git-gui and git-svn for 2.8?
Date: Sat, 19 Mar 2016 18:04:24 +1100
Message-ID: <20160319070424.GI27126@fergus.ozlabs.ibm.com>
References: <xmqqd1qwaopd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 10:14:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahCy5-0004h3-Rh
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 10:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbcCSJOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 05:14:32 -0400
Received: from ozlabs.org ([103.22.144.67]:53295 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752916AbcCSJON (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 05:14:13 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 3qRxH54S7Vz9sB6; Sat, 19 Mar 2016 20:14:09 +1100 (AEDT)
Content-Disposition: inline
In-Reply-To: <xmqqd1qwaopd.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289297>

Hi Junio,

> If there are pending updates for the upcoming release, please let me
> know and tell me what to pull.

Please pull from my gitk repository.

Thanks,
Paul.

The following changes since commit 0de75aafb66b22a04e6c90c0baf15dca11bddb3c:

  Merge branch 'ja.po' of https://github.com/qykth-git/gitk (2015-12-19 13:33:16 +1100)

are available in the git repository at:

  git://ozlabs.org/~paulus/gitk.git 

for you to fetch changes up to 22a713c72df8b6799c59287c50cee44c4a6db51e:

  gitk: Follow themed bgcolor in help dialogs (2016-03-19 14:12:21 +1100)

----------------------------------------------------------------
Alexander Shopov (1):
      gitk: Update Bulgarian translation (311t)

Guillermo S. Romero (1):
      gitk: Follow themed bgcolor in help dialogs

Jean-Noel Avila (2):
      gitk: Update French translation (311t)
      gitk: fr.po: Sync translations with git

Ralf Thielow (1):
      gitk: Update German translation

 gitk     |   8 +-
 po/bg.po | 656 ++++++++++++++++++++++++------------------------
 po/de.po |  79 +++---
 po/fr.po | 849 +++++++++++++++++++++++++++++++--------------------------------
 4 files changed, 788 insertions(+), 804 deletions(-)
