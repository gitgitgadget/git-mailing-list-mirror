From: "Tom Clarke" <tom@u2i.com>
Subject: Re: [PATCH] Add commands that git-gc runs underneath
Date: Thu, 30 Aug 2007 14:15:30 +0200
Message-ID: <550f9510708300515s2069d680y1a02d95d517ec705@mail.gmail.com>
References: <lkbtwek0.fsf@cante.net>
	 <Pine.LNX.4.64.0708301107320.28586@racer.site>
	 <46D6984D.9040802@op5.se>
	 <Pine.LNX.4.64.0708301254420.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Jari Aalto" <jari.aalto@cante.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 30 14:15:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQivw-0005wj-L6
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 14:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155AbXH3MPc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 08:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756063AbXH3MPc
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 08:15:32 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:54827 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbXH3MPb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 08:15:31 -0400
Received: by py-out-1112.google.com with SMTP id u77so2831625pyb
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 05:15:31 -0700 (PDT)
Received: by 10.35.62.19 with SMTP id p19mr589021pyk.1188476130784;
        Thu, 30 Aug 2007 05:15:30 -0700 (PDT)
Received: by 10.35.86.2 with HTTP; Thu, 30 Aug 2007 05:15:30 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708301254420.28586@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57033>

On 8/30/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> I have nothing against listing the commands per se.  But the man page is
> too exposed IMHO.  (Or would you like to add the original shell script to
> git-log's man page, too?)

Perhaps the man pages for the lower level commands should reference
git-gc as the command that - unless you have special circumstances -
you probably want. As a new git user it was only reading this thread
that made me realise that git-gc is the command I want most of the
time - a number of the tutorials I had read referenced the low level
commands, and I didn't realise they had been superseded for normal
use.

-Tom
