From: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Subject: Using fromcvs/togit
Date: Thu, 16 Sep 2010 11:03:56 +0200
Message-ID: <AANLkTi=3u8JMe354J1yW0XTvg0GyTWWDOkAn4d-0cHS=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 16 11:04:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwAOF-0000lX-Fm
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 11:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138Ab0IPJER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 05:04:17 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39546 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab0IPJEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 05:04:16 -0400
Received: by ywh1 with SMTP id 1so326981ywh.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 02:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=cVo/4R9Og2CYaaP6JShCVx5ZZrd707FF6fORHfxGWBY=;
        b=URX5PkbVM3RuoKgojWBTDKuHPuuyR0m1jey4bW4Iw15yJWwE4hyGMTGpWjuvj9Onrt
         iV2h+4f/TEcGkik7Bm4Zu3+akPsh3kJbzcvSEvME2Oyuz8WTxdpQvlZGFVp8gYb0PtBB
         DvgxGMeetqBIixqKOnmXzmDAh7NLiV4tJVjn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=Sd7gxzbNdWwul+7v7pvSfIE3TlWVtV2s903UxijSlu3+CTP9iW8LZOnin9pbo3x0Ck
         VyZ4uq3+KTEUSTokFmEQIEIZD6rBbVinm3CGICD4G2w6icAphxQcBecCnYlcPNJtuHeD
         KWrdSSnI56bhsoPDdXqjHiPUVdwhzNHYniKnI=
Received: by 10.90.79.14 with SMTP id c14mr2266113agb.209.1284627856200; Thu,
 16 Sep 2010 02:04:16 -0700 (PDT)
Received: by 10.231.177.152 with HTTP; Thu, 16 Sep 2010 02:03:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156299>

Hi,

  I am trying to use fromcvs/togit, however it keeps reporting message such as:

fatal: Not a valid object name
...
fatal: Not a valid object name refs/heads/mathieu
fatal: Not a valid object name refs/heads/master

  What does those errors refer to ?

Thanks,
-- 
Mathieu
