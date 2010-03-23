From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Tue, 23 Mar 2010 13:19:39 +0530
Message-ID: <f3271551003230049u6cd5b2ft811acd6ebfad8471@mail.gmail.com>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com> 
	<f3271551003210525l761cf36eh69cdfddf4e645ef3@mail.gmail.com> 
	<alpine.LNX.2.00.1003212011280.14365@iabervon.org> <201003220341.38918.chriscool@tuxfamily.org> 
	<f3271551003212049r1139d6b4x279c6803cc4c7fe2@mail.gmail.com> 
	<alpine.DEB.1.00.1003221231540.7596@pacific.mpi-cbg.de> <f3271551003220643j3a726d09o2d3a078292fd8bf6@mail.gmail.com> 
	<alpine.DEB.1.00.1003222050470.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 23 08:50:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtysJ-0006QR-Kf
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 08:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315Ab0CWHuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 03:50:00 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:47832 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab0CWHuA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 03:50:00 -0400
Received: by yxe29 with SMTP id 29so2590466yxe.4
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 00:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=jz7JuW8J7InqLW2B4evwUm3tM5UDL82od3rdLhisesI=;
        b=sQpwvd+VUeV1O4R2DOdy8v2paaJfT4K1Pzp9HmhXRj6QyWLbeTv+G6ee/eZlMn0LZ0
         uA8xAgw0RM8OJOVjNQRj9mKbwfKYp877ZIGX1Jl01MRFLREIxV3Fth9X9LnSYK6Lc1FZ
         emM/I5PteTcotwx7/gjXYBtMkYrnOESxrRwCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Cp+T19x/9Rh7kMmmJZcioKUStJ8NpIv1to83VB4dbG4lO1NJZ6gJZrQEEKyxPI3QZ5
         Q/2oVacnUnpn5mFjZRh1D6y+u1uPUIq77WJ3nrYh3aB9EoKXFxPcYlf5OMoEmtF/8iNh
         MMymeHolR6amzAtWkvwk1aBttK2UmSwu4EZgE=
Received: by 10.90.62.18 with SMTP id k18mr4105064aga.26.1269330599175; Tue, 
	23 Mar 2010 00:49:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1003222050470.7596@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142994>

Hi,

> The flow looks good (although I had to jump through hoops to look at it, I
> am reading mails via ssh'ed text console).

In that case, I shouldn't put any crucial information in the figure
like the timeline, in the interest of several reviewers who might be
in a similar position.

> I have to admit that I would prefer a more detailed timeline, if only to
> show how well you understand the individual requirements of trying to
> interpret the fast-import protocol in an svn context.

Is the timeline in the text of the proposal detailed enough? I'm
planning to submit that, and remove the one in the figure.

-- Ram
