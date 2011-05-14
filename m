From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 0/7] Document translation with po4a.
Date: Sat, 14 May 2011 11:14:57 +0200
Message-ID: <BANLkTi=Tr-iciTK+ScLao=MWgOnKotZ+5w@mail.gmail.com>
References: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
	<7v39ki8s2r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Osamu OKANO <okano.osamu@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 14 11:20:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLB1C-00030b-J0
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 11:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468Ab1ENJO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 05:14:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43789 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab1ENJO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 05:14:58 -0400
Received: by fxm17 with SMTP id 17so2188451fxm.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=CLjU5kMZNaM1xvQ/iqRScjnKT3+XYIiWykXqPwXNxOY=;
        b=qXhB5ozlxpsrOYSzK5CXUSkvhulH+g/ayQN6H15Llj2D67jhCcx9WertR0bUOPGVM5
         jZcKVlwXDnKOWWISM+G3eQZ8SnlHmHf3tUEPT/m8v4ePiIj6CrLC8OAkj79LJqm9wp7M
         t4NcRtZKohbDMyVeNY4MEDub6KF/h6DN2MK2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=taqN5ek8AC/YPoJAEmEdRoGSgBq/0DxZOawe8fyVBg8QAYUq/Z8if734syhuWEhFln
         rS5jY05Qx+zqvuWTl6ge8BQG3+rLXx1r5yqW4FeeBoGxltbQSkTqae9AtV1ID7oRAnfm
         UmQJVmt9/gtTGpSCGHyTa6/JFG8K2Gq4CX4PE=
Received: by 10.223.23.143 with SMTP id r15mr603825fab.29.1305364497450; Sat,
 14 May 2011 02:14:57 -0700 (PDT)
Received: by 10.223.105.9 with HTTP; Sat, 14 May 2011 02:14:57 -0700 (PDT)
In-Reply-To: <7v39ki8s2r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173578>

On Fri, May 13, 2011 at 18:48, Junio C Hamano <gitster@pobox.com> wrote:

> I have a few comments on the overall structure.

FWIW I was going to add PO support to Documentation with po4a
eventually, but I'm really glad someone beat me to it.

I agree with Junio's suggested workflow for this, it would be really
nice if you would follow up on this and submit something in that
style, I'd be happy to help if needed.
