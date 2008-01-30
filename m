From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] fix doc typos
Date: Wed, 30 Jan 2008 21:56:27 +0100
Message-ID: <87ir1brq10.fsf@rho.meyering.net>
References: <87myqoxvzk.fsf@rho.meyering.net>
	<20080130204357.GC4475@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jan 30 21:57:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKJzU-0000q5-10
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 21:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbYA3U4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 15:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752533AbYA3U4a
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 15:56:30 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:47118 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785AbYA3U4a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 15:56:30 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 8629517B5A9
	for <git@vger.kernel.org>; Wed, 30 Jan 2008 21:56:28 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 7D10217B575
	for <git@vger.kernel.org>; Wed, 30 Jan 2008 21:56:28 +0100 (CET)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 1510C19DE;
	Wed, 30 Jan 2008 21:56:28 +0100 (CET)
In-Reply-To: <20080130204357.GC4475@genesis.frugalware.org> (Miklos Vajna's
	message of "Wed, 30 Jan 2008 21:43:57 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72068>

Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Tue, Jan 29, 2008 at 08:38:55PM +0100, Jim Meyering <jim@meyering.net> wrote:
>>  Here is an illustration, by Jon Loeliger.  Both node B and C are
>> -a commit parents of commit node A.  Parent commits are ordered
>> +commit parents of commit node A.  Parent commits are ordered
>
> wouldn't this be "Both commit node B and C are parents of commit node A."?

That does sound better.
While you're word-smithing, how about s/node B/nodes B/, too:

  "Both commit nodes B and C are parents of commit node A."

Send a patch.
