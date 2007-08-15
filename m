From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: Restoring files from old commits
Date: Wed, 15 Aug 2007 20:27:09 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070815182709.GC1644@informatik.uni-freiburg.de>
References: <4698BD17.5080205@random-state.net> <20070714123754.GA29622@piper.oerlikon.madduck.net> <20070714143233.GC2544@steel.home> <7vbqeeizue.fsf@assigned-by-dhcp.cox.net> <20070715084141.GA2568@steel.home> <6bcc356f0708151022v6cb8c348nb19690c81e489c5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nikodemus Siivola <nikodemus@random-state.net>
X-From: git-owner@vger.kernel.org Wed Aug 15 20:27:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILNaR-0001Dn-NB
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 20:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762365AbXHOS1P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 15 Aug 2007 14:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763466AbXHOS1O
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 14:27:14 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:33628 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762365AbXHOS1N (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Aug 2007 14:27:13 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1ILNaJ-00063o-4F; Wed, 15 Aug 2007 20:27:11 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l7FIR9RD002097;
	Wed, 15 Aug 2007 20:27:09 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l7FIR9fR002096;
	Wed, 15 Aug 2007 20:27:09 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Nikodemus Siivola <nikodemus@random-state.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <6bcc356f0708151022v6cb8c348nb19690c81e489c5d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55932>

Hello Nikodemus,

Nikodemus Siivola wrote:
> So what I'd like is something like
>=20
>  git cat-path <commit> <path-in-the-tree-referenced-by-that-commit>
Try:

	git show  <commit>:<path-in-the-tree-referenced-by-that-commit>

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3Dhalf+a+cup+in+teaspoons
