From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: HELP: cannot clone a repository via http_proxy on FC13
Date: Tue, 1 Jun 2010 13:24:49 +0000
Message-ID: <AANLkTimXYT71cjmLBmF0GWFQeb4pBmNDtfLpAmC4REE0@mail.gmail.com>
References: <AANLkTimefBKp5So03RKaZRqQXePO1KY6EgMRxN0zsf8M@mail.gmail.com>
	<AANLkTinyKoH4QiTnIbBQ60sMNZHKqtYejk-t2ygj9naK@mail.gmail.com>
	<AANLkTinSTJiUdtWbidlnUkJ2Gh6KczaSu56p3cwSgv5k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Sylvia Liu <sylviaonlyone@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 15:24:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJRSj-0007b2-1x
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 15:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376Ab0FANYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 09:24:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60906 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756218Ab0FANYu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 09:24:50 -0400
Received: by iwn6 with SMTP id 6so799816iwn.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 06:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=IJZAAlDoi9KbHT45fEdc34QCpqgma1N/Cf5aOaG4ndQ=;
        b=XYFefxcKpXF2F+tlG7hkSCN9/QL4fH85vonPkYx7bcbm7z6H5pwwE/WD7CvHogz6Uw
         JPVPaHXUu7kzIdcDweJ3hbkHpeTqhJ0NKIHoFb7EBEySPEu59Wr3cvx8PtltrFjJvl74
         9w9sdFVjj2cge0PUZALNXbg7zgTyHU8N2V3xc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=MkQNryC7AGna687t9H7Rea5NiOpdofWjXCMPklIhQGjWJJX/OhapMWu38QLkThZnaZ
         5Gzb8Aw9AV1xwhMOXEe+NWeqAmhezhIXuwRylb1O8Ry5KHVfNbQW2dogDaZ5QNg0H4n/
         U+Z+8ob1g8Ce3r7h7bx4WKYeVIu9g6wvyNWpM=
Received: by 10.231.59.199 with SMTP id m7mr7822225ibh.30.1275398690185; Tue, 
	01 Jun 2010 06:24:50 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 1 Jun 2010 06:24:49 -0700 (PDT)
In-Reply-To: <AANLkTinSTJiUdtWbidlnUkJ2Gh6KczaSu56p3cwSgv5k@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148112>

On Tue, Jun 1, 2010 at 04:30, Sylvia Liu <sylviaonlyone@gmail.com> wrote:
> But on Ubuntu, I use sudo all the times, and it still works. Isn't it strange?
> And as I remembered, while I using FC12 before, it didn't work
> neither; even without a sudo....

What is your Ubuntu's and FC13 /etc/sudoers file like?
