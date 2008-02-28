From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: Multiple -M options for git-cvsimport
Date: Thu, 28 Feb 2008 11:18:20 +0100
Message-ID: <1204193904-3652-1-git-send-email-book@cpan.org>
Cc: gitster@pobox.com, "Philippe Bruhat (BooK)" <book@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 11:19:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUfrW-0005MG-GZ
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 11:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770AbYB1KTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 05:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754483AbYB1KTB
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 05:19:01 -0500
Received: from zlonk.bruhat.net ([91.121.102.217]:34199 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403AbYB1KS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 05:18:57 -0500
Received: from localhost ([127.0.0.1] helo=plop.home.bruhat.net)
	by ks354402.kimsufi.com with esmtp (Exim 4.63)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1JUfrm-0007pf-0w; Thu, 28 Feb 2008 11:19:54 +0100
Received: from book by plop.home.bruhat.net with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1JUfqP-0000aH-8v; Thu, 28 Feb 2008 11:18:29 +0100
X-Mailer: git-send-email 1.5.4.2.187.gfc276
In-Reply-To: <>
References: <>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75379>

Sending again my series of patches to git-cvsimport, which allow to
use several -M options for giving the regular expressions capturing the
source branch name when merging.

Signed-off-by: Philippe Bruhat (BooK) <book@cpan.org>
