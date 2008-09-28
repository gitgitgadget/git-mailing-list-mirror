From: Pierre Habouzit <madcoder@debian.org>
Subject: small warm-up: easy parse-opt migrations.
Date: Sun, 28 Sep 2008 11:45:36 +0200
Message-ID: <1222595139-32087-1-git-send-email-madcoder@debian.org>
Cc: spearce@spearce.org, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 11:58:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjt3D-0005X7-4N
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 11:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbYI1J5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 05:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbYI1J5b
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 05:57:31 -0400
Received: from pan.madism.org ([88.191.52.104]:49827 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbYI1J5a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 05:57:30 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id F04B33B2C7;
	Sun, 28 Sep 2008 11:45:42 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 1FE2A7ADE20; Sun, 28 Sep 2008 11:45:39 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.516.g12936
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96950>

There's not a lot to tell, those are just three migration to
parse-options.
