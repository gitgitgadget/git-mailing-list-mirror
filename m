From: Pedro Rodrigues <pedro@onimail.net>
Subject: Re: gitk repo
Date: Wed, 09 May 2012 20:18:33 +0100
Message-ID: <4FAAC309.5090706@onimail.net>
References: <4FA9BDAD.6080401@onimail.net> <7vhavptg2r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 09 21:18:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSCPK-0005UE-Is
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 21:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760424Ab2EITSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 15:18:37 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:59760 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756803Ab2EITSh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 15:18:37 -0400
Received: by eeit10 with SMTP id t10so258341eei.19
        for <git@vger.kernel.org>; Wed, 09 May 2012 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=7Edc2+/+gsoMcArO/ckKR03EX3oLlfbmvtn0zH+lhrw=;
        b=ShjOpofwvC76rZAPpPzW3Wo9IsK2NIqvS+JSAa1aHiODXZxUIECMUv4kXcATe0fmbT
         3TVnLlQVRr0cWLbe0lrjuXXqpgheE4hNFSc3vZ6C5oJMredc/mIl0nnKFDI4Z4r3t/D1
         QDrCi29vjFbooi0al9JXio+ePsZBoSU3YXN+A1mKgWTVMCNCRRJIpSa6i2ND5UjtSCWs
         d8qLAxharvu35cTF9R8Mctt659by8QtepIxd3fec9UdE3mORQyd7KQb2vvzWd8K1tj3z
         16anqEb66CRZ00BlDSUpSK6arUkl7TN/b1Fy22rGM+9y4Rr07CvQWq7Jlq399SjqaBk9
         XhPg==
Received: by 10.14.53.66 with SMTP id f42mr147849eec.83.1336591115809;
        Wed, 09 May 2012 12:18:35 -0700 (PDT)
Received: from [192.168.1.100] ([89.180.65.147])
        by mx.google.com with ESMTPS id n52sm17194156eef.6.2012.05.09.12.18.34
        (version=SSLv3 cipher=OTHER);
        Wed, 09 May 2012 12:18:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <7vhavptg2r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197493>

OK, thank you!

Pedro Rodrigues

On 09/05/12 18:33, Junio C Hamano wrote:
> Pedro Rodrigues<pedro@onimail.net>  writes:
>
>> I'd like to hack a bit on gitk.
> Paul Mackerras<paulus@samba.org>  is the guy you want to pull from, ask
> guidances from, and send your patches to.
>
> 	[remote "paulus"]
> 	        url = git://ozlabs.org/~paulus/gitk.git
>
>
>
>
