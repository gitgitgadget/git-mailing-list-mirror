From: Jeff Brown <jeff@jeffandbetsy.net>
Subject: Re: problems syncing with svn
Date: Fri, 27 Mar 2009 09:58:43 -0400
Message-ID: <bbd12f0f0903270658o73e9305dj15903f4c50278952@mail.gmail.com>
References: <bbd12f0f0903270617m3c2233b2g6c6e8c3d9a9b50a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 15:00:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnCbw-00020Y-03
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 15:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947AbZC0N6r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2009 09:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbZC0N6r
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 09:58:47 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:44090 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbZC0N6q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2009 09:58:46 -0400
Received: by fk-out-0910.google.com with SMTP id 18so456411fkq.5
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 06:58:43 -0700 (PDT)
Received: by 10.204.53.1 with SMTP id k1mr719178bkg.22.1238162323290; Fri, 27 
	Mar 2009 06:58:43 -0700 (PDT)
In-Reply-To: <bbd12f0f0903270617m3c2233b2g6c6e8c3d9a9b50a4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114895>

On Fri, Mar 27, 2009 at 9:17 AM, Jeff Brown <jeff@jeffandbetsy.net> wro=
te:
> I have found numerous folks having a similar problem but have not
> found a solution that works for me. =A0This is what I have:
>
> I have svn clone'd a repo. =A0I have added a git remote to the projec=
t.
> I have pulled from the git repo. =A0When I attempt to "svn dcommit", =
the
> commit fails with...
>
> Unable to extract revision information from commit
> 26c8e90f67d40d9193fe276f3bcbfdd4e9161730~1
>
> What I really want to do is move our primary development support to
> git (github in particular right now). =A0I want to setup a job that w=
ill
> periodically grab the latest code from github and push those changes
> to our svn repo. =A0These will be the only commits made to svn.
> Developers will no longer be committing to svn. =A0We need the svn re=
po
> kept up to date for a few reasons but do not want to do development
> against svn directly.
>
> Any advice would be much appreciated.
>
> Thanks in advance.
>

If repo details will help, the git repo is at
http://github.com/grails/grails/tree/master and the original svn repo
which that came from is at https://svn.codehaus.org/grails/trunk/.

Thanks again.



Jeff
--=20
Jeff Brown
SpringSource
http://www.springsource.com/

Autism Strikes 1 in 166
=46ind The Cause ~ Find The Cure
http://www.autismspeaks.org/
