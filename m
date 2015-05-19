From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Diffing submodule does not yield complete logs for merge commits
Date: Tue, 19 May 2015 12:44:18 +0200
Message-ID: <20150519104413.GA17458@book.hvoigt.net>
References: <CAHd499BqB_ZFKMNxSVCDTFx2Ge=TfCE6gexFn+rfRbS+ybLybA@mail.gmail.com>
 <20150501175757.GA10569@book.hvoigt.net>
 <CAHd499B=EcgYiTMFt9VYhj45bRkP8h9TBk1B0cr8fYFuXNe_mQ@mail.gmail.com>
 <5547C961.7070909@web.de>
 <CAHd499CRge9Y6VzdC_ngXS4WxuQ9HizXQJzLpX3iQStY5Cg=6g@mail.gmail.com>
 <37f399418bbebb3b53a50bf8daffcdc0@www.dscho.org>
 <CAHd499Do2aB5E_=aDzkoDssEbgz181rH36X28Oe7Zcok2f=zBQ@mail.gmail.com>
 <20150518123036.GB16841@book.hvoigt.net>
 <CAHd499CETM2jmZ2iJk=AoXtjLUCQ==u6q9Z5P-3EVGSY48FY_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 19 12:44:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuf0i-00018j-8p
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 12:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342AbbESKo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 06:44:27 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.103]:42378 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305AbbESKoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 06:44:25 -0400
Received: from [77.7.20.108] (helo=book.hvoigt.net)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Yuf0Y-00008e-Hd; Tue, 19 May 2015 12:44:22 +0200
Content-Disposition: inline
In-Reply-To: <CAHd499CETM2jmZ2iJk=AoXtjLUCQ==u6q9Z5P-3EVGSY48FY_A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269349>

On Mon, May 18, 2015 at 10:06:32AM -0500, Robert Dailey wrote:
> Unfortunately I find it unintuitive and counter productive to perform
> inline patches or do anything on a mailing list. Especially on
> Windows, it's a pain to setup git to effectively do this. Also I read
> mailing lists through Gmail which does not offer a proper monospace
> font view or syntax coloring to effectively review patches and
> comments pertaining to them.

Are you sure you are not overestimating the effort it takes to send
patches inline? Once you've got your user agent correctly setup its just
a matter of copy and paste instead of attaching the patch. On Windows I
would probably use Thunderbird which has a section in the format-patch
documentation how to configure it. Compared to the effort you probably
spent on writing your patch isn't this bit of extra effort neglectable?
And your patch is almost done. It just needs some tests and maybe a few
rounds on the mailinglist after that.

> Since I am not willing to properly follow your process, I will
> withdraw my patch. However it is here if someone else wishes to take
> it over. Really wish you guys used github's amazing features but I
> understand that Linus has already made his decision in that matter.

It not just Linus decision it is also a matter of many people are used
to this workflow. AFAIR there have been many discussions and tries about
using other tools. Email has many advantages which a webinterface does
not provide. It is simply less effort that one person adjusts to this
workflow instead of changing many peoples working workflow.

> I'm sorry I couldn't be more agreeable on the matter. Thanks for the
> time you spent reviewing my patch.

If you are really this fixed in your workflow that would be too bad.

Cheers Heiko
