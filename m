From: Edwin Kempin <edwin.kempin@gmail.com>
Subject: Re: How does 'git notes --ref' work?
Date: Fri, 14 Jan 2011 12:14:21 +0100
Message-ID: <AANLkTimV6LguyjJEiECAVg1zLj=v-GQkrkxBez6t9HHf@mail.gmail.com>
References: <AANLkTimL137aFt2dyvdHxTMUjB4diwJQG-FQiYEK8tVJ@mail.gmail.com>
	<201101141149.38778.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Jan 14 12:14:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pdhbv-0004BX-EK
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 12:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756731Ab1ANLOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 06:14:23 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:60253 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab1ANLOW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 06:14:22 -0500
Received: by qyj19 with SMTP id 19so6686175qyj.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 03:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mdh9R9+vh5cujfcyJqP9wcYLmZVZ9rw7mqpP7raHZZY=;
        b=ogjzCWpzSmD3Vt20mfQ1siMLiFFGohYmE9uc4FSkkwQrEP/9TSk0cUXqOd01LVf/iB
         V2SFYFHJdwvQa8+Xxq4YxgNWK+vWgzBI7675suf4SHAB+Fj0oRkMpi6HY38cJFPHEhqv
         MmZnA7lfTXBsa4RLzRUAwn9ez1cxPKuz073dg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VuKwBgxwoJ+dLdei9grxD0udsAQWhI3Ejs+3t0zA87BqEB6jF071Jg34y6PAqikgK6
         37+isK4o9ZHtky6+q5f5L78tgAzZQNw4UiiQF4Q/0LNfj+UkjltNipqn6y4scKQz7Mcb
         B5sXOuRwOGqYxEoFgSTRfCp0oelnOevYvbd/Q=
Received: by 10.229.90.196 with SMTP id j4mr555178qcm.144.1295003661542; Fri,
 14 Jan 2011 03:14:21 -0800 (PST)
Received: by 10.220.117.67 with HTTP; Fri, 14 Jan 2011 03:14:21 -0800 (PST)
In-Reply-To: <201101141149.38778.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165093>

Thanks for the clarification.
