From: Reinier Lamers <tux_rocker@reinier.de>
Subject: Re: ANNOUNCE: darcs 2.4
Date: Sat, 27 Feb 2010 13:33:46 +0100
Message-ID: <c5c817ef1002270433r15132479obbce12b63596f154@mail.gmail.com>
References: <201002271317.55681.tux_rocker@reinier.de>
	 <fabb9a1e1002270428n67b0664fx430825ab8274191d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 13:33:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlLrl-0003cz-6l
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 13:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968191Ab0B0Mdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 07:33:49 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52588 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968193Ab0B0Mds (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 07:33:48 -0500
Received: by wya21 with SMTP id 21so520046wya.19
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 04:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type;
        bh=fZz/E7x3Tpmbc2enEPFTGjSPBFEnNNaiX6GVge7W1iw=;
        b=gxw7HF34N6r8PHgQaw/uHW7UjmSiz78lhqRnf0dtUayFwBwz/cP40A6JcgPqzhb+sW
         bw8BgbPXdScgvR+xpksEFcDLXX8nJWGgZ2ZdPHUnTnNOVXuXF+Mcj3hzzEtrdZiqEC6A
         3NvmgvjP2vaTUZfIX6f34av9b9DKWHP3lEyUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=OJ3Tge6BKzCBStBa9KwunFIiJ0eg7PJgrpGdJQeFY4CXXM1BORRq5tp6b82dGgRWEP
         BjGQcZvFZAuXy21d7eUm334VBTFyGjF2ZZyfsLOxxJijIPimTD8KZ3YeyfYDOPEH2IZI
         aUS6vZKl+bX8ZoU0q+Sug6zaJzNmUI7M/8bCk=
Received: by 10.216.85.203 with SMTP id u53mr1234545wee.184.1267274027041; 
	Sat, 27 Feb 2010 04:33:47 -0800 (PST)
In-Reply-To: <fabb9a1e1002270428n67b0664fx430825ab8274191d@mail.gmail.com>
X-Google-Sender-Auth: 3481281477bc46e2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141200>

2010/2/27 Sverre Rabbelier <srabbelier@gmail.com>:
> How is this relevant to the git list? After skimming the changes I
> don't see anything that affects git users, did I miss something?

I just wanted to let git developers and interested users know what
their colleagues are up to. If sending release announcements of other
version control systems to the git lists is generally seen as spam,
I'll never do it again.

Reinier
