From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [RESEND] Pagination for gitweb
Date: Fri, 10 Sep 2010 18:17:20 +0200
Message-ID: <1284135442-10971-1-git-send-email-lkundrak@v3.sk>
Cc: Lubomir Rintel <lkundrak@v3.sk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 10 18:17:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou6IJ-000460-Cr
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 18:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755465Ab0IJQRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 12:17:36 -0400
Received: from norkia.v3.sk ([91.210.183.14]:49171 "EHLO norkia.v3.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755409Ab0IJQRf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 12:17:35 -0400
Received: from localhost.localdomain.com (unknown [195.39.106.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lkundrak@v3.sk)
	by norkia.v3.sk (Postfix) with ESMTP id 9107CA0004;
	Fri, 10 Sep 2010 18:17:33 +0200 (CEST)
X-Mailer: git-send-email 1.7.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155941>

I tought something like this could be a starter for better handling long
gitweb project lists (such as http://pkgs.fedoraproject.org/gitweb/).

Could anyone please take a look?
Thanks!
