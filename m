From: marcel partap <mpartap@gmx.net>
Subject: [WISH] git diff --pickaxe-line feature?
Date: Wed, 30 May 2012 09:21:10 +0200
Message-ID: <4FC5CA66.4040006@gmx.net>
Reply-To: mpartap@gmx.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 09:21:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZdDr-00059h-8i
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 09:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756925Ab2E3HVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 03:21:30 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:53505 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755859Ab2E3HV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 03:21:29 -0400
Received: (qmail invoked by alias); 30 May 2012 07:21:16 -0000
Received: from unknown (EHLO [10.68.129.69]) [82.113.121.69]
  by mail.gmx.net (mp010) with SMTP; 30 May 2012 09:21:16 +0200
X-Authenticated: #724076
X-Provags-ID: V01U2FsdGVkX18/ZcBmO5Y/JZewBXYjfUzzMvQaGVoCAhhjpvu10J
	RweopCxshY8KpP
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198783>

Salute!
to quickly skim diff for real algorithmic changes, something like
> # git diff **--pickaxe-line --pickaxe-exclude** --pickaxe-regex -S'/^(\d{4}|(\d\.)*\S*|unsigned)$/i --color-words
would be especially useful between exiting bed and first coffeine
intake. Like, now^^ ... . ;)
#regards!
...& thx@all 4 this pwnsome rcs C;
