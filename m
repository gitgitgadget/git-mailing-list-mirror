From: "Steve Hoelzer" <shoelzer@gmail.com>
Subject: [PATCH] git-stash documentation: add missing backtick
Date: Tue, 7 Aug 2007 12:38:29 -0500
Message-ID: <588192970708071038q5decfdbaic0800d14c09bcc2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git mailing list" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 19:38:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIT0w-00089C-Ey
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 19:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761334AbXHGRib (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 13:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761360AbXHGRib
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 13:38:31 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:10114 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761334AbXHGRia (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 13:38:30 -0400
Received: by an-out-0708.google.com with SMTP id d31so332550and
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 10:38:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=udmjbFVSH5fKEIdCFbzfgz5Qc53JCd9/t6NEnKw8c4oA72MFVZ/kgG7gdbI/UuONSjImg3GlmIWV2CqebJ2tE5TcelwhNXRJO2+sNTbqFkBAF1XlcOvDvSb/zgVQv/JLMV4MauRtgw2oFW16ogDycJxuRLnoPqRtqjJcPYqCg7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=V7XOMIBVrXkmzdMvESCL76HgA1gpSCA/NY8J3z9P1UAg7tqfSN2+B6vTN+PhlNNXylCnC84gJpdUkcJ288/Gt2Es9rSDLU40jcdikqoOFpbnTYOmFi3kfKuaCIh3nJJkN9ZwLG2sdguq6cgVgX1qBoFBK+sP6obNjl66Oqytwnc=
Received: by 10.100.10.20 with SMTP id 20mr4028228anj.1186508309645;
        Tue, 07 Aug 2007 10:38:29 -0700 (PDT)
Received: by 10.100.105.9 with HTTP; Tue, 7 Aug 2007 10:38:29 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55268>

Signed-off-by: Steve Hoelzer <shoelzer@gmail.com>
---
 Documentation/git-stash.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 17121ad..4ec61a9 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -45,7 +45,7 @@ save::
 list::

 	List the stashes that you currently have.  Each 'stash' is listed
-	with its name (e.g. `stash@\{0}` is the latest stash, `stash@\{1} is
+	with its name (e.g. `stash@\{0}` is the latest stash, `stash@\{1}` is
 	the one before, etc.), the name of the branch that was current when the
 	stash was made, and a short description of the commit the stash was
 	based on.
-- 
1.5.3.rc3.141.g53d646
