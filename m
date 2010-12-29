From: Marlene Cote <Marlene_Cote@affirmednetworks.com>
Subject: help for a git newbie please
Date: Wed, 29 Dec 2010 17:43:43 +0000
Message-ID: <20053D7ED46E664F8B9A4D5E5B31937407197534@MBX021-W4-CA-1.exch021.domain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 29 19:02:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY0LX-0003RR-Ke
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 19:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437Ab0L2Rxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 12:53:51 -0500
Received: from hub021-ca-6.exch021.serverdata.net ([64.78.56.71]:20956 "EHLO
	hub021-ca-6.exch021.serverdata.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752717Ab0L2Rxu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 12:53:50 -0500
X-Greylist: delayed 603 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Dec 2010 12:53:50 EST
Received: from MBX021-W4-CA-1.exch021.domain.local ([10.254.4.83]) by
 HUB021-CA-6.exch021.domain.local ([10.254.4.92]) with mapi; Wed, 29 Dec 2010
 09:43:45 -0800
Thread-Topic: help for a git newbie please
Thread-Index: Acunf++vTCN7jb1DQvuQ8Ye4slAdaA==
Sensitivity: private
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-hashedpuzzle: AyiM A6Ap BTun Bgpa Cc34 Cxkw DLWW FJBX FMgu GOeP GPpR
 GeYv Jhlm LVZf LhPe
 Lu0S;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{462C8339-FC7B-45B0-865C-6E561ACD608D};bQBhAHIAbABlAG4AZQBfAGMAbwB0AGUAQABhAGYAZgBpAHIAbQBlAGQAbgBlAHQAdwBvAHIAawBzAC4AYwBvAG0A;Wed,
 29 Dec 2010 17:43:43
 GMT;aABlAGwAcAAgAGYAbwByACAAYQAgAGcAaQB0ACAAbgBlAHcAYgBpAGUAIABwAGwAZQBhAHMAZQA=
x-cr-puzzleid: {462C8339-FC7B-45B0-865C-6E561ACD608D}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164320>

I don't understand the docs when they talk about hooks.  I have tried making my .git/hooks samples executable and they don't have any suffix to remove, so they should just run.  However, every time I make a new clone, the changes I made to the hooks are gone.  Just the samples get put into  the clone again.  How do I put a hook in place that every developer will get and execute?  If I should be using server side hooks, where exactly would those go?  Should I modify the hooks under my repositories directory?
--------------------------
Regards,
Marlene Cote
Affirmed Networks
978-268-0821 
