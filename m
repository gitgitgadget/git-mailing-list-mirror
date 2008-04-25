From: "Jeffrey Ollie" <jeff@ocjtech.us>
Subject: Re: Problems importing from Apache SVN
Date: Fri, 25 Apr 2008 11:07:57 -0500
Message-ID: <935ead450804250907h3967fbf1w185e626930e185f6@mail.gmail.com>
References: <935ead450804231050u25be05bcjaaab22caa82c984c@mail.gmail.com>
	 <ceb24f170804232316p5312febeuc19728efb700619b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Terje Sten Bjerkseth" <terje@ceteo.no>
X-From: git-owner@vger.kernel.org Fri Apr 25 18:08:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpQTg-00042e-DS
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 18:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757262AbYDYQH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 12:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758576AbYDYQH7
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 12:07:59 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:55459 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757017AbYDYQH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 12:07:58 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2962233wff.4
        for <git@vger.kernel.org>; Fri, 25 Apr 2008 09:07:57 -0700 (PDT)
Received: by 10.142.53.1 with SMTP id b1mr820973wfa.348.1209139677766;
        Fri, 25 Apr 2008 09:07:57 -0700 (PDT)
Received: by 10.142.172.8 with HTTP; Fri, 25 Apr 2008 09:07:57 -0700 (PDT)
In-Reply-To: <ceb24f170804232316p5312febeuc19728efb700619b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80338>

On Thu, Apr 24, 2008 at 1:16 AM, Terje Sten Bjerkseth <terje@ceteo.no> wrote:
> On Wed, Apr 23, 2008 at 7:50 PM, Jeffrey Ollie <jeff@ocjtech.us> wrote:
>  >  I'm having some problems importing CouchDB from the Apache SVN
>  >  repository.  Here's what I get:
>
>  Works for me using git svn clone. git svn init fails for me, too.

Huh, I see the same thing.  Anyone have any clues?  I normally use
"git svn init", edit the .git/config to customize what's getting
pulled and then use "git svn fetch" from there, so I'm not usually
using "git svn clone".

Jeff
