From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v2] Give the hunk comment its own color
Date: Wed, 18 Nov 2009 16:20:43 +0100
Message-ID: <36ca99e90911180720yad3f08br1d1dd0d14f811ed5@mail.gmail.com>
References: <1258543836-799-1-git-send-email-bert.wesarg@googlemail.com>
	 <1258557087-31540-1-git-send-email-bert.wesarg@googlemail.com>
	 <31e9dd080911180717i27c6ef3fp736b7f8d41e4c8be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jason Sewall <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 16:21:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAmL9-0002tf-Oa
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 16:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757083AbZKRPUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 10:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754923AbZKRPUl
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 10:20:41 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:39030 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001AbZKRPUk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 10:20:40 -0500
Received: by fxm21 with SMTP id 21so1293632fxm.21
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 07:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=yzXGv2KVYVzSEMMnVqIOGne3ImIsdIoizjAvpnu2zno=;
        b=vjxsn7UnBHUjAV3akNqHLyqszybk0Ivqdcvlt64waA9nAsy0MbXJrAxL41rEAEoZ27
         DHGTM4J+f7WUg1QeE4X/1U2q1KrLFl/w17epmWSxKcYD7wsf2kYKAaOW1VVH+/dPBnIh
         DFZsfIcbmeoKYUZt1iYhaEGj2pa/hkaCVoTdU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=UkxUInpu6b9ex5vSEez3vPIZ+Hvd7kyXkVibbopbnEV5qzN4nLFSuBeEYfB9sG6RLs
         A7FUNGPe4yBrdtoLoak96K4XEufUlot1dgHTIEblA/HfZNy3LS7prVq+2dqE7Ai6nhZ4
         XrpbwcGOUcsn9882e/3665tD1G/aFUXgRpLSU=
Received: by 10.223.17.65 with SMTP id r1mr1417131faa.5.1258557643498; Wed, 18 
	Nov 2009 07:20:43 -0800 (PST)
In-Reply-To: <31e9dd080911180717i27c6ef3fp736b7f8d41e4c8be@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133186>

On Wed, Nov 18, 2009 at 16:17, Jason Sewall <jasonsewall@gmail.com> wrote:
> On Wed, Nov 18, 2009 at 10:11 AM, Bert Wesarg
> <bert.wesarg@googlemail.com> wrote:
>
>> Now with updated test suit.
>
> Spelling this as 'suite' would be sweet.
Thanks. I re-submit only if you find a bug too.

Bert
>
