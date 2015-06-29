From: Tony Finch <dot@dotat.at>
Subject: Re: What's cooking in git.git (Jun 2015, #06; Wed, 24)
Date: Mon, 29 Jun 2015 15:32:41 +0100
Message-ID: <alpine.LSU.2.00.1506291530590.32296@hermes-1.csi.cam.ac.uk>
References: <xmqqwpys95bm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 16:48:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9aLn-0003UJ-8n
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 16:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbbF2Orw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 10:47:52 -0400
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:46244 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007AbbF2Orq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 10:47:46 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jun 2015 10:47:46 EDT
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:58876)
	by ppsw-50.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:25)
	with esmtpa (EXTERNAL:fanf2) id 1Z9a6z-0007ww-qz (Exim 4.82_3-c0e5623)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 29 Jun 2015 15:32:41 +0100
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1Z9a6z-0008Ma-As (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 29 Jun 2015 15:32:41 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <xmqqwpys95bm.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272952>

What can I do to help un-stall my gitweb patches?

> [Stalled]
>
> * tf/gitweb-project-listing (2015-03-19) 5 commits
>  - gitweb: make category headings into links when they are directories
>  - gitweb: optionally set project category from its pathname
>  - gitweb: add a link under the search box to clear a project filter
>  - gitweb: if the PATH_INFO is incomplete, use it as a project_filter
>  - gitweb: fix typo in man page
>
>  Update gitweb to make it more pleasant to deal with a hierarchical
>  forest of repositories.
>
>  Any comments from those who use or have their own code in Gitweb?

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
South Utsire: Westerly 4, occasionally 5 in east. Smooth or slight,
occasionally moderate in east. Fog patches later. Moderate, occasionally very
poor later.
