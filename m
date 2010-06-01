From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/8] Documentation/cherry-pick: describe passing more than 
	one commit
Date: Tue, 1 Jun 2010 12:26:01 +0200
Message-ID: <AANLkTikjCFLj8ZxKI-kiLOqYDg9YYIkX8-lRxNATNGcO@mail.gmail.com>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org> 
	<20100531194240.28729.50475.chriscool@tuxfamily.org> <20100601095124.GA1033@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 12:27:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJOgV-0004cr-My
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 12:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922Ab0FAK0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 06:26:25 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42254 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755885Ab0FAK0W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 06:26:22 -0400
Received: by vws11 with SMTP id 11so813548vws.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 03:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=Vp0VZI80wK5E3Zr10aUtKPf2hYuoWu6lIbP0zHaG8h4=;
        b=YZ+02XiYNMa2VKoWVEXqapEkPsShCp8U0WWA4Kn2MYzyUBFv65ocvePak2m6pcEXwz
         A+iVjYe6th1rG2LQhZgqruqbeLp34YthzYMXyQoZGWziivJYbUtXCwqh9rKq8+jiNqIZ
         uQ9cdmscj7ufLFVzMyXWTMbtYbsr5qYAzVrY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=pczmmveRIe/KBkufW7i+aS9eKOAZjbmN0c9k3aj7DuGJszU5z3f70ZrEdpBecGv4yq
         8k227mESw6G/PaB3YlpYy0JulLFzZx/GDeCR+xCgMJ4pMkMeXYI8QXk2sL8sCrrZjiZa
         batXr6HVraOVzuptOgzvswKZ5iQohbu4SQGCo=
Received: by 10.224.73.73 with SMTP id p9mr2182288qaj.320.1275387981418; Tue, 
	01 Jun 2010 03:26:21 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Tue, 1 Jun 2010 03:26:01 -0700 (PDT)
In-Reply-To: <20100601095124.GA1033@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148107>

Hi,

Jonathan Nieder wrote:
> Christian Couder wrote:
>> +Examples
>> +--------
>
> These are a little repetitive.

Since you also posted an "Examples" section for the git-revert, you
could especially showcase options that aren't in git-revert (--ff and
-x) here.
Also, you might want to include a reference to git-revert in this
document, in a "See Also" section perhaps?

-- Ram
