From: Aneesh Kumar <aneesh.kumar@gmail.com>
Subject: [topgit] tg update error
Date: Thu, 12 Feb 2009 13:39:06 +0530
Message-ID: <cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, madduck@debian.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 09:10:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXWeb-0004pI-Vy
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 09:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbZBLIJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 03:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbZBLIJJ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 03:09:09 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:32788 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbZBLIJI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 03:09:08 -0500
Received: by fxm13 with SMTP id 13so1586639fxm.13
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 00:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=CrQzOKLbTQZbam0+Toq1MKExN3Fl9KXbKwXd0QC7/Rg=;
        b=Ng7dWOIujResI6sRI4WIdE2es2w8jxnvSipoX3kepBeRvp4q7+j77uIXMmPptf/pYj
         FK5Z9PtPn499GyXtHQKxIxA3703aOCBqAL/UaPseKu75V6Mu51nwD1PrMPTcmZdRaJai
         Z5MT9uXMFB+NTdfXBV2+EuJfIL4lSAFY3Nj7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=BATCQFEgikBXj/iLIrpAmfi5Q+GnqQXOPVMB7q5356kbDBx2miq5UGa06YXV4mWrNc
         IMxRJ0mV+S+fXmTsAPnYW+HFMccwLcmf/r369qT9jIfjHJoCzp7BhlMmpVQp6A0MBCR+
         RcbZNPWPtk8xrLQ+Vqk5xxr4Hv7DrO4xg7TRo=
Received: by 10.180.241.8 with SMTP id o8mr216693bkh.102.1234426146278; Thu, 
	12 Feb 2009 00:09:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109581>

doing a tg update with latest git gives the below error

[extent_validate@linux-2.6]$ tg update
fatal: Refusing to point HEAD outside of refs/heads/
[extent_validate@linux-2.6]$

-aneesh
