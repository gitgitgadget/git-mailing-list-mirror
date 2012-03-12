From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 0/2] prettify t0303-credential-helpers.sh
Date: Mon, 12 Mar 2012 13:05:05 +0100
Message-ID: <1331553907-19576-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 12 13:05:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S740a-0002e6-35
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 13:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886Ab2CLMFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 08:05:44 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:55715 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723Ab2CLMFm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 08:05:42 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S740Q-0005xL-J9; Mon, 12 Mar 2012 13:05:39 +0100
X-Mailer: git-send-email 1.7.9.3.467.g8f1c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192859>

Two patches which are not very important, but trivial, so probably
safe.

  1/2: set reason for skipping tests
    (Fix an imperfection in test output under prove)
  2/2: resurrect commit message as test documentation
    (Add documentation)

 t/t0303-credential-external.sh |   27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

-- 
1.7.9.3.467.g8f1c7
