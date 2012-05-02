From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Bad Man Page URLs
Date: Wed, 02 May 2012 14:46:02 -0700 (PDT)
Message-ID: <m3lilaqmub.fsf@localhost.localdomain>
References: <2AC038A1-3D8D-425E-92B3-DADFD027761A@justatheory.com>
	<20120406023223.GB16264@sigill.intra.peff.net>
	<20120406025457.GA23997@sigill.intra.peff.net>
	<20120406042215.GA3938@burratino>
	<20120406054637.GA25301@sigill.intra.peff.net>
	<7vzkap1gck.fsf@alter.siamese.dyndns.org>
	<BCD7B631-8C73-4F3F-AB37-9B5CF02655D5@justatheory.com>
	<20120426201921.GA15026@burratino>
	<0DF25EFA-9CB5-4CA3-B654-D796175220F7@justatheory.com>
	<20120426202909.GA15385@burratino>
	<92D71232-83D3-4CC5-BC35-8F697070F8F7@justatheory.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: "David E. Wheeler" <david@justatheory.com>
X-From: git-owner@vger.kernel.org Wed May 02 23:46:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPhND-0001kz-3F
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 23:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158Ab2EBVqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 17:46:06 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:37716 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab2EBVqE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 17:46:04 -0400
Received: by were53 with SMTP id e53so720112wer.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 14:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=pbgac932HGcAMqEzNlARztFzhC1CedYEC4PON5uS55E=;
        b=WDPt6RDd3qH1EsLBg/NJiE+TjtdnvbQ82xtmy+a6TKlVnOjlfOJ90pZERfHvSdcj7i
         DX062GlLKWcM2O8a3Rergr6Fi8Mbwge6UNF7f6OIcRSdBYLqrWBPCtUXTl9BlsViCIEj
         u9h3RCeJPdJOTGb8r61ZP/wGRT0RO1A4+ZQgxrS7rI5xHgqxIzHor9fX7m50LmTUJP9X
         +DYNlK2WfkxiWXe0FveW6N4lhGO40eNe3giKwdjIo9Zt1G888f79zgGvHE1lMsGvMtvy
         WTlhmtJ9GtMeH+ge4ELkV9xMq30fKAXgYoBccy6WK4MUMsn/kcPkMT8UlKc56tZtMbJG
         bQtQ==
Received: by 10.216.132.75 with SMTP id n53mr18054826wei.51.1335995162955;
        Wed, 02 May 2012 14:46:02 -0700 (PDT)
Received: from localhost.localdomain (eps70.neoplus.adsl.tpnet.pl. [83.20.60.70])
        by mx.google.com with ESMTPS id fn2sm10901456wib.0.2012.05.02.14.46.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 14:46:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q42LjMhK027426;
	Wed, 2 May 2012 23:45:27 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q42Lj0Up027419;
	Wed, 2 May 2012 23:45:00 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <92D71232-83D3-4CC5-BC35-8F697070F8F7@justatheory.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196864>

"David E. Wheeler" <david@justatheory.com> writes:
> On Apr 26, 2012, at 1:29 PM, Jonathan Nieder wrote:
>>> 
>>> All of those titles have links on gitmanual.org:
>>> 
>>>  http://www.gitmanual.org/
>> 
>> Who runs that webpage?  Would they mind the increased traffic?  Can we
>> count on them to continue to serve the docs?
> 
> Oh, not an official Git site? Seems to me that the project ought to
> have something like that. Many of the same links are on
> http://git-scm.com/documentation.
>
> As for gitmanual.org, whois says:
> 
> Registrant Name:Loic d'Anterroches
> Registrant Organization:Ceondo Ltd
> Registrant City:London
> Registrant Email:pnwr10o0vs6u6a82ixx9@o.o-w-o.info

If I am not mistaken this is the person behind InDefero git hosting
site (http://www.indefero.net) and git hosting software powering it
(http://projects.ceondo.com/p/indefero) in PHP.

I don't remember it being announced on git mailing list...

-- 
Jakub Narebski
