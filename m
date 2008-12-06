From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git Books
Date: Sat, 06 Dec 2008 04:54:06 -0800 (PST)
Message-ID: <m34p1hihx4.fsf@localhost.localdomain>
References: <d411cc4a0812060358ub640ea3kd04072c5640eef68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git list" <git@vger.kernel.org>
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 13:56:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8whY-0004VR-3n
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 13:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324AbYLFMyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 07:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754226AbYLFMyM
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 07:54:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:43365 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbYLFMyK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 07:54:10 -0500
Received: by ug-out-1314.google.com with SMTP id 39so226918ugf.37
        for <git@vger.kernel.org>; Sat, 06 Dec 2008 04:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=E9TLLjgBGeEkCk80PvoI92xVhJW9id1lkV3LioEbVyg=;
        b=o0IRqnLLQfC902i6xUwEqcYlsZxUOzb7DOxptgBz9agHhJ1kt3Z9l/lXXopVIzyhYz
         CsEV+xxCHslOVKObC0okEuCYSvNJZ3Z2Dvw+CwNtE5gl4Vos/7DgsDw5EKRXc4IOkqC/
         8YcAwcmnb3koFU19pATF1uhJD8QLDr36uPyiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=wrscrdw6egABM5z5CVrYGpvTIajeM8HauIDFDzKXZRrka81yNJmPnvdBL5DALofh4a
         iGeATtkGsoU2251WcChrl5UKLXIFI0/xnUde2TTKp0gAnSM5DirFiRUcUaReqAZAFFrB
         8pgFshLtbgrMiNt9iUlyRbxoIyvjIkMV4mkxY=
Received: by 10.67.26.7 with SMTP id d7mr602558ugj.16.1228568046959;
        Sat, 06 Dec 2008 04:54:06 -0800 (PST)
Received: from localhost.localdomain (abvc175.neoplus.adsl.tpnet.pl [83.8.200.175])
        by mx.google.com with ESMTPS id j4sm1093929ugf.16.2008.12.06.04.54.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Dec 2008 04:54:06 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mB6Crd1l019215;
	Sat, 6 Dec 2008 13:53:49 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mB6CrS6l019211;
	Sat, 6 Dec 2008 13:53:28 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <d411cc4a0812060358ub640ea3kd04072c5640eef68@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102450>

"Scott Chacon" <schacon@gmail.com> writes:

> I have been talked into helping write a real, paper-based book on Git
> for a publisher big enough that you may even see it in your local
> Borders or whatnot.  (And, it appears that Junio has been as well:
> http://gitster.livejournal.com/21616.html)
> 
> So, since I'm near the beginning of this process, I was wondering if
> the group had any feedback as to what might be super helpful to
> include.  I mean, I have a pretty good layout and all, but if you
> wanted to point me to some threads that tend to crop up in the mailing
> list and IRC channel from relative newcomers that I might be able to
> nip in the bud, I would like to.  I'm addressing the stuff that _I_
> hear a lot, and I'm scanning the IRC logs and list for topics, but I
> figured many of you must answer the same questions all the time, too.

What I really would like to see in a paper book is _diagrams_, in the
form of simple graphs (and not UML-like diagrams, of flow-control like
diagrams).  You can find them in various slides for presentations
(among others Junio's talks), and sometimes in blog posts[1], but
usually only as ASCII-diagrams[2] in git documentation.  (And the
examples in"The Git Comminity Book" I've seen so far are a bit too
complicated).

For example explaining git object model, explaining refs: local
branches, remote-tracking branches and tags, explaining pulling and
pushing, explaining merging and 3-way merge algorithm are difficult to
do without diagrams; diagrams make it much easier to understand.

Others have emphasized workflows enough...

Footnotes:
==========
[1] http://www.gnome.org/~federico/news-2008-11.html#pushing-and-pulling-with-git-1
[2] This is understandable, as while AsciiDoc format makes it quite
    good on promise to be easy to edit for non-tech users, AFAIK there
    is no such format for diagrams and pictures.  PIC and Asymptote
    nonwithstanding.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
