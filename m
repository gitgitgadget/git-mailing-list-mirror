From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: What's cooking extra
Date: Wed, 19 May 2010 11:12:23 -0400
Message-ID: <4BF3FFD7.6020904@gmail.com>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 19 17:20:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEl4Q-0007RH-3T
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 17:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405Ab0ESPUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 11:20:25 -0400
Received: from mail-yw0-f180.google.com ([209.85.211.180]:51233 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832Ab0ESPUY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 11:20:24 -0400
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 May 2010 11:20:24 EDT
Received: by ywh10 with SMTP id 10so4212676ywh.1
        for <git@vger.kernel.org>; Wed, 19 May 2010 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=uIG5JYT0TUEFxFwgN1yrKR3m3OsFU9NyLdDdYQPyk8U=;
        b=s7mVg0DIpgW5IR8i1juoPqBgudKShz3+EhCEAKMTeZU+yImOmsvsjImO9SO/FgjIE2
         CyT6++WqGUZo3SO4EvwuiFDOeBq3yxKPmyEKAcPDWDf8sKLFROobNgAm1FUb4aH4rKPK
         EcCboS4qCvfCMMd86QiD6svHPIpxV5ffncOzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=BMVpj/t14Xlf7g0LcE/VSqGNTwTlCstT3NNt8AEDlbuJ6z8rjRLZDEJPCyxiZC4JEO
         vA86JXVphxwKOmU4rTYnW2vlRpmK3PuZ3vLJoRTUD0Ctk9WDfFZcIBXswrdWoxD9uf4/
         jjkckDdQgpiOedA/o6p+remkdoRy4LdMNtlAo=
Received: by 10.150.74.15 with SMTP id w15mr9537644yba.408.1274281950129;
        Wed, 19 May 2010 08:12:30 -0700 (PDT)
Received: from [10.0.0.6] (c-24-129-111-166.hsd1.fl.comcast.net [24.129.111.166])
        by mx.google.com with ESMTPS id w18sm1393133ybe.10.2010.05.19.08.12.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 May 2010 08:12:28 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147331>

Junio C Hamano wrote:
[...]
> 
> I took a new day-job (yesterday was my second day) and haven't quite
> adjusted yet, but I finally managed to find some time and energy to browse
> through the list traffic and even queued a handful of topics.  I expect
> I'll be more productive and back to speed in a week or two, but until then
> I expect to still be slower than my usual self.
> 

This is interesting news. Congratulations on the new job! It must be a 
good one to get you to leave southern California. Is your new employer 
subsidizing your git work similar to your previous employer?
