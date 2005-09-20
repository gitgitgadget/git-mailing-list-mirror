From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 0/8] cogito: cg-object-id
Date: Mon, 19 Sep 2005 22:31:58 -0400
Message-ID: <1127183518.31115.44.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 20 04:32:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHXvQ-00085D-Mf
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 04:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbVITCcB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 22:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbVITCcA
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 22:32:00 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:43436 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964849AbVITCcA
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 22:32:00 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EHXvL-0006RE-HE
	for git@vger.kernel.org; Mon, 19 Sep 2005 22:31:59 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EHXvK-0001is-IC
	for git@vger.kernel.org; Mon, 19 Sep 2005 22:31:58 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8961>

Hello!

These are the patches that implement cg-object-id and fix the bugs I
found in process.  The patches show separate stages of changes.
Otherwise it would be a huge patch.

This applies to all patches in the series
Signed-off-by: Pavel Roskin <proski@gnu.org>

-- 
Regards,
Pavel Roskin
