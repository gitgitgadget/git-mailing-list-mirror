From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Mon, 22 Oct 2007 18:15:09 -0700
Message-ID: <7v3aw2aaxu.fsf@gitster.siamese.dyndns.org>
References: <20071016060456.GC13801@spearce.org>
	<Pine.LNX.4.64.0710161209480.25221@racer.site>
	<20071016195744.GB32132@closure.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 23 03:15:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik8Mn-0003K2-S1
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 03:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbXJWBPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 21:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbXJWBPV
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 21:15:21 -0400
Received: from rune.pobox.com ([208.210.124.79]:56074 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388AbXJWBPU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 21:15:20 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id A64CE14E3FA;
	Mon, 22 Oct 2007 21:15:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D63F714E3C7;
	Mon, 22 Oct 2007 21:15:33 -0400 (EDT)
In-Reply-To: <20071016195744.GB32132@closure.lan> (Theodore Tso's message of
	"Tue, 16 Oct 2007 15:57:44 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62065>

Theodore Tso <tytso@mit.edu> writes:

> On Tue, Oct 16, 2007 at 12:16:28PM +0100, Johannes Schindelin wrote:
>> 
>> first let me thank you for being the interim maintainer.  I know it is 
>> much work, and I frankly do not have the time, or nerve, to do it.  Out of 
>> curiousity: did you use the scripts in "todo" to send these emails?
>
> I've recently started trying to use some of the scripts in "todo" to
> send similar "What's cooking" messages, and started wondering if they
> were what Junio actually used in production to send his notes.  For
> example, the scripts don't work particularly well if the refs have
> been packed.  So I had to make changes such as these so they would
> work for me.

Sorry, WI is for "what's in", WC is for "what's cooking".  I
should remove PU and RB from there.
