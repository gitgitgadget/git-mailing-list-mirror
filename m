From: Joshua Juran <jjuran@gmail.com>
Subject: Re: Gitbox
Date: Wed, 13 Apr 2011 11:55:32 -0700
Message-ID: <31F2C72E-3949-4052-B501-E596C0C61CC4@gmail.com>
References: <A2315DA1-780C-4024-B774-9AD5F9AA0DB6@medialab.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Searles <dsearles@medialab.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 20:55:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA5E5-00021s-IZ
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 20:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757792Ab1DMSzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 14:55:36 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43757 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757398Ab1DMSzg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 14:55:36 -0400
Received: by iyb14 with SMTP id 14so803798iyb.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 11:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=8+bcITJxn8gsE59Z/tuxIor9TLryZBrUVX5wCNbXLvs=;
        b=bxPTI2ZW15i6C/3pW1urKF40WabY567xhA99Vc/C5cKRsUIRObmgGSfW3EZwhdpha0
         pR/bfxhhyyzwsMD8lVGVc1aiHJGwumf0pCx0a/6/zl9Av8WwgdZV8wm6nJFplpNBRc6p
         MEhIlAHeTmHpyGIe/oxBkPYjK8UcLglwUIVmE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=xHnr8y1t688rd644ZSGfCYi0TCT0iVkywp0Y4SQg+6xRAyArfDd8MT3Q7wzIOpGdzc
         +h25JhSqDCu5yZ6I9IgfBEMtyiBCL3hc8VGaqXUAk93xl7SzqLqeA+dCKQh/WmzsCreC
         b6Ycm2oAwgnArao0wG/wWLyM4Bx3hs6pteJEI=
Received: by 10.42.151.72 with SMTP id d8mr1994231icw.26.1302720935119;
        Wed, 13 Apr 2011 11:55:35 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id o3sm603836ibd.44.2011.04.13.11.55.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2011 11:55:34 -0700 (PDT)
In-Reply-To: <A2315DA1-780C-4024-B774-9AD5F9AA0DB6@medialab.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171471>

On Apr 13, 2011, at 11:16 AM, Daniel Searles wrote:

> I'm curious if Gitbox is in violation of the Git's GPL.
> http://www.gitboxapp.com/

 From <http://www.gitboxapp.com/faq.html#gpl>:

"The application package contains a compiled official version 1.7.3.2  
of the Git content tracker. Gitbox neither links (statically or  
dynamically) against Git nor uses custom interfaces to interact with  
it. Git binaries are provided for your convenience only. You can  
replace  bundled binaries with any compatible build of the current  
version of Git or newer."

That appears to comply with both the letter and spirit of the GPL.

Josh
