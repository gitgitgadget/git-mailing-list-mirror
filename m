From: Paul Mackerras <paulus@samba.org>
Subject: Please pull gitk master branch
Date: Sat, 20 Jun 2009 16:48:14 +1000
Message-ID: <19004.34350.109422.730109@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 08:48:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHuNI-00073P-1M
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 08:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbZFTGsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 02:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbZFTGsR
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 02:48:17 -0400
Received: from bilbo.ozlabs.org ([203.10.76.25]:44352 "EHLO bilbo.ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108AbZFTGsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 02:48:16 -0400
Received: by bilbo.ozlabs.org (Postfix, from userid 1003)
	id E7F7CB7268; Sat, 20 Jun 2009 16:48:18 +1000 (EST)
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121934>

Junio,

Please do a pull from my gitk repository master branch to get the
following commits:

Christian Stimming (1):
      gitk: Update German translation.

Dirk Suesserott (1):
      gitk: Add option 'Simple history' to the options menu

Elijah Newren (1):
      gitk: Make more options easily accessible from Edit View dialog

Johannes Sixt (1):
      gitk: Use --textconv to generate diff text

Markus Heidelberg (1):
      gitk: Allow diff view without context lines

Michele Ballabio (1):
      gitk: Add another string to translation

Pat Thoyts (1):
      gitk: Handle msysGit version during version comparisons

Paul Mackerras (1):
      gitk: Check git version before using --textconv flag

Thanks,
Paul.
