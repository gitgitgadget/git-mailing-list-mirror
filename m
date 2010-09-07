From: Ryan Anderson <ryan@michonline.com>
Subject: Re: git-send-email (Fw: Delivery reports about your email [FAILED(1)])
Date: Tue, 7 Sep 2010 09:12:13 -0700
Message-ID: <AANLkTin6LOUqJxuOhzHca9Hq52_a_GvFG2hqZs7WOtJO@mail.gmail.com>
References: <20070620.034202.35337858.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, B6rn Steinbrink <B.Steinbrink@gmx.de>
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Tue Sep 07 18:12:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot0mX-0007nR-MY
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580Ab0IGQMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 12:12:19 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48098 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756517Ab0IGQMS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:12:18 -0400
Received: by qwh6 with SMTP id 6so4792226qwh.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:12:17 -0700 (PDT)
Received: by 10.229.96.17 with SMTP id f17mr4916907qcn.142.1283875934351; Tue,
 07 Sep 2010 09:12:14 -0700 (PDT)
Received: by 10.229.73.105 with HTTP; Tue, 7 Sep 2010 09:12:13 -0700 (PDT)
In-Reply-To: <20070620.034202.35337858.davem@davemloft.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155705>

On Wed, Jun 20, 2007 at 3:42 AM, David Miller <davem@davemloft.net> wrote:
>
> Looks like at least some mailers don't like the Message-Id's
> being spit out by the version of git-send-email this person
> is using.

I'm going to guess the problem is the lack of a "@" in the Message-Id:

> Message-Id: <11823357623688-git-send-email->

That's not really right. :)

> Just FYI from your friendly vger postmaster. :-)

thanks.

-- 
Ryan
