From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-subtree Ready for Inspection
Date: Thu, 09 Feb 2012 02:07:57 -0800 (PST)
Message-ID: <m3bop8uxoi.fsf@localhost.localdomain>
References: <87liocoayz.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan <jk@jk.gs>, git@vger.kernel.org
To: greened@obbligato.org (David A. Greene)
X-From: git-owner@vger.kernel.org Thu Feb 09 11:08:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvQv9-0002zJ-3j
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 11:08:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757599Ab2BIKIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 05:08:01 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41817 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab2BIKIA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 05:08:00 -0500
Received: by eekc14 with SMTP id c14so520859eek.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 02:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=pOQmB1W0HiGb1srtVOoBLDCYODQ4wnT/TD6+YYO/AQU=;
        b=rJixQr0K0eHRXslUeUvwAJLSM2HkBRKHl63qmMJbRGysLLEE8nuOhhs4AO/toJpUpk
         /QGsnxGA3IhYKwEFPPLd6fzIkJEGnlNZ104wJAnJ+4xuCTzfX0VtMLhgAlRtxKd4Inti
         /rPVTeUSKg19gwgoNOBj3ZTOOTEdoldLlk2Vk=
Received: by 10.213.33.145 with SMTP id h17mr272940ebd.89.1328782079172;
        Thu, 09 Feb 2012 02:07:59 -0800 (PST)
Received: from localhost.localdomain (abvr119.neoplus.adsl.tpnet.pl. [83.8.215.119])
        by mx.google.com with ESMTPS id y12sm7974690eeb.11.2012.02.09.02.07.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 02:07:57 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q19A7xVh008192;
	Thu, 9 Feb 2012 11:07:59 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q19A7wZ1008189;
	Thu, 9 Feb 2012 11:07:58 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <87liocoayz.fsf@smith.obbligato.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190284>

greened@obbligato.org (David A. Greene) writes:
> Jan <jk@jk.gs> writes:
>> On 02/08/2012 04:49 AM, David A. Greene wrote:
>>>
>>> I've put up a branch containing git-subtree at:
>>>
>>> gitolite@sources.obbligato.org:git.git
>>
>> A publicly accessible URL would be much more helpful. :-)
> 
> Do you mean running gitweb?  Are you not able to access the above
> repository?

Nope, the git:// URL or http:// URL -- anonymous unathenticated access.
SSH needs authorization (password or public-key based authenthication).

-- 
Jakub Narebski
