From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: Announcement: Git Extensions stable (windows shell extensions)
Date: Wed, 17 Dec 2008 20:23:21 +0100
Message-ID: <bd6139dc0812171123p54d89209t14739540b92bd9e9@mail.gmail.com>
References: <1229540813648-1669264.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Henk <henk_westhuis@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 20:25:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD20h-0003q9-Vv
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 20:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbYLQTXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 14:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbYLQTXX
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 14:23:23 -0500
Received: from rn-out-0910.google.com ([64.233.170.188]:62075 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbYLQTXW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 14:23:22 -0500
Received: by rn-out-0910.google.com with SMTP id k40so52320rnd.17
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 11:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=OhbUFAm5y/swbCsEo3pK9v/faDVbprZK1mqZ2yh4PZY=;
        b=nK1U7AFwpglfRMFjaZCHYy2PBd/7fxyM+OejjKydGY4B7XW6mmTyOnyhPPPiFwUH95
         yNmulNwxlOP4hK/sUgJ+QLc0dnIWoeO2LaX+WBVrrzZmXoGqxMkbSnry5KVTgIXqx8QA
         JXwiR+xmbSN7/fLXSVY9JlvMwa7oacDdKk2uY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=RR9gDqYfDIuKwpLznf8KfKKnsrcw+8f9+mK+ArEgCI7heHnbm7lFaiAXcuS6opjp3O
         ftbtHa27Auk20fBhUZkfk9c2jJTV8qVmIDQEy9PFjFo2ikUw99fm3WU55NaL4Gf5RS0F
         UcctfFTJo2/JivSZfc7v8x4q3Z/GYyIZHalQ0=
Received: by 10.151.114.6 with SMTP id r6mr1882280ybm.126.1229541801055;
        Wed, 17 Dec 2008 11:23:21 -0800 (PST)
Received: by 10.151.13.13 with HTTP; Wed, 17 Dec 2008 11:23:21 -0800 (PST)
In-Reply-To: <1229540813648-1669264.post@n2.nabble.com>
Content-Disposition: inline
X-Google-Sender-Auth: fa24d93fe87eaa64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103373>

On Wed, Dec 17, 2008 at 20:06, Henk <henk_westhuis@hotmail.com> wrote:
> I know there is a TortoiseGit project also, I just didn't know about that at
> the time I started. If I knew about TortoiseGit, I probably never started
> writing my own tool.

It seems TortoiseGit started only recently and is not nearly as
feature-complete as Git Extensions, so I wouldn't feel too bad in that
regard ;).

-- 
Cheers,

Sverre Rabbelier
