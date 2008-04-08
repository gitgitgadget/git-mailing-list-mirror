From: Mike Hommey <mh@glandium.org>
Subject: Re: Integration branching
Date: Tue, 8 Apr 2008 21:01:27 +0200
Organization: glandium.org
Message-ID: <20080408190127.GA28556@glandium.org>
References: <b24851260804070602o11b93923m7ce7d79d5f59547b@mail.gmail.com> <7vod8lpnpb.fsf@gitster.siamese.dyndns.org> <b24851260804071118h4eaadef8i8313c5a4cb26495d@mail.gmail.com> <32541b130804071132q24acff6an853730af4fc7273e@mail.gmail.com> <b24851260804080656u4c42c31cv3984fa2943d83b8a@mail.gmail.com> <7vmyo4mbb6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kai Hendry <hendry@aplixcorp.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 21:02:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjJ5c-0003Qy-32
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 21:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758769AbYDHTBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 15:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758760AbYDHTBw
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 15:01:52 -0400
Received: from vuizook.err.no ([194.24.252.247]:57749 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758742AbYDHTBv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 15:01:51 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JjJ4Y-0003lC-49; Tue, 08 Apr 2008 21:01:40 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JjJ4R-0007Uj-6B; Tue, 08 Apr 2008 21:01:27 +0200
Content-Disposition: inline
In-Reply-To: <7vmyo4mbb6.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79018>

On Tue, Apr 08, 2008 at 11:49:33AM -0700, Junio C Hamano wrote:
> "Kai Hendry" <hendry@aplixcorp.com> writes:
> 
> > I need http:// to work as some of the engineers I work with are behind
> > a "corporate firewall" that doesn't allow ssh://. Crazy, I know.
> 
> It is not "crazy", but simply is "unfortunate".  I am not involved in
> http-push at all myself, but I recall there was somebody working on
> improving it recently?

That was me, but it has been stalled by various debian work in progress.

I hope to be able to work on http-push again in a couple weeks.

Mike
