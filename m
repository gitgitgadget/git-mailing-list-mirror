From: Paul Donohue <stgit-bug@TopQuark.net>
Subject: Minor bug in 'stg edit' ?
Date: Wed, 27 Feb 2008 17:47:57 -0500
Message-ID: <20080227224756.GK2222@TopQuark.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 27 23:58:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUVEO-0005Rw-VH
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 23:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758530AbYB0W54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 17:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758327AbYB0W54
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 17:57:56 -0500
Received: from god.thegod.com ([128.8.96.75]:53995 "EHLO Mail1.TopQuark.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757214AbYB0W5z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 17:57:55 -0500
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Feb 2008 17:57:55 EST
Received: by Mail1.TopQuark.net (8.12.6/8.11.3, from userid 1000)
	id 2ED1A9798; Wed, 27 Feb 2008 17:47:56 -0500 (EST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75318>

I'm running StGIT 0.14.1

After running 'stg edit', the file '.stgit-edit.txt' is always left behind.

Is this supposed to happen?  I would have assumed the file would be automatically removed after the changes were committed.

Thanks!
-Paul
