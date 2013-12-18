From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: I have end-of-lifed cvsps
Date: Wed, 18 Dec 2013 15:20:09 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20131218202009.GA4935@thyrsus.com>
References: <52B02DFF.5010408@gmail.com>
 <20131217140746.GB15010@thyrsus.com>
 <CANQwDwe8AcbCYG5GZcY1tn9BN0x5KWux_CNQY2OWG+qZJ5rS4Q@mail.gmail.com>
 <20131217210255.GA18217@thyrsus.com>
 <CANQwDwdQZGhR=hhFHe7wRAeNej_F5fHspN7+f-LiJu06utwC-w@mail.gmail.com>
 <20131218002122.GA20152@thyrsus.com>
 <CANQwDwdgZUWcgyZCWoDni+e9jgQ+8j0Yn_HMxiMn5OHzsRzjwQ@mail.gmail.com>
 <20131218162710.GA3573@thyrsus.com>
 <CACPiFC+W-RiO-YL=Wgs7YzV=z-p97ehfA+64j5F2KbayPAQm8w@mail.gmail.com>
 <20131218195450.GK3163@serenity.lan>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Dec 18 21:20:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtNbP-0004Ib-En
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 21:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373Ab3LRUUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 15:20:12 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:46890
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab3LRUUL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 15:20:11 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 0DFF2380488; Wed, 18 Dec 2013 15:20:10 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20131218195450.GK3163@serenity.lan>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239482>

John Keeping <john@keeping.me.uk>:
> Which I think sums up the position nicely; if you're doing a one-shot
> import then the standalone tools are going to be a better choice, but if
> you're trying to use Git for your work on top of CVS the only choice is
> cvsps with git-cvsimport.

Which will trash your history - the bugs in that are worse than the bugs
in 3.0, which are bad enough that I *terminated* it.

Lovely....
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
