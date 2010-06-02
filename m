From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 7/8] Documentation/cherry-pick: describe passing more than one commit
Date: Wed, 2 Jun 2010 07:57:42 +0200
Message-ID: <201006020757.42629.chriscool@tuxfamily.org>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org> <20100601095124.GA1033@progeny.tock> <AANLkTikjCFLj8ZxKI-kiLOqYDg9YYIkX8-lRxNATNGcO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 07:57:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJgxf-0006OG-8u
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 07:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214Ab0FBF5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 01:57:52 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:46631 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231Ab0FBF5v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 01:57:51 -0400
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E05218180F0;
	Wed,  2 Jun 2010 07:57:43 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <AANLkTikjCFLj8ZxKI-kiLOqYDg9YYIkX8-lRxNATNGcO@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148206>

Hi,

On Tuesday 01 June 2010 12:26:01 Ramkumar Ramachandra wrote:
> Hi,
> 
> Jonathan Nieder wrote:
> > Christian Couder wrote:
> >> +Examples
> >> +--------
> >
> > These are a little repetitive.
> 
> Since you also posted an "Examples" section for the git-revert, you
> could especially showcase options that aren't in git-revert (--ff and
> -x) here.

There is already an example with --ff and I think -x may not deserve an 
example. (But feel free to propose a patch to add one if you think it's worth 
it.)

> Also, you might want to include a reference to git-revert in this
> document, in a "See Also" section perhaps?

Ok, I added a "SEE ALSO" section to both git-cherry-pick.txt and git-
revert.txt.

Thanks,
Christian.
