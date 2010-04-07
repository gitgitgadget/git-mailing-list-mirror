From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Documentation/SubmittingPatches: Clarify Gmail section
Date: Wed, 7 Apr 2010 23:38:49 +0530
Message-ID: <t2of3271551004071108ic4393a8v3ae9929f01b8c086@mail.gmail.com>
References: <s2kf3271551004071052o58656534z80de5068b207bdb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Tapsell <johnflux@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 07 20:09:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzZgn-0007ca-Fm
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 20:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745Ab0DGSJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 14:09:11 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:60860 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab0DGSJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 14:09:09 -0400
Received: by ywh2 with SMTP id 2so692056ywh.33
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 11:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=BkPltqy9E/mjJ2b8yN/Hgaf+K18O5RhweMNkXNnZ4Jc=;
        b=Qud8YQaOrS2bBiH79DLDkcEFFA4XHvp8JBlYCBlzhWP52LEbD913/m1eaf5MxYkx/b
         sa//GJAYfuUZttPWsh8CbPetLPfia1JCKCu6+8Ez0Ds4/gURMu5kLq1GDpoqWSNbAhFa
         TiloJr5qwRk6B9d+tqhe6IBs6+cpjDuxMFWuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=XEmwbSxaw8zzlYWgIahS3ZAeoDcPrB/ZIxt+A1baWH/DArHRluVYYKkKD3La3b4ZaJ
         Mwkj3fZ/PtqEMN9BxAKLgN/14MQu/8av9HnPKhVMkJaEBnDaJmAHMnmzoCk6UoDb/Ewr
         cxjz5UZ9sYNDhSU+5lDKH30sc+WIOnIO9WSLo=
Received: by 10.90.69.14 with HTTP; Wed, 7 Apr 2010 11:08:49 -0700 (PDT)
In-Reply-To: <s2kf3271551004071052o58656534z80de5068b207bdb2@mail.gmail.com>
Received: by 10.90.2.23 with SMTP id 23mr3196605agb.103.1270663749090; Wed, 07 
	Apr 2010 11:09:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144258>

Hi,

I can't be sure that I'm right about this. Could someone please confirm?
Ironically, this patch seems to be broken. I think it has something to
do with the auto-save (for drafts) in the web interface.

-- Ram
