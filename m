From: mhagger@alum.mit.edu
Subject: [PATCH v2 0/2] git-show-ref: fix asciidoc formatting
Date: Fri, 13 Jan 2012 17:39:14 +0100
Message-ID: <1326472756-15227-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 13 17:39:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlkA6-00016T-JU
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 17:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758221Ab2AMQj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 11:39:26 -0500
Received: from mail.berlin.jpk.com ([212.222.128.130]:45603 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab2AMQjY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 11:39:24 -0500
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1Rlk02-0007wV-CP; Fri, 13 Jan 2012 17:29:06 +0100
X-Mailer: git-send-email 1.7.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188518>

From: Michael Haggerty <mhagger@alum.mit.edu>

This topic was discussed before [1].  I hereby try again, with a bit
more information in the commit messages for posterity.

The patches apply to master or maint, whatever you prefer.

[1] http://comments.gmane.org/gmane.comp.version-control.git/183940

Michael Haggerty (2):
  git-show-ref: fix escaping in asciidoc source
  git-show-ref doc: typeset regexp in fixed width font

 Documentation/git-show-ref.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.7.8.3
