From: "pradeep singh" <pradeep.rautela@gmail.com>
Subject: Re: git-update-server-info may be required,cannot clone and pull from a remote repository
Date: Fri, 13 Jul 2007 13:57:26 +0530
Message-ID: <a901b49a0707130127y4ec116bbr3747df1a1e0a86ce@mail.gmail.com>
References: <a901b49a0707110708o7c883bb0s707d9791f344f1f6@mail.gmail.com>
	 <f74tk8$k21$1@sea.gmane.org>
	 <a901b49a0707120550i9361e30wc5811bd5d3305f59@mail.gmail.com>
	 <200707130217.37817.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 10:27:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9GV9-0002oZ-HJ
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 10:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761831AbXGMI12 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 04:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760895AbXGMI12
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 04:27:28 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:47456 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245AbXGMI11 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 04:27:27 -0400
Received: by py-out-1112.google.com with SMTP id d32so652947pye
        for <git@vger.kernel.org>; Fri, 13 Jul 2007 01:27:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TSun3Tn6sVmHFGjY6ytwKjbGk/ayyUpGwZvFwJfMqYBjtzVMM7PdTBMULVGfnU9di34w/5KYqsX48kyM9PE1tKWdG5DBZ97hR7L76ynGX6MsqkL+alDssuHw3nul0phme6qSfEkxOkyUbhRWStl4ryeEJTkG23PBY0NVIPrOCeg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ODXR9PK50y8RzS4+PoKI+Xou6E53l1ExFDEpMItE96h/U247DfjzDKdgd5vnVJ3433TAVOTccF416c1ZnhynivWutlIKJQiQdsVVLEo1h0H8agwEDw9fhNHtQY8yyMZmLZpj6iDWAl++y1vH9dW9AYsb6uRgZM4nrXHT287eji4=
Received: by 10.35.77.18 with SMTP id e18mr2253967pyl.1184315246523;
        Fri, 13 Jul 2007 01:27:26 -0700 (PDT)
Received: by 10.35.93.15 with HTTP; Fri, 13 Jul 2007 01:27:26 -0700 (PDT)
In-Reply-To: <200707130217.37817.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52371>

Thank you all for your valuable suggestions and timely help.
I am now able to view the git repo in a web browser.

Thank you once again for help and for a great tool like git.
--pradeep


On 7/13/07, Jakub Narebski <jnareb@gmail.com> wrote:
> Pradeep Singh wrote:
> > On 7/12/07, Jakub Narebski <jnareb@gmail.com> wrote:
> >> [Cc: git@vger.kernel.org, Pradeep Singh <pradeep.rautela@gmail.com>,
> >>  Eric Wong <normalperson@yhbt.net> (instaweb creator)]
> >>
> >> pradeep singh wrote:
> >>
> >>> Anyway i could not get gitweb running after running git-instaweb.
> >>>
> >>> Any thoughts on how to setup a gitweb interface ?
> >>
> >> What information does gitweb/INSTALL lack?
> >
> > May be I am running some old version on my Ubuntu Edgy machine
> > perhaps? I cannot find such a file anywhere?
>
> You can always look up this file at git.git gitweb (either kernel.org
> one, or repo.or.cz one), e.g.
>
>   http://repo.or.cz/w/alt-git.git/:gitweb/INSTALL
>
> > Looks like it is available in newer versions.
> > Does it works for git-1.4.4?
>
> The installation instructions may have changed a bit since then. It is
> much easier to use 1.5.x series, nevertheless.
>
> --
> Jakub Narebski
> Poland
>


-- 
Pradeep
