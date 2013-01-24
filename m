From: Shumkin Alexey <alex.crezoff@gmail.com>
Subject: Re: [PATCH] send-email: Honor multi-part email messages
Date: Thu, 24 Jan 2013 22:31:46 +0400
Message-ID: <CAEFUfsE-Ca=4jAyoaCtoeVYX0Etsn2Cj42OJm+nu4042JPJaBg@mail.gmail.com>
References: <1316507347-6693-1-git-send-email-zapped@mail.ru>
	<7v1uvb6mn9.fsf@alter.siamese.dyndns.org>
	<20110921001925.03a83d3a@zappedws>
	<20130124143816.7c33fc1c@ashu.dyn1.rarus.ru>
	<7v622mcuyb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 19:32:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyRar-0000ej-Lf
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 19:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705Ab3AXSbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 13:31:48 -0500
Received: from mail-wg0-f42.google.com ([74.125.82.42]:41377 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190Ab3AXSbr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 13:31:47 -0500
Received: by mail-wg0-f42.google.com with SMTP id 12so542784wgh.5
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 10:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=6EYG2ShvZBXremHJPOvK9ql6xJgxlafb1kYRNAa7KNE=;
        b=Gg70N/5tDh2yzSym+jgmrVr//Tlr5CelOQNddnAn2dYrNkBB/KTSAMjse8X3STvv85
         WzglYFe+w+H+U6oWBTeUGBr5zjbocb34c4YUpO8ITkpgt24IXr7jFUC60ccUxFE7v1fH
         3UD9mkOllCFhjn2z3ga4K0usiPGQ08hlcqTubYHqQvycoaGlLvCugvssPDohFHOMND2T
         Wl+b/swrnpXs+EuvHlzHErbuKnnqCEVbOLyGY/619i6T1fbrJPIiHYOryaMwETz+wpA3
         DvDqj9bH8NfnOqIVjCu1yqaPIbtLhUbK0hOuU6RNua4LpeQf5GFJLFYD7Sm0xQh0+v/n
         d2oQ==
X-Received: by 10.180.14.10 with SMTP id l10mr4963052wic.7.1359052306142; Thu,
 24 Jan 2013 10:31:46 -0800 (PST)
Received: by 10.194.157.69 with HTTP; Thu, 24 Jan 2013 10:31:46 -0800 (PST)
In-Reply-To: <7v622mcuyb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214439>

I've meant you did not reply to my last message in this thread
http://thread.gmane.org/gmane.comp.version-control.git/181791

2013/1/24 Junio C Hamano <gitster@pobox.com>
>
> Alexey Shumkin <alex.crezoff@gmail.com> writes:
>
> > Bump
>
> Bump what???
