From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-fetch: more terse fetch output
Date: Sat, 03 Nov 2007 18:03:14 -0700
Message-ID: <7v1wb6yg8d.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.9999.0711030101340.21255@xanadu.home>
	<alpine.LFD.0.999.0711031229470.15101@woody.linux-foundation.org>
	<alpine.LFD.0.9999.0711031627000.21255@xanadu.home>
	<20071103204000.GA24959@glandium.org>
	<alpine.LFD.0.9999.0711031645350.21255@xanadu.home>
	<20071103210321.GA25685@glandium.org>
	<alpine.LFD.0.999.0711031546110.15101@woody.linux-foundation.org>
	<20071103233144.GA16734@glandium.org>
	<Pine.LNX.4.64.0711040050430.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 04 02:03:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoTts-0005Ro-6F
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 02:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757145AbXKDBDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 21:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756930AbXKDBDZ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 21:03:25 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:40927 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756827AbXKDBDY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 21:03:24 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 750FF2EF;
	Sat,  3 Nov 2007 21:03:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E50CA91EA3;
	Sat,  3 Nov 2007 21:03:37 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0711040050430.4362@racer.site> (Johannes
	Schindelin's message of "Sun, 4 Nov 2007 00:54:55 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63332>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 1kB = 1024 bytes.
>
> 1MB = 1024*1024 bytes.
>
> Everybody who claims anything else is just an annoyance to the rest of the 
> world, who is not clueless, thank you very much.
>
> And hard disk manufacturers be damned, and should burn in hell.

Don't blame the hard disk people too harshly.  The insanity
dates back to floppy disk days, where they marketted 1440kB
disks as 1.44MB.

I wonder if 700MB CD-ROM and 4.7GB DVD-R are also in decimal
bytes.  I am too lazy to check ;-)
