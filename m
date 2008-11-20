From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH v2] Document levenshtein.c
Date: Thu, 20 Nov 2008 18:48:55 +0100
Message-ID: <bd6139dc0811200948u7d2cf8e9qfaada22d21f6d01c@mail.gmail.com>
References: <20081118185326.12721.71576.stgit@arrakis.enst.fr>
	 <alpine.DEB.1.00.0811190151000.30769@pacific.mpi-cbg.de>
	 <2008-11-19-09-42-45+trackit+sam@rfc1149.net>
	 <alpine.DEB.1.00.0811191053250.30769@pacific.mpi-cbg.de>
	 <7vhc63svsl.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0811201255120.30769@pacific.mpi-cbg.de>
	 <2008-11-20-13-00-31+trackit+sam@rfc1149.net>
	 <alpine.DEB.1.00.0811201426100.30769@pacific.mpi-cbg.de>
	 <1227201710.22668.2.camel@ld0161-tx32>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Samuel Tardieu" <sam@rfc1149.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git List" <git@vger.kernel.org>
To: "Jon Loeliger" <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 18:50:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3DfQ-0004eG-Cn
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 18:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbYKTRs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 12:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbYKTRs5
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 12:48:57 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:19169 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbYKTRs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 12:48:56 -0500
Received: by yx-out-2324.google.com with SMTP id 8so259050yxm.1
        for <git@vger.kernel.org>; Thu, 20 Nov 2008 09:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=khbU+ctJ5EF14sYkf7sFbO6HsKtfvCEzNNRfJI2rTlQ=;
        b=DOL6gE7DNiw4OpJt0uQVR2CBxwkUYTq99Zsf0gc0K0eu9JebFQfjUCwUL/v8+V7oc1
         NzfI8lAej+JUfNCE+Kgf+wZqmcBVSpa4ICV8yFYcLCFfMnZLRxQX5slCIslqe6m24P7r
         lXDOwLxcEX+T4n27xqEw17wpSyZwXH91DbsTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=xqpI/IUyZkwOToZXSTxsEivuyE9f0UseUNZiKwZZJRABnifARhba9NaNpQqsLmnBED
         pdTv1njv3iDFdQfzvuNnyf2enhDycdiD5kXnkCmrwODX1uBlHSa5AJt4W9Q3FLUu5iOZ
         5ErbrpU1lj/j6YlBVOXXJw5BonQYngBUaLfZc=
Received: by 10.151.83.12 with SMTP id k12mr4633145ybl.46.1227203335839;
        Thu, 20 Nov 2008 09:48:55 -0800 (PST)
Received: by 10.150.149.14 with HTTP; Thu, 20 Nov 2008 09:48:55 -0800 (PST)
In-Reply-To: <1227201710.22668.2.camel@ld0161-tx32>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101463>

On Thu, Nov 20, 2008 at 18:21, Jon Loeliger <jdl@freescale.com> wrote:
> Were these supposed to be examples or definitions?
> The first looks like a definition by example.
> I'm not sure what "Substition" is besides a misspelling.
> Is it the definition "Substitution"?  Or was it an
> example "Substitition" poorly spelled?
> The final two look like straight definitions.

Err, I'm pretty sure it's documenting the parameters?

-- 
Cheers,

Sverre Rabbelier
