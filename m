From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: gitk : french translation
Date: Sat, 7 Nov 2009 03:54:39 +0100
Message-ID: <20091107025439.GC13724@vidovic>
References: <9f50533b0911060605p6ad28ad9neac3620a1809c3db@mail.gmail.com> <b0c32d010911061016t2208af0er8d7fe88508c30f10@mail.gmail.com> <9f50533b0911061259w54b57fcdo2c0b21e95dbbdc54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Moulard <thomas.moulard@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Emmanuel Trillaud <etrillaud@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 07 03:55:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6bS8-0007tm-42
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 03:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759879AbZKGCyl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Nov 2009 21:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759873AbZKGCyl
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 21:54:41 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:57820 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755581AbZKGCyl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 21:54:41 -0500
Received: by ewy3 with SMTP id 3so1656893ewy.37
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 18:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3OQegiwAwIO6MhTxGvmrYnyCRcFbvHRkpyQjsI0zQ/8=;
        b=ZtR9YdllAd8xIytAtvBKmVQdB8ohSnMatYyn7rZtLz3cUJVNYRbTHY/CuKKJAdsarW
         6foBlKT/kU+xXW7+X+gJMpmrCTurKtKT2DGR91/+5hN28/e430NMgL/A9tjWmj/mfZP1
         S7MHboCaNe0Qbo6e5Fn4ngUUz1fiEenVvTdCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hopc/tz5UkDgP1a8G0fJnBm7esSBK/gu6K2ZfUk4QI1h3hBNz2kpR87aTxrvIwctfh
         QIjEV0jBbT+x6Bz5TZZ81neJeKzskueJ11BwVdTojuCiC+NByybbwZHjtUbE1N81AAuS
         uxyFvKnm1YGJP0+GBdfMZSvkBATYSc7Pu3Wiw=
Received: by 10.213.110.9 with SMTP id l9mr5868799ebp.14.1257562484501;
        Fri, 06 Nov 2009 18:54:44 -0800 (PST)
Received: from @ (91-165-129-169.rev.libertysurf.net [91.165.129.169])
        by mx.google.com with ESMTPS id 28sm185290eyg.22.2009.11.06.18.54.41
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 18:54:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9f50533b0911061259w54b57fcdo2c0b21e95dbbdc54@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132352>

[
  Please, conform to Documentation/SubmittingPatches of the git.git
  project and send your patches inline to make the work for reviewers
  easier.

  Both of your patches lack the Signed-off-by but maybe you don't want
  them to be merged?
]

The 06/11/09, Emmanuel Trillaud wrote:

> > Here is an updated translation with the following changes:

<...>

> > - make some consistency changes
> > =A0* s/diff/diff=E9rences/
> > =A0* s/patch/correctif/ everywhere

I disagree here. Words like "diff", "commit", "patch", etc should be
kept as is. Translation of those terms make things harder for the users=
=2E

> > IMHO the most important should be to decide how to translate the gi=
t vocabulary.
> > The Subversion project has guidelines concerning that issue:
> > http://svn.collab.net/viewvc/svn/trunk/subversion/po/fr.po?revision=
=3D39920&view=3Dmarkup
> > It may be a good idea to stick with what they are doing if possible=
=2E

No, no. SVN and Git vocabulary/operations are not identical (not only
for 'commit' as you stated). Please, don't make things harder than it
already is.

--=20
Nicolas Sebrecht
