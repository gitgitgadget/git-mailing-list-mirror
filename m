From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v8 00/16] GSOC remote-svn
Date: Wed, 19 Sep 2012 17:21:14 +0200
Message-ID: <1348068090-31988-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 17:22:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEM6U-0005kj-Um
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 17:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755763Ab2ISPWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 11:22:03 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64575 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755332Ab2ISPV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 11:21:58 -0400
Received: by bkwj10 with SMTP id j10so596995bkw.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 08:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=s40UEn5TO66u702p1+36mesO+hPkCkXtDu4oBZJ2Jsk=;
        b=qzz/NEHxK1MYpdWpB4Gqwzces2gLe0OfbWF/ZVQu7MXZHZ/EuR0UvbshHqFMmhuJ4S
         C/N7/vKzTkjgg/QgcSpgzk2pANvjYWwtkq26IyT05HUuYqjh8gcGid8We5nvou7xoy2r
         TxDslirqVYP3naC1xMrrTJukq+25f2a3e4+e0xIMyx9CwzKTqKOQ3kYB8/MMUUm+2+UK
         ZotuK9zICT07u6gmiNXLBNbPR4lVwyOOuhjed2h4CFpfjTqvjOLDD48M2HeXvM8Bth3z
         OsB0wuYnl1r/7JyA/6RRcXiC5narqVXiWNmksG77f8zkL44A/MMy70PfY5Zsu92Jzpv+
         czpA==
Received: by 10.204.147.1 with SMTP id j1mr1395903bkv.110.1348068116840;
        Wed, 19 Sep 2012 08:21:56 -0700 (PDT)
Received: from flobuntu.lan (91-115-94-56.adsl.highway.telekom.at. [91.115.94.56])
        by mx.google.com with ESMTPS id d13sm1570686bkw.12.2012.09.19.08.21.49
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 08:21:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205927>

Back from holidays with version 8.
Incorporates reviews by Junio, thanks!
Diff description is attached to the single patches

Florian
