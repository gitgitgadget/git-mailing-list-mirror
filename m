From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Updated Swedish translation (514t0f0u).
Date: Thu, 20 Nov 2008 12:10:13 +0100
Message-ID: <49254595.7040103@op5.se>
References: <20081116215822.GF2932@spearce.org> <Pine.LNX.4.64.0811201047180.1606@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Mikael Magnusson <mikachu@gmail.com>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Nov 20 12:11:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L37Rg-0008Ks-LM
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 12:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025AbYKTLKV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Nov 2008 06:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753993AbYKTLKV
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 06:10:21 -0500
Received: from mail.op5.se ([193.201.96.20]:51993 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753962AbYKTLKU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 06:10:20 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 843651B8005E;
	Thu, 20 Nov 2008 12:05:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dV6C3EXKyJQI; Thu, 20 Nov 2008 12:05:16 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 630B31B80053;
	Thu, 20 Nov 2008 12:05:15 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <Pine.LNX.4.64.0811201047180.1606@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101406>

Some english notes in there too.

Peter Krefting wrote:

> +"* Untracked file is %d bytes.\n"
> +"* Showing only first %d bytes.\n"
> +msgstr "* Den osp=E5rad filen =E4r %d byte.\n"
> +"* Visar endast inledande %d byte.\n"
> =20

s/osp=E5rad/osp=E5rade/

> +#: lib/mergetool.tcl:45
> +#, tcl-format
> +msgid "File %s seems to have unresolved conflicts, still stage?"
> +msgstr "Filen %s verkar inneh=E5lla ol=F6sta konflikter, vill du =E4=
nd=E5 k=F6a?"
> +

's/, vill/. Vill/'

Should probably be two sentences in english too.

> +
> +#: lib/mergetool.tcl:303
> +msgid "Merge tool is already running, terminate it?"
> +msgstr "Verktyget f=F6r sammanslagning k=F6rs redan, vill du avsluta=
 det?"
> +

Same as above.

> =20
> -#: lib/option.tcl:128
> +#: lib/option.tcl:151
> +msgid "Blame History Context Radius (days)"
> +msgstr "Historikkontextradie f=F6r klandring (dagar)"
> +

At least a 100 points in scrabble for "historikkontextradie". How about
"Historikradie f=F6r klandring (dagar)"?

Imo, "context" is noise in both english and swedish, and should probabl=
y
be removed.

> =20
> +#: lib/remote.tcl:163
> +msgid "Remove Remote"
> +msgstr "Ta bort fj=E4rr"
> +
> +#: lib/remote_add.tcl:19
> +msgid "Add Remote"
> +msgstr "L=E4gg till fj=E4rr"
> +
> +#: lib/remote_add.tcl:24
> +msgid "Add New Remote"
> +msgstr "L=E4gg till ny fj=E4rr"
> +
> +
> +#: lib/remote_add.tcl:37
> +msgid "Remote Details"
> +msgstr "Detaljer f=F6r fj=E4rr"
> +
> +
> +#: lib/remote_add.tcl:71
> +msgid "Initialize Remote Repository and Push"
> +msgstr "Initiera fj=E4rrarkiv och s=E4nd till"
> +
> +
> +#: lib/remote_add.tcl:101
> +msgid "Please supply a remote name."
> +msgstr "Ange ett namn f=F6r fj=E4rren."
> +
> +#: lib/remote_add.tcl:114
> +#, tcl-format
> +msgid "'%s' is not an acceptable remote name."
> +msgstr "\"%s\" kan inte anv=E4ndas som namn p=E5 fj=E4rren."
> +
> +#: lib/remote_add.tcl:125
> +#, tcl-format
> +msgid "Failed to add remote '%s' of location '%s'."
> +msgstr "Kunde inte l=E4gga till fj=E4rren \"%s\" p=E5 platsen \"%s\"=
=2E"
> +

Anv=E4nd "fj=E4rrarkiv" konsekvent ist=E4llet. "fj=E4rr" anv=E4nds, s=E5=
vitt jag
vet, inte ensamt n=E5gonstans i svenska spr=E5ket, annat =E4n som slang=
=2E

> +
>  #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
> -msgid "Delete Remote Branch"
> +msgid "Delete Branch Remotely"
>  msgstr "Ta bort fj=E4rrgren"
> =20

"Ta bort gren i fj=E4rrarkivet" (fj=E4rrgren =E4r n=E5got annat)

> +
> +#: lib/tools.tcl:111
> +#, tcl-format
> +msgid "Running: %s"
> +msgstr "K=F6r: %s"
> +

s/K=F6r/Exekverar/ (upplysning, inte uppmaning)

Other than that:
Acked-by: Andreas Ericsson <ae@op5.se>

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
