From: Josh Boyer <jwboyer@gmail.com>
Subject: Re: RPM build report
Date: Fri, 11 Nov 2005 09:28:15 -0600
Message-ID: <625fc13d0511110728p7dccbfd9td3b0000c90334ae4@mail.gmail.com>
References: <200511111440.jABEeV7c023333@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 16:28:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaapT-0002PT-Hb
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 16:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVKKP2R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 10:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVKKP2R
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 10:28:17 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:1448 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750815AbVKKP2Q convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 10:28:16 -0500
Received: by zproxy.gmail.com with SMTP id 14so709204nzn
        for <git@vger.kernel.org>; Fri, 11 Nov 2005 07:28:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gstXlw9gmdjvj5z5BeOHpvLOsR4FKtAq5FjPbOQ/W40ZY8gDjAtAwyFQPBw9898sTlhFGsQnVkoSb87PpOL9t6DuTGyAVyWouw0VvwCkndsk0QRiQ8E17Z0fvFvT5v+bbcY7CkTEAQsZFu5Ex+Y0sHxvr7b47GTjqxzlmQltHRw=
Received: by 10.36.91.8 with SMTP id o8mr1365047nzb;
        Fri, 11 Nov 2005 07:28:15 -0800 (PST)
Received: by 10.36.101.7 with HTTP; Fri, 11 Nov 2005 07:28:15 -0800 (PST)
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200511111440.jABEeV7c023333@pincoya.inf.utfsm.cl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11605>

On 11/11/05, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Again, on Fedora rawhide, x86_64.
>
> After the big splitup, the builds for git and cogito go fine but
> git-core-email requires perl(Email::Valid), which is not in Fedora's
> repositories. The rest installs OK.

How recent of a rawhide snapshot did you use?  I ask because openssl
was recently updated in rawhide and I was just wondering if git coped
with that.

josh
