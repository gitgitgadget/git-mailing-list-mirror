From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Fri, 29 Apr 2011 13:35:07 +1000
Message-ID: <BANLkTikhqx2+JCey_ivP+Q+8X2VYT3hPKw@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<4DB82D90.6060200@op5.se>
	<BANLkTi=XcR9FTPC8oe100fMneNf1nca4_Q@mail.gmail.com>
	<BANLkTikGZgEb-4jzHt+t2k__s7BMgbU9gg@mail.gmail.com>
	<4DB84D65.6070906@gmail.com>
	<BANLkTimyFmujc+Lsd7DMWfJgUzZME+Sveg@mail.gmail.com>
	<alpine.DEB.2.00.1104280915230.7120@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "gitzilla@gmail.com" <gitzilla@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "david@lang.hm" <david@lang.hm>
X-From: git-owner@vger.kernel.org Fri Apr 29 05:35:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFeU9-0001l7-O7
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 05:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435Ab1D2DfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 23:35:10 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60769 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175Ab1D2DfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 23:35:09 -0400
Received: by eyx24 with SMTP id 24so1023231eyx.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 20:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=w7BxOQIJ+JuDJ1J1QsjHIzHwPJtgMo8iM+dIUAteD0U=;
        b=Maf8J5DaqYtU3m16uZUe/N3jUQxC8AsnCd2ppzwuVbn+oYDGYavaYQJMQyOqxbF1ei
         nma+pt1y0rH+Xux7EmrnY8TKhgixuAtHXBQ1XCyojV79eWXdL6qDVai3EMOnT6vZr2hN
         0uVfBXMnu161vspZLZ9WhubWtv/mgSQdr1e+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=olMpZOoFBz9/7uQ9VPb3dip76KkqwhvV80CSBVSlGNU6fdfjaOuRy4gVlwDZ7+fdsC
         1bdR2HWyt8t5Og9/afqWOIBImSO3PN4e+NS1wvyBTh1AB9JoKmMNWARN7kW82VQV9MZR
         EYPXOMSlHZ+hv4Xvb3Io6+uogohQwyDBGbr5w=
Received: by 10.14.16.136 with SMTP id h8mr287041eeh.53.1304048107900; Thu, 28
 Apr 2011 20:35:07 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Thu, 28 Apr 2011 20:35:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104280915230.7120@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172422>

<david@lang.hm> wrote:
> On Thu, 28 Apr 2011, Jon Seymour
> start with documenting (and therefor formalizing) how plugins can work today. Then propose your change to how they work, what the benifits of your change are, and the code needed to implement your change.
>


Good suggestion, thank you,

jon
