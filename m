From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2] Add push --set-upstream
Date: Sat, 16 Jan 2010 02:02:12 +0100
Message-ID: <fabb9a1e1001151702i9c38190yb260debfee7e836d@mail.gmail.com>
References: <1263595630-18962-1-git-send-email-ilari.liusvaara@elisanet.fi> 
	<7vzl4frl7i.fsf@alter.siamese.dyndns.org> <7vfx66sz5p.fsf@alter.siamese.dyndns.org> 
	<20100116090321.6117@nanako3.lavabit.com> <7vk4virjzh.fsf@alter.siamese.dyndns.org> 
	<be6fef0d1001151653o7ba2cf7et8875eaf4333fc15a@mail.gmail.com> 
	<fabb9a1e1001151655r515374f3ybe2a7d4fb20ea532@mail.gmail.com> 
	<be6fef0d1001151658g78af211duc33c9b3ec71bdb57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 02:02:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVx3k-0007Xb-Ur
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 02:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327Ab0APBCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 20:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073Ab0APBCd
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 20:02:33 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:53826 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758369Ab0APBCc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 20:02:32 -0500
Received: by pwj9 with SMTP id 9so645897pwj.21
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 17:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=vAWL2bROoANYTLtG6Bynmr60BwXyAkI83f0YenaCc5Y=;
        b=hi3wOGsDR1XB9Voy90UhDAkREmVdWOATyrAxBvucY3m3ZhHazobTjejkCI0LQX3FQJ
         PFTwSnWEiz2znq4CEbHr1XPYnZ70adLXPC8vb8/T/Piq9WlfnAx7hkuqh5Bo8JRvgcJU
         BrItm3xJXvB3AWnYm81ZLt5Rxs3q+6dRKnycQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=gBpOEzhX+pN+yST4qGvyPTcUSo5CAUHfJroyroYs3ot9b8gfuWMPq4lo181HcsiImX
         fHhMGlRx1ZjsfMyFt+XrlueT2wxXLdYSNImhSKaHXrvtbpn5wjBeU2F8tiMrCy5hjYof
         j7M9KHM6oINZ+Mg0zSRW1gNZBVCE0fxi7H0sM=
Received: by 10.142.249.6 with SMTP id w6mr2071469wfh.346.1263603752112; Fri, 
	15 Jan 2010 17:02:32 -0800 (PST)
In-Reply-To: <be6fef0d1001151658g78af211duc33c9b3ec71bdb57@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137181>

Heya,

On Sat, Jan 16, 2010 at 01:58, Tay Ray Chuan <rctay89@gmail.com> wrote:
> if I'm not wrong, --set-upstream (which you want renamed to
> --setup-upstream, right?) means the same thing as what I want to call
> --setup-merge.

Ah, correct; that should teach me not to send emails when it's almost 2am :).

-- 
Cheers,

Sverre Rabbelier
