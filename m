From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/20] remote-bzr: massive changes
Date: Fri, 26 Apr 2013 16:21:37 -0500
Message-ID: <CAMP44s1ZCD4qNH23Zv-Lb3aq9qGeB0LAkr8mOBwusMKPO9GVmg@mail.gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s0XHXbX5brcxv-NROJ=PSSzi3oEzQv81=f3-1-zcypQuQ@mail.gmail.com>
	<7vy5c5xmka.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 23:21:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVq5U-0006cW-KJ
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 23:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757381Ab3DZVVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 17:21:40 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:49574 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab3DZVVj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 17:21:39 -0400
Received: by mail-lb0-f172.google.com with SMTP id d10so1319175lbj.17
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=cuPxXsRWAVhQTLIqN2bcZXNqfa8+i3ZxAl72Q4A13/U=;
        b=aiwASurnXuICapNQn3wYPnV+E2s7ouMPzAR/6qDuCKiIxPbaYVGFLUfNHXYnSRWimz
         FYdc8fDz2+EN6Z4woeKKx2rUXSIP4s9/N0C4kuRNC8zbhNPn3MszEvG84KzsVk8hifBH
         egRE3zoKf1Jal48z0P+8YGmSncMKQkv4D+gqFGWTDZ0qBGsP2Rsi8xQESpnMXU5acj84
         WN65XqZ7OO+ppJePO5eYb+pv9ml3/EO8Rrszyb7z4m4366mII+W4zdwB7t+wY9IvOwGJ
         0P97O8d0vyJG5Sxi1nzjyiyMA4QagT3yQF1F2wS85PCb9uP4R7jq5j3CUydwX1OrTs+M
         uvLg==
X-Received: by 10.112.22.198 with SMTP id g6mr18675887lbf.135.1367011297982;
 Fri, 26 Apr 2013 14:21:37 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Fri, 26 Apr 2013 14:21:37 -0700 (PDT)
In-Reply-To: <7vy5c5xmka.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222592>

On Fri, Apr 26, 2013 at 11:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Apr 25, 2013 at 8:07 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>
>> I forgot to mention; these apply on top of the previous 'fixes and cleanups'.
>
> Then I should probably wait for v2 6/9 of that series is rerolled.

Done.

> There could be ones that you may want to reroll other than 6/9 in
> that, I didn't have time to look at the backlog. I'll be whipping
> the -rc0 into shape today and it is unlikely I'll have time to look
> at this or the previous one today.

I don't see any need to reroll more. All the concerns of v1 and v2
have been addressed in one way or the other.

-- 
Felipe Contreras
