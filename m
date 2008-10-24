From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2008, #05; Wed, 22)
Date: Sat, 25 Oct 2008 01:06:34 +0200
Message-ID: <200810250106.35185.jnareb@gmail.com>
References: <7v8wsf50ne.fsf@gitster.siamese.dyndns.org> <gdsjb1$eob$1@ger.gmane.org> <7vprlp1w1u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 01:04:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtVhw-0005mU-8V
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 01:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbYJXXD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 19:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbYJXXD0
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 19:03:26 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:43492 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbYJXXDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 19:03:25 -0400
Received: by ey-out-2122.google.com with SMTP id 6so387953eyi.37
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 16:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=uBUypq7r/mF4bN3zxNU3+DB2HQpIzT79JjmOn7OTxyU=;
        b=LgEr7irtYLQaav6s2A5mwAOgZcnsAGPY4Mdp5ZSub5mM5wNL1yFGZzQ3Vhf1u/kqec
         9Csgdh/gxqvovuEBF0/w/Wr/DklKNqCZC3OHMktvTWXoOsdk5Fxv54kk0uCpIfpr6aqj
         Z3OpZxaEPTgm41ilMgw4Ln3gnlv6k69lL687M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=byVv4xs3PN5vU/aOr+hYMeof30ADuIn/D7wCYKoRx3k6fEi47WBhwPWkYUIt88pZXq
         FBGJuHDAP3SswuQ5cti28e9Ep6/aTF1SHtN25vaK82LV8Czrc+jMJQE8PFNwn1roHN7r
         fE/A51JaBLFnZ3pYmDP8gPhoOZmqAukJyqs9o=
Received: by 10.210.22.16 with SMTP id 16mr3039321ebv.69.1224889404093;
        Fri, 24 Oct 2008 16:03:24 -0700 (PDT)
Received: from ?192.168.1.11? (abwm208.neoplus.adsl.tpnet.pl [83.8.236.208])
        by mx.google.com with ESMTPS id 3sm1147665eyi.5.2008.10.24.16.03.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Oct 2008 16:03:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vprlp1w1u.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99081>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes: 
>> Junio C Hamano wrote:
>>
>>> * gb/gitweb-pathinfo (Tue Oct 21 21:34:54 2008 +0200) 5 commits
>>>  - gitweb: generate parent..current URLs
>>>  - gitweb: parse parent..current syntax from PATH_INFO
>>>  - gitweb: use_pathinfo filenames start with /
>>>  - gitweb: generate project/action/hash URLs
>>>  - gitweb: parse project/action/hash_base:filename PATH_INFO
>>> 
>>> Seventh iteration; hopefully the usual gitweb gangs will give quick
>>> comments and ack to push this out to 'next' soon.
>>
>> If I remember correctly v7 is mainly cosmetic changes, and I have
>> acked all or almost all of the equivalent patches from v6.

All of v6 patches were acked.

> I take it to mean you reviewed v7 and we have your Ack on them;
> thanks.

Yes.

-- 
Jakub Narebski
Poland
