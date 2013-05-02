From: deg <deg@degel.com>
Subject: Re: trouble on windows network share
Date: Thu, 2 May 2013 14:26:08 -0700 (PDT)
Message-ID: <1367529968647-7584800.post@n2.nabble.com>
References: <871B6C10EBEFE342A772D1159D1320853F63D205@umechphj.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 02 23:26:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY115-00031I-37
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 23:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab3EBV0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 17:26:10 -0400
Received: from sam.nabble.com ([216.139.236.26]:40516 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019Ab3EBV0J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 17:26:09 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <deg@degel.com>)
	id 1UY10y-0003td-LG
	for git@vger.kernel.org; Thu, 02 May 2013 14:26:08 -0700
In-Reply-To: <871B6C10EBEFE342A772D1159D1320853F63D205@umechphj.easf.csd.disa.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223265>

I'm having this same problem.

Here's one more clue that may help: The problem is dependent on the exact
type of NAS drive.
I moved from a Buffalo LS-X2.0, which worked fine, to a WD "My Book Live"
(MBL), which has this problem.

I don't know much more yet about why the MBL is failing, but am still poking
around, and am happy to try tests for anyone who wants to debug this.



--
View this message in context: http://git.661346.n2.nabble.com/trouble-on-windows-network-share-tp7581547p7584800.html
Sent from the git mailing list archive at Nabble.com.
