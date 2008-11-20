From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH v2] Document levenshtein.c
Date: Thu, 20 Nov 2008 11:21:50 -0600
Message-ID: <1227201710.22668.2.camel@ld0161-tx32>
References: <20081118185326.12721.71576.stgit@arrakis.enst.fr>
	 <alpine.DEB.1.00.0811190151000.30769@pacific.mpi-cbg.de>
	 <2008-11-19-09-42-45+trackit+sam@rfc1149.net>
	 <alpine.DEB.1.00.0811191053250.30769@pacific.mpi-cbg.de>
	 <7vhc63svsl.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0811201255120.30769@pacific.mpi-cbg.de>
	 <2008-11-20-13-00-31+trackit+sam@rfc1149.net>
	 <alpine.DEB.1.00.0811201426100.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Samuel Tardieu <sam@rfc1149.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 20 18:24:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3DGB-0001Mb-8q
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 18:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbYKTRWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 12:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752478AbYKTRWq
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 12:22:46 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:39084 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbYKTRWp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 12:22:45 -0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id mAKHLqwC013172;
	Thu, 20 Nov 2008 10:22:04 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id mAKHLpl2009554;
	Thu, 20 Nov 2008 11:21:51 -0600 (CST)
In-Reply-To: <alpine.DEB.1.00.0811201426100.30769@pacific.mpi-cbg.de>
X-Mailer: Evolution 2.0.2 (2.0.2-35.el4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101461>

On Thu, 2008-11-20 at 14:27 +0100, Johannes Schindelin wrote:
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

> + * This implementation allows the costs to be weighted:
> + *
> + * - w (as in "sWap")
> + * - s (as in "Substition")
> + * - a (for insertion, AKA "Add")
> + * - d (as in "Deletion")
> + *


Were these supposed to be examples or definitions?
The first looks like a definition by example.
I'm not sure what "Substition" is besides a misspelling.
Is it the definition "Substitution"?  Or was it an
example "Substitition" poorly spelled?
The final two look like straight definitions.

Thanks,
jdl
