From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] bash completion: Hide more plumbing commands
Date: Wed, 27 Aug 2008 11:09:25 +0200
Message-ID: <20080827090925.GB14222@diana.vm.bytemark.co.uk>
References: <20080826171012.GO10360@machine.or.cz> <20080826171144.21328.82727.stgit@localhost> <vpqiqtnsasb.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	gitster@pobox.com, andi@firstfloor.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 27 10:49:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYGhy-0005KM-VS
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 10:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbYH0Irv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Aug 2008 04:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbYH0Irv
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 04:47:51 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3990 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942AbYH0Iru (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 04:47:50 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KYH1p-000421-00; Wed, 27 Aug 2008 10:09:25 +0100
Content-Disposition: inline
In-Reply-To: <vpqiqtnsasb.fsf@bauges.imag.fr>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93876>

On 2008-08-26 23:53:40 +0200, Matthieu Moy wrote:

> Petr Baudis <pasky@suse.cz> writes:
>
> > git <tab><tab> still shows way too many commands, some of them are
> > clearly plumbing.
>
> Is it possible to have the completion not show them by default, but
> fall back to them if no other completion is found?

I don't know if it's possible, but it sounds like a great idea.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
