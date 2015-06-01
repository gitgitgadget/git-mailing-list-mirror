From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] l10n: de.po: translate "index" as "Index"
Date: Mon, 01 Jun 2015 22:00:20 +0200
Organization: Alumni Technische =?UTF-8?B?VW5pdmVyc2l0w6R0?= Hamburg-Harburg
Message-ID: <1749852.uCRPrjoCKZ@cs-pc>
References: <1432925644-26231-1-git-send-email-ralf.thielow@gmail.com> <3813728.oJDPxEPYet@cs-pc> <CAGZ79kb01tODVL+iMNWvQdxwUZujy8fy0B3ZiNwODoJ5kadzvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>, tr@thomasrast.ch,
	jk@jk.gs, phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 22:00:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzVt2-00045X-8H
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 22:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288AbbFAUAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 16:00:32 -0400
Received: from smtp6.rz.tu-harburg.de ([134.28.205.36]:36720 "EHLO
	smtp6.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200AbbFAUAa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 16:00:30 -0400
Received: from mail.tu-harburg.de (mail.tu-harburg.de [134.28.202.179])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.tu-harburg.de", Issuer "TUHH CA in DFN-PKI Global - G01" (verified OK))
	by smtp6.rz.tu-harburg.de (Postfix) with ESMTPS id 3m0nRc6kn1zGmS2;
	Mon,  1 Jun 2015 22:00:28 +0200 (CEST)
Received: from mailspring.rz.tu-harburg.de (mailspring.rz.tu-harburg.de [134.28.202.181])
	(user=alucst mech=PLAIN)
	by mail.tu-harburg.de (8.13.8/8.13.8) with ESMTP id t51K0Sue000956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Jun 2015 22:00:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2015-23;
	t=1433188828; bh=O7snybgLewEZ3Nz88o9Jo88bTjFdIWwDs01hH2a9V7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=UxbGWq/kPHyOnELqMnhIi6UZp2nuAPHlmTwMaqliZyOv3G1WERW2YwTUtl6O7roRZ
	 czmXqN+rXjM/uNdSZZ7IG/h9WHcyWZ42nYUYbaVeXMijoKeZhPRNJlfGFIcA4bOOyO
	 k40fGD7FXUvdp/aZF38SgvxR1N4n9AO7FXnm/M2Q=
User-Agent: KMail/4.13 (Linux/3.13.0-52-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <CAGZ79kb01tODVL+iMNWvQdxwUZujy8fy0B3ZiNwODoJ5kadzvw@mail.gmail.com>
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270467>

Am Montag, 1. Juni 2015, 12:34:31 schrieb Stefan Beller:
> On Mon, Jun 1, 2015 at 12:26 PM, Christian Stimming <stimming@tuhh.de> 
wrote:
> > "index" concept, my explanation routinely says "This concept is called
> > 'index' but it has nothing to do with any associations you make with that
> > word. Better remember this thingy as *** and replace the termin 'index'
> > with *** every time you read about it." where "***" is my preferred
> > translation. The facial expressions of the audience regarding "index"
> > regularly confirm this approach as the better one. I never encountered
> > anyone who says "Oh, but isn't 'index' a much better term for this than
> > what you said..."
> 
> So the *** is cut out here, or do you literally advise to think of a
> black magic box here?
> I'd be interested to know your preferred translation, maybe that can
> be used instead of Staging-Area then?

Sorry for being unclear here: I left out the concrete word I use because you 
might need to come up with your own choice in the command-line git 
translation. The point of this remark is rather that almost any other term is 
better than leaving "index" as a term as-is. The term that I use is only one 
among probably many possibilities.

In case you still want to know my preferred German word, I stick to the 
translations that are used in git-gui, mostly still proposed by myself in 
(huh) 2008. http://repo.or.cz/w/git-gui.git/blob/HEAD:/po/glossary/de.po  
There, "index" isn't used in the user interface anymore but rather "staging 
area", and that's translated into German as "Bereitstellung". In my experience 
this term works quite well for a German-speaking developer audience, even 
though the term with its military background is only seldomly used or known. 
But the word triggers some well-suited associations: partly "bereit" for the 
next step, partly "Stellung" as some extra third place in addition to working 
copy and repository. But that might very well be a different discussion than 
what you need to discuss for command line git.

Regards,

Christian
