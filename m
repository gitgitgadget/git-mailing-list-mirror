From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Sun, 13 Jan 2008 17:53:21 -0800
Message-ID: <7vejclmaum.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 02:54:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEEWg-0004Wd-97
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 02:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528AbYANBxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 20:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753446AbYANBxm
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 20:53:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308AbYANBxl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 20:53:41 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 354BB4B14;
	Sun, 13 Jan 2008 20:53:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D54B34B13;
	Sun, 13 Jan 2008 20:53:37 -0500 (EST)
X-maint-at: aadd4efa715f56e0eac5ac459c8ff4933b56d4ce
X-master-at: 16335fdd7ace78a8285ba25fd7a81177a48e7c9b
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70433>

* The 'master' branch has these since v1.5.4-rc3

Eric Wong (1):
  git-svn: handle leading/trailing whitespace from svnsync revprops

Jeff King (1):
  git-clean: fix off-by-one memory access when given no arguments

Junio C Hamano (1):
  builtin-commit.c: remove useless check added by faulty cut and paste

Linus Torvalds (1):
  Fix performance regression for partial commits
