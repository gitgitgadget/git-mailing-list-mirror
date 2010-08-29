From: Alexander Sulfrian <alexander@sulfrian.net>
Subject: daemon: allow more than one host addresses given via --listen
Date: Sun, 29 Aug 2010 17:13:14 +0200
Message-ID: <1283094796-27984-1-git-send-email-alexander@sulfrian.net>
References: <1283094462-5184-1-git-send-email-alexander@sulfrian.net>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 29 17:13:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpjZc-00026X-5A
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 17:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601Ab0H2PN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 11:13:27 -0400
Received: from animux.de ([78.46.93.45]:41373 "EHLO mail.sulfrian.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581Ab0H2PN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 11:13:27 -0400
Received: by mail.sulfrian.net (Postfix, from userid 65534)
	id A6C5380DFFAC; Sun, 29 Aug 2010 17:13:38 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5-gr2 (2008-06-10) on mail.intern
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=7.0 tests=ALL_TRUSTED,AWL,
	DNS_FROM_OPENWHOIS autolearn=no version=3.2.5-gr2
Received: from laptop (unknown [93.214.39.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.sulfrian.net (Postfix) with ESMTPSA id 3677380D7590;
	Sun, 29 Aug 2010 15:13:37 +0000 (UTC)
Received: by laptop (sSMTP sendmail emulation); Sun, 29 Aug 2010 17:13:23 +0200
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1283094462-5184-1-git-send-email-alexander@sulfrian.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154690>


Hi,
uups sorry, missed the string_list_clear in v2.

Thanks
Alex
