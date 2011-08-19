From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH v3 0/4] git-p4: Improve branch support
Date: Fri, 19 Aug 2011 19:23:17 +0100
Message-ID: <CAOpHH-XduhWd_CTORxRoc24En1+Q_kvxb0uwD6HQqLNv+B0phA@mail.gmail.com>
References: <1313711046-23489-1-git-send-email-vitor.hda@gmail.com> <7v4o1d46uk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 20:23:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuTjU-0002MX-Oi
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 20:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150Ab1HSSXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 14:23:48 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:43653 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab1HSSXr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 14:23:47 -0400
Received: by iye16 with SMTP id 16so5977564iye.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 11:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4qC+zZU+T1JDeT6yhlojGYNZvwUfpuQwJCxVwCjyIDM=;
        b=DbMH0ptvmGt+hqOKc7agwVMnhZTNm7f+kmWbXFE9GJZf27MDCCSqmIzG67TjnDR9IV
         YC4Tq8/+wMWf4+eJe1uvulFrjAdnnJlGiPOcDAJWe8lPGq0Ifkn84gEBpEpGn/2ZX/Ix
         tPdwI4oNPcu1qpHmJrvCv0kmvhrmi1HtxWnck=
Received: by 10.231.21.194 with SMTP id k2mr160618ibb.2.1313778227150; Fri, 19
 Aug 2011 11:23:47 -0700 (PDT)
Received: by 10.231.19.8 with HTTP; Fri, 19 Aug 2011 11:23:17 -0700 (PDT)
In-Reply-To: <7v4o1d46uk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179717>

On Fri, Aug 19, 2011 at 7:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Even though this is labeled as v3, I do not see a corresponding v2 in
> recent mail log. Is this an unrelated series that depends on v2 of your
> "p4 rename/copy" topic?

You have to search in older archives... :)

http://article.gmane.org/gmane.comp.version-control.git/167998

-- 
Vitor Antunes
