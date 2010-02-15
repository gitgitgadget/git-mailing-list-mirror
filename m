X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Using test-lib.sh under GPLv3?
Date: Mon, 15 Feb 2010 09:39:28 +0100
Message-ID: <871vgmki4f.fsf@steelpick.localdomain>
References: <87ljf8pvxx.fsf@yoom.home.cworth.org>
	<87hbpwpoko.fsf@yoom.home.cworth.org>
	<5641883d1002060727ia4e6c16lf800a92fc8735430@mail.gmail.com>
	<201002081614.24284.sojkam1@fel.cvut.cz>
	<871vgr78lr.fsf@yoom.home.cworth.org>
	<87iqa2y0gz.fsf@steelpick.localdomain>
	<87r5oqe7mi.fsf@yoom.home.cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 15 Feb 2010 08:39:44 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, notmuch@notmuchmail.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
X-Virus-Scanned: IMAP AMAVIS
In-Reply-To: <87r5oqe7mi.fsf@yoom.home.cworth.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140000>
Received: from vger.kernel.org ([209.132.180.67]) by lo.gmane.org with esmtp
 (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id 1NgwUW-0006V9-9e
 for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 09:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752220Ab0BOIjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2010
 03:39:35 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:37841 "EHLO
 max.feld.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1752017Ab0BOIje (ORCPT <rfc822;git@vger.kernel.org>); Mon, 15 Feb 2010
 03:39:34 -0500
Received: from localhost (unknown [192.168.200.4]) by max.feld.cvut.cz
 (Postfix) with ESMTP id DCE9119F3322; Mon, 15 Feb 2010 09:39:33 +0100 (CET)
Received: from max.feld.cvut.cz ([192.168.200.1]) by localhost
 (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044) with ESMTP id
 FAvfL6GERslT; Mon, 15 Feb 2010 09:39:29 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34]) by
 max.feld.cvut.cz (Postfix) with ESMTP id 99C1419F3381; Mon, 15 Feb 2010
 09:39:29 +0100 (CET)
Received: from steelpick.localdomain (k335-30.felk.cvut.cz [147.32.86.30])
 (Authenticated sender: sojkam1) by imap.feld.cvut.cz (Postfix) with ESMTPSA
 id 1FCDBFA003; Mon, 15 Feb 2010 09:39:28 +0100 (CET)
Received: from wsh by steelpick.localdomain with local (Exim 4.71)
 (envelope-from <sojkam1@fel.cvut.cz>) id 1NgwUK-0004KG-86; Mon, 15 Feb 2010
 09:39:28 +0100
Sender: git-owner@vger.kernel.org

Dear Junio,

I like the simple and powerful test suite used by Git and I would like
to use something like that in Notmuch project (http://notmuchmail.org/).
Notmuch is licenced under GPLv3 and we think that things will be simpler
if everything in the repository is licenced the same. You are mentioned
as a copyright holder in test-lib.sh and t0000-basic.sh so I'd like to
ask you: Would you mind using parts of these files under GPLv3?

You can see the patches for how I'd like to use these files at
http://notmuchmail.org/pipermail/notmuch/2010/thread.html#1431

Thanks,
