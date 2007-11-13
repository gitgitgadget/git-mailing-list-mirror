From: David Kastrup <dak@gnu.org>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Tue, 13 Nov 2007 23:56:29 +0100
Message-ID: <85abph4uw2.fsf@lola.goethe.zz>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
	<20071112131927.GA1701@c3sl.ufpr.br>
	<Pine.LNX.4.64.0711121355380.4362@racer.site>
	<200711121719.54146.wielemak@science.uva.nl>
	<Pine.LNX.4.64.0711121624330.4362@racer.site>
	<vpq3avbv2ju.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121715090.4362@racer.site>
	<18232.35893.243300.179076@lisa.zopyra.com>
	<Pine.LNX.4.64.0711121727130.4362@racer.site>
	<vpq7iknqrtp.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121755460.4362@racer.site>
	<vpqy7d3pck0.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121804400.4362@racer.site>
	<vpqoddzpc88.fsf@bauges.imag.fr>
	<7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.9999.0711121702030.21255@xanadu.home>
	<Pine.LNX.4.64.0711122212540.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 14 00:07:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is4qt-0000qt-7A
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 00:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758372AbXKMXHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 18:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759551AbXKMXHK
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 18:07:10 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:39958 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757018AbXKMXHI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 18:07:08 -0500
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1Is4qX-00012e-18; Tue, 13 Nov 2007 18:07:05 -0500
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 54F831C3DB46; Tue, 13 Nov 2007 23:56:29 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.0711122212540.4362@racer.site> (Johannes
	Schindelin's message of "Mon, 12 Nov 2007 22:17:52 +0000 (GMT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64903>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If Alice and Bob clone from an empty repository, and both work on it,
> there is _no way_ that they can have a common ancestor[*].  Hence, an
> empty clone _would_ be a cause of that condition.

So where is the problem with that?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
