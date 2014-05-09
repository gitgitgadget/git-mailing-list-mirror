From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 1/2] Remove 'git archimport'
Date: Fri, 09 May 2014 17:01:03 -0500
Message-ID: <536d501fd74a1_65615d32ecf5@nysa.notmuch>
References: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
 <1399599203-13991-2-git-send-email-felipe.contreras@gmail.com>
 <20140509055024.GB30674@dcvr.yhbt.net>
 <xmqqlhuazw2c.fsf@gitster.dls.corp.google.com>
 <536d15f512afd_a7adc530c31@nysa.notmuch>
 <CA+39Oz63YEFPmwntLs+W9X9dMc+TcvV3n05+rr74P8zHoEaAmg@mail.gmail.com>
 <20140509192121.GA14448@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>,
	Martin Langhoff <martin@laptop.org>,
	Thomas Adam <thomas@xteddy.org>
To: Eric Wong <normalperson@yhbt.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 10 00:01:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wisqx-0004rL-80
	for gcvg-git-2@plane.gmane.org; Sat, 10 May 2014 00:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757704AbaEIWBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 18:01:10 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:61785 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757672AbaEIWBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 18:01:09 -0400
Received: by mail-yh0-f47.google.com with SMTP id z6so3925672yhz.6
        for <git@vger.kernel.org>; Fri, 09 May 2014 15:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=6XapOpDUNJPgk8nVBpdSmNi1I3XG4sSDzbQHFiflHBI=;
        b=LasYi4cOiiIq9Lyb0AmtwuAQhzSBbratfTzKR+2bVCQkapeIxuw1t4C5fORSqT/dlS
         MuKbTS83ciWLqe+eJCd3HO6GziBlE3jcGPm5cLwX0ZtOPKIzt7AIMiRoKwUAEO3RoEAc
         +EQOQYqlQSlg26P2ZMwmJIscf1kkMtf4umhPc13i7Mu4zx3OP224TRbD72pV25F/fP7f
         Hxs7QmADviamEdGObc6jlMfv9+TAEi00UEIfZa81XH0G0AowySsQBF14/+oNKJy1uq9U
         kDtwoWnYqMprQJFAC1J2LVmpFmAjuypkkUckBD2yngs/NDAZ4Aki2SdxS+Dl9ATNr6h8
         zbTw==
X-Received: by 10.236.100.177 with SMTP id z37mr18994303yhf.123.1399672868509;
        Fri, 09 May 2014 15:01:08 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id r18sm8038386yhr.1.2014.05.09.15.01.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 15:01:07 -0700 (PDT)
In-Reply-To: <20140509192121.GA14448@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248647>

Eric Wong wrote:
> Thomas Adam <thomas@xteddy.org> wrote:
> > I think I speak for everyone when I say: fuck off.
> 
> I wouldn't put it so harshly...
> 
> Felipe: I suggest you take a long vacation away from development.

Nah, I'm done.

> Whatever good you may be able to contribute today is drowned out by your
> behavior.

That's OK because I'm never contributing again.

I'd contribute patches that would be a burden to maintain on my tree
otherwise, but all the goodies will go to my git-fc fork.

There is just no point in contributin to Git, because nothing ever
changes ever. Nothing gets removed, nothing changed.

> The projects you are involved with will get by fine without you.

git-remote-hg didn't get by so fine without me.

-- 
Felipe Contreras
