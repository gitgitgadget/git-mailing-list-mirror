From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: msysGit patches for upstream
Date: Wed, 29 Sep 2010 23:22:31 +0100
Message-ID: <1285798953-15320-1-git-send-email-patthoyts@users.sourceforge.net>
References: <7vocbhsn03.fsf@alter.siamese.dyndns.org>
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 00:23:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P153E-0006Jc-O2
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 00:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796Ab0I2WW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 18:22:56 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:43668 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752379Ab0I2WWz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 18:22:55 -0400
Received: from [172.23.170.145] (helo=anti-virus03-08)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1P1538-0004Bg-Du; Wed, 29 Sep 2010 23:22:54 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out4.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1P1535-0003BR-5d; Wed, 29 Sep 2010 23:22:51 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 94AFD26646; Wed, 29 Sep 2010 23:22:50 +0100 (BST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <7vocbhsn03.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157613>

Junio C Hamano <gitster@pobox.com> writes:

> pack-objects.c usage string
> connect.c use of unchecked git_getpass()
>
> Good eyes, but these should not be part of the series but applied to
> maint.  If possible please send them separately.

Following up on this comment here are the two patches from msysGit.

Pat.
