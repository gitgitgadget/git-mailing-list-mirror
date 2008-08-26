From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 17:00:04 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0808261658120.17093@gandalf.stny.rr.com>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <48B3715D.7020608@gmail.com> <20080826091701.2e4e3ff4@hyperion.delvare> <48B3E517.2040409@gmail.com> <48B3EF6B.7070400@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitzilla@gmail.com, Jean Delvare <khali@linux-fr.org>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, users@kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
X-From: git-owner@vger.kernel.org Tue Aug 26 23:01:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY5fF-0008Hm-23
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 23:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbYHZVAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 17:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbYHZVAL
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 17:00:11 -0400
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:42008 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbYHZVAK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 17:00:10 -0400
Received: from gandalf ([74.74.65.243]) by hrndva-omta06.mail.rr.com
          with ESMTP
          id <20080826210005.FENW2273.hrndva-omta06.mail.rr.com@gandalf>;
          Tue, 26 Aug 2008 21:00:05 +0000
X-X-Sender: rostedt@gandalf.stny.rr.com
In-Reply-To: <48B3EF6B.7070400@s5r6.in-berlin.de>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93819>


On Tue, 26 Aug 2008, Stefan Richter wrote:

> A Large Angry SCM wrote:
> > Jean Delvare wrote:
> >> On Mon, 25 Aug 2008 22:58:37 -0400, A Large Angry SCM wrote:
> >>> David Woodhouse wrote:
> >>>>   (C) Just don't do it. Leave the git-foo commands as they were. They
> >>>>       weren't actually hurting anyone, and you don't actually _gain_
> >>>>       anything by removing them. For those occasional nutters who
> >>>>       _really_ care about the size of /usr/bin, give them the _option_
> >>>>       of a 'make install' without installing the aliases.
> >>> Acked-by: A Large Angry SCM <gitzilla@gmail.com>
> [...]
> > Do some research; [...]
> 
> ...the plan to move git-foo out of /usr/bin has been discussed and 
> wrapped up quite a while ago (am I confident to say without being 
> subscriber of git@vger.k'org myself).
> 

I'm sorry, but this thread reminds me of the day Aurther Dent's house was 
going to be destroyed for a by-way. ;-)

-- Steve
