From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 1/3] Move CodingGuidelines to
 ./technical/coding-guidelines.txt and SubmittingPatches to
 ./technical/submitting-patches.txt
Date: Sun, 30 Dec 2012 11:31:54 +0100 (CET)
Message-ID: <1979101508.1364078.1356863514997.JavaMail.ngmail@webmail19.arcor-online.net>
References: <1023165134.213650.1356863340563.JavaMail.ngmail@webmail06.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: th.acker@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 30 11:32:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpGBj-0004dm-Kj
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 11:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855Ab2L3Kb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 05:31:58 -0500
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:57976 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751164Ab2L3Kb4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Dec 2012 05:31:56 -0500
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mx.arcor.de (Postfix) with ESMTP id 0C48C126006
	for <git@vger.kernel.org>; Sun, 30 Dec 2012 11:31:55 +0100 (CET)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 0FC4B28ADC4;
	Sun, 30 Dec 2012 11:31:55 +0100 (CET)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 0195A2129F0;
	Sun, 30 Dec 2012 11:31:54 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-13.arcor-online.net 0195A2129F0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1356863515; bh=VRGHgeCr2kTz6iW9z+7VTWa3QGgsi3ls2s4gdDWyWoA=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=L5jJxCnESZyshvwvbJ3uX8QnLtq+doWwPpDD9DxUG9OJNQbQnWZ3P4C11NIiE5Cj8
	 nPexZtt5GsFMtTHvEpw1uXPpqVDgMxI1rs9HD2i0Jb8/dW+Ws1DJKbw09JmRWtWI9/
	 O0jAeAlTVKlDTS/mJSA7iymF9eF2p2ChSvFv+UT8=
Received: from [188.98.241.53] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Sun, 30 Dec 2012 11:31:54 +0100 (CET)
In-Reply-To: <1023165134.213650.1356863340563.JavaMail.ngmail@webmail06.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.241.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212324>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/{CodingGuidelines => technical/coding-guidelines.txt}   | 0
 Documentation/{SubmittingPatches => technical/submitting-patches.txt} | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/{CodingGuidelines => technical/coding-guidelines.txt} (100%)
 rename Documentation/{SubmittingPatches => technical/submitting-patches.txt} (100%)

diff --git a/Documentation/CodingGuidelines b/Documentation/technical/coding-guidelines.txt
similarity index 100%
rename from Documentation/CodingGuidelines
rename to Documentation/technical/coding-guidelines.txt
diff --git a/Documentation/SubmittingPatches b/Documentation/technical/submitting-patches.txt
similarity index 100%
rename from Documentation/SubmittingPatches
rename to Documentation/technical/submitting-patches.txt
-- 
1.8.0.msysgit.0


---
Thomas
