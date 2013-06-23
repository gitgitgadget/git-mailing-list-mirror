From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 01/14] t/t5505-remote: modernize style
Date: Sun, 23 Jun 2013 13:20:11 +0530
Message-ID: <CALkWK0=wMhSHOU1m-vUMshXbdKNu1TrY_mPCxdWKLOYY-O7YAw@mail.gmail.com>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
 <1371887901-5659-2-git-send-email-artagnon@gmail.com> <7vehbtgto1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 09:50:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uqf4a-0007pA-CO
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 09:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011Ab3FWHuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 03:50:52 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36124 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab3FWHuv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 03:50:51 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so22736251ieb.30
        for <git@vger.kernel.org>; Sun, 23 Jun 2013 00:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MOJ2O8BXa+rojEvmTC+z+prbzGFL2yakaL9xux6QpNM=;
        b=zdD13W9qJwJYbiIES/WECif64j/SKPGHcJN47d2UHOD5oD19sHbuCCAI3ofNDLI0zp
         o0TehEqcMSLB4tfnElODYf1AV1zf7i+nA36+JR7iwAs6/YttNqQI9rlFXsUpG2i3i8z8
         7PgPS8z17q/iUn6RcjpsJKE4WVp6CYdF+sGMZX8Mssp4nA+nliWLFo71icLfLTQpo29T
         M44NmWhIGISeONbM+maffXAovDGIHFqWQBXuCv0hRkC8D54gzD3ViH5DimjU/CbFoPB+
         RwhV3yIBKQQy+UnFgKhCoLGQnCuHzuPr2mRHqXf86uQxbpis7ftIiNQqq7x2R/Wh93cZ
         +pKQ==
X-Received: by 10.50.66.130 with SMTP id f2mr2789734igt.55.1371973851343; Sun,
 23 Jun 2013 00:50:51 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 23 Jun 2013 00:50:11 -0700 (PDT)
In-Reply-To: <7vehbtgto1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228726>

Junio C Hamano wrote:
> This smells like a largely blind conversion done with a script,

It is :)

> I'll queue with this fix-up squashed in.

Thanks; I really appreciate it.
