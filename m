From: Karl Chen <quarl@cs.berkeley.edu>
Subject: git-diff-files man page
Date: Tue, 02 Sep 2008 10:47:35 -0700
Message-ID: <quack.20080902T1047.lth63pemoco@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 02 19:48:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaZze-0000P3-6l
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 19:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbYIBRrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 13:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbYIBRrg
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 13:47:36 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:46202 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbYIBRrg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 13:47:36 -0400
Received: by roar.quarl.org (Postfix, from userid 18378)
	id EE97A34462; Tue,  2 Sep 2008 10:47:35 -0700 (PDT)
X-Quack-Archive: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94683>


The git-diff-files man page should say that it is a low level
command and one should call git update-index --refresh before
using it.
