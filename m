From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH 0/4] implement "git cherry-pick A..B"
Date: Sat, 29 May 2010 15:12:23 +0200
Message-ID: <AANLkTilgOu1siF2ORrF7vspmL8Vsvsvz20dKNkSBKb3F@mail.gmail.com>
References: <20100529043738.569.85482.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat May 29 15:14:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OILre-0002Rf-Ua
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 15:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341Ab0E2NMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 May 2010 09:12:45 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:38152 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710Ab0E2NMo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 09:12:44 -0400
Received: by ywh36 with SMTP id 36so1396874ywh.4
        for <git@vger.kernel.org>; Sat, 29 May 2010 06:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=xO8L9vQ7lFMmNYxyJlfn7f2CTWq/VSKSPcPyV3Z+/zQ=;
        b=SMlM3YZjgjNnXmYtLd05tjD0fEszZlaMqvF40j/e8kXHJpUFooQx+pyL9m5PkBX0mQ
         L3csiMyqyPnRWTrevs4sn+u8/bDAj/GtPfk8FD/T8WKb8dc+s6jn6vdIJjWZ0ihVwvo0
         yHVWs0ANJIddFBmADjyVe3eLoZOMnc8lL4Tv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=tTDcB+6Mjr7vKHF4CdwCgrMN/wMYlRxzMBMBP3XDUM1g0lIum9M/xrv4oGzmJjMBUy
         jZGU1axBuKFDQEPyv7qz95EQ9qudHxrt+pbhvba00eg1iTCvYr7er6MapgkiJy+nPWmu
         O7WJlUWoYrbNjaScwLI4mO3dF1gO76iRQTMYM=
Received: by 10.150.166.5 with SMTP id o5mr2826293ybe.404.1275138763338; Sat, 
	29 May 2010 06:12:43 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Sat, 29 May 2010 06:12:23 -0700 (PDT)
In-Reply-To: <20100529043738.569.85482.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147965>

Heya,

On Sat, May 29, 2010 at 06:40, Christian Couder <chriscool@tuxfamily.org> wrote:
> This an RFC patch series to implement "git cherry-pick A..B" and
> "git revert A..B".

Awesome! Please keep working on this, I would love to see this implemented :).

-- 
Cheers,

Sverre Rabbelier
