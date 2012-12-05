From: Sebastian Leske <Sebastian.Leske@sleske.name>
Subject: [PATCH v3 0/4] git-svn: More docs for branch handling
Date: Wed, 5 Dec 2012 08:36:41 +0100
Message-ID: <cover.1354693001.git.Sebastian.Leske@sleske.name>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 13:51:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgERU-0000TU-Jn
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 13:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722Ab2LEMuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 07:50:55 -0500
Received: from serv28.loswebos.de ([213.187.93.221]:42928 "EHLO
	serv28.loswebos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab2LEMuy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 07:50:54 -0500
Received: from iota.localnet (unknown [46.115.102.110])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by serv28.loswebos.de (Postfix) with ESMTPSA id 514FC1602003;
	Wed,  5 Dec 2012 13:50:19 +0100 (CET)
Received: from sleske by iota.localnet with local (Exim 4.69)
	(envelope-from <sebastian.leske@sleske.name>)
	id 1Tg9Yo-0001A7-Pr; Wed, 05 Dec 2012 08:38:26 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211119>

Updated version of my documentation patch for git-svn. Thanks to Junio C
Hamano for pointing out improvements.

Sebastian Leske (4):
  git-svn: Document branches with at-sign(@).
  git-svn: Recommend use of structure options.
  git-svn: Expand documentation for --follow-parent
  git-svn: Note about tags.

 Documentation/git-svn.txt |   92 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 6 deletions(-)

-- 
1.7.10.4
