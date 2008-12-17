From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: rsync deprecated?
Date: Thu, 18 Dec 2008 00:41:10 +0100
Message-ID: <200812180041.10312.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 00:42:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD61w-0004mg-0f
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 00:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbYLQXk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 18:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752294AbYLQXk5
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 18:40:57 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:48597 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbYLQXk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 18:40:56 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 45EACF5842C6
	for <git@vger.kernel.org>; Thu, 18 Dec 2008 00:40:55 +0100 (CET)
Received: from [91.19.64.135] (helo=pluto)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1LD60a-0007cn-00
	for git@vger.kernel.org; Thu, 18 Dec 2008 00:40:52 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/rimuWZpgnaUg4W/p/W/634QtnxpmgnuJ4PAfE
	Y3VkIpmDpt2EeLDLmfXjay1w9CCylp1333I3BJM9PxacMIxXq7
	ljFJfBMx85sI1kdRA9rA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103412>

Hi,

in the "Merging external work" section of the gitcore-tutorial it is
stated that the rsync transport is deprecated. The description was added
in commit 914328a (Update tutorial., 2005-08-30) together with the
"deprecated" note. Having never heard/read this before and since this
commit is quite old, I wonder if it is still the case or there was a
solution for this problem.

Markus
