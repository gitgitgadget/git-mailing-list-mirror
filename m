From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Signed push progress?
Date: Wed, 28 Sep 2011 07:50:54 +0000
Message-ID: <20110928075054.GA13727@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 28 09:51:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8ouy-0001je-IG
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 09:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851Ab1I1Hu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 03:50:56 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:41687 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549Ab1I1Huz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 03:50:55 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 121C11B4007
	for <git@vger.kernel.org>; Wed, 28 Sep 2011 07:50:55 +0000 (UTC)
Received: (qmail 16549 invoked by uid 10000); 28 Sep 2011 07:50:54 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182297>

I haven't seen anything about the status of signed push since earlier in
the month, even the what's cooking report marked it as stalled.

While I'd previously noted my concerns re the use of SHA1, that's not
presently a solvable problems, whereas signed-push does improve security
today.

Additionally, in the ever ongoing discussion about Gentoo's conversion
from CVS to Git (we're very close now), we've decided that the signed
pushes will provide better security than our plan of previous plan of
using signed notes, so we'd like to see signed pushes succeed.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
