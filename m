From: Aghiles <aghilesk@gmail.com>
Subject: Useless error message?
Date: Wed, 21 Apr 2010 17:17:26 -0400
Message-ID: <z2o3abd05a91004211417v263d5a0eg497341ddf7bd79a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 21 23:18:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4hJH-0000U0-Tx
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 23:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608Ab0DUVRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 17:17:49 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:35547 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156Ab0DUVRs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 17:17:48 -0400
Received: by wwb24 with SMTP id 24so4379255wwb.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 14:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:content-type;
        bh=rMs8Fyn3nHj3IbXsL6D/RsPS20wuZQz2fxhZNdpK/rc=;
        b=JFZJXUH2eyYd8QDGUwNp0eBmXM2jWmbZsrug4M0kSala+Qteu+SB5rGuPW2mNHerTh
         dByh03rdaP6GG7cFD+ivRBnwKPMWkytTud30M38Nt30ZoOuF085IYOuv1+Qdtc1kwtbJ
         ER+TkTP+WzEJ6ehpuFsmLgDyuzYMxwj8W9ZBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=dnvYnubPDrNRHvqf9AkMgAMxizOt3R8ctV45dlrZuVNlk+gaUEK9Wa80zJvD/Vtipk
         CgrMy+OuJwYPGjmkwjCvS9f/iRsog4Au3QlSptEZ6w5PSny2I8iSyOLY2TcmkFJOLwrn
         nHFHo4Y0VXKBOZKApZG+zJh9lOhrpsGFqf+0Y=
Received: by 10.216.157.212 with HTTP; Wed, 21 Apr 2010 14:17:26 -0700 (PDT)
Received: by 10.216.85.198 with SMTP id u48mr2469466wee.225.1271884666158; 
	Wed, 21 Apr 2010 14:17:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145456>

"fatal: The remote end hung up unexpectedly"

Is that really meaningful ? Or maybe it is a configuration problem
on my side ?

  -- aghiles
