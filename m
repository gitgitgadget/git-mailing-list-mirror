From: Pierre Habouzit <madcoder@debian.org>
Subject: [take 2] git send-email updates
Date: Tue, 11 Nov 2008 00:53:58 +0100
Message-ID: <1226361242-2516-1-git-send-email-madcoder@debian.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 00:55:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzgbX-0003dS-Od
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 00:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbYKJXyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 18:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbYKJXyJ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 18:54:09 -0500
Received: from pan.madism.org ([88.191.52.104]:37653 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668AbYKJXyI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 18:54:08 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 1F3513CD73
	for <git@vger.kernel.org>; Tue, 11 Nov 2008 00:54:06 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id E12F72A28E; Tue, 11 Nov 2008 00:54:02 +0100 (CET)
X-Mailer: git-send-email 1.6.0.4.862.g3e9be
In-Reply-To: <1225450632-7230-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100597>

The last patch is dropped for now (the automatic --compose stuff)
because I'm not sure which option to add, and that I don't care enough
about it to spend more time on it.

I think I've incorporated most of the stuff people asked about in this
series.

 [PATCH 1/4] git send-email: make the message file name more specific.
 [PATCH 2/4] git send-email: interpret unknown files as revision lists
 [PATCH 3/4] git send-email: add --annotate option
 [PATCH 4/4] git send-email: ask less questions when --compose is used.
