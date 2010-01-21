From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2010, #06; Wed, 20)
Date: Thu, 21 Jan 2010 03:04:12 +0100
Message-ID: <fabb9a1e1001201804j4d847569p6c1a9921464e6cd@mail.gmail.com>
References: <7vljfsxos5.fsf@alter.siamese.dyndns.org> <fabb9a1e1001201706i4c7ffaecs55153c9220bc5992@mail.gmail.com> 
	<201001210240.10522.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jan 21 03:04:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXmPh-0002OG-3i
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 03:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716Ab0AUCEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 21:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753399Ab0AUCEd
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 21:04:33 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:56829 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab0AUCEc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 21:04:32 -0500
Received: by pxi12 with SMTP id 12so6159128pxi.33
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 18:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=FciyaeiPxerz0O3y6BNPJEq3a0RwFcvRcHSZvYPDJbY=;
        b=Iuxtyrs1xcqCJN0g3ZO/R9nDula4D7TUL3EW0weMJYZmmHjyaYXYjgyu0BLUepHq4+
         b+wsGoidkUqf6EomAedWDT9tvIhROvyk56X6VqN71NVrLuwgrwfzlJ8g2Ol8zxK8m9Vu
         MFYQu1Q5iFU0PJapUI3vY5scSKRWIKkaoBJRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=GqZ2Cq4PUrXCzjoUVgch9ga4quSiXf+dAWI/q1QdpdChty//b1gw8p3l9JwJmddYZj
         5KuyyvydrKdbb2jirWHs7PfMzGYyuSZLw9zRxOZVM7+2S5f83UiczSz9J1gMPzexe1Iz
         0hZKC/Sd/jeAEMVMLTfcyfWilyD5xUbEpfzi8=
Received: by 10.142.75.3 with SMTP id x3mr525481wfa.340.1264039472106; Wed, 20 
	Jan 2010 18:04:32 -0800 (PST)
In-Reply-To: <201001210240.10522.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137616>

Heya,

On Thu, Jan 21, 2010 at 02:40, Johan Herland <johan@herland.net> wrote:
> You misremembered. Only the three first were merged to 'next'. Junio was
> about to merge the rest, but I asked him to hold until I had produced the
> current iteration.

Ah, I should have checked the last what's cooking; or looked at that
inter-diff thingy Junio's contemplating on doing :)

-- 
Cheers,

Sverre Rabbelier
