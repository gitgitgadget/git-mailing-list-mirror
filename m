From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 1/5] Documentation/remote-helpers: Rewrite description
Date: Sun, 18 Apr 2010 13:23:22 +0800
Message-ID: <w2jbe6fef0d1004172223kd0d5de2hccf67badf817bd97@mail.gmail.com>
References: <1271551934-sup-1118@kytes> <20100418022900.GA1669@progeny.tock>
	 <1271566331-sup-9608@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 07:23:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Mys-0004rz-6k
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 07:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722Ab0DRFXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 01:23:25 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:53242 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab0DRFXY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 01:23:24 -0400
Received: by ywh32 with SMTP id 32so2105496ywh.33
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 22:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=KYST3h6GAPuxQL/jx0DonrJC45yuNJtOdEVMKvS2lPY=;
        b=hxxO4PDbiqYf9Cc7NhCgLWn/5H+VuVar+78swggNefpulxIkEdqROwLlHSGgxt7UPQ
         EjQBkS2s/UBXtBNkP4UtaGQ2esmnPBpiAIDZE+NSmNciqNNRwWordPKEFqlnFR86Yzt1
         MMem6gJ9pMf0RTTo6Bi9lxXzC5a47dR671Nqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SMIhHSPQPVcYWDZWMI/X+twaNNZtfcymhjCegoHY0xn/09I/j7YlsFi4OzWQKUSIEj
         wduWss6KMqLKhdmdREsY9o60BL+yR799vvWfPc/AuqObA1Oj0MsVzZA6ZoKCfwugZ7Um
         aPjVFC6AnWqgG0dQfeZ55mEnbDfxQNGYnARwQ=
Received: by 10.231.10.65 with HTTP; Sat, 17 Apr 2010 22:23:22 -0700 (PDT)
In-Reply-To: <1271566331-sup-9608@kytes>
Received: by 10.101.178.20 with SMTP id f20mr8942672anp.229.1271568203144; 
	Sat, 17 Apr 2010 22:23:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145213>

Hi,

On Sun, Apr 18, 2010 at 12:58 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Since patch has already been reviewed many times, and signed off by
> Junio before going into pu, I've tried to minimize changes and prepare
> a fixup patch while addressing all your concerns. Do tell me if it's
> alright.

barring any comment from Junio, I think a fixup is probably more
onerous than a resend with the fixup squashed in; that is, assuming
the old iteration is already git-am'ed in, and the fixup applies onto
a new iteration.

-- 
Cheers,
Ray Chuan
