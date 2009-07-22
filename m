From: Yann Dirson <ydirson@altern.org>
Subject: [PATCHv2 0/2] format-patch / send-mail threading documentation
Date: Wed, 22 Jul 2009 23:39:29 +0200
Message-ID: <1248298771-21075-1-git-send-email-ydirson@altern.org>
References: <cover.1246834883.git.ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 23:39:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjXa-0000vv-Fq
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 23:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235AbZGVVjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 17:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbZGVVjp
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 17:39:45 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:58182 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323AbZGVVjp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 17:39:45 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id BD2FD94005C;
	Wed, 22 Jul 2009 23:39:39 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id A126D940091;
	Wed, 22 Jul 2009 23:39:36 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id A1AC7A003; Wed, 22 Jul 2009 23:39:50 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.rc1.12.g05859c
In-Reply-To: <cover.1246834883.git.ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123777>

This new series attempts to correct things to take into account
comments from Junio and Markus, and to avoid duplication of config
item descriptions into config.txt.

Yann Dirson (2):
  List send-email config options in config.txt.
  Improve doc for format-patch threading options.

 Documentation/config.txt           |   44 ++++++++++++++++++++++++++++++++++++
 Documentation/git-format-patch.txt |   22 ++++++++++++-----
 Documentation/git-send-email.txt   |   21 +++++++++++++----
 3 files changed, 75 insertions(+), 12 deletions(-)
