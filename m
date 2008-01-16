From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 12:59:02 +0100
Message-ID: <vpqd4s2rng9.fsf@bauges.imag.fr>
References: <478D79BD.7060006@talkingspider.com>
	<vpq4pdeum3v.fsf@bauges.imag.fr>
	<alpine.LSU.1.00.0801161035380.17650@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike <fromlists@talkingspider.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 13:00:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF6wI-00074D-2S
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 13:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbYAPL7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 06:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752142AbYAPL7p
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 06:59:45 -0500
Received: from imag.imag.fr ([129.88.30.1]:49175 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067AbYAPL7p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 06:59:45 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m0GBx3um012446
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2008 12:59:03 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JF6v8-00059I-6V; Wed, 16 Jan 2008 12:59:02 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JF6v8-0000ql-4E; Wed, 16 Jan 2008 12:59:02 +0100
In-Reply-To: <alpine.LSU.1.00.0801161035380.17650@racer.site> (Johannes Schindelin's message of "Wed\, 16 Jan 2008 10\:36\:34 +0000 \(GMT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 16 Jan 2008 12:59:03 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70657>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 16 Jan 2008, Matthieu Moy wrote:
>
>> Mike <fromlists@talkingspider.com> writes:
>> 
>> > I'm learning git and I'm really annoyed that the .git directory lives 
>> > in the same directory as my code.  I don't want it there for three 
>> > reasons:
>> 
>> The idea was discussed here, mostly under the name "gitlink".
>
> It goes by "git worktree";

Any pointer to some doc? My git doesn't have a "worktree" command.

> has nothing to do with gitlink (which has something to do with
> submodules).

We may not be talking about the same gitlink then.

The one I'm refering to is "Lightweight Checkout
Otherwise known as the .gitlink idea." on
http://git.or.cz/gitwiki/SoC2007Ideas for example.

-- 
Matthieu
