From: jidanni@jidanni.org
Subject: stopping patches from just floating by
Date: Mon, 12 Jan 2009 01:27:20 +0800
Message-ID: <87y6xhkb2f.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 18:29:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM47O-0001vm-W3
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 18:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbZAKR10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 12:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbZAKR1Z
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 12:27:25 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:41133 "EHLO
	homiemail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750905AbZAKR1Z (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jan 2009 12:27:25 -0500
Received: from jidanni.org (122-127-36-11.dynamic.hinet.net [122.127.36.11])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a5.g.dreamhost.com (Postfix) with ESMTP id 4C4319C4E5
	for <git@vger.kernel.org>; Sun, 11 Jan 2009 09:27:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105194>

I have many Documentation/* grammar patches that I can send next week.

However I fear they will be for naught, just floating by.

OK, one should keep track of the patches one sends, making sure they
are resolved one way or the other, and don't just float by.

Reviewing SubmittingPatches, in the future I will use [PATCH/RFC]
instead of just [PATCH].

I notice lots of "Merge branch qq/bla". And think, hmmm, Mr. QQ must
be using Documentation/everyday.txt's [[Individual Developer
(Participant)]] git-push methods, for a more efficient way of getting
his patches included by the maintainer.

But then I step back and look at all the [PATCH]s on this list and
conclude that just as SubmittingPatches doesn't mention git-push, the
whole git development world must be by simple emailed patches, and I
needn't bother learning git-push, making depositories on my web server
etc.
