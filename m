From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 11:34:20 -0400
Message-ID: <1219764860.4471.13.camel@gaara.bos.redhat.com>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
	 <1219664940.9583.42.camel@pmac.infradead.org>
	 <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <7vy72kek6y.fsf@gitster.siamese.dyndns.org>
	 <20080826145719.GB5046@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	users@kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 17:52:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY0pK-00068L-UN
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 17:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775AbYHZPuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 11:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754436AbYHZPuV
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 11:50:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39965 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754338AbYHZPuU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 11:50:20 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m7QFYMor001555;
	Tue, 26 Aug 2008 11:34:22 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m7QFYMPq025542;
	Tue, 26 Aug 2008 11:34:22 -0400
Received: from [10.16.3.198] (dhcp-100-3-198.bos.redhat.com [10.16.3.198])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m7QFYLV0004207;
	Tue, 26 Aug 2008 11:34:21 -0400
In-Reply-To: <20080826145719.GB5046@coredump.intra.peff.net>
X-Mailer: Evolution 2.23.6 (2.23.6-1.fc10) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93751>

On Tue, 2008-08-26 at 10:57 -0400, Jeff King wrote:
> On Mon, Aug 25, 2008 at 04:41:57PM -0700, Junio C Hamano wrote:
> 
> > > Umm.  What exactly makes you feel you should ignore the discussions we had 
> > > around the issues on the git and msysgit mailing list?
> > 
> > Well, this was partly my fault, as I did not make it clear in this part
> > that beating the horse that has been dead for two years is not a
> > productive way to spend out time.  I however did, in the part David did
> > not quote, try to make it clear:
> > 
> >   That's all history now anyway.  We should try to do better the next time,
> >   which is much more important, and that is the topic of this message.
> 
> I don't want to stir up this discussion too much; I am sure you have
> many more important things to be working on. But I did want to make one
> observation.
> 
> One side of the argument, I see a lot of "I would prefer it this way."
> And on the other side I see a lot of "this discussion is already
> history" and "but I do not care personally that much."
> 
> It makes me wonder why nobody has said "no, really, I prefer it without
> the programs in /bin." Are they simply confident that the decision has
> been made, and don't feel the need to say something?

It's pretty normal to see opponents of a decision like this complain
loudly when it lands on their system, whereas the silent majority in
favour will be happy to see the change finally implemented but reluctant
to stir up the discussion again.

I don't think new arguments are brought to the discussion, just new
people, who are temporarily inconvened by a change towards sanity.

Kristian
