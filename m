From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.0.0
Date: Fri, 30 May 2014 16:42:00 -0500
Message-ID: <5388fb283edaf_bd8167d3002b@nysa.notmuch>
References: <xmqqr43dbkni.fsf@gitster.dls.corp.google.com>
 <53866e8562b7a_12a7a052f87a@nysa.notmuch>
 <20140529185311.GB10865@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	git-fc@googlegroups.com
To: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 23:42:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqUYz-0003Le-8h
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 23:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933271AbaE3VmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 17:42:05 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:60697 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611AbaE3VmE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 17:42:04 -0400
Received: by mail-ob0-f179.google.com with SMTP id vb8so2404740obc.38
        for <git@vger.kernel.org>; Fri, 30 May 2014 14:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=gsoIP9hsvSHs299oqiDUbbag+3dxrF8wh5uSfg0KCtc=;
        b=oITQrU3A7UZ7Vy+jSlmRapfHjBMgDJtJ8f5y+2Ov2SDM1sEiaOtVrTkr/GnVS6wX25
         nO2NzH3D1WLX2Fk/VcqQPXmOw4OOVOcUAchvDAazL1f6vCUOCSgsB/rs9DH+pO/rg/TH
         ZmSoMTtiJjwfsbQOK075HjPc06LZGPPBC6p1eFNzW9AtMbnWevNn2rb2h+9U+FCwHA4X
         w2xqYBDst/Dpxd6dU/rAaQaLFnMPQ8duJH49XN7GqXtvK9fuif69xSwmz5YKv9piwFek
         ow+pBNC2jYflyTfvG9/32MEaxH4BIeF/IAZ4+k7WdWe68hQthIk5q7KQogDvd9mdJNHT
         u2og==
X-Received: by 10.60.42.144 with SMTP id o16mr20957365oel.47.1401486122914;
        Fri, 30 May 2014 14:42:02 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id jr2sm9252474obb.8.2014.05.30.14.42.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 May 2014 14:42:02 -0700 (PDT)
In-Reply-To: <20140529185311.GB10865@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250489>

Jeff King wrote:
> On Wed, May 28, 2014 at 06:17:25PM -0500, Felipe Contreras wrote:
> 
> > This is the last mail I sent to you, because you ignore them anyway, and
> > remove them from the mailing list.
> > [...]
> > [2], a mail you conveniently removed from the tracked record.
> > [...]
> > You also conveniently removed this mail from the archives.
> 
> I see you already noticed the changes in v2.0, but I wanted to address
> these points, because I consider silent censorship to be a serious
> accusation.

Yes, I also think silent censorship is a very seriours matter, and I was
very dissapointed that this mailing list would engage in that.

> I've reported the bug to gmane.discuss (no link yet, as I'm waiting
> for the message to go through, but it is not a high traffic group, so
> it should be easy to find the thread once it is there).

Thanks. At first I thought that was the reason, but then I noticed it
was always my mails that seemed to get this "bug", so I decided it was
too much of a coincidence.

Hopefully it's indeed a bug.

-- 
Felipe Contreras
