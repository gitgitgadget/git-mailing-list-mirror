From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Mon, 12 Nov 2007 19:02:23 +0100
Message-ID: <vpqy7d3pck0.fsf@bauges.imag.fr>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
	<20071112131927.GA1701@c3sl.ufpr.br>
	<Pine.LNX.4.64.0711121355380.4362@racer.site>
	<200711121719.54146.wielemak@science.uva.nl>
	<Pine.LNX.4.64.0711121624330.4362@racer.site>
	<vpq3avbv2ju.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121715090.4362@racer.site>
	<18232.35893.243300.179076@lisa.zopyra.com>
	<Pine.LNX.4.64.0711121727130.4362@racer.site>
	<vpq7iknqrtp.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121755460.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 19:03:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrddD-0004aZ-7v
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 19:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbXKLSCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 13:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbXKLSCu
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 13:02:50 -0500
Received: from harmonie.imag.fr ([147.171.130.40]:32895 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbXKLSCt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 13:02:49 -0500
X-Greylist: delayed 892 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Nov 2007 13:02:49 EST
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id lACI2NEe003862;
	Mon, 12 Nov 2007 19:02:23 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Irdc7-0003mJ-MY; Mon, 12 Nov 2007 19:02:23 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Irdc7-0006n9-K8; Mon, 12 Nov 2007 19:02:23 +0100
In-Reply-To: <Pine.LNX.4.64.0711121755460.4362@racer.site> (Johannes Schindelin's message of "Mon\, 12 Nov 2007 17\:57\:32 +0000 \(GMT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Mon, 12 Nov 2007 19:02:23 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64679>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 12 Nov 2007, Matthieu Moy wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > So you need to populate the repository before starting _anyway_.
>> 
>> Last time I checked, the thread was talking about bare repository. 
>
> Wrong.  Wrong, wrong, wrong.

Repeating it 4 times doesn't make it correct. You can even try 5
times, it won't change.

Grep for "bare" in the following text:

,----
| Hi,
| 
| On Mon, 12 Nov 2007, Jan Wielemaker wrote:
| 
| > I found out that cloning a empty bare repository produces nothing at 
| > all, [...]
| 
| If they are empty, what exactly do you mean to clone?
| 
| Ciao,
| Dscho
`----

And then, guess how I ended-up with that text (hint : cut-and-paste).

>> Perhaps you have a magic formula to populate a bare repository without 
>> pushing to it from another repo, but I don't.
>
> No, but that was not what I was questioning.  No, sir, not at all.

Perhaps you can reconsider this after reading the above.

-- 
Matthieu
