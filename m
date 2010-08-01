From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv2 00/11] Splitting gitweb
Date: Sun, 1 Aug 2010 15:44:07 -0500
Message-ID: <AANLkTi=L4xieJ_HuoX7aGVVVjujdY6bE78iq4v2=nxgx@mail.gmail.com>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Aug 01 22:44:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OffOm-0000Vh-TX
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 22:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592Ab0HAUo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Aug 2010 16:44:29 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43173 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234Ab0HAUo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Aug 2010 16:44:28 -0400
Received: by gwb20 with SMTP id 20so1080537gwb.19
        for <git@vger.kernel.org>; Sun, 01 Aug 2010 13:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=/3ptI3UKd1yzkusQ5VNFXV+ig6YkQz2qTtbPbEnhyRI=;
        b=U3dW2jyE60WkF7pskiKcGwL9a5aZvDxdQy7QXUFTte229iMENhCPp20Q8ZrZlLloG0
         78XPVAmKji8psC5xTujH+sq9I+r4LuGAR6Gka78+ZTk3BUek2haIXybgntVA08zy6Bo0
         mA5VIIOzQvMhBlrNwgc9hLJcqrrZGc71Rnmg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=lnczr7LUKhaTHObBDt4yi+YWbYCbMiUj0g5ZaP8f6WBttDZZJv74hRkS6Lte0c35mm
         lD56Vve7AO/Vqd3g5ZSZxRhY1dQiNwZVgz9M7/yPcEzjyhxG3VTDCF6IkOdSFhiruSTt
         WkGxg1MLGvHf4PphTOx3OEsMylYYkIzMhVxS8=
Received: by 10.150.254.17 with SMTP id b17mr6242422ybi.82.1280695467212; Sun, 
	01 Aug 2010 13:44:27 -0700 (PDT)
Received: by 10.150.66.12 with HTTP; Sun, 1 Aug 2010 13:44:07 -0700 (PDT)
In-Reply-To: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152383>

Heya,

On Thu, Jul 15, 2010 at 02:29, Pavan Kumar Sunkara
<pavan.sss1991@gmail.com> wrote:
> 10 patches out of the 11 patches in this patch series split gitweb into
> several small sized modules

What is the status of this series? Is anyone going to carry it
forward? I remember multiple people wishing for gitweb to be more
modular to make it easier to hack on? What shape is the series in, is
it almost done, or will it need a lot more work?

-- 
Cheers,

Sverre Rabbelier
