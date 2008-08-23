From: Marius Vollmer <marius.vollmer@uni-dortmund.de>
Subject: Re: Documenting branches
Date: Sun, 24 Aug 2008 01:30:51 +0300
Message-ID: <87bpzjfjok.fsf_-_@uni-dortmund.de>
References: <20080822174655.GP23334@one.firstfloor.org>
	<alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org>
	<20080822182718.GQ23334@one.firstfloor.org>
	<alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org>
	<20080823071014.GT23334@one.firstfloor.org>
	<alpine.LFD.1.10.0808230853170.3363@nehalem.linux-foundation.org>
	<20080823164546.GX23334@one.firstfloor.org>
	<20080823181827.GA15993@atjola.homenet>
	<alpine.LFD.1.10.0808231152250.3363@nehalem.linux-foundation.org>
	<87k5e7fm3q.fsf_-_@uni-dortmund.de>
	<20080823221728.GI23800@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Aug 24 00:32:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX1eH-0002Pr-L6
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 00:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbYHWWax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 18:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752780AbYHWWax
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 18:30:53 -0400
Received: from smtp6.pp.htv.fi ([213.243.153.40]:56575 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592AbYHWWax (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 18:30:53 -0400
Received: from zagadka.ping.de (cs178034.pp.htv.fi [213.243.178.34])
	by smtp6.pp.htv.fi (Postfix) with SMTP id 146CD5BC00E
	for <git@vger.kernel.org>; Sun, 24 Aug 2008 01:30:52 +0300 (EEST)
Received: (qmail 9060 invoked by uid 1000); 24 Aug 2008 01:30:51 +0300
In-Reply-To: <20080823221728.GI23800@genesis.frugalware.org> (Miklos Vajna's
	message of "Sun, 24 Aug 2008 00:17:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93499>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Sun, Aug 24, 2008 at 12:38:33AM +0300, Marius Vollmer <marius.vollmer@uni-dortmund.de> wrote:
>> Junio periodically posts "A note from the maintainer" that explains how
>> the Git repository is structured and what each of the branches is for.
>> It would good if this information could be found in a standard location
>> in the repository itself.
>
> See MaintNotes in the 'todo' branch.

Yes, I found them there, but I wouldn't call this a good example that
other people should imitate.  "MaintNotes in the todo branch" seems more
born out of accident than by design.  "NOTES in the README branch"
already sounds much better.

> See also Junio's post in this thread:
>
> http://thread.gmane.org/gmane.comp.version-control.git/79608/focus=79621

Thanks, I will read the whole thread.
