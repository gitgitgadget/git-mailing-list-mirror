From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Wed, 24 Oct 2007 12:29:50 +0200
Message-ID: <20071024102950.GA3908@diana.vm.bytemark.co.uk>
References: <1192827476.4522.93.camel@cacharro.xalalinux.org> <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de> <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com> <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se> <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se> <Pine.LNX.4.64.0710221156540.25221@racer.site> <8fe92b430710231906l35606fe2j2b7c28ed6f4dd1a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>,
	Steffen Prohaska <prohaska@zib.de>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 12:30:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkdVU-0003cl-7C
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 12:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbXJXKaY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Oct 2007 06:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbXJXKaY
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 06:30:24 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4116 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbXJXKaX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 06:30:23 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IkdUl-00015s-00; Wed, 24 Oct 2007 11:29:51 +0100
Content-Disposition: inline
In-Reply-To: <8fe92b430710231906l35606fe2j2b7c28ed6f4dd1a3@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62205>

On 2007-10-24 04:06:38 +0200, Jakub Narebski wrote:

> 5. git format-patch to generate patch series; use git-shortlog or
> grepping for patches subjects and git-diff --stat to generate
> introductory email. Unfortunately StGIT template for introductory
> email does have neither shortlog nor diffstat fields to atomatically
> fill.

It does now! (I don't think it's in any released version yet, though.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
