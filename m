From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v5] Add log.abbrevCommit config variable
Date: Wed, 18 May 2011 13:56:43 -0400
Message-ID: <BANLkTimi1ar0+q2qfq1L0bm=qoRv+=5ZWQ@mail.gmail.com>
References: <1305681991-11699-1-git-send-email-jaysoffian@gmail.com>
	<7vmxikeiyt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 19:56:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMkzJ-00075I-8J
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 19:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933326Ab1ERR4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 13:56:45 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50620 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630Ab1ERR4o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 13:56:44 -0400
Received: by pvg12 with SMTP id 12so812795pvg.19
        for <git@vger.kernel.org>; Wed, 18 May 2011 10:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=CCewgBel+2B20OsZMvY/ZMRshHQxeir8MI6CDWKPLCM=;
        b=rPE+i2D5AiPzYrYJcB74C0cw5iRy8o4yVfL6q5ZYkAeEhylLoTKM6a4Gcu1pC2XBmQ
         Vaje305iKc6GGvEXFuN9sNv4NW9g/p0L1RmZbO6+FvZFrqO37j9wkz5McZyXRYfaq3gd
         l2PiBDtYPnOBmIysmxzxhZr2zAROQjTVh9KJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hgMEBnq6rg0XzWzAKuc5jnEggmvBGzSyBL1It45PHPdaHUZLX4WTIDGNkxNxvnUQ9X
         1ju1IeUjtS2owa+tR22cwOATP+CY1Gz1tZsnMxYhyQ7ASXvx25H8GpSHSI+0cEYfAr1n
         UzVpp3cGcq5IP/WeFTSm5eKRZWFy9mkjVGRxA=
Received: by 10.142.107.12 with SMTP id f12mr1241858wfc.226.1305741403857;
 Wed, 18 May 2011 10:56:43 -0700 (PDT)
Received: by 10.142.200.15 with HTTP; Wed, 18 May 2011 10:56:43 -0700 (PDT)
In-Reply-To: <7vmxikeiyt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173892>

On Wed, May 18, 2011 at 12:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Other than that, the patch looked fine from my cursory look.

Thanks, I hope v7 addresses all concerns.

j.
