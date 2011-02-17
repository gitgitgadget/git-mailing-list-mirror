From: "Spencer E. Olson" <olsonse@umich.edu>
Subject: Re: [PATCH 1/2 (v2)] submodule: no [--merge|--rebase] when newly cloned
Date: Thu, 17 Feb 2011 16:50:15 -0700
Message-ID: <201102171650.15312.olsonse@umich.edu>
References: <1297959526-8089-1-git-send-email-olsonse@umich.edu> <201102171517.15906.olsonse@umich.edu> <7vr5b68c7c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 01:48:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqEWi-0002ax-FM
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 01:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504Ab1BRAss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 19:48:48 -0500
Received: from smtp.mail.umich.edu ([141.211.14.81]:51099 "EHLO
	hackers.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab1BRAsr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 19:48:47 -0500
Received: FROM localhost (cadash.gpcc.itd.umich.edu [141.211.2.218])
	By hackers.mr.itd.umich.edu ID 4D5DC1D7.B503B.23257 ;
	Authuser olsonse;
	17 Feb 2011 19:48:24 EST
User-Agent: KMail/1.9.4
In-Reply-To: <7vr5b68c7c.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167143>

great, and thanks


On Thursday 17 February 2011 16:37, Junio C Hamano wrote:
> "Spencer E. Olson" <olsonse@umich.edu> writes:
> > This looks fine by me.
> >
> > What about the testing patch?  It'll be a few hours before I can resubmit
> > with "git submodule status submodule" changed to "git status -s
> > submodule".
>
> I just squashed the patch from Jens in, with Ack from him.
