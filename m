From: Marcus <prima@wordit.com>
Subject: Re: Invalid path on new Git installation
Date: Tue, 27 May 2008 16:42:41 +0100
Message-ID: <8345bd80805270842y5e495109x350ef378795ada27@mail.gmail.com>
References: <8345bd80805270758j1315234bwf3b16607c95c9620@mail.gmail.com>
	 <20080527151406.GA16378@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 17:43:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K11Kx-0000fM-Fr
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 17:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757773AbYE0Pmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 11:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756887AbYE0Pmn
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 11:42:43 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:29655 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757368AbYE0Pmm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 11:42:42 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2997793rvb.1
        for <git@vger.kernel.org>; Tue, 27 May 2008 08:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=IQ17+5elaxiAI5OLPaEgM4vtn28LdUEnaff+2YRudK0=;
        b=aE0agb2+uc4S4daCiFNQNTlY5ip0yqT4AruGaTCf7h1wsuH+eM2lVHcrS2dbURSLg7Mkqnyt31WpnanvqIhNIHPJSqamDzEMLICqM5H7zios1dQO18e8TCxvQmQFFOCK/z1tWQ/6qVGEgpI3N4eUoHKw+OXJS70IOsB0gCi2fQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=XQQHMTEBlWFcObPlcL0VUxLf3KbLRMeuF8RvfOZfqrYrwBbQWU3+7YoGp3sSIDOtlCEmXGhILl/GmB9TnR2vQmWjW35UEORl5sb4BD0m0FL4wUSz7PBYRnNpLhtey+9h1sbtYWydXZRZ8/J4434pHuu+EyIpK9Tu1zeIxWt8ZVw=
Received: by 10.140.180.42 with SMTP id c42mr606000rvf.145.1211902961726;
        Tue, 27 May 2008 08:42:41 -0700 (PDT)
Received: by 10.141.202.7 with HTTP; Tue, 27 May 2008 08:42:41 -0700 (PDT)
In-Reply-To: <20080527151406.GA16378@bit.office.eurotux.com>
Content-Disposition: inline
X-Google-Sender-Auth: dd40d486b1171f1c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83027>

On Tue, May 27, 2008 at 4:14 PM, Luciano Rocha <luciano@eurotux.com> wrote:
> What is the correct path on the remote?

The full path to the Git repo is:
/home/admin/mydomain.com/git/projectname.git

I tried:
git clone ssh://admin@mydomain.com/~/git/projectname.git

It gives the same error.

Thanks,

Marcus
