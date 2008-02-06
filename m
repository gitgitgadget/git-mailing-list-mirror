From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase.sh: Change .dotest directory to .git-dotest
Date: Tue, 05 Feb 2008 16:48:47 -0800
Message-ID: <7vlk5y7vv4.fsf@gitster.siamese.dyndns.org>
References: <ve53xwob.fsf@blue.sea.net>
	<alpine.LSU.1.00.0802051524580.8543@racer.site>
	<prvbxfhl.fsf@blue.sea.net>
	<alpine.LFD.1.00.0802051334070.3110@woody.linux-foundation.org>
	<alpine.LSU.1.00.0802052236220.8543@racer.site>
	<ejbrxbid.fsf@blue.sea.net>
	<alpine.LSU.1.00.0802052303060.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 01:49:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMYTy-000570-L9
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 01:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761102AbYBFAtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 19:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbYBFAtK
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 19:49:10 -0500
Received: from rune.pobox.com ([208.210.124.79]:42397 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763387AbYBFAtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 19:49:09 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 3FFEB193CA8;
	Tue,  5 Feb 2008 19:49:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1042C193C6A;
	Tue,  5 Feb 2008 19:49:21 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802052303060.8543@racer.site> (Johannes
	Schindelin's message of "Tue, 5 Feb 2008 23:04:55 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72733>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 6 Feb 2008, Jari Aalto wrote:
>
>> Sloppy scripts are best left to script writers headache.
>
> I see no sloppy behaviour when somebody sees that git-am (which uses 
> the same directory!) has no way of handling a non-applying patch, and then 
> writes a script that accesses .dotest/patch.

It may count sloppy not to feed the improvements back, though.

Of course, if the reason is because somebody is ashamed of the
script being too hacky for public consumption, then not feeding
is not sloppy at all.  But then probably that makes the script
sloppy.  That somebody is sloppy either way, isn't s/he? ;-)

> But I _see_ some sloppy behaviour of somebody not following netiquette, 
> responding to a certain mail, but not to the original poster!
>
> Ciao,
> Dscho "who is annoyed"

JC "who is trapped in day-job".
