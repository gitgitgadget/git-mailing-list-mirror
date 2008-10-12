From: Marius Vollmer <marius.vollmer@gmail.com>
Subject: [ANNOUNCE] Magit 0.6  (Emacs interface for Git)
Date: Mon, 13 Oct 2008 00:49:14 +0300
Message-ID: <87ljwtmqlh.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 12 23:50:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp8pZ-0003XK-4j
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 23:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309AbYJLVtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 17:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbYJLVtR
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 17:49:17 -0400
Received: from smtp6.pp.htv.fi ([213.243.153.40]:43151 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175AbYJLVtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 17:49:16 -0400
Received: from zagadka.ping.de (cs178034.pp.htv.fi [213.243.178.34])
	by smtp6.pp.htv.fi (Postfix) with SMTP id 901305BC010
	for <git@vger.kernel.org>; Mon, 13 Oct 2008 00:49:15 +0300 (EEST)
Received: (qmail 9193 invoked by uid 1000); 13 Oct 2008 00:49:15 +0300
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98059>

Hi,

I am happy to announce the second pre-release of Magit.  Get it here:

  http://zagadka.vm.bytemark.co.uk/magit/

Almost everything has changed.  Please read the manual again.  Some
highlights:

* Magit now works with Git 1.6.0.  (John Wiegley)

* Support for interactive rewriting.

* Sections can be shown and hidden.

* Staging, unstaging, applying, reverting and discarding changes can
  now be done line-by-line, not only hunk-by-hunk.
