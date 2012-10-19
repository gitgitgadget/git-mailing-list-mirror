From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: libgit2 status
Date: Fri, 19 Oct 2012 09:24:21 +0530
Message-ID: <CALkWK0=P7THaJduYFS1Sr6mxtNqAWQsDgwQyr_KEX4NA4kmVSA@mail.gmail.com>
References: <87a9xkqtfg.fsf@waller.obbligato.org> <5038A148.4020003@op5.se>
 <7vharpv77n.fsf@alter.siamese.dyndns.org> <nnglih0jotj.fsf@transit.us.cray.com>
 <7vfw78s1kd.fsf@alter.siamese.dyndns.org> <nngsjb8i30w.fsf@transit.us.cray.com>
 <7v6284qfw8.fsf@alter.siamese.dyndns.org> <20120827214027.GA511@vidovic>
 <nngr4qqhp7x.fsf@transit.us.cray.com> <7vvcg2zwvq.fsf@alter.siamese.dyndns.org>
 <CACnwZYe6BZVuqCCPho5+3dy=rzKqDv1A8uGAvhLm2JPO9b2LMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	dag@cray.com, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Andreas Ericsson <ae@op5.se>, greened@obbligato.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:54:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TP3fi-0003Ra-GM
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 05:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab2JSDyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 23:54:43 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:46346 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab2JSDym (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 23:54:42 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so75828qaa.19
        for <git@vger.kernel.org>; Thu, 18 Oct 2012 20:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IyiSd3uE7NOvCh8PJa5vaY02ICBX7HsaprdiFpAR46I=;
        b=IAN0hpTr9LZwc8VSwjAlVaoy8Dncq2akeawO6i/DCGcejHii//YsgOP+L4+Z7Q+ZgA
         gTeBENb+mWCRA2D5PwmNFWsTfCTScxZqPDtP2yJwjFry9zbcU+gxtZJZ47LiwKvZufnu
         rCxt7TOaaV9SYUHsbT9k+eeFZc4B4Vv2svGDVycHjYmzLAn6XdxnieJEp2MoYnEgwktH
         jtOR5/pQMWbUL1XaAIcCDcXoioN60o7SHT0fQOU2OCRLxIt1bsTOGe2Fj8I65JL7f1e2
         PwD4tqHkCRMrKl/K9emJPFtnjtemBALW/rzt/8JiTkqOIKZzHsSNPgTcfih20grm+J6K
         m0Hw==
Received: by 10.224.78.141 with SMTP id l13mr156885qak.25.1350618881613; Thu,
 18 Oct 2012 20:54:41 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Thu, 18 Oct 2012 20:54:21 -0700 (PDT)
In-Reply-To: <CACnwZYe6BZVuqCCPho5+3dy=rzKqDv1A8uGAvhLm2JPO9b2LMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208038>

Thiago Farina wrote:
> [...]
> With some structure like:
>
> include/git.h
> src/git.c
>
> ...
>
> whatever.
> [...]

Junio- is it reasonable to expect the directory-restructuring by 2.0?

Ram
