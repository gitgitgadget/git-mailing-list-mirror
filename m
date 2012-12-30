From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 0/3] Move CodingGuidelines and SubmittingPatches to
 ./Documentation/technical
Date: Sun, 30 Dec 2012 11:29:00 +0100 (CET)
Message-ID: <1023165134.213650.1356863340563.JavaMail.ngmail@webmail06.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: th.acker@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 30 11:29:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpG8y-00032Y-8T
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 11:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698Ab2L3K3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 05:29:04 -0500
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:56160 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753194Ab2L3K3C (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Dec 2012 05:29:02 -0500
Received: from mail-in-16-z2.arcor-online.net (mail-in-16-z2.arcor-online.net [151.189.8.33])
	by mx.arcor.de (Postfix) with ESMTP id 9B0822D6E76
	for <git@vger.kernel.org>; Sun, 30 Dec 2012 11:29:00 +0100 (CET)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-16-z2.arcor-online.net (Postfix) with ESMTP id 914FA3FEF5B;
	Sun, 30 Dec 2012 11:29:00 +0100 (CET)
Received: from webmail06.arcor-online.net (webmail06.arcor-online.net [151.189.8.133])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 89E7D1976B7;
	Sun, 30 Dec 2012 11:29:00 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-09.arcor-online.net 89E7D1976B7
Received: from [188.98.241.53] by webmail06.arcor-online.net (151.189.8.133) with HTTP (Arcor Webmail); Sun, 30 Dec 2012 11:29:00 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.241.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212323>


CodingGuidelines and SubmittingPatches are IMHO a little bit hidden in ./Documentation
and with respect to their content should be better placed in ./Documentation/technical.

[PATCH 1/3] Move CodingGuidelines to ./technical/coding-guidelines.txt and SubmittingPatches to ./technical/submitting-patches.txt
[PATCH 2/3] Add coding-guidelines.txt and submitting-patches.txt to ./Documentation/Makefile
[PATCH 3/3] Convert coding-guidelines.txt and submitting-patches.txt to asciidoc


---
Thomas
