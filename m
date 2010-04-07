From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Documentation/SubmittingPatches: Clarify Gmail section
Date: Thu, 8 Apr 2010 01:30:47 +0530
Message-ID: <n2tf3271551004071300pe6ae8f42v8f0a19e1b6cec272@mail.gmail.com>
References: <s2kf3271551004071052o58656534z80de5068b207bdb2@mail.gmail.com> 
	<t2of3271551004071108ic4393a8v3ae9929f01b8c086@mail.gmail.com> 
	<7v8w8zcc5h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	John Tapsell <johnflux@gmail.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 22:01:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzbR8-00043c-71
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 22:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168Ab0DGUBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 16:01:10 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44532 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab0DGUBI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 16:01:08 -0400
Received: by gyg13 with SMTP id 13so718188gyg.19
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=jsU6P0aCWbGQOYteCb7frrfz3KrzSAHfe4OfHFH6h1E=;
        b=KqyYD6kIUwj8zitOpLemnjgfNbGNVy+ec3fh3c4r1HlbyDZWNATDChTQjrxRD6otVp
         nvk4g8bbpnC7n62HoRzOTaEq87IV+Ux5pDdCJs0zQdUijXut3rc9JvXAuXCENPcNMPoT
         k1lvABpx/EA8hFID2zXiu7pCbhMRNfHXrvvnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=cewqTsnwHolbNyWavU7/6zx5VmD1JyTvBGm+IiruzVNsbCjKg4ZnPOR01KuYv5nNwo
         amqEAfWPeQvby00GozIlknxiQbdnYVvz6bHGM/FYMkSmd/6KQLsqceUDo74moyFmpSZ/
         KioGGOPGfPvaWg/Bt7sRxWjIvjsBsqnioLUp0=
Received: by 10.90.69.14 with HTTP; Wed, 7 Apr 2010 13:00:47 -0700 (PDT)
In-Reply-To: <7v8w8zcc5h.fsf@alter.siamese.dyndns.org>
Received: by 10.90.197.4 with SMTP id u4mr828691agf.22.1270670467093; Wed, 07 
	Apr 2010 13:01:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144279>

> Didn't I already say that it is _known_ not to work?

Right. Sorry about that. While testing, I must have made the mistake
of using a patch that didn't not have long enough lines to be
linewrapped.

> As you earlier said that the documentation of imap-send states GMail web
> works, perhaps that description is incorrect and needs fixing.

Thanks for the pointer. I've prepared another revision.

-- Ram
