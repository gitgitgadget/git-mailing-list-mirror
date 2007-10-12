From: "Simon Sasburg" <simon.sasburg@gmail.com>
Subject: Re: Suggestion for mailing lists... split [PATCH]-es into own list
Date: Fri, 12 Oct 2007 11:51:01 +0200
Message-ID: <981e6de60710120251s6fc2cdf9w21083038930eef7a@mail.gmail.com>
References: <e47324780710110857s472bf099u3e350d17a2c29f78@mail.gmail.com>
	 <Pine.LNX.4.64.0710111704570.4174@racer.site>
	 <981e6de60710120027j5f390a9tbe2a4c76db9ed06d@mail.gmail.com>
	 <8c5c35580710120126x51c300bfu4345b8c6315d953c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>, git@vger.kernel.org
To: "Lars Hjemli" <lh@elementstorage.no>
X-From: git-owner@vger.kernel.org Fri Oct 12 11:51:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgHAs-0007yp-39
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 11:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbXJLJvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 05:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754386AbXJLJvG
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 05:51:06 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:45433 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbXJLJvF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 05:51:05 -0400
Received: by wa-out-1112.google.com with SMTP id v27so937212wah
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 02:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1njb0udQF06Ivh8Lddov/HqC/KdiOgKA9sikQVyQKUk=;
        b=tEtYFs5sIVMRYHwaQOtWCiD+wC8mJB39zvZirIGoyEM4pH3lB/A4SWRsPI7tWLQjgnVwf9AxdzmFV5/UAYkzeJ3AGv46wcs1sYTuFZKszOyOJZCwdvpxL5RphcFRn8TY+EC92k300F6xOknI69y2wnjv+sIBQVrW7AVVFbnd5mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gsdWBARYJeC+nFWxgK6knyavDU/YWjskFfdPaUuapo1aoob/qwkNbAs0MbowDBcZP56+L7NteSyWWrivKxOihljzum2mt0WZAZmgXAa0o4IcALGV5IQxOyUIeV0dAsvm0vdtsDpkhS+HrBAAlJx9DWMi0E1nLiRDrqJrxWNy1jA=
Received: by 10.114.124.1 with SMTP id w1mr3278700wac.1192182661247;
        Fri, 12 Oct 2007 02:51:01 -0700 (PDT)
Received: by 10.114.124.3 with HTTP; Fri, 12 Oct 2007 02:51:01 -0700 (PDT)
In-Reply-To: <8c5c35580710120126x51c300bfu4345b8c6315d953c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60667>

On 10/12/07, Lars Hjemli <lh@elementstorage.no> wrote:
> On 10/12/07, Simon Sasburg <simon.sasburg@gmail.com> wrote:
> > On 10/11/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > We did not even find a way to post patches via gmail's web interface, not
> > > without severely damaging the patches.
> >
> > Oh? Turning off Rich formatting and copy/pasting the patch from my
> > editor worked for me.
>
> The problem occurs when gmail decides to wrap the lines in the patch
> (max 72 chars per line, I guess).
>
> --
> larsh
>

Ah, good to know, then.
