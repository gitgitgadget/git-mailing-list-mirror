From: "George Spelvin" <linux@horizon.com>
Subject: receive.denyCurrentBranch
Date: Sat, 07 Feb 2009 23:29:10 -0500
Message-ID: <20090208042910.19079.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 05:31:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW1KP-0001z4-KI
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 05:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbZBHE3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 23:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752584AbZBHE3M
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 23:29:12 -0500
Received: from science.horizon.com ([192.35.100.1]:10185 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751944AbZBHE3M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 23:29:12 -0500
Received: (qmail 19080 invoked by uid 1000); 7 Feb 2009 23:29:10 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108918>

(Prompted by the 1.6.2-rc0 announcement.)

Myself, I always thought the obvious way to handle this problem was to
detach the HEAD.  Is there a reson there's no "detach" option for this?
