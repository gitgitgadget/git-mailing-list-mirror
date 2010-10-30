From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Sat, 30 Oct 2010 01:58:50 -0700 (PDT)
Message-ID: <m3fwvogiqj.fsf@localhost.localdomain>
References: <4B123C80.30607@syntevo.com> <4B14CA79.6040408@syntevo.com>
	<4B14D381.3010706@viscovery.net> <4B14DA1A.4060505@syntevo.com>
	<4B14E934.9090304@viscovery.net> <4B150747.2030900@syntevo.com>
	<4B151782.8050309@viscovery.net> <4B15391C.5090302@syntevo.com>
	<40aa078e0912010750m4518f068s9c955042307bf9fe@mail.gmail.com>
	<4B154560.1020806@syntevo.com>
	<1288411330615-5688741.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: brad12 <brad.john75@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 30 10:59:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PC7HA-0002NM-2u
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 10:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505Ab0J3I6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Oct 2010 04:58:54 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46660 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab0J3I6w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 04:58:52 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3211087bwz.19
        for <git@vger.kernel.org>; Sat, 30 Oct 2010 01:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=s+T/WiFABH2tDHpV+ts6nZwRNGtVwt2zQo56G5Cyhzk=;
        b=d6yM9DmWxkC6LuC1MLFn0uKdp1rpE0CvjO1GW60FCNiRVXBg1ND6NHsSDmNohwc+VD
         qp3cF3XDI0HDf+xVIUnuhU5dOPyj5248CROcgjfObUNQ1TO9SpdAwzGOrav1Vwic5oPz
         rAZOmfksSPFUVH9jhbS5wmc+mek9ikizJXzkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=RYpSY2slvezFA1X9YaGU2lxQfaqI+godgzBWSm2mPZPsloiCNvPYbkVsS07DP2uB+4
         XoQJRreCi4jJbEts/ld46wKX7wL6RYiqnNzSujfOaUYzpYVbQ0ZIoyrUb+Pgn/Dap/8c
         DcI7S+Lhpj1DJJ5SB1ScPZgcILPs2sW7cfJTY=
Received: by 10.204.68.137 with SMTP id v9mr10667844bki.148.1288429132230;
        Sat, 30 Oct 2010 01:58:52 -0700 (PDT)
Received: from localhost.localdomain (abvq193.neoplus.adsl.tpnet.pl [83.8.214.193])
        by mx.google.com with ESMTPS id 4sm1586318bki.1.2010.10.30.01.58.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 Oct 2010 01:58:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9U8wMGd007350;
	Sat, 30 Oct 2010 10:58:32 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9U8wCB5007345;
	Sat, 30 Oct 2010 10:58:12 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1288411330615-5688741.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160394>

brad12 <brad.john75@gmail.com> writes:

> actually I am also working Japanese language site , I have same problem , I
> have also some japanese sentences which is to be written in japanese , but
> they did not appear on browser....so what should I do

Why are you sending this question to *this* mailing list (this
newsgroup)?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
