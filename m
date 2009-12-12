From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/3] Update advice in commit/status output
Date: Sat, 12 Dec 2009 17:13:09 +0100
Message-ID: <fabb9a1e0912120813h1c41b7bfg4525f8f01e04ddb1@mail.gmail.com>
References: <7vk4wtysyu.fsf@alter.siamese.dyndns.org> <1260608523-15579-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 02:19:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJd7n-0002n9-4M
	for gcvg-git-2@lo.gmane.org; Sun, 13 Dec 2009 02:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbZLMBQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 20:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbZLMBQQ
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 20:16:16 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:57248 "HELO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932593AbZLMBQO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 20:16:14 -0500
Received: by vws30 with SMTP id 30so330182vws.33
        for <git@vger.kernel.org>; Sat, 12 Dec 2009 17:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=TyX11fApEu3yTwZKaWY851HXCPx3Bsn2yIa8WTtDpaw=;
        b=OBokbk2bqhVJexjp/N9iI7/w5QA7gzZN71HGGAzHMQqjS0u1b5WRSZcZllYeqRWYuF
         s8Uj3mt9/1654+aT2oo6TYL4kOIKkDORbCrHmqlS46SXQh6eVsy2RioukDHfmUE57xd1
         tGzHl2NgyXUj2iAJ9Z8sfTw+v+UDYFiv+thfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fteuBGrKQ8lF9Fh2LlD4XrQ5EnmKEFvpC4PVCP0kX1dgIROK6OXZlVTnuBALyv1XFK
         WV3vAbmrI4tGXCn4BsEJMRScQ2jBLPPe6M1dSobyyJ+qe0I2b4LEohDFlCdhuFDNJ4UR
         R3ozyOmk4VTl1hxld5kvkJO6dUBYjJq/HHipc=
Received: by 10.220.127.36 with SMTP id e36mr485417vcs.64.1260634409267; Sat, 
	12 Dec 2009 08:13:29 -0800 (PST)
In-Reply-To: <1260608523-15579-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135137>

Heya,

On Sat, Dec 12, 2009 at 10:02, Junio C Hamano <gitster@pobox.com> wrote:
> In neither case, "git reset HEAD <path>" is absolutely a wrong thing to do
> while merging.

>From the patches I'm guessing you mean "In either case" instead?

-- 
Cheers,

Sverre Rabbelier
