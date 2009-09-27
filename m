From: alexandrul <alexandrul.ct@gmail.com>
Subject: Re: git log --pretty=format:%h prints (unrequired) abbreviated sha
Date: Sun, 27 Sep 2009 13:40:57 +0300
Message-ID: <4ABF4139.4080403@gmail.com>
References: <e5bfff550909250240q3351d39evbcf507af422fde43@mail.gmail.com>	 <e5bfff550909251304g53202e1fna50afabf93722ce5@mail.gmail.com>	 <23e749600909251507m345ab66aq74730d1ada75cb7b@mail.gmail.com>	 <e5bfff550909260217l7f6e8766te072decee1bbbbf3@mail.gmail.com>	 <4ABDE6FF.2090008@gmail.com>	 <e5bfff550909260309x1ef007a0k8a1ab85f78fe5c5e@mail.gmail.com>	 <23e749600909260500i5e04864bsc845b9f20a11141@mail.gmail.com>	 <e5bfff550909260553v38243faaic53860d20322232d@mail.gmail.com>	 <e5bfff550909260858u71df1487va569262fc9819415@mail.gmail.com>	 <23e749600909261128v4e398dadhc8be096f2500b17e@mail.gmail.com> <e5bfff550909261455g4eef8432jbb90048417deecba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 27 12:41:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrrBs-0006d6-Cd
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 12:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772AbZI0KlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 06:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753764AbZI0KlF
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 06:41:05 -0400
Received: from mail-yw0-f174.google.com ([209.85.211.174]:40383 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747AbZI0KlE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 06:41:04 -0400
Received: by ywh4 with SMTP id 4so3985686ywh.33
        for <git@vger.kernel.org>; Sun, 27 Sep 2009 03:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=zHbEKVpzQ9Ft8O3mUBmPeFlVURpb5pHqZazFNZ3KhJE=;
        b=E3w6/Ou3MrVTfkef62qg6k9EPIuz53YvPqFZOX7eC4ATM/Ar2HNic8OfasIvsSRDa4
         9fEmzXLyc+A8Iyn30824JmF9nCKRm/9joZeQnof44XwpR8ZKM88K/rjT343D/fsn6/Mr
         2OgQubAytAfE5W5xZ3aKxjGKTGtp5N/JoFhqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=NbkCFVg3+MhTMIsc1MFlzBfHgIPqYm20bk/5xOfUNey4+0kjvweqH6crahfwWFnvNY
         zDDdHm0YsZ2zvIW7e8kMLzOS2tSmqqg4e2/jknwHokkfrtyogx/AWBaqqTNbE9AjeoT0
         iAqUCWhKOkIGE9SOlYdqg8d0vS0AlqyTf4640=
Received: by 10.90.134.2 with SMTP id h2mr2117363agd.110.1254048067352;
        Sun, 27 Sep 2009 03:41:07 -0700 (PDT)
Received: from ?192.168.2.8? ([89.136.114.133])
        by mx.google.com with ESMTPS id 11sm4255102aga.38.2009.09.27.03.41.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Sep 2009 03:41:06 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <e5bfff550909261455g4eef8432jbb90048417deecba@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129206>

Marco Costalba wrote:
> Hi Alexandrul,
> 
> Now it works !!!! :-)  :-)
> 
> It was a virus !  I have run Malwarebytes Anti-malware 1.41 and it
> found some virus (I send you the logs in attachment), after removing
> them the problem disappeared.
> 
> I have Kaspersky as antivirus, but, although a very good antivirus it
> failed to identify them.
> 
> I didn't know this Malwarebytes, but it seems very powerful.
> 
> Thanks anyhow for your exceptional help, I have really appreciated that !!!!
> 
> 
> Thanks again
> Marco
> 

You are welcome.

Unfortunately, Kaspersky and Malwarebytes target different threats, but 
both of them are very good at what they do.

Have a nice day,
   A.
