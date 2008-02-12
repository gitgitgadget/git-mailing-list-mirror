From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Fix 'git cvsexportcommit -w $cvsdir ...' when used with relative $GIT_DIR
Date: Tue, 12 Feb 2008 21:41:34 +0100
Message-ID: <200802122141.35594.robin.rosenberg.lists@dewire.com>
References: <200802110228.05233.johan@herland.net> <200802112158.16830.robin.rosenberg.lists@dewire.com> <200802120043.41610.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Feb 12 22:02:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP2GO-00047L-CR
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 22:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764853AbYBLVA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 16:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764930AbYBLVA5
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 16:00:57 -0500
Received: from [83.140.172.130] ([83.140.172.130]:8258 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1764919AbYBLVA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 16:00:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 13CA480069F;
	Tue, 12 Feb 2008 22:00:54 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bIn3rQdGN32d; Tue, 12 Feb 2008 22:00:53 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 22FC1800690;
	Tue, 12 Feb 2008 22:00:53 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <200802120043.41610.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73689>


Looks ok. Something for the test suite?

-- robin
