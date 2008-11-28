From: jidanni@jidanni.org
Subject: timestamps not git-cloned
Date: Fri, 28 Nov 2008 10:24:04 +0800
Message-ID: <87ej0wwptn.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 28 03:25:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5t37-0003cd-K3
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 03:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbYK1CYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 21:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbYK1CYI
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 21:24:08 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:50772 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753372AbYK1CYH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Nov 2008 21:24:07 -0500
Received: from jidanni1.jidanni.org (122-127-33-127.dynamic.hinet.net [122.127.33.127])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 75E61119DCC
	for <git@vger.kernel.org>; Thu, 27 Nov 2008 18:24:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101859>

Gentlemen, it's my first git-clone,
$ git-clone git://git.debian.org/git/pkg-fso/files.git
and I'm disappointed to find the timestamps of the files created are
all now and not the date of last edit. At least mention something
about this on the git-clone man page.
