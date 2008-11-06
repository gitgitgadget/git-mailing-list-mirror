From: Miles Bader <miles.bader@necel.com>
Subject: multiple-commit cherry-pick?
Date: Thu, 06 Nov 2008 11:45:27 +0900
Message-ID: <buoiqr18tdk.fsf@dhapc248.dev.necel.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 03:47:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxutt-0000Fw-DF
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 03:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbYKFCpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 21:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbYKFCpi
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 21:45:38 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:37477 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbYKFCph (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 21:45:37 -0500
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id mA62jOmI001529;
	Thu, 6 Nov 2008 11:45:28 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay11.aps.necel.com with ESMTP; Thu, 6 Nov 2008 11:45:28 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay31.aps.necel.com with ESMTP; Thu, 6 Nov 2008 11:45:28 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 3EF963E2; Thu,  6 Nov 2008 11:45:28 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100209>

Is there any easy way to cherry pick a _range_ of commits from some other
branch to the current branch, instead of just one?

I thought maybe git-rebase could be coerced to do this somehow, but I
couldn't figure a way.  [Using git-rebase would be nice because of all the
useful tools it provides, e.g., the --abort, --continue, and -i options.]

Thanks,

-Miles

-- 
P.S.  All information contained in the above letter is false,
      for reasons of military security.
