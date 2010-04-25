From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/5] Export more test-related variables when running external tests
Date: Sun, 25 Apr 2010 13:47:10 +0200
Message-ID: <201004251347.11102.jnareb@gmail.com>
References: <20100424132255.30511.98829.stgit@localhost.localdomain> <20100424134640.30511.37449.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 25 13:47:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O60J1-0007GM-CC
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 13:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973Ab0DYLrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 07:47:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:52747 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918Ab0DYLrR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 07:47:17 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1362194fgg.1
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 04:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=tb6fRlb4rMMI1NV/RyskjttSqdu07cSfFdCLjkjmicY=;
        b=Hni42sprqbzWnfm7YMWGGcfa5ZzH0lKez69q337Ymf5Q3N8mF9X500NaKWeEq9kyUv
         Ytof+2FIOh0uufdsSChsdKJfevU5iOLcPyzwOrVmrCYP/9nctTrAm8ByQ4VqAJGDSGo6
         8ce2215oYQRaFk0/6vgmunieosHQ3I1Sc3Dp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=rJOkwsdOt/1xHS71JXjUVBRlzBIsPCBiHMFra3EEEpBl6QFX7MQqs4wo9UHP6TcUId
         xDhO5ZCQPi00stK4L4hKcglXiEdjAzonZ70MK8sVu26/GjuPqUnUi3YLeTE/BFmVG/QR
         gtiwzs53EfbfoxRJqaNdbdOAWC6jLVWylPTHM=
Received: by 10.86.126.33 with SMTP id y33mr4457955fgc.51.1272196032341;
        Sun, 25 Apr 2010 04:47:12 -0700 (PDT)
Received: from [192.168.1.13] (abvs189.neoplus.adsl.tpnet.pl [83.8.216.189])
        by mx.google.com with ESMTPS id 28sm666371fkx.6.2010.04.25.04.47.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 04:47:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100424134640.30511.37449.stgit@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145736>


>  t/test-lib.sh |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 t/test-lib.sh
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> old mode 100644
> new mode 100755

Ooops, I'm sorry, the mode change is accidental.

-- 
Jakub Narebski
Poland
