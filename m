From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] t/README: Document the Smoke testing
Date: Mon, 2 Aug 2010 15:54:41 -0500
Message-ID: <AANLkTim2EY7AACe=UzbG-k7oteV6UMmfPAQMEOFn0iZ7@mail.gmail.com>
References: <1280780684-26344-1-git-send-email-avarab@gmail.com> 
	<1280780684-26344-3-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 22:55:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og22S-0000kW-E9
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 22:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194Ab0HBUzE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 16:55:04 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50789 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab0HBUzC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 16:55:02 -0400
Received: by gxk23 with SMTP id 23so1403084gxk.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=HAdygVB/ps+0+LlzeIn4zvyJDzrSP85CMPBeP/RR71Q=;
        b=QWFtmbLJFaHelQYE7jZAVOHmY6qxf71dIlOBlqaGfmxAWtW37hKflB1AFzKXhog5iq
         /w5E+Rk80X5j3CFbav048Bp0dASF1485SSb1gFsXPny59gf3oNZXfvIcqe2+fKfJ3mCt
         sNB+6rtL2RaL5ieTRI3hxGyu/MrDGMikq7mG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NI0qeNGKMwjYf+i8IgiaGmzXJtFRfLSnLeJtTJZbB3NLe70tdASc2466/vHPlGwQsP
         zIYhvsONILRCKvyd1WK/U+uuo/EJzUuVM5n85MtWr377Rj6VEEYk2EzHP5suaxxyslRG
         M7cp+mmfe9WcLSaPVTbz8a1aHAmhJL3dISmhY=
Received: by 10.150.63.14 with SMTP id l14mr7768922yba.155.1280782501156; Mon, 
	02 Aug 2010 13:55:01 -0700 (PDT)
Received: by 10.150.66.12 with HTTP; Mon, 2 Aug 2010 13:54:41 -0700 (PDT)
In-Reply-To: <1280780684-26344-3-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152456>

Heya,

On Mon, Aug 2, 2010 at 15:24, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> Git now has a smoke testing service at http://smoke.git.nix.is that
> anyone can send reports to. Change the t/README file to mention this.

Can't we run this somewhere a little less "shabby"? I'd hate to
introduce Yet Another Official Git Site (I'm really glad for example
that the Git Wiki is now on kernel.org). Is it not possible to move
this to git-scm.com, kernel.org, or something like that?

--=20
Cheers,

Sverre Rabbelier
