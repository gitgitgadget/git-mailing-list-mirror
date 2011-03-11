From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Summer of Code project ideas due this Friday
Date: Fri, 11 Mar 2011 14:28:05 +0100
Message-ID: <201103111428.05627.trast@student.ethz.ch>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com> <20110310001017.GA24169@elie> <m339mu7u6n.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 14:28:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py2O7-0001BW-Br
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 14:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278Ab1CKN2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 08:28:10 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:13894 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807Ab1CKN2J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 08:28:09 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.270.1; Fri, 11 Mar
 2011 14:27:54 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.270.1; Fri, 11 Mar
 2011 14:28:06 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-9-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <m339mu7u6n.fsf@localhost.localdomain>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168897>

Jakub Narebski wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > 4. filter-branch killer: using fast-import's new features to implement
> >    common filter-branch operations (--subdirectory-filter,
> >    --prune-empty, obliterating certain files) faster.
> 
> How it would be different from existing reposurgeon tool by ESR
> (cross-VC thanks to using fast-import format), or git_fast_filter by
> Elijah Newren (more of a library than a ready tool)?

Git integration?  I haven't looked at these tools for long enough to
say how much they fit the ticket and how fast they are, so for me it's
hard to say how much work it would be.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
