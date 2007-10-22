From: Wincent Colaiuta <win@wincent.com>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Mon, 22 Oct 2007 15:17:19 +0200
Message-ID: <ED965042-27DE-450B-96CB-00D27000FAF6@wincent.com>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>  <Pine.LNX.4.64.0710130130380.25221@racer.site>  <1192827476.4522.93.camel@cacharro.xalalinux.org> <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de> <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com> <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se> <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se> <Pine.LNX.4.64.0710221156540.25221@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>, Jakub Narebski <jnareb@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 15:18:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjxAv-0003BP-U3
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 15:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932AbXJVNST convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Oct 2007 09:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754769AbXJVNST
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 09:18:19 -0400
Received: from wincent.com ([72.3.236.74]:37457 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754551AbXJVNSS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2007 09:18:18 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9MDI5kj015838;
	Mon, 22 Oct 2007 08:18:06 -0500
In-Reply-To: <Pine.LNX.4.64.0710221156540.25221@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62000>

El 22/10/2007, a las 13:04, Johannes Schindelin escribi=F3:

> So once again, what operations involving git do people use regularly?

Here are my top ten commands, sorted by the number of times they =20
appear in my ~/.bash_history:

533 status
342 diff
252 commit
234 add
123 checkout
116 log
106 push
97 config
83 show
83 branch

Not very scientific, but it gives a rough idea of how one Git newbie =20
(using it for several months) with a very basic workflow uses Git.

Cheers,
Wincent
