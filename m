From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: make test failure with latest master
Date: Mon, 03 Dec 2007 18:25:45 -0500
Message-ID: <47549079.60400@gmail.com>
References: <4752A53E.4030000@gmail.com>	<20071202163426.GA29781@coredump.intra.peff.net>	<47533D75.1090002@gmail.com>	<Pine.LNX.4.64.0712022340250.27959@racer.site>	<20071203015954.GB8322@coredump.intra.peff.net>	<47548CEC.6010701@gmail.com> <7vir3fe54c.fsf@gitster.siamese.dyndns.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 00:26:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzKfz-0005wm-Ro
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 00:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbXLCXZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 18:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752576AbXLCXZv
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 18:25:51 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:35909 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbXLCXZu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 18:25:50 -0500
Received: by wr-out-0506.google.com with SMTP id c49so2854742wra
        for <git@vger.kernel.org>; Mon, 03 Dec 2007 15:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=/bzENYDpEkt0tbHehPp2p4KZdJGpZbG0+ovG7WE2G80=;
        b=XBCOHgxmJKrAJ0qdnKFTUzcEfONjXPIxaBzJUdagBF+Xqxf3ijdL0SQh+F6BwgVpWjEHvhiWLXOVyf5rPiUyLp/und95R03OLhs34UjxPwoqZ1uWyA28Vzksl3oe4l7C8yFQpaBJIAG59jKRY2J0ab+QYqociaab7cZlBcz1Y5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=MyLjG6CBB+Fl49pdTtE07ESobriIa6lus8E+JEzSINzbmpV71IYLUQkQ+JaVBAkES59aVi8GMq1m+ZLMPkoTSQlOvYP+w7Wwa62s7KdiREIT/KLwOg+h/DuazPDVoqXrx7E7b/H8DHUde9WQUAR94vMC356YCBMfalDshxu/LiE=
Received: by 10.70.49.1 with SMTP id w1mr5081582wxw.1196724348374;
        Mon, 03 Dec 2007 15:25:48 -0800 (PST)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id h9sm17683209wxd.2007.12.03.15.25.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Dec 2007 15:25:47 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <7vir3fe54c.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66976>

Junio C Hamano wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
[...]
>> Acked-by: A Large Angry SCM <gitzilla@gmail.com>
> 
> It would be Tested-by: in a stricter sense of the word but thanks for
> testing.

Tested-by: A Large Angry SCM <gitzilla@gmail.com>
