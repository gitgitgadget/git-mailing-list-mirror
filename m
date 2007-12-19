From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: kha/safe updated
Date: Wed, 19 Dec 2007 23:17:42 +0000
Message-ID: <b0943d9e0712191517r6154f6c2g98068c8070275cb3@mail.gmail.com>
References: <20071219221848.29455.50676.stgit@yoghurt>
	 <20071219221957.29455.27315.stgit@yoghurt>
	 <20071219224638.GB15119@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 00:18:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J58BA-0000eE-Nz
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 00:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbXLSXRr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 18:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753577AbXLSXRq
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 18:17:46 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:11390 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbXLSXRq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 18:17:46 -0500
Received: by py-out-1112.google.com with SMTP id u77so5368787pyb.16
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 15:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4J363eEv8hYrWduPxH6/91eYTPkrWcJZ/KzBdjBe53Y=;
        b=nYm9s6K0qf+gJNHuhFU6J7pyWK7pBHn+PAByTaOGJaOsA/GlIunoJRVaoTVewCTxR2DtUwgOwZ8uhLFhXZLyqHmvtINEIvVi6mrQ1waZ6Mx2/1BqDNFnqNWJ8e8Aj/y7o0JSQ3p2aforxRHXSHXVRaX0RXir1T26wVDqLI13g6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qyr1ul+tqqVOW32otzzJs8UEuUMMtXXyN4fWaqoVo6IuxvS9uQ/bDSXiT2Sg07PcN76EUi0/MVP5EbsjsilzQ8XjnlQ2fcDBTMmFO7lc0FLPZMerSiBH1C3RwO1eV5FarHDE9yWxEpVbmrKPGNDGeA2KlwRhSGNeNlTC5Jlx6OM=
Received: by 10.140.170.12 with SMTP id s12mr6317885rve.101.1198106262609;
        Wed, 19 Dec 2007 15:17:42 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Wed, 19 Dec 2007 15:17:42 -0800 (PST)
In-Reply-To: <20071219224638.GB15119@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68953>

On 19/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-12-19 23:24:49 +0100, Karl Hasselstr=F6m wrote:
>
> > And here it is!
>
> And with that, I don't see any reason to not recommend that you pull
> every patch I have. Which is:

Please rebase again when you have time since I already merged most of
this branch and added some patches that might conflict with yours.

--=20
Catalin
