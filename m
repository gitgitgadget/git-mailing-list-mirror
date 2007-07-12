From: "pradeep singh" <pradeep.rautela@gmail.com>
Subject: Re: git-update-server-info may be required,cannot clone and pull from a remote repository
Date: Thu, 12 Jul 2007 19:02:55 +0530
Message-ID: <a901b49a0707120632m1654733as94839e88bd993bb1@mail.gmail.com>
References: <a901b49a0707110708o7c883bb0s707d9791f344f1f6@mail.gmail.com>
	 <81b0412b0707110731n4ffa25afoea5395a856869325@mail.gmail.com>
	 <a901b49a0707112227m2ea746ectd367031fdc8d3537@mail.gmail.com>
	 <f74tk8$k21$1@sea.gmane.org>
	 <a901b49a0707120550i9361e30wc5811bd5d3305f59@mail.gmail.com>
	 <a901b49a0707120552y649fba20p4fa14ca48be4be54@mail.gmail.com>
	 <Pine.LNX.4.64.0707121411070.4516@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 12 15:33:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8ymz-0005Lq-Q7
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 15:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760175AbXGLNc7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 09:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759284AbXGLNc6
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 09:32:58 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:28196 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758799AbXGLNc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 09:32:56 -0400
Received: by py-out-1112.google.com with SMTP id d32so274406pye
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 06:32:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SQYdOaXAuo0UenZJUDNzSl719ns6AN73XNXXBrb7hdd2fTNI/9va2F97yiGzLgB0+bw7bZ41tdrRmn3w/EASQlX9wNbgyeYSJylF9eDKc9hyMIzXHPlDUYM9sV4cPgdEwoZCBcFuU1N+KMTiPwfkDdWoEeAlg/Sr8XrE9EOCTfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Iz+W3pD26AfT1FvoL4dh5bKbfSdML6Zfpx9dciHFcXzvJ3hTuoTa3i/H0S3xrUhj2/PEu261Wd7rcCG5Oyd9xsu8FNbTu3o94mlfRjdKYR1+Aky0LQphdWzuXSXRL53lCZ19GWzpioIdYDMHFuC7/mNZoc64KkkGdpnSxY94MrE=
Received: by 10.35.68.3 with SMTP id v3mr1147301pyk.1184247176023;
        Thu, 12 Jul 2007 06:32:56 -0700 (PDT)
Received: by 10.35.72.8 with HTTP; Thu, 12 Jul 2007 06:32:55 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707121411070.4516@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52289>

On 7/12/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 12 Jul 2007, pradeep singh wrote:
>
> > On 7/12/07, pradeep singh <pradeep.rautela@gmail.com> wrote:
> > > On 7/12/07, Jakub Narebski <jnareb@gmail.com> wrote:
> > > > What information does gitweb/INSTALL lack?
> > >
> > > May be i am running some old version on my Ubuntu Edgy machine
> > > perhaps? I cannot find such a file anywhere?
> > >
> > > Looks like it is available in newer versions. Does it works for
> > > git-1.4.4?
>
> IMHO it is not good to start with anything prior to 1.5.0, if you did not
> have any exposure to older Git.  In terms of user friendliness,
> 1.4.4.4->1.5.0 is a leap by an astronomic unit.
thanks for the update.
My question now changes to -
If i upgrade to git 1.5.x will i loose my earlier git info and all the stuff?
I hope having differnt git versions on different machines does not hurts?

Thanks once again for the valuable advice.

regards
>
> Ciao,
> Dscho
>
>


-- 
Pradeep
