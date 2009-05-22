From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Heap allocation error in git-1.6.2.4 on Cygwin. Problem not 
	present in git-1.6.1.2
Date: Sat, 23 May 2009 00:29:20 +0800
Message-ID: <be6fef0d0905220929p64f45f52ub8dd39feb063936b@mail.gmail.com>
References: <10845a340905220423x69eb1718n7a6f9dcd5c2df459@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: RQuadling@googlemail.com
X-From: git-owner@vger.kernel.org Fri May 22 18:29:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7Xch-0007Dw-H6
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 18:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbZEVQ3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 12:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbZEVQ3U
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 12:29:20 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:50081 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbZEVQ3T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 12:29:19 -0400
Received: by pxi1 with SMTP id 1so1424404pxi.33
        for <git@vger.kernel.org>; Fri, 22 May 2009 09:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VO1NoP5SlTZwtHJ6UcpaJOZb9213rMUrhJnCOsVJ7Hs=;
        b=rD39vRU4/9L52SWm61Zfj0NHTZ/O3xGn+/RJ87Nwec7Tm4F7mTxo8sqYL+rnMDOnpG
         uFP3sfFNCst/sk+9Ka2Z4YskgRUEj2+8sXBNdnVvDWNHeNBjIDnC/pxxolP/7GWdC0Sy
         +++p1z2Bxj5eyI17X4T+R8DftrAG8TBqF5tv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=URNDsPvYesjBV165GJvvG0ZCKPId2CJRsO6uJV/JjWRT4HO403Rl47AqyDtE0kyUL2
         U9aWoQFQTaoNO8U27RWptXBZyGddGgFIX/2yaZnTsfCXMweUILBCujkZmlB6C7swqhM1
         bckgfUjfujUKcCcTBLDhl6LT/WBd/+3uVzBkk=
Received: by 10.114.200.2 with SMTP id x2mr8156394waf.83.1243009760455; Fri, 
	22 May 2009 09:29:20 -0700 (PDT)
In-Reply-To: <10845a340905220423x69eb1718n7a6f9dcd5c2df459@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119741>

Hi,

On Fri, May 22, 2009 at 7:23 PM, Richard Quadling
<rquadling@googlemail.com> wrote:
> I've just upgraded GIT on Cygwin from git-1.6.1.2 to git-1.6.2.4.

you would be better off posting this on the cygwin list; I've read of
some git problems there.

-- 
Cheers,
Ray Chuan
