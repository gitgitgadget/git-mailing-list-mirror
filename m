From: Valentin Haenel <valentin.haenel@gmx.de>
Subject: [PATCH v2 0/5] better document 'interactive.singlekey'
Date: Mon,  2 May 2011 15:44:27 +0200
Message-ID: <1304343872-1654-1-git-send-email-valentin.haenel@gmx.de>
References: <20110501045140.GA13387@sigill.intra.peff.net>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Valentin Haenel <valentin.haenel@gmx.de>
To: Git-List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 02 15:46:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGtSA-0007UC-J0
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 15:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758924Ab1EBNqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 09:46:16 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:38718 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757656Ab1EBNqF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 09:46:05 -0400
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p42DjfHC002102;
	Mon, 2 May 2011 15:45:41 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p42Dje6S002101;
	Mon, 2 May 2011 15:45:40 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <20110501045140.GA13387@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172589>

The configuration 'interactive.singlekey' is incredibly useful but
underdocumentated. Bring the documentation in config.txt up-to-date and
document it in individual commands.

Thanks to Jeff King for advice.

Valentin Haenel (5):
  config.txt: 'interactive.singlekey; is used by...
  git-add.txt: document 'interactive.singlekey'
  git-reset.txt: document 'interactive.singlekey'
  git-stash.txt: document 'interactive.singlekey'
  git-checkout.txt: document 'interactive.singlekey'

 Documentation/config.txt       |    5 +++--
 Documentation/git-add.txt      |    3 +++
 Documentation/git-checkout.txt |    3 +++
 Documentation/git-reset.txt    |    3 +++
 Documentation/git-stash.txt    |    3 +++
 5 files changed, 15 insertions(+), 2 deletions(-)
