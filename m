From: Zhi Li <lizhi1215@gmail.com>
Subject: Re: early days before git's invention
Date: Mon, 9 Nov 2009 11:39:05 +0800
Message-ID: <2986b3940911081939s1bc78ab0m8e9d8f040af87a70@mail.gmail.com>
References: <2986b3940911080423p4ccfe279ia00c995e1ea23fb9@mail.gmail.com>
	 <m3ws21rvrd.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 04:39:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7L62-0007aF-BF
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 04:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538AbZKIDjB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 22:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbZKIDjB
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 22:39:01 -0500
Received: from mail-pz0-f188.google.com ([209.85.222.188]:61481 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbZKIDjA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Nov 2009 22:39:00 -0500
Received: by pzk26 with SMTP id 26so1836602pzk.4
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 19:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aL/a2Amw8XlEVn/XPKHMbJkQDcqTjffMXBo6yxOeaU4=;
        b=RosGU8YfereRRpo+7o1vGjfu/SemVZMv2CNpNVYeJb1hb9RXTIq5s0RaY98V13fVbC
         Cbni3pXx5Mp6F8ZRKywxWDNK+SgPkV5/vd5Io6OkNwh64s+FaVvGgvrPpAv2yn7ATrNb
         WXJIoBYpUt2gsSl20hgv9AuWuKltvuw1OgLj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=S6lUuCEsZatNVNvXnrIdLofHpyQrCHcXsFJ0xQza4N/xEjUhKkbtPipFjVtjE9VOoM
         YTYwdL/e+vaMJdPTFed6MzxK8jLmYRZXlXGV0LeR/aorh0wJ6R/xr0v80xnS+sueZMKz
         Sd+DQraFQYMbl7678urNjIhpnW3dtu65+NjN0=
Received: by 10.142.74.16 with SMTP id w16mr782467wfa.200.1257737945534; Sun, 
	08 Nov 2009 19:39:05 -0800 (PST)
In-Reply-To: <m3ws21rvrd.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132437>

Thank you all for the information!

Zhi

On Sun, Nov 8, 2009 at 9:29 PM, Jakub Narebski <jnareb@gmail.com> wrote=
:
>
> Zhi Li <lizhi1215@gmail.com> writes:
>
> > I have a question maybe not suitable to be put on this list. I'm ju=
st
> > curious on git and Linux history. As what was said on wiki, Linux
> > kernel was maintained by BitKeeper, then for some reason, BitKeeper
> > can not be used, so git was invented. My question is what was used
> > before BitKeeper, CVS? I don't think so. Then, just using file to
> > manage?
>
> For why BitKeeper could not be used, see:
> =A0http://en.wikipedia.org/wiki/Git_(software)#Early_history
> =A0http://git.or.cz/gitwiki/GitHistory
> =A0http://kerneltrap.org/node/4982
> =A0http://www.pcworld.idg.com.au/article/129776/after_controversy_tor=
valds_begins_work_git?fp=3D16&fpid=3D0
>
> =A0http://better-scm.berlios.de/bk/demise-of-gratis-bitkeeper.html
> =A0http://better-scm.berlios.de/bk/what-bitmover-got-wrong.html
> =A0http://better-scm.berlios.de/bk/the-bitkeeper-ghost.html
>
> Before BitKeeper Linux used tarballs (for releases) plus patches (for
> changes); patches were send by email (on LKML). =A0Some maintainers u=
sed
> tools like Quilt (or custom scripts) for patch management.
>
>
> P.S. FreeBSD (IIRC) used / uses CVS for version control, but it has
> quite different development model than Linux.
>
> --
> Jakub Narebski
> Poland
>
