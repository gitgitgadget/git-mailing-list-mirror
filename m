From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Sun, 3 Sep 2006 13:10:02 +0200
Message-ID: <e5bfff550609030410h11469715m88e0b5fba09f2440@mail.gmail.com>
References: <200609021817.09296.jnareb@gmail.com> <edcm1v$24k$1@sea.gmane.org>
	 <e5bfff550609022126j1a79c750vb3aeea01cda10bac@mail.gmail.com>
	 <ede765$b9u$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 03 13:10:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJprk-00075Z-RK
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 13:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWICLKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 07:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWICLKF
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 07:10:05 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:32217 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751201AbWICLKD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Sep 2006 07:10:03 -0400
Received: by py-out-1112.google.com with SMTP id n25so2120522pyg
        for <git@vger.kernel.org>; Sun, 03 Sep 2006 04:10:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CVFpu8tGOqWaZoAgjewzM80WZCpOG9tNCy5pISfwOUT0Lxm1DgDnpm/NrfVjSQlJlEjgmZGf6JKZVV67sV2B01PkusHdXegsYN+nvprZqSk0Z0+24LO7obSNTRWUjD6QlL703YA86qtuV/1ULS37dy2LXx4BwJNGDzrhO1niS8I=
Received: by 10.35.128.1 with SMTP id f1mr7464167pyn;
        Sun, 03 Sep 2006 04:10:02 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Sun, 3 Sep 2006 04:10:02 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <ede765$b9u$2@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26370>

On 9/3/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Marco Costalba wrote:
>
> > On 9/2/06, Jakub Narebski <jnareb@gmail.com> wrote:
> >>
> >> By the way, do the diff between arbitrary revisions (say, between two
> >> branches/two refs) and between arbitrary versions of the same file would be
> >> useful to have in gitweb?
> >>
> >
> > A nice tool, lot of ideas to steal ;-)
> >
> > http://www.cenqua.com/fisheye/demo/viewrep/ant/src/main/org/apache/tools/ant/?FETOUR=A1
>
> FishEye? I haven't took the full tour, but the tool seems somewhat
> CVS centric, i.e. per file history, file description,...
>
> But for example "breadcrumbs" idea for the file path (each segment of path
> being link to given (sub)directory) is a nice one. Although if I remember
> correctly the pathname (for files only) is currently hack to have somewhere
> link to "head" version of current file in plain format.
> --

Also the UI for diff between arbitrary revisions could be interesting.

-- 
VGER BF report: U 0.791104
