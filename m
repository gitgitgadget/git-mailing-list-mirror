From: Douglas Campos <douglas@theros.info>
Subject: Re: [JGIT PATCH 0/3] Request for help: graph-based UI
Date: Sat, 25 Jul 2009 17:54:34 -0300
Message-ID: <ed88cb980907251354o3c5e9007t4de328d0c4cdea52@mail.gmail.com>
References: <cover.1247408350u.git.johannes.schindelin@gmx.de> 
	<200907212140.32520.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, spearce@spearce.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 23:00:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUoMR-0002W0-Mt
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 23:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbZGYVA2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Jul 2009 17:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752681AbZGYVA2
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 17:00:28 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:47795 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbZGYVA1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jul 2009 17:00:27 -0400
Received: by gxk9 with SMTP id 9so4513153gxk.13
        for <git@vger.kernel.org>; Sat, 25 Jul 2009 14:00:27 -0700 (PDT)
Received: by 10.150.153.21 with SMTP id a21mr7961658ybe.130.1248555294132; 
	Sat, 25 Jul 2009 13:54:54 -0700 (PDT)
In-Reply-To: <200907212140.32520.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124070>

Just a question.. all graphic things that we implement in swing aren't
usable inside eclipse with swt-awt bridge?

On Tue, Jul 21, 2009 at 4:40 PM, Robin
Rosenberg<robin.rosenberg@dewire.com> wrote:
> Diff yes, absolutely.
>
> As for the graph, have you considered using JGraph (LGPL) or some
> other =C2=A0graph toolkit.
>
> I'm not sure jgit gui in any advanced version belong in jgit itself, =
but should
> probably be a project on its' own and let jgit stay as building block=
s for more
> advanced stuff, such as EGit, NbGit, Gerrit and others, and of course=
 the gui
> of yours.
>
> I'm not likely to have much time for much non-Eclipse GUI stuff, but =
I do
> think this is a sensible project.
>
> -- robin
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
Douglas Campos
Theros Consulting
+55 11 7626 5959
+55 11 3020 8168
