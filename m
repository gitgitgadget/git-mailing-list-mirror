From: "Rhodes, Kate" <masukomi@gmail.com>
Subject: Re: git-who
Date: Wed, 8 Oct 2008 09:48:12 -0400
Message-ID: <8323B5AF-AECC-4576-BA85-382BAD8FE74B@gmail.com>
References: <DE2CF127-A7FD-4765-A8E4-5235C5F1B9A9@gmail.com> <48EC4F9D.4020202@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 08 15:53:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnZQR-0000vr-1X
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 15:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293AbYJHNsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 09:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753381AbYJHNsR
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 09:48:17 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:24155 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbYJHNsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 09:48:16 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2118857wah.21
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 06:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=qZAl+UZy+zstZeFqyP/9GPO9myiHq95WX+Hortknghs=;
        b=HoYOlVsGLD4tyfbQO/cwgdvvChGuOvggTbR4zZP1WN3zWWguLeTQbTpwNcYdyBFeuR
         T4DtrjdjXhJ/KmvoEBxc4bzdVXWuL1LIM+12volgEBNU4q7z53ZR27YpoBuNCnx7Kmwo
         u1vk0DqdjYbD9WuoY9LFJMx0T1Rr/fsxoBa3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=ooYtuSAOEec/MOz0BOmsvg5f4RuSZFO3NYqi7SGyblmxmkekyEcj3wMARzomtVpmIB
         6+CTSJZWouVMRVvM68F4yu3xQ6FDGks4u41J595ruLB7oS9gUaVztVMuEFJZ0KytHndc
         11Fj3WoXVeAk7jHWK2MI9UNrk+hpaYPfB5uZc=
Received: by 10.114.181.1 with SMTP id d1mr9114434waf.3.1223473695676;
        Wed, 08 Oct 2008 06:48:15 -0700 (PDT)
Received: from ?172.30.14.217? (fw01.cmbrmaks.akamai.com [80.67.64.10])
        by mx.google.com with ESMTPS id 6sm9846139ywp.3.2008.10.08.06.48.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Oct 2008 06:48:14 -0700 (PDT)
In-Reply-To: <48EC4F9D.4020202@viscovery.net>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97800>


No. No, that's far too simple.


;)

-Kate

On Oct 8, 2008, at 2:13 AM, Johannes Sixt wrote:
> Rhodes, Kate schrieb:
>> Once upon a someone asked about seeing who had touched some files.  
>> Petr
>> Baudis responded with a quickie script that did the job.
>
> Wouldn't
>
>   git shortlog -s -- path/to/file
>
> solve your problem?
>
> -- Hannes
>
