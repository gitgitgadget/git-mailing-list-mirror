From: Mike Hommey <mh@glandium.org>
Subject: Re: Integration branching
Date: Thu, 10 Apr 2008 22:04:13 +0200
Organization: glandium.org
Message-ID: <20080410200413.GA16951@glandium.org>
References: <b24851260804070602o11b93923m7ce7d79d5f59547b@mail.gmail.com> <7vod8lpnpb.fsf@gitster.siamese.dyndns.org> <b24851260804071118h4eaadef8i8313c5a4cb26495d@mail.gmail.com> <32541b130804071132q24acff6an853730af4fc7273e@mail.gmail.com> <b24851260804080656u4c42c31cv3984fa2943d83b8a@mail.gmail.com> <7vmyo4mbb6.fsf@gitster.siamese.dyndns.org> <20080408190127.GA28556@glandium.org> <b24851260804081332l74beb7e6o2f48b18f65af7b55@mail.gmail.com> <20080408204319.GA12323@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Kai Hendry <hendry@aplixcorp.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 22:07:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jk31P-0002k0-OO
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 22:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756931AbYDJUEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 16:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756922AbYDJUEj
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 16:04:39 -0400
Received: from vuizook.err.no ([194.24.252.247]:45295 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756702AbYDJUEj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 16:04:39 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1Jk30P-0007hK-Da; Thu, 10 Apr 2008 22:04:27 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1Jk30H-0007s4-RA; Thu, 10 Apr 2008 22:04:13 +0200
Content-Disposition: inline
In-Reply-To: <20080408204319.GA12323@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79246>

On Tue, Apr 08, 2008 at 10:43:19PM +0200, Mike Hommey wrote:
> On Tue, Apr 08, 2008 at 09:32:31PM +0100, Kai Hendry wrote:
> > Hi Mike!
> > 
> > You're busy. :)
> > 
> > So do you acknowledge this as a bug or am I doing something wrong?
> > 
> > If you know where the problem lies, perhaps I can get a C ninja from
> > work to look at it.
> 
> Could you provide a trace with GIT_CURL_VERBOSE set so that i can get a
> better idea ?

FWIW, it was made clear from off-list discussion with Kai that his
problem was a lack of running git update-server-info when required.

Mike
