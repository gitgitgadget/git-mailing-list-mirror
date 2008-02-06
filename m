From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (repost)] Improve bash prompt to detect merge / rebase in progress
Date: Wed, 06 Feb 2008 14:31:25 -0800
Message-ID: <7vodatu37m.fsf@gitster.siamese.dyndns.org>
References: <9b3e2dc20802061152q63bc61acuaecf3f33d4df8b19@mail.gmail.com>
	<7vodatvmtl.fsf@gitster.siamese.dyndns.org>
	<200802062314.39440.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Stephen Sinclair" <radarsat1@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:32:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMsoU-0007Q3-BJ
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 23:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756475AbYBFWbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 17:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756251AbYBFWbq
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 17:31:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635AbYBFWbp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 17:31:45 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3998A3D58;
	Wed,  6 Feb 2008 17:31:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 85A243D57;
	Wed,  6 Feb 2008 17:31:37 -0500 (EST)
In-Reply-To: <200802062314.39440.robin.rosenberg.lists@dewire.com> (Robin
	Rosenberg's message of "Wed, 6 Feb 2008 23:14:38 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72866>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> I'm not sure whether you didn't like it or not or just lost it. Here
> is the vastly enhanced prompt again, rebased.

Most likely "lost", and I appreciate a reminder like this.

> From 76aa8bae8491c1ffbd6e3f5c99ab014ef87794c8 Mon Sep 17 00:00:00 2001
> From: Shawn O. Pearce <spearce@spearce.org>
> Date: Tue, 4 Sep 2007 03:13:01 -0400
> Subject: 
>
> This patch makes the git prompt (when enabled) show if a merge or a
> rebase is unfinished. It also detects if a bisect is being done as
> well as detached checkouts.
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>

But this looks funny, without Subject: and also S-o-b by the
original author (if Shawn is indeed the original author).  It
appears that the patch originally was from Shawn and after
discussion petered out around Oct 1st 2007 there wasn't a resend
for inclusion.  Is this improved/revised in any way from the one
in the thread?

http://thread.gmane.org/gmane.comp.version-control.git/57271/focus=57536
