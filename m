From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2] Add push --set-upstream
Date: Sat, 16 Jan 2010 08:58:06 +0800
Message-ID: <be6fef0d1001151658g78af211duc33c9b3ec71bdb57@mail.gmail.com>
References: <1263595630-18962-1-git-send-email-ilari.liusvaara@elisanet.fi>
	 <7vzl4frl7i.fsf@alter.siamese.dyndns.org>
	 <7vfx66sz5p.fsf@alter.siamese.dyndns.org>
	 <20100116090321.6117@nanako3.lavabit.com>
	 <7vk4virjzh.fsf@alter.siamese.dyndns.org>
	 <be6fef0d1001151653o7ba2cf7et8875eaf4333fc15a@mail.gmail.com>
	 <fabb9a1e1001151655r515374f3ybe2a7d4fb20ea532@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 01:59:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVwzW-0004oA-69
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 01:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758398Ab0APA6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 19:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758392Ab0APA6J
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 19:58:09 -0500
Received: from mail-iw0-f197.google.com ([209.85.223.197]:34144 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019Ab0APA6I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 19:58:08 -0500
Received: by iwn35 with SMTP id 35so942380iwn.4
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 16:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=VHjZorAHQ5AgyIrQHCjfHINay/J6BTAdXMcqzHSEPOw=;
        b=KAdsF+gvVCKpdOrCkPErO2TNy/r6b0+PVjwTWuckNLgfMyyaVI25uKgySvog3WZLzw
         VzMXRNyLtmghtr2dIgIyUTANAPjCq3CWToLMFXPew+f3Qund8g6v2TB/kcPv60xLkXIq
         ndTeXN3PxEfh2Rrt93Y59p9OXtODHMy6c6KPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LqKJjfVpUtxuaE/PsnLY69YtcrM281Uw9ddk4w+ejuoUbZvqkozWm+w5EuWZNIGsPP
         rDnfgT+2+nWDoFYTWcmIRgCPXOD05WwyEglncd/UK4OVOs4HLJHZy/6dCsvffV/di6CU
         CLzLdi1NRxxmd6x2frmJf3VJcY6t6OAM3yhYA=
Received: by 10.231.158.205 with SMTP id g13mr153558ibx.30.1263603487014; Fri, 
	15 Jan 2010 16:58:07 -0800 (PST)
In-Reply-To: <fabb9a1e1001151655r515374f3ybe2a7d4fb20ea532@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137178>

Hi,

On Sat, Jan 16, 2010 at 8:55 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Sat, Jan 16, 2010 at 01:53, Tay Ray Chuan <rctay89@gmail.com> wrote:
>> how about --setup-merge and --setup-rebase?
>
> I like it, it also suggests this should be called '--setup-upstream', no?

if I'm not wrong, --set-upstream (which you want renamed to
--setup-upstream, right?) means the same thing as what I want to call
--setup-merge.

-- 
Cheers,
Ray Chuan
