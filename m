From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Status of kha/experimental
Date: Fri, 12 Oct 2007 09:56:28 +0100
Message-ID: <b0943d9e0710120156x1ebea377od11e1175fabec4cf@mail.gmail.com>
References: <b0943d9e0710071418o6a664981i9d31db980c04bc50@mail.gmail.com>
	 <20071007213307.GA32210@diana.vm.bytemark.co.uk>
	 <b0943d9e0710091410w1559f1a0yb5055182fd289646@mail.gmail.com>
	 <20071009214613.GC26436@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20071010082602.GF12970@diana.vm.bytemark.co.uk>
	 <b0943d9e0710111338u109aa304o6ba9c886a42c2e24@mail.gmail.com>
	 <20071012074323.GB17403@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Yann Dirson" <ydirson@altern.org>,
	"=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	"Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 10:56:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgGK0-0007b5-6G
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 10:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910AbXJLI4a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Oct 2007 04:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753090AbXJLI4a
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 04:56:30 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:48608 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbXJLI43 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Oct 2007 04:56:29 -0400
Received: by rv-out-0910.google.com with SMTP id k20so750331rvb
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 01:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Ga3iQDYxpFAaxHMIkjmumTUEAxt1WiZRZ7B2scFNrPI=;
        b=RbvQ6iWYIWaVNeyryjOAtQEOrgHiG98U9+x7E30azYBqUPNoJOLRUp8zSIj2V2EioWReBI430D3s/NCnNvC3YAzKVC4FxG+NCifAgO5humt8pRPgGUFwMohYPNyqgle5wZmGZTN8tdSYTn+k/+MmyZ/u1mofG3xWtfUYKPWTQTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NNV/k+XFPw3uBIMtJiSsbkCWpms4YUW6NmNLOxU4E12rfH3J4pgfROR6KtQlatREGs7FdRQuJst4WYBHJs8cRDqbt7NsnETUVIvrwpDArAVlAdeACh7v9uRARlzCpYbbW7TRbwK8UylrZGZOQvwYrtRGHyfy41lWh2CqTt3yzwU=
Received: by 10.141.169.9 with SMTP id w9mr1377780rvo.1192179388804;
        Fri, 12 Oct 2007 01:56:28 -0700 (PDT)
Received: by 10.140.187.15 with HTTP; Fri, 12 Oct 2007 01:56:28 -0700 (PDT)
In-Reply-To: <20071012074323.GB17403@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60664>

On 12/10/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-10-11 21:38:12 +0100, Catalin Marinas wrote:
>
> > I'll try - let's say we freeze it starting with the coming Monday
> > (what's currently in kha/safe will be merged anyway) and aim to
> > release 0.14 in about 3 weeks (or as soon as we fix the major bugs)=
=2E
>
> Do you have a list of the bugs you'd like to see fixed before the
> release? (I don't, I'm not organized. :-) )

https://gna.org/bugs/?group=3Dstgit. All of them, if possible :-). If
you happen to work on any of them, change the "assigned to" filed so
that we don't duplicate the effort.

--=20
Catalin
