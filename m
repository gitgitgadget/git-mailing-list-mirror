From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/6] Merge David's SVN exporter into git.git
Date: Fri, 4 Jun 2010 15:41:41 +0200
Message-ID: <AANLkTilOcQyYHfVz5rQwKZmvD5w-SATwlscR_E3PnbYi@mail.gmail.com>
References: <1275657988-29765-1-git-send-email-artagnon@gmail.com> 
	<4C090025.6010905@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 04 15:49:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKXHQ-0003DK-KT
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 15:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755967Ab0FDNto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 09:49:44 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55652 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168Ab0FDNtn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 09:49:43 -0400
Received: by gye5 with SMTP id 5so885708gye.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 06:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=B4zhw2YD72GmVIYFMTl2/AbJYOKJktoxZ3KHZ9iTgH4=;
        b=nChXEvWHV23wXI0AKqVBUti90TUpnmI/Te1+vs44qdscbiZB7uXdz/6P61syL+9HrK
         3DOLndwtLqzC3Prf+nidMPHTZcg2qzMUIDMxpSwnbXe6ChyviSmCD3WGoKuxN4cR+RVV
         AeBq9JN6r7RXqqhI3TuIqCtgyEKdOlYUAvoDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=nxZh+xyzFB/0917RK8zqjNHbVOPWWuMJ8jc/RrPNxh/pFsAVgW6lNayoKZsRK4+GFs
         OdIL4RIzb3SIVoeq9bmG8XM1dMmh6msUJ1997ckKJC5/dwBiaalatLGJZfvdcNO4rrLi
         s4uJHF4d8hW3MhdaxbrciOhLF2p6Pshh++woY=
Received: by 10.229.190.80 with SMTP id dh16mr2585383qcb.29.1275658921180; 
	Fri, 04 Jun 2010 06:42:01 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Fri, 4 Jun 2010 06:41:41 -0700 (PDT)
In-Reply-To: <4C090025.6010905@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148417>

Hi,

Sverre and Michael: I'm awfully sorry about this- I didn't realize
that I could change the author while committing. I've re-posted the
series now with the author corrected.

Thanks,
Ram
