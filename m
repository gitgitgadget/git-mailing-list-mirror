From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 22 Apr 2008 22:51:04 +0200
Message-ID: <200804222251.04559.barra_cuda@katamail.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 22:50:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoPRA-00065d-OX
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 22:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746AbYDVUtK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Apr 2008 16:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756365AbYDVUtJ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 16:49:09 -0400
Received: from smtp.katamail.com ([62.149.157.154]:45594 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1755546AbYDVUtH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2008 16:49:07 -0400
Received: (qmail 18730 invoked by uid 89); 22 Apr 2008 20:46:01 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO host149-57-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.149)
  by smtp1-pc with SMTP; 22 Apr 2008 20:45:57 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80166>

On Tuesday 22 April 2008, Junio C Hamano wrote:
> * mv/defer-gc (Wed Apr 2 21:35:11 2008 +0200) 3 commits
> =A0+ contrib/hooks: add an example pre-auto-gc hook
> =A0+ Documentation/hooks: add pre-auto-gc hook
> =A0+ git-gc --auto: add pre-auto-gc hook
>=20
> A new hook to stop "git gc --auto" from running.

About "git gc --auto", there was a patch sometime ago:

	[PATCH] commit: resurrect "gc --auto" at the end

http://marc.info/?l=3Dgit&m=3D120716427130606&w=3D2

Was it dropped?
