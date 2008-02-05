From: "Ramagudi Naziir" <naziirr@gmail.com>
Subject: Re: git-tag HEAD
Date: Tue, 5 Feb 2008 07:12:39 +0200
Message-ID: <dfb262380802042112s324cc7dfx452a540e6bc54473@mail.gmail.com>
References: <dfb262380802042024p49bfb0c3v689946dba350ac01@mail.gmail.com>
	 <BAYC1-PASMTP15D0374A5A075B79E17284AE2C0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Tue Feb 05 06:13:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMG7R-0007rG-Bj
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 06:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027AbYBEFMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 00:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbYBEFMm
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 00:12:42 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:56040 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882AbYBEFMl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 00:12:41 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1623164rvb.1
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 21:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yhBHcoZJ2HZaJFjBozF49xDdtPx1pg+AMNYV/xbWYZs=;
        b=Qik8nsXkdQqalFyEC7niZP9eEPqFJ1SbG8D1T5cOJnot2N0UbFFghv5JYPp40aoJJX17YGNaEdZAu9GeskSUZGxS/BuSDQBUBrL+MyW56z6UoMuf1ANRU8di27XcvS3d+MCdeyKlqqvDPE1Hb0zmwATj3XQyX6OuAdRghJrPr/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p+zAivVg9pIc+NrMqOzUdAqcJHHjEiojY5a5mdyZ/u4diiwS6NScbOU+m9zEWf/dnPjK54NdREKDawAj8w/LILi7UMoBAET8yiEc9MSM3dDUArf9KNMSFav3jIHPNMLhPa/kZ9ojR8nCK3vI0Uys90mRGFcDYX3akrbVA84AYQk=
Received: by 10.140.142.4 with SMTP id p4mr5317271rvd.261.1202188359298;
        Mon, 04 Feb 2008 21:12:39 -0800 (PST)
Received: by 10.140.142.6 with HTTP; Mon, 4 Feb 2008 21:12:39 -0800 (PST)
In-Reply-To: <BAYC1-PASMTP15D0374A5A075B79E17284AE2C0@CEZ.ICE>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72626>

On Feb 5, 2008 6:30 AM, Sean <seanlkml@sympatico.ca> wrote:
> On Tue, 5 Feb 2008 06:24:00 +0200
> "Ramagudi Naziir" <naziirr@gmail.com> wrote:
>
>
> > I accidently executed the command "git-tag HEAD" in one of my git repositories.
>
> $ git tag -d HEAD

Is it exactly the same as "rm .git/refs/tags/HEAD" ?

Thank you Sean.

>
> HTH,
> Sean
>
>
