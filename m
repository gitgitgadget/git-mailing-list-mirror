From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] Sequencer: Debating the UI
Date: Mon, 20 Jun 2011 21:21:23 +0530
Message-ID: <BANLkTi=nBAX6KSFCYOGa9L-x=a8wCX_P3g@mail.gmail.com>
References: <BANLkTinxx5qFuhwsUt3JeXOO7TjBj8wFvw@mail.gmail.com>
 <20110614053143.GA24882@elie> <BANLkTikDq8DJeUde-jSPL2bKw1jk3GoYVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 17:51:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYglW-0003ch-Tz
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 17:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398Ab1FTPvq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jun 2011 11:51:46 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56529 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356Ab1FTPvo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2011 11:51:44 -0400
Received: by wwe5 with SMTP id 5so2693291wwe.1
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 08:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Lwb1a28AbQkiIpbRIqJTVuiNi9fZh6sGEB61SclqKOM=;
        b=kua2HPMhpvJntTTfVRByzI/NoDMOvXMFqGBFSpEQr7zjYc8q7pVXda5RaRo0iIpalN
         7Y4Ar34/X1kGlyVxD32Xbgwhwihz9V/tMXKshkMt1n14bNRVKkDM/2R8f/7w5J+qqmz5
         YilW2yahBt2bQVolkwuQK5zwawJEgnQNDo30s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uczqshpB75VGDr51ax940jMYZiLQ/k6x3YQl4bnuOV0E2WP355Pi9bX0R7a2W4JFU1
         bv/jJyAWgnyv/5gJxuSP3TqpRQGFaRsXgFItueuAmGSqM3Q8C8xP6kT1Hl0navugLVx0
         rr06uGGdGlMAEY2DBlFKVFC9cO+8+3bqpcaMs=
Received: by 10.216.237.136 with SMTP id y8mr2203512weq.76.1308585103103; Mon,
 20 Jun 2011 08:51:43 -0700 (PDT)
Received: by 10.216.18.16 with HTTP; Mon, 20 Jun 2011 08:51:23 -0700 (PDT)
In-Reply-To: <BANLkTikDq8DJeUde-jSPL2bKw1jk3GoYVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176076>

Hi,

Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:
>> I would love to use a working "cherry-pick --continue". :) =C2=A0I w=
ould
>> use it like this:
>
> Great. =C2=A0I hope to have a mockup of this ready in a couple of day=
s or so.

Gah, it took much longer than expected.  My latest work is in the
'sequencer-continue' branch on my GitHub.  It's almost there; will
send to list after polishing it for a few hours in the morning.

Thanks.

-- Ram
