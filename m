From: Bill Lear <rael@zopyra.com>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 5 Mar 2007 19:59:32 -0600
Message-ID: <17900.51972.524213.320552@lisa.zopyra.com>
References: <17895.18265.710811.536526@lisa.zopyra.com>
	<Pine.LNX.4.63.0703022018190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070305072323.GA31169@diana.vm.bytemark.co.uk>
	<Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.27067.247950.419438@lisa.zopyra.com>
	<Pine.LNX.4.63.0703052014020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.30394.172067.743310@lisa.zopyra.com>
	<Pine.LNX.4.63.0703052143120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.36569.805689.922989@lisa.zopyra.com>
	<Pine.LNX.4.64.0703051347490.3998@woody.linux-foundation.org>
	<17900.39124.763603.695942@lisa.zopyra.com>
	<Pine.LNX.4.64.0703051431130.3998@woody.linux-foundation.org>
	<17900.42415.750335.329874@lisa.zopyra.com>
	<Pine.LNX.4.63.0703060026340.13683@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.43487.947400.649777@lisa.zopyra.com>
	<Pine.LNX.4.63.0703060042040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.46257.982036.751903@lisa.zopyra.com>
	<Pine.LNX.4.63.0703060227150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 06 02:59:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOOxn-0004em-FZ
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 02:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965574AbXCFB7h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 20:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbXCFB7h
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 20:59:37 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60638 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965679AbXCFB7g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 20:59:36 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l261xXf32179;
	Mon, 5 Mar 2007 19:59:33 -0600
In-Reply-To: <Pine.LNX.4.63.0703060227150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41526>

On Tuesday, March 6, 2007 at 02:34:27 (+0100) Johannes Schindelin writes:
>On Mon, 5 Mar 2007, Bill Lear wrote:
>> On Tuesday, March 6, 2007 at 00:50:16 (+0100) Johannes Schindelin writes:
>> >On Mon, 5 Mar 2007, Bill Lear wrote:
>> >> No, I think you missed my point.  There are two xyz.o's:
>> >> 
>> >> One in .master/xyz.o, and one in .branchX/xyz.o.
>> >
>> >Why not put the two xyz.c's into .master/ and .branchX/ as well (surely, 
>> >the source files are small compared to the object files)? And just to make 
>> >sure ...
>> 
>> So, be resorting to snide sarcasm, I can see you concede my point,
>> finally.
>
>If you would have cared to actually read and try to understand my reply 
>here:

Which I did, your baseless presumption to the contrary
notwithstanding.

>you would have seen long ago that I actually see your problem, and want 
>the something similar myself. This is what I "concede". Always have. Only 
>that I use a sane method to achieve it. And that was my point you 
>consistently refused to accept.
>...
>You don't have to thank me, as you clearly chose to ignore my help.

Your presumption is again false: your point was that my logic was
confused, that the entire dependency scheme I sketched out was
"stupid", and you and another expended considerable effort to show how
stupid this was, which now is clearly wrong --- my explanation and
example wasn't stupid after all.  I was merely trying to convey WHAT I
wanted to have happen, and HOW, logically speaking, it could.  What I
got from you and one other ON THIS PART was that my logic was STUPID,
IDIOTIC, etc., though to their credit, several others merely chimed in
with their opinion and helped the discussion along by presenting
argument, example, and not invective and mere assertion that my
logic was very much beneath contempt.

I saw and appreciated your earlier explanation, and will be trying to
work with it, and those the others suggested.  My guess is that it
will not be as buttery-smooth as I would have hoped, but it will
probably do well enough.

Your petulance and quick temper to dismiss someone as stupid merely
because he pursues a line of discussion that you yourself admittedly
confuse, not to mention your name-calling --- both explicit and veiled
--- really is not helpful, though your suggestions on how to use git
better certainly are, and I do very much appreciate them here, and
elsewhere.


Bill
