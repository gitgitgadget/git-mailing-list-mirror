From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH 1/2] init: support --import to add all files and commit 
	right after init
Date: Wed, 25 Mar 2009 13:49:40 +0100
Message-ID: <adf1fd3d0903250549l60e4a2d1j8bd57ba66d24a678@mail.gmail.com>
References: <1237978720-2500-1-git-send-email-pclouds@gmail.com>
	 <adf1fd3d0903250456l3c14a863pd6ee00c0025100c4@mail.gmail.com>
	 <alpine.DEB.1.00.0903251338130.26370@intel-tinevez-2-302>
	 <20090325124219.GA5307@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 25 13:51:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmSZf-00066P-Ah
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 13:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbZCYMtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 08:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbZCYMto
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 08:49:44 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:52127 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbZCYMto (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 08:49:44 -0400
Received: by fxm2 with SMTP id 2so14890fxm.37
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 05:49:41 -0700 (PDT)
Received: by 10.103.24.17 with SMTP id b17mr4165774muj.112.1237985380919; Wed, 
	25 Mar 2009 05:49:40 -0700 (PDT)
In-Reply-To: <20090325124219.GA5307@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114600>

2009/3/25 Jeff King <peff@peff.net>:
> On Wed, Mar 25, 2009 at 01:38:30PM +0100, Johannes Schindelin wrote:
>
>> > > +If no message is given, "Initial commit" will be used.
>> >
>> > Why a default message and not running the editor?
>>
>> Because I would say "Initial commit" anyway.

And I would say "Commit inicial".

>
> Agreed. This feature is about convenience.

... for project in english.

> If you really want to say
> something more exciting, then use "git commit" directly. Heck, you can
> even "git commit --amend" it afterwards.

I can. But then it is no longer "convenience".

But anyway, it is like the "Merge branch..." commit message for
merges. So nothing new.

Santi
