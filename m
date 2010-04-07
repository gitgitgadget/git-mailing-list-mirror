From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] Documentation/SubmittingPatches: Clarify Gmail section
Date: Thu,  8 Apr 2010 01:03:12 +0530
Message-ID: <1270668793-2187-1-git-send-email-artagnon@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	John Tapsell <johnflux@gmail.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 21:36:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzb2d-0000J2-Rq
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 21:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873Ab0DGTfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 15:35:55 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53007 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab0DGTfy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 15:35:54 -0400
Received: by pwj9 with SMTP id 9so1324551pwj.19
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 12:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=kXvMG4XBRfXPVqpWDcuRK/SpRjajmyNEYOORCcFtXG0=;
        b=SvoD3GEECiKTixNEDi7FmtQMvDuW6VmhRltLkAaXm7H8oM53E5NQ5PQUwfBq6Sy2PD
         rfTr4GCwFdZziXl5y24zN5scxYEOoyxNLYGZDwsrQL3yxsTyAJqOf6GF5zRueE18fqWV
         rGhNoWgWGkb466AJBJppu+dhPfWbKxzhguWic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=IyxIqiPbxZtzXCpTp4JwCQKB16OkFDn0GWMY0DLcqdrtixVtZhVFsdVkvpRsDJg2b0
         mLe3Qoq7Fqn9mTJtToT8NLkJrcJCytyLLHPFfsSkNSKiOtEMJsrzU8D3jtmUj2YoG6uq
         M+9nIOgWXBJtHyI+TDKuc5nti+lQVx0nVJLE8=
Received: by 10.142.1.21 with SMTP id 21mr3606478wfa.173.1270668953806;
        Wed, 07 Apr 2010 12:35:53 -0700 (PDT)
Received: from localhost.localdomain ([203.110.244.110])
        by mx.google.com with ESMTPS id j42sm385492ibr.7.2010.04.07.12.35.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 12:35:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144275>

I made a mistake. Junio pointed out that the Gmail web interface wraps
lines no matter what. Using "git imap-send" doesn't help.
