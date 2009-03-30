From: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
Subject: [PATCH 0/5] Header includes cleanup
Date: Mon, 30 Mar 2009 02:55:20 -0700
Message-ID: <1238406925-15907-1-git-send-email-nathaniel.dawson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 11:57:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoEEo-0001OF-Nk
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 11:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756897AbZC3Jzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 05:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755477AbZC3Jza
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 05:55:30 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:10076 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199AbZC3Jza (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 05:55:30 -0400
Received: by yx-out-2324.google.com with SMTP id 31so1910555yxl.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 02:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=DSU5JPrACPRzDnWYeSfBZV1M4aQea3DOqGKBHaPSlP8=;
        b=tCSK6D4LkckYBgbWOKuPSAotR+27yngR/36ieERlYnvITUDJZOlehzs5BoB0l4GBLd
         6pNcfq1c2kIbvV0xxZ17OHPgkpZ5eXdz+1qwPo/bQv1QZT2uRniAdnboyKNcLjozF+cK
         wyr5Gvwgy4pfyL1w/Zw1XFABAgna2z4XKI6Co=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=W/idCpJvqEw1+MmUuhqG2nCy9pfRKFWwbKP0XT6M1Do2g45suj9RHhLo9KYEPENZ5J
         XjHeyiw3Mf+/B33of0v8Gb12s8Pf/iiPeJxZhg/+2z+/1Qv6o0c24p63wH+9QlDAhSlD
         2ZMLUCYiVrX90JPE/uQShSNDVDxSsQlYXE/NM=
Received: by 10.100.137.12 with SMTP id k12mr3738555and.55.1238406927775;
        Mon, 30 Mar 2009 02:55:27 -0700 (PDT)
Received: from localhost (ip68-98-113-49.ph.ph.cox.net [68.98.113.49])
        by mx.google.com with ESMTPS id b14sm897446ana.43.2009.03.30.02.55.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 02:55:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115121>

This is just the beginning for this project. I'm slowly cleaning up the header includes one chunk at a time. I hope my patches aren't too messy, I've learned how to better utilize git to make patches and organize my commits logically so I'll submit neater chunks henceforth. You can expect patches from me nightly until I've finished this project.

Regards,
Nathaniel P Dawson
