From: pcm2a <cameron@ree-yees.com>
Subject: Permissions per git repository
Date: Mon, 28 Nov 2011 05:38:22 -0800 (PST)
Message-ID: <1322487502060-7038724.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 14:38:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV1Pf-00005d-N8
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 14:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab1K1NiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 08:38:22 -0500
Received: from sam.nabble.com ([216.139.236.26]:42541 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751774Ab1K1NiW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 08:38:22 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <cameron@ree-yees.com>)
	id 1RV1Pa-0001Qz-39
	for git@vger.kernel.org; Mon, 28 Nov 2011 05:38:22 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186015>

I have a central git repository running on Windows Server 2008 using Apache
2.2 + Smart HTTP + SSPI (for authentication).  I can easily limit users to
all of the repositories with the 'require' command in apache. This is for
all repositories and not just certain ones.

How can I limit user(s) or group(s) to one repository and a different
user(s) or group(s) to another repository using git or apache configuration?

--
View this message in context: http://git.661346.n2.nabble.com/Permissions-per-git-repository-tp7038724p7038724.html
Sent from the git mailing list archive at Nabble.com.
