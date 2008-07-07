From: "Rob Shearman" <robertshearman@gmail.com>
Subject: Re: [PATCH 3/3] imap-send.c: Clean up coding style to better match the rest of the git codebase.
Date: Mon, 7 Jul 2008 13:17:49 +0100
Message-ID: <1096648c0807070517o8f22f0cs4d25103675bd635d@mail.gmail.com>
References: <1096648c0807070105s2b4ea1d9t2ab1eb17e891e3e8@mail.gmail.com>
	 <7vfxqm5ba2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 14:18:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFpg8-0000es-3O
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 14:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529AbYGGMRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 08:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753027AbYGGMRu
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 08:17:50 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:4245 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbYGGMRu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 08:17:50 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1439128wri.5
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 05:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=TWldHRZPmK+58qsaZzrygO/aSSOTTx182OPnkoTVuVQ=;
        b=x1aZ080ZBjwj9VxUnB0BI+VgKtfEWSktAJesukCeF2VFfMErCJWBqCOMxlM3FdiuQZ
         jlDi/eKK17+1eBNl5JaP84cgK+nUlnSXJk2xRhjhQWeh/rtPx6Oc/wlQt6OVkatYf4zD
         FDSyS5oxzf6TEbOy9dT2UnKoy9C1NhYaBwS4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mc0aHaG1VpLyGeYYpSTRP975LT1txN4aX+vqY60MAd9kYn0s5w+U/Zo9ZdusswQpmA
         0Qz/Dm0mHEo6egwp41b8umhtaaVQLyRqu3FOlO9A2gi/JDGXFZWQvhvKNoj+/nGPM7+m
         B+N/HlDmvUoqDwkWDQkUuwZKKf2xWHzahzcd4=
Received: by 10.90.101.17 with SMTP id y17mr5080843agb.72.1215433069108;
        Mon, 07 Jul 2008 05:17:49 -0700 (PDT)
Received: by 10.90.93.17 with HTTP; Mon, 7 Jul 2008 05:17:49 -0700 (PDT)
In-Reply-To: <7vfxqm5ba2.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87600>

2008/7/7 Junio C Hamano <gitster@pobox.com>:
> These patches seem to have been linewrapped severely.  I _could_ fix them
> up and apply, but the last one being about whitespace and style fixes, I'd
> rather not.

2008/6/22 Junio C Hamano <gitster@pobox.com>:
> Next time please do _not_ attach *.diff but follow the style of patch
> submission other people do (see recent patch from Linus for example).

How do you propose I fix this? I attached the patch last time to avoid
the problem of line wrapping.

-- 
Rob Shearman
