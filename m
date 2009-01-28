From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Tue, 27 Jan 2009 20:41:50 -0800
Message-ID: <20090128044150.GI1321@spearce.org>
References: <7v1vuo1f6d.fsf@gitster.siamese.dyndns.org> <bab6a2ab0901271634x7201130bx4a565bd8bea6967b@mail.gmail.com> <7vvds0z1c1.fsf@gitster.siamese.dyndns.org> <7vk58gz04l.fsf@gitster.siamese.dyndns.org> <7vfxj4yzjj.fsf@gitster.siamese.dyndns.org> <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com> <20090128020220.GE1321@spearce.org> <7v3af4yvmu.fsf@gitster.siamese.dyndns.org> <20090128033020.GF1321@spearce.org> <7v1vuoxcxk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: PJ Hyett <pjhyett@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 05:43:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS2Gj-0006KC-Pj
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 05:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbZA1Elw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 23:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752397AbZA1Elv
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 23:41:51 -0500
Received: from george.spearce.org ([209.20.77.23]:60413 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbZA1Elv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 23:41:51 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id D8E9538210; Wed, 28 Jan 2009 04:41:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v1vuoxcxk.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107476>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> >
> > Oh, right, its not.  I was pointing out that the last time the
> > protocol changed in a way the server can infer something about the
> > client, which IIRC was 41fa7d2, we still don't have a way to tell
> > what the client is.
> 
> But you are still talking as if there is one protocol you can call "the
> protocol", but it is not.  The send-pack receive-pack protocol is on topic
> in this thread; the quoted commit was about a separate and independent
> fetch-pack upload-pack protocol.  It does not matter when that unrelated
> protocol was enhanced.

Blargh.  Of course you are right.  Its been a long 2 months for me
at work.  I'm too #@*#@!@! tired to keep the basics straight anymore.

I'm going to shut up now.
 
-- 
Shawn.
