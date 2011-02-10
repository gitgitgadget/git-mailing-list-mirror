From: Jason Brooks <jasonbbrooks@gmail.com>
Subject: Unknown software revision
Date: Thu, 10 Feb 2011 14:33:47 -0800
Message-ID: <733D558A-0935-42A8-BA5B-7B97703656F6@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 10 23:33:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pnf5I-00059l-Ew
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 23:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757247Ab1BJWdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 17:33:51 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41569 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757161Ab1BJWdv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 17:33:51 -0500
Received: by ywo7 with SMTP id 7so816005ywo.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 14:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:from:to:content-type
         :content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=uRx79bakTnSvo3Us0biDUJKmojNZpEGHi9NktdUeHt0=;
        b=m1rDRPvnXhSTHyoA4vtLGFsPOwWxWnqygj+XohZPpCUNfevDV91S6bugW1b3D7Bkr9
         8PyqcQNBxZpRuLDBi91695OErpLn5438nt1uYkLZnAZ3mqA01IhzmlPJ8DOrnXpXVXe4
         LQSGgUTF5cpRoMwjluCAabqOB+mbSQjU/hCiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=i23Dh0NxwItaBzrvyqhJI3v8AE1Pd7IabWeFXY+KLceeMAbMqM914c7OHUabP+xtlS
         eTVD6VyY3B4r4rQq+zTGATOt67JWgfqji1hNQ0RBRj+bqY4dMhDFD7qNKYxj5khWLDyB
         WNceuz077VOdEttzJ7nM5IR5Ow5MfXp/LtaSE=
Received: by 10.150.189.17 with SMTP id m17mr4057310ybf.250.1297377230370;
        Thu, 10 Feb 2011 14:33:50 -0800 (PST)
Received: from [192.168.1.3] (pool-98-108-149-135.ptldor.fios.verizon.net [98.108.149.135])
        by mx.google.com with ESMTPS id r24sm352164yba.6.2011.02.10.14.33.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 14:33:49 -0800 (PST)
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166507>

Hello,

I am not sure what I am asking, so I thought I would start here.  If I
knew the name of this operation, I would look for it.  :)

I have also posted to the git-users google group, but signs there tell  
me this is the better place.

I have a software deployment that was copied out of a git repository
but without the .git directories.  Thus, I have no idea what revision
this deployment is, so I don't know how to upgrade from git.  Is there a
method, or script out there that can help me?

The trouble is, I should have made a branch or tag when I deployed it  
to at
least freeze that version.  At the very least so I can rebase and re-
deploy it again.  (I could be wrong about this last statement: I am  
definitely new to git)

I appreciate any assistance you all can give me...

--jason
