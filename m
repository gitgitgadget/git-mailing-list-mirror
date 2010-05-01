From: David Lee <zhushenli2@gmail.com>
Subject: How to push to remote(dropbox) when submit automatically?
Date: Sat, 01 May 2010 09:42:35 +0800
Message-ID: <4BDB870B.8080503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 01 03:42:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O81jF-0004qG-QX
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 03:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438Ab0EABmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 21:42:44 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:63755 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756635Ab0EABmn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 21:42:43 -0400
Received: by pxi17 with SMTP id 17so473694pxi.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 18:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=itTrHtRMazmcG8/M0yNaoiL/mBTVtotAhpzpHJd7YPc=;
        b=tqYgvxu4VKlkqgfzB+P/1A/YRgry7JkPPlInFq8AYVofLFHe4qsRwb5SPtLmbUIfJW
         bIMvkij52sS3DfVGfIvpXFQ89l3jTsE6q8zx8AdyuWEaW5xbyqO80Xx0UDJoHipBICPV
         Mph386EO4nc8oybHOxk7TLFR275Xq19jPG/E0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=Chx8MyCU0DQhh1KftdlEOboWd7pVKi7dTqADUH/UKlh+MWTMInfH2gakjZ9AiLXbr+
         yU60ZcoS8AFP8Hljd8eQwbrvUpgruQJ1YH0GRHfScY8XqngYJTXOrJaVpRLNRtazkvbW
         txSZkhPhVTy5UPE2cd1A56KIlbZreYDUUGGVM=
Received: by 10.115.80.1 with SMTP id h1mr5692389wal.116.1272678162246;
        Fri, 30 Apr 2010 18:42:42 -0700 (PDT)
Received: from [116.232.93.59] ([116.232.93.59])
        by mx.google.com with ESMTPS id g30sm11471372wag.4.2010.04.30.18.42.39
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Apr 2010 18:42:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146073>

Hi all,

I am new to git and find it powerful.

I build a local repository(origin) and clone it to dropbox 
directory(dropbox-git). Each time I submit to origin, I have to "git 
push dropbox-git" manually.

How to push to remote when I submit automatically?

Thanks,
David
