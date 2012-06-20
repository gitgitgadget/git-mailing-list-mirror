From: lalebarde <l.alebarde@free.fr>
Subject: workflow clarification: sha1/merge/patch/diff ws smudge/clean
Date: Wed, 20 Jun 2012 05:13:39 -0700 (PDT)
Message-ID: <1340194419857-7561818.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 20 14:13:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShJn7-00026O-Cm
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 14:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939Ab2FTMNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 08:13:41 -0400
Received: from sam.nabble.com ([216.139.236.26]:37606 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586Ab2FTMNk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 08:13:40 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <l.alebarde@free.fr>)
	id 1ShJn1-0005o7-Vh
	for git@vger.kernel.org; Wed, 20 Jun 2012 05:13:39 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200293>

Hi all,

First, sorry if I am mistaken in using this mailing list. Please,
let me know if I am wrong.

I need some clarification on the git workflow I didn't find in
the documentation, thought it is probably one of the best
software documentation I have ever read.

My question concerns sha1, merge, patch and diff commands :
are they performed in the repository referencial or in the
workspace referential. In other words, when a filter is defined,
respectively after smudge or after clean ?

Regards,

Laurent.

--
View this message in context: http://git.661346.n2.nabble.com/workflow-clarification-sha1-merge-patch-diff-ws-smudge-clean-tp7561818.html
Sent from the git mailing list archive at Nabble.com.
