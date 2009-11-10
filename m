From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: gitk : french translation
Date: Tue, 10 Nov 2009 21:47:42 +0100
Message-ID: <20091110204742.GA27518@vidovic>
References: <9f50533b0911060605p6ad28ad9neac3620a1809c3db@mail.gmail.com> <9f50533b0911101005j4839bd93ld69edfa94241c755@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Maximilien Noal <noal.maximilien@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nicolas Pitre <nico@fluxnic.net>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Thomas Moulard <thomas.moulard@gmail.com>,
	Guy Brand <gb@unistra.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Emmanuel Trillaud <etrillaud@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 21:48:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7xd7-0008UE-3s
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 21:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758104AbZKJUrq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Nov 2009 15:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758081AbZKJUrp
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 15:47:45 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:51518 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758065AbZKJUrp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 15:47:45 -0500
Received: by ewy3 with SMTP id 3so469674ewy.37
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 12:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kt9LHsZBjArIFFWVaJJlaIZR49XcKL7fe5IjTUYkiM4=;
        b=dsW6OIn7WaTwXTocyw0yyykwOqQDTFKf/RT2aZ9jDwDW3573EjHNT7keakJG9JVIls
         NBAI9QTbZM9NOHfKi7p6mGZ10NAVOXBCrjarcilkJ74wEb/ifgIsWIaYqZ4itPXx8t21
         57GG8exK+Rqa73/SSHsvy1NpKEs8zYenm7pE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=efFQP6Uzzqi9jPpy0jUNHuVGzgyEyCUNSyBpF8jyWbZT0b4qYDxCZX42FZZHzLiogm
         EnjUtmK1HHWkG448W6ov7mH+RRiJ0JZ095ZTPXjsS0wWOr8gwpHkRVzS3Djp/g7PNsjB
         9+rBMB/YFPgtRuOBs0TQXrCl+vWcFVT8fIEG4=
Received: by 10.213.0.142 with SMTP id 14mr5696642ebb.26.1257886069739;
        Tue, 10 Nov 2009 12:47:49 -0800 (PST)
Received: from @ (91-164-133-202.rev.libertysurf.net [91.164.133.202])
        by mx.google.com with ESMTPS id 24sm2556364eyx.5.2009.11.10.12.47.44
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 12:47:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9f50533b0911101005j4839bd93ld69edfa94241c755@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132595>

The 10/11/09, Emmanuel Trillaud wrote:

> Here is a glossary which contains the Git words and the proposed tran=
slations.
>=20
> Terme : Traduction(gitk) : Traduction(git-gui)

Nice idea, this will help for consistency.

> Branch : branche :
                     branche (git gui)

> To blame : bl=E2mer : bl=E2mer
> Commit : commit : commit
> to commit : commiter : commiter
> commiter : auteur du commit : commiteur

Why not "commiteur" for gitk too?

> Check out : R=E9cup=E9rer : charger
> to cherry-pick : Ceuillir
> Diff : Diff=E9rence : Diff

See comment at the end.

> Index : Index
> Tag : Tag : Marque (tag)
> Revision : R=E9vision : R=E9vision
> Merge : fusion : fusion
> to merge : fusionner : fusionner
> Head : Head : Head
> to reset : R=E9initialiser : R=E9initialiser
> reset : r=E9initialisation ;
> Hard (Reset) : Dure :
> Mixed (reset) : Hybride :
> Soft (Reset) : Douce :

L=E9ger ?

> Patch : Patch :
> To stage : Indexer :
>=20
> some RFCs :
> I am ok with the translation of "patch" by "patch" since it is use in
> france in other context
> I prefer to translate "Diff" by "Diff=E9rences" _especially_ when we =
are
> talking about the action of making a "diff"

You don't explain _why_. We had 3 points in favour of the "diff" term i=
n
french in this thread (keep Git's commands consistency, rough
translation and english word more used even by french people as for
"patch"). I have another argument to use "diff" now: keep consistency
with 'git gui'.

> translation of "Hard", "Mixed", "Soft" in the Reset context
> translation of "cherry-pick". For this one we could use "<translation=
>
> (<english-word>) ..." as suggest previously.

I'm fine here.

--=20
Nicolas Sebrecht
