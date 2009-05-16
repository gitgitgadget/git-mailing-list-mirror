From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] new test fails "add -p" for adds on the top line
Date: Sat, 16 May 2009 21:14:45 +0200
Message-ID: <fabb9a1e0905161214o66736a56y5660c576095a3cb5@mail.gmail.com>
References: <1c5969370905152010m486a8b85s96334e99e6c54ad5@mail.gmail.com> 
	<20090516192529.6117@nanako3.lavabit.com> <200905161612.30911.trast@student.ethz.ch> 
	<7viqk1ndlk.fsf@alter.siamese.dyndns.org> <fabb9a1e0905161055q89b9e6ei77a922749ed8cd5e@mail.gmail.com> 
	<7vr5yon9ny.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Matt Graham <mdg149@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 16 21:15:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5PLm-0003UT-PY
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 21:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267AbZEPTPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 15:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755315AbZEPTPG
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 15:15:06 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:53955 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755039AbZEPTPE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 15:15:04 -0400
Received: by fxm2 with SMTP id 2so2532841fxm.37
        for <git@vger.kernel.org>; Sat, 16 May 2009 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0BpiUSa1RUtRTMo6LaVteZEdkCmdREgVvPKDkriuUcQ=;
        b=KXhvJKDIvvzJSQddSreWzjsfnsNJdwbYySipDkKTujuHEGWrQcyrMQewlMz9Z5E/9k
         oOTAWIuWLdbDK4p+T6OQ77xJ5faclMND8uzyHwowuvk8PRAkdFFzKwz+9VdVYBDKir7V
         OIp9J8BdjMAW81SToLO2VAJM0DX2pb/9q5erc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wSVKx9EBcI4o40g5FdyQCWhFNmkjfI+d5RinlfxVF9gre7Cvd2RoDg8ev/UfaTF8zR
         7HKb2/m0eFa7QtKAIYgfjENuT7z9i9D0cCxyOT9Gz4Cj3T+Y/KHbgLrj42s/Zmgw3lRQ
         A5mKNJ+N1dK6KYw93lFHpbHuf6l+4UzEMBMrs=
Received: by 10.103.213.19 with SMTP id p19mr3112168muq.9.1242501305092; Sat, 
	16 May 2009 12:15:05 -0700 (PDT)
In-Reply-To: <7vr5yon9ny.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119376>

Heya,

On Sat, May 16, 2009 at 21:13, Junio C Hamano <gitster@pobox.com> wrote:
> Sorry, forgot a smiley ;-).

Phew, what would be without those :).

-- 
Cheers,

Sverre Rabbelier
