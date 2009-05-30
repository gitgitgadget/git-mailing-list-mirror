From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH v3] add --abbrev to 'git cherry'
Date: Sun, 31 May 2009 01:44:56 +0200
Message-ID: <200905310144.56380.markus.heidelberg@web.de>
References: <20090530140349.GA25265@unpythonic.net> <780e0a6b0905301413o2686fe34qaa076209c26c0b55@mail.gmail.com> <7v63fiyyrz.fsf@alter.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Stephen Boyd <bebarino@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 01:45:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAYEb-0006wQ-Q3
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 01:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbZE3Xo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 19:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753513AbZE3Xoz
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 19:44:55 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:40458 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbZE3Xoy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 19:44:54 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 7051CFE7A946;
	Sun, 31 May 2009 01:44:56 +0200 (CEST)
Received: from [89.59.100.180] (helo=.)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MAYES-0002qF-00; Sun, 31 May 2009 01:44:56 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7v63fiyyrz.fsf@alter.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/VcgwxCccGArMYfRM8tJY4/bPTUgtwg7DLN51D
	UcOhsZjQHLNpIkBdcq3dYmo+Kv27EV8+8F8jtev+Di3SJw66lV
	odkWmc2SRdEyKSVqPvPw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120370>

Junio C Hamano, 31.05.2009:
> Why do people even think a change like this to a _plumbing_ command is
> desirable?

git-cherry is plumbing? In git(1) it is listed as porcelain.
And the plumbings show-ref, ls-files and ls-tree support --abbrev.

Markus
