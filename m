From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit-2.1 and qgit-1.5.8
Date: Tue, 1 Jan 2008 09:26:55 +0100
Message-ID: <e5bfff550801010026x62d53b25m2e78a30b4a8b0ee@mail.gmail.com>
References: <e5bfff550712302335ie96e143g55c93e984fba6aaa@mail.gmail.com>
	 <4778CB78.2010906@yahoo.it>
	 <e5bfff550712310358g347d883fm9866f328f24e3ad0@mail.gmail.com>
	 <47792B3E.60509@panasas.com>
	 <e5bfff550712311007j1cd8223es51b6a59dfb958193@mail.gmail.com>
	 <4779F200.1020507@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Filippo Zangheri" <filippo.zangheri@yahoo.it>,
	"Linux Kernel Development" <linux-kernel@vger.kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Boaz Harrosh" <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 09:27:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9cTQ-0001Pg-11
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 09:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbYAAI1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2008 03:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbYAAI06
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 03:26:58 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:5515 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbYAAI05 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 03:26:57 -0500
Received: by rv-out-0910.google.com with SMTP id k20so4843015rvb.1
        for <git@vger.kernel.org>; Tue, 01 Jan 2008 00:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=BGfH/spj/BwTmJkil9itmSRKFch+7qC2dc3wxhg2uLE=;
        b=gvB2AWqZjxBRhrP0A5Ww0pGtwf8YcqJ+FIhgJQ4Z7WOE5MOgog5BsUPYgccxge+xKq5xkFfYo7P4nzDsRi58HpDy4X4GeEuyYqyG6jCqc+pqJm1X6ljiw7ETs7a++xf5aSzTS6xoLQtF/tI42F7rEntkyshkpl92yUSSGZpLlss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X7o5TM+a99+et51pS5MDR0tqzpXzYKU7mpHrSgO5fSMlsRVdQEkhmAklL02LT4xPfDZyxAvVyS3ZLK8d9TrABYv/3olT/NbBoftYYO00N/Hpern1pxUCoYrBNMnk74V+SQt4vaMGh5Qh0YYDtxB86D1IYekPpn2Mqk4j7pReKM4=
Received: by 10.141.79.12 with SMTP id g12mr6722322rvl.126.1199176015186;
        Tue, 01 Jan 2008 00:26:55 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Tue, 1 Jan 2008 00:26:55 -0800 (PST)
In-Reply-To: <4779F200.1020507@panasas.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69432>

On Jan 1, 2008 8:55 AM, Boaz Harrosh <bharrosh@panasas.com> wrote:
>
>
> We use it a lot here. When the guys make a mess, and you need to figure what
> happened than qgit is your only friend. I intend to hack some extra stuff that
> we need often.
>

Glad to hear this. Hacking on qgit spans from very easy to nasty,
according to what you hack, in case, please, don't hesitate to write
me for some hints or API clarifications.

Thanks
Marco
