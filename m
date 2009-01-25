From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Allow cloning an empty repository
Date: Sun, 25 Jan 2009 19:33:01 +0100
Message-ID: <bd6139dc0901251033g166478d5y2050977cc7beaa5a@mail.gmail.com>
References: <1232669252-21881-1-git-send-email-srabbelier@gmail.com>
	 <7vwscm4xx0.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0901221746h258f548etf857ab37399133da@mail.gmail.com>
	 <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de>
	 <20090123230520.GL21473@genesis.frugalware.org>
	 <alpine.DEB.1.00.0901240131570.3586@pacific.mpi-cbg.de>
	 <bd6139dc0901231642v6bd593d3mfefaca3c419a9f0a@mail.gmail.com>
	 <20090125004955.GY21473@genesis.frugalware.org>
	 <bd6139dc0901241655n66f75a8fn8450b774809fa8e7@mail.gmail.com>
	 <7vy6x0j7py.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 19:34:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR9oT-0000Fi-Rr
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 19:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbZAYSdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 13:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbZAYSdF
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 13:33:05 -0500
Received: from el-out-1112.google.com ([209.85.162.178]:44296 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbZAYSdD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 13:33:03 -0500
Received: by el-out-1112.google.com with SMTP id b25so958726elf.1
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 10:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=Nf50Yfcua8RJOTrw5knpLzNApM6aAuNmvYkQgBvNMoQ=;
        b=n2f0J52UwZhOAysYN/c8USNuQ3TuaAP7+B440IepyngSaPMMyCW26VcQTTCRpp8IDs
         ebc/qdq7JXkSvaLe25kPj/MtHGLnOKeU8idWWyDVNSklq9lT1I6xIbPRHHRRWZRSdMp9
         VCdXhHsON5CQ+rQJJyCrsSLSWkjEWf0QlP0Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=bwx1RDCMC2L6njOxbQl645QCVsd7VtYuSLWcLcxHajZoD0Y7Old2mEzvzx3mjdU9Yk
         eRXqzZ5TM/mZwuUZjfzK2LgI3TFE3cNOehwYEq69rsidBY5YPFkGbtlEQX18uYVxxvPh
         DZHoUqMVnTDk4w0zztgiDelAWrptIMvh9Hsbw=
Received: by 10.150.200.16 with SMTP id x16mr858279ybf.202.1232908381806; Sun, 
	25 Jan 2009 10:33:01 -0800 (PST)
In-Reply-To: <7vy6x0j7py.fsf@gitster.siamese.dyndns.org>
X-Google-Sender-Auth: a64ce42c65496661
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107076>

On Sun, Jan 25, 2009 at 06:05, Junio C Hamano <gitster@pobox.com> wrote:
> Yeah, it is on 'next' and I've pushed the results out last night, but I
> got sick and didn't manage to send out "What's cooking".

Ok, awesome! :).

-- 
Cheers,

Sverre Rabbelier
