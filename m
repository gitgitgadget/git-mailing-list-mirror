From: Francis Moreau <francis.moro@gmail.com>
Subject: Is current HEAD pointing at a given revision ?
Date: Tue, 14 Jun 2011 08:59:57 +0200
Message-ID: <BANLkTikFTHc4Qiu1YLxXgPhweNnVqMO11Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 09:00:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWNbZ-0008IQ-39
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 09:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362Ab1FNG76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 02:59:58 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35101 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab1FNG76 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 02:59:58 -0400
Received: by pzk9 with SMTP id 9so2484361pzk.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 23:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=g7NZQQnj6Jp3oddwSndTYgPKuWAlBI7JJnkxtvMCBgA=;
        b=KRyEVwylhSsjGfR7DULCb55eJwUg2G89XA0/vWBUsziRkk20r61Vdupbxn2TsO97yV
         qrZ8tYE/HNWrvHqCROC+S0Cy/dhxi1Zj6G0we7kASUSYi77t4illq0rjgMoXmQhHUymD
         ph3Urvh+OQEEjPe+VaD6WcTv0Hn45rLRIoh40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=q6A6ly0/QRqKUJaEyXpaHWCc+R/ljPJAySlr7HicnCX8Rgw5awP5j37baCJ7qquhUC
         GT6migSqey4XP5zdBRg5hMGFt6EwnjJqhjvNMbqF8Q6uklZ9oHOM8Cv+md4C+80ntlvX
         0NCjMkZGhE3mkeDwrFt2TtF0FStnU1SamV24E=
Received: by 10.142.164.21 with SMTP id m21mr69179wfe.116.1308034797525; Mon,
 13 Jun 2011 23:59:57 -0700 (PDT)
Received: by 10.142.110.7 with HTTP; Mon, 13 Jun 2011 23:59:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175749>

Hello,

I have a given revision (tag, sha1 ...) and I'd like to know if that
revisions corresponds to what the current HEAD is pointing at.

Could anybody give me some advices for achieving this ?

Thanks
-- 
Francis
