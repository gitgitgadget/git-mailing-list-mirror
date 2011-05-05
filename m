From: Matthew Daniel <mdaniel@gmail.com>
Subject: Re: git-svn and a new svn remote helper
Date: Thu, 5 May 2011 22:32:05 +0200
Message-ID: <BANLkTimZ6P=b6KHnj2+re5zke4Ds1012Eg@mail.gmail.com>
References: <1303138000-27807-1-git-send-email-stsp@stsp.name>
	<vpqhb9vplu4.fsf@bauges.imag.fr>
	<7v39lfa1h5.fsf@alter.siamese.dyndns.org>
	<20110419093108.GA7440@ted.stsp.name>
	<4DAD6FC4.6060004@drmicha.warpmail.net>
	<20110419120031.GE4134@ted.stsp.name>
	<4DAD7EFB.2050507@drmicha.warpmail.net>
	<BANLkTimJa5EDxXerwgZP7viLFPQRc=39uQ@mail.gmail.com>
	<loom.20110505T211005-593@post.gmane.org>
	<BANLkTikAtgunYTax5d4oEDAot83wOROmhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 22:32:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI5DZ-00069O-8u
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 22:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361Ab1EEUcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 16:32:08 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44490 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab1EEUcG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 16:32:06 -0400
Received: by vxi39 with SMTP id 39so2649249vxi.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 13:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bcHwkzdjFuMtmaQp6xiLEU6qbFGWFKyx/Rpfv95MFOI=;
        b=p4rwGthgHJ9APpDhFfYpFskrj58Peikdz+6hRcQ7m0bMtMz4q7NR+vukgJYdvqfyCe
         rL3EVo76E+KcJJgpjpbaQxQhNtWXFUWyohCAUSAf5rNZbONwEPHx4npotuB90H6powgH
         x+3Ck1Cby/dJKkFhHdhWty1AQaF/VgrNJPjZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=b5ywpHILfUK05aI/TTbXZPab79GOoyft3pFEyQab0CA1/UShfH51fnvmysZmpAOSbe
         oaUCQp7K9yJjTeCIBHNs1crzhtvyT5Ah/a1AvTrftjQpQGmgJQJeRkIlc4uhk4BdyDC7
         huW0kzwRe5AoS3WK0CRMuk80qLMFGGPc7/oj0=
Received: by 10.52.96.71 with SMTP id dq7mr1883226vdb.157.1304627525591; Thu,
 05 May 2011 13:32:05 -0700 (PDT)
Received: by 10.52.166.197 with HTTP; Thu, 5 May 2011 13:32:05 -0700 (PDT)
In-Reply-To: <BANLkTikAtgunYTax5d4oEDAot83wOROmhw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172908>

On Thu, May 5, 2011 at 10:25 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Thu, May 5, 2011 at 21:13, Matthew L Daniel <mdaniel@gmail.com> wrote:
>> Is there, in fact, a new svn remote helper under development?
>
> Yes, Dmitry Ivankov is working on this as part of his GSoC project [0].
>
> [0] http://www.google-melange.com/gsoc/project/google/gsoc2011/divanorama/17001

The link wasn't very informative; is this work scheduled to happen in
public, e.g. on a git branch perhaps?

Has Dmitry submitted the GSoC design document yet?

Inquiring minds want to know. :-)

  Thanks for your help,
  -- /v\atthew
