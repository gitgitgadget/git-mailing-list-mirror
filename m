From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] Re: Clarify documentation on the "ours" merge
 strategy.
Date: Mon, 16 Nov 2009 09:20:06 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0911160916250.9282@ds9.cixit.se>
References: <alpine.DEB.1.00.0911031047510.4985@pacific.mpi-cbg.de> <7vskckn5b4.fsf@alter.siamese.dyndns.org> <20091111213049.GJ27518@vidovic> <200911120037.11901.trast@student.ethz.ch> <7vvdhggote.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0911121034580.8825@ds9.cixit.se>
 <20091114111259.6117@nanako3.lavabit.com> <7vk4xsqhkv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes.Schindelin@gmx.de, B.Steinbrink@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 09:21:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9wpg-0007MP-KY
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 09:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbZKPIU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 03:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbZKPIU4
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 03:20:56 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:46465 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751360AbZKPIUz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 03:20:55 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id nAG8K756011218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 16 Nov 2009 09:20:07 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id nAG8K6Hv011214;
	Mon, 16 Nov 2009 09:20:06 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <7vk4xsqhkv.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Mon, 16 Nov 2009 09:20:07 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132991>

Junio C Hamano:

> Even though I still think -Xours/-Xtheirs are nonsense options in the 
> context of source code management, I suspect that they might be exactly 
> what Peter needs in this situation.

Yes, it sounds like it would. That is not something I would use for source 
code management, but it would fit this, and some other use-cases I have, 
quite nicely.

I tend to use Git not only for source code management, but also for document 
synchronisation across machines which may, or may not, be connected to a 
network at any given time. Git is very nice for that sort of work.

> ; otherwise Peter's web site is seriously broken from the security point 
> of view and no SCM can fix that),

Indeed. If it that was the case, I deserve whatever problems I get :-)

-- 
\\// Peter - http://www.softwolves.pp.se/
