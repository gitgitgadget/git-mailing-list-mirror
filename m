From: Sebastian Morr <sebastian@morr.cc>
Subject: Is it "GIT" or "Git" or "git"? Standardize documentation?
Date: Wed, 14 Dec 2011 01:43:33 +0100
Message-ID: <20111214004332.GA8464@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 01:43:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Racwe-00080C-UJ
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 01:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755105Ab1LNAng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 19:43:36 -0500
Received: from static.148.34.47.78.clients.your-server.de ([78.47.34.148]:51961
	"EHLO morr.cc" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753513Ab1LNAng (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 19:43:36 -0500
Received: by morr.cc (Postfix, from userid 1001)
	id 1CADF4763F80; Wed, 14 Dec 2011 01:43:35 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on morr.cc
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
	version=3.3.1
Received: from thinkpad (port-92-196-84-34.dynamic.qsc.de [92.196.84.34])
	by morr.cc (Postfix) with ESMTPSA id 95EC24763F7E
	for <git@vger.kernel.org>; Wed, 14 Dec 2011 01:43:34 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187087>

Okay, I'd like to hear opinions on this before creating a patch.

My perception is that "Git" is the name of the software, whereas "git"
is used to refer to the actual command. But "GIT" is all over the
documentation as well, most prominently at the top of README.
Would anyone mind if we replaced all occurrences of "GIT" in the
documentation with "Git"?
I suppose the release notes shouldn't be touched for historical reasons.

Completely unrelated: Why is it "Documentation/RelNotes" and not
something like "documentation/release-notes"? Almost everything else is
spelled either all-lower- or all-uppercase.

Sorry for being such a nazi...
