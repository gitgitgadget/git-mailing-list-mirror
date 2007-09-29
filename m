From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Please pull mergetool.git
Date: Sat, 29 Sep 2007 10:47:43 -0400
Message-ID: <E1Ibdbb-0006Ep-NS@candygram.thunk.org>
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Sep 29 16:48:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibdbt-0001AB-P5
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 16:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130AbXI2Orx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 10:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753842AbXI2Orx
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 10:47:53 -0400
Received: from thunk.org ([69.25.196.29]:38348 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636AbXI2Orw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 10:47:52 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Ibdl9-0002ov-Jl; Sat, 29 Sep 2007 10:57:35 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1Ibdbb-0006Ep-NS; Sat, 29 Sep 2007 10:47:43 -0400
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59471>

Hi Junio,

Please pull from the "mergetool" branch at:
        git://repo.or.cz/git/mergetool.git mergetool

It contains the bug fixes for git mergetool discussed recently, and is
against the maint branch.   Thanks!

						- Ted

Junio C Hamano (1):
      Mergetool generating blank files (1.5.3)

Theodore Ts'o (2):
      mergetool: fix emerge when running in a subdirectory
      mergetool: Fix typo in options passed to kdiff3
