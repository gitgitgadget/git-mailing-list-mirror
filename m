From: =?UTF-8?B?Q2hyaXN0b3BoIEdyw7xuaW5nZXI=?= <foss@grueninger.de>
Subject: Re: [wish] Revert changes in git gui
Date: Fri, 12 Dec 2014 09:27:18 +0100
Message-ID: <548AA6E6.5050805@grueninger.de>
References: <54875263.1010407@grueninger.de>	<548759C2.5030909@kdbg.org> <CAKPyHN2OSARgsYtC0MAxXqe=LZnBC9eq9BxkGme0QTRhnH9a1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:27:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzLZW-0004Ta-4a
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759045AbaLLI1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:27:23 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:54951 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbaLLI1X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 03:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1418372841; l=333;
	s=domk; d=grueninger.de;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Subject:CC:To:MIME-Version:From:Date;
	bh=1Pd/SEvU8lObmJnDOwYvYoQpy8Y=;
	b=r3VO0FqFhUe0JyCBaoaB5iN1cTvn2caAis+GkDndUaft9nqzXfhhlGPyt5Neo7s6FNC
	icI1fhe6S1fw20zBbrbcoe6527l/gnC/lWC5q50dgTWSsXinWcxWqKkp/wFnncdMNx7dZ
	A6oOkymtpxCl/M4Kv9XokTamhjUJkzwTmoc=
X-RZG-AUTH: :PH4kclK9fvHEIDd1AEB/H6dKpHPYpRotT71NeUdfzJ4Ym8WRdhCO7/u5jZI=
X-RZG-CLASS-ID: mo00
Received: from [10.59.2.71] (HSI-KBW-078-043-053-226.hsi4.kabel-badenwuerttemberg.de [78.43.53.226])
	by smtp.strato.de (RZmta 36.3 DYNA|AUTH)
	with ESMTPSA id 60481fqBC8RJB57
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate);
	Fri, 12 Dec 2014 09:27:19 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CAKPyHN2OSARgsYtC0MAxXqe=LZnBC9eq9BxkGme0QTRhnH9a1g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261311>

Hi Bert,
your commit is more than half a year old. Do you intent to include that
into Git master? If not, what's the reason?

Bye
Christoph

Am 10.12.2014 um 08:42 schrieb Bert Wesarg:
>
> Maybe this is easier to apply:
> 
> http://repo.or.cz/w/git-gui/bertw.git/commit/5d7a81b626c34a94c6c43937d8a64572b6231196
> 
> Bert 
