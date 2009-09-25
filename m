From: alexandrul <alexandrul.ct@gmail.com>
Subject: Re: git log --pretty=format:%h prints (unrequired) abbreviated sha
Date: Fri, 25 Sep 2009 21:40:16 +0300
Message-ID: <4ABD0E90.5030301@gmail.com>
References: <e5bfff550909250240q3351d39evbcf507af422fde43@mail.gmail.com>	 <e5bfff550909250246qed6f2ci4237bdaefd8a18a@mail.gmail.com>	 <4ABC9C5D.5030202@viscovery.net>	 <e5bfff550909250344y535a05edx7d30ad7e48a5f036@mail.gmail.com>	 <e5bfff550909250430x14b0d7f4w5e22467ddd66cc29@mail.gmail.com>	 <e5bfff550909250704x724fd4c7lebe7184b4557c7a9@mail.gmail.com>	 <4ABCCFE4.6070202@viscovery.net>	 <e5bfff550909250718y51709692kc8d1e2586017341b@mail.gmail.com>	 <4ABCE167.7060204@viscovery.net> <e5bfff550909251125t6ed59b1fv953eee597adc4471@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 20:40:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrFim-0002aT-AA
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 20:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbZIYSkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 14:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbZIYSkW
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 14:40:22 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:37758 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbZIYSkV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 14:40:21 -0400
Received: by bwz6 with SMTP id 6so136430bwz.37
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 11:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=9blDuJ1vvbkoRC1ebQEMkFR2yKCl4Iwufgw3lUA50sc=;
        b=rKiypwQWfA4E7RzYsq9S1LZTVCkQbw/qj61aLlcB/0VyuBMgosJqz3sQEg0G8yKW7+
         M39cNvQGuryE180m+SkuUH7CRxQiBN/XIxER49aESI/VPgU96QuNNk1Ao+wvbeQA3mjG
         kFZNvGwws+rueeUQVSEkT4+FUZQIxPbp7JU8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=iirvZiDR5apRmo4OkXjPhWPDAcOhnc6010kpPQbmlSINhoOxG1NoM+raCaPsDd6XPH
         9HzkTJGr+eilNF3MClSqdkjyjdTEeb5O8buQspiuF6Y/mbg16rJWr15DZRNSet4PLubm
         05tV5nNxZ8EF5snE9XGqARMN0BJaxCo1P6Fc0=
Received: by 10.86.187.27 with SMTP id k27mr1236821fgf.11.1253904023316;
        Fri, 25 Sep 2009 11:40:23 -0700 (PDT)
Received: from ?192.168.2.8? ([89.136.114.133])
        by mx.google.com with ESMTPS id d4sm554136fga.17.2009.09.25.11.40.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Sep 2009 11:40:22 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <e5bfff550909251125t6ed59b1fv953eee597adc4471@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129102>

> Now path is C:\Program Files\Git\bin
> 
> I have even deleted the contents of cmd directory to be sure they were
> not called.
> 
> But unfortunatly the problem persists.

Could you copy the git installation folder to another PC and see if the 
problem is still present? Or archive it and upload it on some file 
sharing service?

Have a nice day,
   A.
