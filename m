From: Karl Chen <quarl@cs.berkeley.edu>
Subject: git-update-index --refresh man page
Date: Tue, 02 Sep 2008 10:54:51 -0700
Message-ID: <quack.20080902T1054.lthwshul9g4@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 02 19:56:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaa6f-0002uJ-FX
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 19:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbYIBRyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 13:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbYIBRyw
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 13:54:52 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:49533 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360AbYIBRyv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 13:54:51 -0400
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 824583448D; Tue,  2 Sep 2008 10:54:51 -0700 (PDT)
X-Quack-Archive: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94687>


I suggest expanding/clarifying the documentation for
git-update-index --refresh.  For example:

    "If a file's mtime has changed, but its contents have not,
    then update-index --refresh will update the index to reflect
    the new mtimes."
