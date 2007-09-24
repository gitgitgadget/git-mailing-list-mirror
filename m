From: Pierre Habouzit <madcoder@debian.org>
Subject: mini-refactor in rerere.c
Date: Mon, 24 Sep 2007 11:25:02 +0200
Message-ID: <1190625904-22808-1-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 24 11:25:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZkBp-0000hG-69
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 11:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbXIXJZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 05:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbXIXJZL
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 05:25:11 -0400
Received: from pan.madism.org ([88.191.52.104]:33258 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127AbXIXJZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 05:25:09 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8CB7A2177B;
	Mon, 24 Sep 2007 11:25:05 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 8483A43B5; Mon, 24 Sep 2007 11:25:04 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.2.1067.g96579
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59032>

  Here is a smallish series in builtin-rerere.c. Nothing very exciting
though.
