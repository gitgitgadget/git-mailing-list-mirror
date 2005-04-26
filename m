From: Ryan Anderson <ryan@michonline.com>
Subject: Re: git "tag" objects implemented - and a re-done commit
Date: Tue, 26 Apr 2005 01:55:06 -0400
Message-ID: <1114494906.5983.23.camel@mythical>
References: <Pine.LNX.4.58.0504251213530.18901@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504251318290.11481@sam.ics.uci.edu>
	 <Pine.LNX.4.58.0504251339020.18901@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504251442480.12019@sam.ics.uci.edu>
	 <Pine.LNX.4.58.0504251505260.18901@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504251530480.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Andreas Gal <gal@uci.edu>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 07:50:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQIxe-0001rG-Vv
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 07:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVDZFzY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 01:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVDZFzY
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 01:55:24 -0400
Received: from mail.autoweb.net ([198.172.237.26]:2517 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261341AbVDZFzT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 01:55:19 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DQJ2J-00040z-M1; Tue, 26 Apr 2005 01:55:07 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DQJ34-0008Ud-00; Tue, 26 Apr 2005 01:55:54 -0400
Received: from ryan by mythical with local (Exim 4.50)
	id 1DQJ2J-0006dv-4i; Tue, 26 Apr 2005 01:55:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504251530480.18901@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-04-25 at 15:39 -0700, Linus Torvalds wrote:
> 
> On Mon, 25 Apr 2005, Linus Torvalds wrote:
> > 
> > So I'll probably just push out my tags with my archives, and then people
> > can verify them if they want to.
> 
> Ok, for the intrepid users, you can now test to see if you can pick them 
> out. fsck should make them totally obvious, and here's my public key in 
> case you also want to verify the things.
> 
> Of course, since I normally don't use pgp signing etc, it's entirely 
> possible that I've done something stupid, and I'm now sending you my 
> secret key and my full porn-collection.

(Un?)fortunately, you appear to have done it correctly.

Now, you just need to get a few people that know for certain it's really
your key to sign it and upload the signatures to the key server, and it
would be golden.

-- 
Ryan Anderson <ryan@michonline.com>
