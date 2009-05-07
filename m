From: Baz <brian.ewins@gmail.com>
Subject: Re: A note from the maintainer
Date: Thu, 7 May 2009 14:40:58 +0100
Message-ID: <2faad3050905070640v1718794dt2f5d2da3f06b3bb6@mail.gmail.com>
References: <7vocu5s824.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 15:41:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M23rD-00051m-GB
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 15:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbZEGNlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 09:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753305AbZEGNlA
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 09:41:00 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:51439 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192AbZEGNk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 09:40:59 -0400
Received: by bwz22 with SMTP id 22so777464bwz.37
        for <git@vger.kernel.org>; Thu, 07 May 2009 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YGUSYNkNfkcnpFf4nXz7FK+5GsjbLF716W5KrHKG2DM=;
        b=pOcQugWUxjfWDq3i7+nwHyc+1w/JE0Vt7BBiJfj3GCuBEShi/g3wJ3vTp5OXuse69+
         V79Zalr15jV1uiDC1n4L/7j8tghdHib09N+LjEwQ9vFKKzAgRe59J563gq8/bxqSn4jb
         4/gb4FC3tqiPGL1f8ydfwWgcqT6rN86LOLiCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=X59pSLa3jFOLtsDMKpKo/U+ADzcqX9ngLNcWOK21qrjgnmsAp122ATIyx1p/9lGaa3
         WMPVlbIXrqS1SJb38TBV/z0QQuXpBJd17lgGsulX7xSYjKIgTazb89vsfyT+wh63eSIO
         mBAmmrcJfQu/RYQ4gG5DlyzV7ZyNIKjSgFAns=
Received: by 10.223.108.15 with SMTP id d15mr1583208fap.62.1241703659008; Thu, 
	07 May 2009 06:40:59 -0700 (PDT)
In-Reply-To: <7vocu5s824.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118477>

Apologies for not quoting the mail I'm replying to, but gmail would
just make the character encoding issues worse.

Junio, Rene Scharfe's name appears incorrectly in the MaintNotes
message - the mail was sent as iso-2022-jp. Previous editions of this
mail (like the one on 4th March) were in utf-8. Maybe a consequence of
the recent change you made to your emacs setup?

http://article.gmane.org/gmane.comp.version-control.git/115746

Just mentioning it in case it causes problems with patch mails down the line.

Cheers,
Baz
