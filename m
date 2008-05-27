From: Mark Lawrence <nomad@null.net>
Subject: Re: [cogito-0.18.2] Documentation/Code Mismatch: cg-switch -l
Date: Tue, 27 May 2008 10:04:17 +0200
Message-ID: <20080527080417.GA32209@lifebook.rekudos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 10:05:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0uBp-0001kL-HA
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 10:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789AbYE0IEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 04:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754563AbYE0IEe
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 04:04:34 -0400
Received: from lawrence.nine.ch ([217.150.250.121]:37123 "EHLO
	lawrence.nine.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757243AbYE0IE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 04:04:27 -0400
Received: from 217-162-110-104.dclient.hispeed.ch ([217.162.110.104] helo=lifebook.rekudos.net)
	by lawrence.nine.ch with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nomad@null.net>)
	id 1K0uAR-0007bx-JP
	for git@vger.kernel.org; Tue, 27 May 2008 10:04:24 +0200
Received: from mlawren by lifebook.rekudos.net with local (Exim 4.63)
	(envelope-from <nomad@null.net>)
	id 1K0uAL-0000EH-Ps
	for git@vger.kernel.org; Tue, 27 May 2008 10:04:17 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: 217.162.110.104
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: nomad@null.net
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	lawrence.nine.ch
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=1.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
X-SA-Exim-Version: 4.2.1 (built Tue, 09 Jan 2007 17:23:22 +0000)
X-SA-Exim-Scanned: Yes (on lawrence.nine.ch)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82986>

> On Mon May 26, 2008 at 02:19:04PM +0200, Andreas Ericsson wrote:
> > Mark Lawrence wrote:
> > >Hi,
> > >
> > >I don't know if this is a bug or just my understanding, but I'm having
> > >trouble matching the behaviour of "cg-switch -l" with the documentation.
> > >
> > 
> > Cogito became officially unmaintained a very long time ago (late 2006?)
> > and will almost certainly not work properly with any half-recent version
> > of git. Don't use it.
> 
> Oh. That's only <sarcasm>slightly annoying</sarcasm> to learn now, given
> that I've spent the past two years learning and converting my projects
> over to cogito :/ Could somebody *please* update the cogito web page at
> http://git.or.cz/cogito/ and put a big (maybe even blinking) notice
> informing people of this?
> 
> Bit of a shame that it's died though, because I appreciated the simpler
> interface (and some of the output I find nicer).
> 
> On a more practical note, am I likely to suffer any issues using pure
> git on repos created with cogito?

And a related question: is there any kind of cogito replacement that
provides a simplified interface? As far as versioning tools go, git is
quite low-level...

Thanks,
Mark.
-- 
Mark Lawrence
