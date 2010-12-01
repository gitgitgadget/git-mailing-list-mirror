From: Peter van der Does <peter@avirtualhome.com>
Subject: [PATCH v4 0/2] *** SUBJECT HERE ***
Date: Wed,  1 Dec 2010 15:49:40 -0500
Message-ID: <1291236582-28603-1-git-send-email-peter@avirtualhome.com>
Cc: Peter van der Does <peter@avirtualhome.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 01 21:50:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNtd0-0001dh-6k
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 21:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757035Ab0LAUuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 15:50:07 -0500
Received: from morn.lunarbreeze.com ([216.227.218.220]:38247 "EHLO
	morn.lunarbreeze.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756387Ab0LAUuG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 15:50:06 -0500
Received: from c-69-248-93-14.hsd1.nj.comcast.net ([69.248.93.14] helo=monza.grandprix.int)
	by morn.lunarbreeze.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <peter@avirtualhome.com>)
	id 1PNtcp-0004fw-Bb; Wed, 01 Dec 2010 12:50:03 -0800
Received: from MonteCarlo.grandprix.int. (montecarlo.grandprix.int [192.168.1.102])
	by monza.grandprix.int (Postfix) with ESMTPA id 88E2BD79EE;
	Wed,  1 Dec 2010 15:50:00 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - morn.lunarbreeze.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - avirtualhome.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162607>

*** BLURB HERE ***
Make git-completion Bash 4 compatible.

I've made the following changes since v3:
- Patch is based upon the next branch.
- Grammatical error in commit message

Peter van der Does (2):
  Introduce functions from bash-completion project.
  Use the new functions to get the current cword.

 contrib/completion/git-completion.bash |  446 ++++++++++++++++++++++++++------
 1 files changed, 363 insertions(+), 83 deletions(-)

-- 
1.7.3.2
