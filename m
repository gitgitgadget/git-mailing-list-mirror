From: Karl Wiberg <kha@treskal.com>
Subject: Re: [PATCH RFC] git-send-email --expand-aliases
Date: Tue, 24 Nov 2009 20:08:13 +0100
Message-ID: <b8197bcb0911241108mc0d6297h48d3c7bc69acc8e5@mail.gmail.com>
References: <20091123221628.GE26810@ldl.fc.hp.com>
	 <7v6390sqhz.fsf@alter.siamese.dyndns.org>
	 <20091124004554.GA27643@ldl.fc.hp.com>
	 <b8197bcb0911232312l251dfbc9va671388cfb7fe57b@mail.gmail.com>
	 <b0943d9e0911240243m13730f0bw34f2f18cf41f9079@mail.gmail.com>
	 <20091124184629.GB27418@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 20:08:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND0kR-0004jX-47
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 20:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933922AbZKXTIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 14:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933841AbZKXTIL
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 14:08:11 -0500
Received: from mail1.space2u.com ([62.20.1.135]:62340 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933824AbZKXTIL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 14:08:11 -0500
Received: from mail-bw0-f227.google.com (mail-bw0-f227.google.com [209.85.218.227])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id nAOJ7x6j001157
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Tue, 24 Nov 2009 20:07:59 +0100
Received: by bwz27 with SMTP id 27so6311587bwz.21
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 11:08:15 -0800 (PST)
Received: by 10.204.5.207 with SMTP id 15mr6532575bkw.89.1259089695833; Tue, 
	24 Nov 2009 11:08:15 -0800 (PST)
In-Reply-To: <20091124184629.GB27418@ldl.fc.hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133588>

On Tue, Nov 24, 2009 at 7:46 PM, Alex Chiang <achiang@hp.com> wrote:

> * Catalin Marinas <catalin.marinas@gmail.com>:
>
> > If there are no other users of the stg mail templates, I'm happy
> > to let them go. Otherwise, we can replace the sendmail with
> > git-send-email in stgit.
> >
> > It seems that git-format-patch and git-send-email have all the
> > features stgit has. We would need to keep some of the interactive
> > options like --edit-cover and --edit-patches since we use
> > git-format-patch and git-send-email in one go.
>
> So, is this something you (or Karl) plan on doing? Or should I take
> a crack at it?

I wasn't planning to do it, at least. I haven't had much time for
StGit lately, but when I do there are other things I was planning to
fix before this.

If you feel like trying, please go ahead. I'll be happy to assist.

> I don't mind doing the work, but it will definitely take me longer
> than it would take you.
>
> All I was doing was trying to get stg mail to understand my mutt
> aliases. ;)

Yeah, sorry about that. ;-)

Seriously, though, doing just what you started out wanting to do would
be fine too. If you decide to do the larger project, it shouldn't be
because we made you feel you had to.

-- 
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
