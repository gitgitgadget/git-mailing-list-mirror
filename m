From: Thomas Koch <thomas@koch.ro>
Subject: git test repository creator
Date: Tue, 5 Jan 2016 14:22:03 +0100 (CET)
Message-ID: <1475689154.16587.1675247d-815f-4c4b-9c93-3aa94b8d08fb.open-xchange@office.mailbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 14:28:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGRex-00037S-UL
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 14:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbcAEN2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 08:28:20 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:37122 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616AbcAEN2T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 08:28:19 -0500
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jan 2016 08:28:19 EST
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.mailbox.org (Postfix) with ESMTPS id 1933343A4E
	for <git@vger.kernel.org>; Tue,  5 Jan 2016 14:22:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
	by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
	with ESMTP id BGtBPsQcWHUf for <git@vger.kernel.org>;
	Tue,  5 Jan 2016 14:22:03 +0100 (CET)
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.0-Rev11
X-Originating-Client: open-xchange-appsuite
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283375>

I don't know whether I dreamed of such a tool or whether I just can't find
it anymore:

Specify characteristics (size, dir depth, files count, history length) of
a repository and the tools creates a random git repository with this
characteristics.

Such a tool is obviously useful for testing and I would need it right now.

Regards, Thomas Koch
