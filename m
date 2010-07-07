From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: git status / ls-files
Date: Thu, 8 Jul 2010 02:01:54 +0530
Message-ID: <AANLkTikdA7CEY19bYHIxIsPezaZZo-SrEaSupi2UoRNS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 07 22:32:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWbHl-00038D-Lm
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 22:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938Ab0GGUb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 16:31:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38079 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab0GGUbz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 16:31:55 -0400
Received: by gye5 with SMTP id 5so30905gye.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 13:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=REI5Gi6Yphd7LNPmsYVVoj53qiAaw/aIs92fvJ20hr4=;
        b=oltd0Lu57O1sVmo+0FmI2z/L9lYGeYAf4FHpwbaDTbb9fhispomBdHdZERIPhxdUqS
         fULEWGQS5yxJWYf6A8GwxnmMgWNO5jW70Quy/CpmdcTiFxTaYfOc4LtMaGfvQ7r5EHwT
         NvrqvptD06S6baeQnSGaq7dX6/+4tHaiqbluU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ZEQrSo8XuRD0FGnFVU5DnThXMkcioq0wPX/PNmOqEC7rAQZkI7UmRaDSCgEVayhOk9
         YhQBXnTVDgbHxWZIut7U0+bqIkvAf31arb7lUbmhZh7cNLGMYksbN/12PtaDkmCHgabc
         XLNjydX/tdxeia3H/Uy9ZLP4ea3XChObdcNWM=
Received: by 10.90.54.14 with SMTP id c14mr3019606aga.174.1278534714349; Wed, 
	07 Jul 2010 13:31:54 -0700 (PDT)
Received: by 10.90.100.4 with HTTP; Wed, 7 Jul 2010 13:31:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150500>

Hi

Is there a query command which I can run on my workspace which will
give output of following style. (in the same that of command
git merge foo  givesO

I have examined git-lsfiles ; git log ; git-status didn't get output
in following style


Auto-merging nv/aaad/aaad_utils.c
Auto-merging nv/aaad/include/aaad_session_private.h
CONFLICT (content): Merge conflict in nv/aaad/include/aaad_session_private.h
Auto-merging nv/aaad/test/session_authen_test.c
CONFLICT (content): Merge conflict in nv/aaad/test/session_authen_test.c


-- 
Thank you and best regards.
Mahesh Vaidya  / 9740500144
http://www.twitter.com/forvaidya
