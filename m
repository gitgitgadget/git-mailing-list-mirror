From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [RFC] git-bisect unsure
Date: Thu, 20 Mar 2008 09:58:36 -0500
Message-ID: <1206025116.5488.15.camel@ld0161-tx32>
References: <CE6D7D80-DC0F-4840-8B95-7482EE0E71A3@gmail.com>
	 <7vod9az00w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Rhodes, Kate" <masukomi@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 16:01:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcMGH-00074b-Mm
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 16:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097AbYCTPAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 11:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755052AbYCTPAP
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 11:00:15 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:45803 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755164AbYCTPAP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 11:00:15 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m2KEwbUE029004;
	Thu, 20 Mar 2008 07:58:43 -0700 (MST)
Received: from ld0161-tx32.am.freescale.net (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m2KEwaqT007586;
	Thu, 20 Mar 2008 09:58:36 -0500 (CDT)
In-Reply-To: <7vod9az00w.fsf@gitster.siamese.dyndns.org>
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-17) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77661>

On Wed, 2008-03-19 at 19:55, Junio C Hamano wrote:

> But if this is what you are trying to say:
> 
>     6ca8b97 (Bisect: add "skip" to the short usage string., 2007-10-29)
> 
> you are about 4.5 months late ;-).

Heh.  That and one can always nudget bisect to
a different commit directly by hand as well.

jdl
