From: Francis Moreau <francis.moro@gmail.com>
Subject: Adding default remotes to a bare repository
Date: Wed, 9 Feb 2011 17:53:07 +0100
Message-ID: <AANLkTikVtSFs+qRiWJwxre8urOJs7q2HXBGPZkiTmn=i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 09 17:53:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnDI3-0004MP-3n
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 17:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab1BIQxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 11:53:09 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62389 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097Ab1BIQxI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 11:53:08 -0500
Received: by pwj3 with SMTP id 3so179214pwj.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 08:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=p/wUm8GtnlmKpn5Nq4UaeSLDoMgMqSXOFTlrS6p4vOM=;
        b=ts0F/1CVzZUDiVNO3noxrPdTCkd23262dIwuklpmZgWsW3OSP398UJMjwC6NzX3VOb
         bvMbJ2MagRnup07RwdkXvlomlWZyGTqge6Qj3j2l4Kv01ae12bOeMgKvklSlxXk4Delc
         j3Wx3y8uNv1EUZXYJaTHZJjGFp9G78zmgsdE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Z49MEZkBuuXtEUgaNEOKN7atUGJppn5Wx94Hv0lHCQHrdk3WVpYvtbv45ThaBrXmdS
         wLbsQX2hgIIIpFtVdw3g9ueLkUrsXphMyTq6M0QSE8AHt+Zi3QkDM9Ak9xgB0NfmSl8B
         wxQQ3+zOHp4l0PqyEzR39ItmFFRycMXZ10nIw=
Received: by 10.142.154.5 with SMTP id b5mr18756780wfe.125.1297270387957; Wed,
 09 Feb 2011 08:53:07 -0800 (PST)
Received: by 10.142.44.3 with HTTP; Wed, 9 Feb 2011 08:53:07 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166432>

Hi,

Is it possible to add some default remotes for a given repository ?

That is when cloning the repository, I can use the default remotes in
the cloned repository.

Thanks
-- 
Francis
