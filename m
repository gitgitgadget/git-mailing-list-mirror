From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH]     git gui spanish translation.
Date: Wed, 3 Feb 2010 20:13:56 +0100
Message-ID: <F0288AB4-A1C8-4D72-BA2F-B35B0FDE4180@wincent.com>
References: <4b69946c.0f67f10a.25e8.03e1@mx.google.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "=?iso-8859-1?Q?=22Alejandro_Riveira_Fern=E1ndez_=28by_way_of_Ale?=
	=?iso-8859-1?Q?jandro_Riveira_Fern=E1ndez_<ariveira@gmail.com>?=
	=?iso-8859-1?Q?=29=22?=" <alejandro.riveira@gmail.c
X-From: git-owner@vger.kernel.org Wed Feb 03 20:54:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NclIi-0008Dr-Kf
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 20:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757698Ab0BCTyB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 14:54:01 -0500
Received: from outmail137182.authsmtp.com ([62.13.137.182]:64987 "EHLO
	outmail137182.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757677Ab0BCTx7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 14:53:59 -0500
X-Greylist: delayed 2384 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Feb 2010 14:53:59 EST
Received: from mail-c193.authsmtp.com (mail-c193.authsmtp.com [62.13.128.118])
	by punt5.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o13JEAPw037285;
	Wed, 3 Feb 2010 19:14:10 GMT
Received: from wincent1.inetu.net (wincent1.inetu.net [209.235.192.161])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o13JE2c9087932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Feb 2010 19:14:03 GMT
Received: from [192.168.1.2] (124.Red-88-3-77.dynamicIP.rima-tde.net [88.3.77.124])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id o13JDv5r026136
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 3 Feb 2010 14:13:59 -0500
In-Reply-To: <4b69946c.0f67f10a.25e8.03e1@mx.google.com>
X-Mailer: Apple Mail (2.1076)
X-Server-Quench: 4ab5507f-10f8-11df-97bb-002264978518
X-Report-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJD0VH ah0dAFdZdwdEHAkR Am8BWlBeUF4/W2N8 dQhSaBtca0hQXgNr T0pMXVMcSwRre2kD VRceWh57dAcIe39z bEMsWiEJWUF6chBg Q04CHXAHZDM2dWkY AhJFdwNWcgVOdxhN b1F3GhFYa3VsBgsE NC8Gd3h5dX1QKTgd TRwMZUkKSEAKBT50 WwoLGy4rFFEEQCN1 RwAA
X-Authentic-SMTP: 61633436303433.1014:706/Kp
X-AuthFastPath: 255
X-Virus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138876>

Great work on the patch Alejandro. Such a lot of text to translate!

I spotted quite a few spelling errors in it which I comment on below. =20
There were some style issues as well but nothing too major so I mostly =
=20
just commented on the spelling.

El 01/02/2010, a las 20:51, Alejandro Riveira Fern=E1ndez (by way of =20
Alejandro Riveira Fern=E1ndez <ariveira@gmail.com>) escribi=F3:

> +#: git-gui.sh:41 git-gui.sh:737 git-gui.sh:751 git-gui.sh:764 git-=20
> gui.sh:847
> +#: git-gui.sh:866
> +msgid "git-gui: fatal error"
> +msgstr "git-gui: erro fatal"

erro -> error

> +#: git-gui.sh:738
> +msgid "Cannot find git in PATH."
> +msgstr "git no se encontra en PATH."

encontra -> encuentra

> +"No se puede determinar la version de Git,\n"
> +"\n"
> +"%s dice que es la version '%s',\n"
> +"\n"
> +"%s requeire al menos Git 1.5.0 o superior.\n"
> +"\n"
> +"Asumir que '%s' es versi=F3n 1.5.0.?\n"

requeire -> requiere

> +#: git-gui.sh:1835
> +msgid "Staged for removal"
> +msgstr "Preparado para borrar"
> +
> +#: git-gui.sh:1836
> +msgid "Staged for removal, still present"
> +msgstr "Preparado para borrado, todav=EDa presente"

Consistency fix: use either "borrar" in both of the above, or "borrado"=
=2E

> +#: git-gui.sh:2495 git-gui.sh:3087
> +msgid "Show More Context"
> +msgstr "Mostar mas contexto"

mas -> m=E1s

> +#: git-gui.sh:2611
> +msgid "Online Documentation"
> +msgstr "Documentacion en linea"

Documentacion -> Documentaci=F3n

> +#: git-gui.sh:3315
> +#, tcl-format
> +msgid ""
> +"Possible environment issues exist.\n"
> +"\n"
> +"The following environment variables are probably\n"
> +"going to be ignored by any Git subprocess run\n"
> +"by %s:\n"
> +"\n"
> +msgstr ""
> +"Hay probablemente problemas con las variables de entorno.\n"
> +"\n"
> +"Las sigientes variables de entorno ser=E1n probablemente\n"
> +"ignoradas por los todos subprocesos Git ejecutados por\n"
> +"%s:\n"
> +"\n"

"por los todos" doesn't make any sense

perhaps you meant: "por todos los"

> +#: lib/blame.tcl:967
> +msgid "Committer:"
> +msgstr "Comitter:"

"Comitter" (one "m") doesn't exist in Spanish.

Did you mean to leave it as "Committer" (two "m") as in English?

> +#: lib/branch_create.tcl:80
> +msgid "Fast Forward Only"
> +msgstr "Solo Fast Forward"

Solo -> S=F3lo

> +#: lib/branch_create.tcl:97
> +msgid "Checkout After Creation"
> +msgstr "Activar despues de crear"

despues -> despu=E9s

> +#: lib/browser.tcl:267 lib/browser.tcl:273
> +msgid "Browse Branch Files"
> +msgstr "Explora los ficheros de la rama"

Explora -> Explorar

You need to use the infinitive consistently for command verbs. You are =
=20
doing it in some places but not in others.

> +#: lib/browser.tcl:278 lib/choose_repository.tcl:394
> +#: lib/choose_repository.tcl:480 lib/choose_repository.tcl:491
> +#: lib/choose_repository.tcl:995
> +msgid "Browse"
> +msgstr "Explora"

Explora -> Explorar

> +#: lib/choose_font.tcl:39
> +msgid "Select"
> +msgstr "Selecciona"

Selecciona -> Seleccionar

> +#: lib/choose_repository.tcl:508
> +msgid "Full Copy (Slower, Redundant Backup)"
> +msgstr "Copia completa (Mas lento, redundante, copia de respaldo)"

Mas -> M=E1s

> +#: lib/choose_repository.tcl:586
> +msgid "Standard only available for local repository."
> +msgstr "Standar solo disponible para repositorios locales."

solo -> s=F3lo

> +#: lib/choose_repository.tcl:852
> +msgid "Cannot fetch branches and objects.  See console output for =20
> details."
> +msgstr "Imposible traer las ramas y objetos. Para mas detalles vea =20
> la salida de consola"

Style issue here... Do you think "obtener" might be a better =20
translation than "traer" here (and in the other places where you are =20
translating "fetch")?

Traer is closer to "bring", imo.

> +#: lib/choose_repository.tcl:887
> +msgid "Cannot determine HEAD.  See console output for details."
> +msgstr "No se puede determinar HEAD. Para mas detalles vea la =20
> salida de consola."

mas -> m=E1s

> +#: lib/choose_repository.tcl:909
> +msgid "No default branch obtained."
> +msgstr "No se obtubo la rama por defecto."

obtubo -> obtuvo

> +#: lib/choose_rev.tcl:60
> +msgid "Revision Expression:"
> +msgstr "Expresion de revisi=F3n:"

Expresion -> Expresi=F3n

> +#: lib/choose_rev.tcl:346
> +msgid "Revision expression is empty."
> +msgstr "Exprasi=F3n de revisi=F3n vacia."

Exprasi=F3n -> Expresi=F3n

vacia -> vac=EDa

> +#: lib/commit.tcl:18
> +msgid ""
> +"Cannot amend while merging.\n"
> +"\n"
> +"You are currently in the middle of a merge that has not been fully =
"
> +"completed.  You cannot amend the prior commit unless you first =20
> abort the "
> +"current merge activity.\n"
> +msgstr ""
> +"No se puede corregir mientras durante una fusi=F3n.\n"
> +"\n"
> +"Esta usted en el medio de un proceso de fusi=F3n que no ha\n"
> +"sido completado. No puede corregir la revision anterior a\n"
> +"no ser que primero cancele el proceso de fusi=F3n.\n"

mientras durante -> durante

> +#: lib/commit.tcl:331
> +msgid ""
> +"No changes to commit.\n"
> +"\n"
> +"No files were modified by this commit and it was not a merge =20
> commit.\n"
> +"\n"
> +"A rescan will be automatically started now.\n"
> +msgstr ""
> +"No hay cambios para una nueva revisi=F3n.\n"
> +"\n"
> +"Ning=FAn fihero ha sido modificado por esta revisi=F3n y no es una\=
n"
> +"revis=F3n de fusi=F3n.\n"
> +"\n"
> +"Un rescaneo empezar=E1 automaticamente ahora.\n"

fihero -> fichero

revis=F3n -> revisi=F3n

> +#: lib/date.tcl:25
> +#, tcl-format
> +msgid "Invalid date from Git: %s"
> +msgstr "Fecha invalida de Git: %s"

invalida -> inv=E1lida

> +#: lib/merge.tcl:55
> +#, tcl-format
> +msgid ""
> +"You are in the middle of a change.\n"
> +"\n"
> +"File %s is modified.\n"
> +"\n"
> +"You should complete the current commit before starting a merge.  =20
> Doing so "
> +"will help you abort a failed merge, should the need arise.\n"
> +msgstr ""
> +"Esta en el medio de un cambio.\n"
> +"\n"
> +"El fichero %s ha sido modificado.\n"
> +"\n"
> +"Deber=EDa completar la revisi=F3n actual antes de comenzar la fusi=F3=
n.\n"
> +"Hacer eso le ayudar=E1 a cancelar una fusi=F3n fallida si surgiese =
la =20
> \n"
> +"necesidad.\n"

Esta -> Est=E1

fallida -> fallada

> +#: lib/mergetool.tcl:14
> +#, tcl-format
> +msgid ""
> +"Note that the diff shows only conflicting changes.\n"
> +"\n"
> +"%s will be overwritten.\n"
> +"\n"
> +"This operation can be undone only by restarting the merge."
> +msgstr ""
> +"Tenga en cuenta que el diff solo mestra los cambios conflictivos.\n=
"
> +"\n"
> +"%s ser=E1 sobrescrito.\n"
> +"\n"
> +"Esta operacion solo se puede deshacer reiniciando la fusi=F3n."

Earlier you used "parche" as a translation for "diff". Perhaps you =20
should use it here as well.

In any case:

solo -> s=F3lo
mestra -> muestra
solo -> s=F3lo

> +#: lib/option.tcl:149
> +msgid "Blame Copy Only On Changed Files"
> +msgstr "Detecci=F3n de copia solo a ficheros cambiados"

solo -> s=F3lo

Perhaps also:

a -> en

> +#: lib/option.tcl:151
> +msgid "Blame History Context Radius (days)"
> +msgstr "Contexto de Cronolog=EDa de Anotaci=F3n (dias)"

dias -> d=EDas


> +#: lib/option.tcl:152
> +msgid "Number of Diff Context Lines"
> +msgstr "N=FAmero lineas de contexto en diffs"

"N=FAmero de l=EDneas"

Again, use "parches" for "diffs"?

> +#: lib/remote_branch_delete.tcl:109
> +msgid "Delete Only If"
> +msgstr "Borrar solo si"

solo -> s=F3lo

> +#: lib/remote_branch_delete.tcl:184
> +#, tcl-format
> +msgid ""
> +"The following branches are not completely merged into %s:\n"
> +"\n"
> +" - %s"
> +msgstr ""
> +"Las siguientes ramas no estan completamente fusionadas a %s:\n"
> +"\n"
> +"- %s"

estan -> est=E1n

> +#: lib/remote_branch_delete.tcl:189
> +#, tcl-format
> +msgid ""
> +"One or more of the merge tests failed because you have not fetched =
=20
> the "
> +"necessary commits.  Try fetching from %s first."
> +msgstr ""
> +"Una o mas de las comprobaciones de fusi=F3n fallaron porque no se =20
> trajeron las\n"
> +"revisones necesarias. Intente trayendolas de %s primero."

Don't you think:

   trayendolas -> traerlas

Would be better?

> +#: lib/remote_branch_delete.tcl:207
> +msgid "Please select one or more branches to delete."
> +msgstr "Por favor seleccione una o mas ramas para borrar."

mas -> m=E1s

> +#: lib/remote_branch_delete.tcl:286
> +msgid "No repository selected."
> +msgstr "No se a seleccionado un repositorio."

a -> ha

> +#: lib/search.tcl:25
> +msgid "Case-Sensitive"
> +msgstr "Sensible a Mayusculas"

Mayusculas -> May=FAsculas

> +#: lib/spellcheck.tcl:68
> +msgid "Invalid spell checking configuration"
> +msgstr "Configuraci=F3nn de correcci=F3n ortogr=E1fica inv=E1lida"

Configuraci=F3nn -> Configuraci=F3n

> +#: lib/spellcheck.tcl:388
> +msgid "Unexpected EOF from spell checker"
> +msgstr "EOF inesperado desde el corrector ortogr=E1fico"

I'm not sure what the standard translation of EOF is, but seeing as it =
=20
stands for "End Of File" it wouldn't surprise me if there is something =
=20
similar in Spanish like "FDA" (Fin De Archivo) or something similar...?

> +#: lib/sshkey.tcl:118
> +msgid "Generation succeded, but no keys found."
> +msgstr "La generaci=F3n tubo =E9xito, pero no se encontraron llaves.=
"

tubo -> tuvo

> +#: lib/transport.tcl:175
> +msgid "Use thin pack (for slow network connections)"
> +msgstr "Usar paquete ligero (thin pack) (para conexiones de red =20
> lentas)"

Don't think you need "thin pack" here.

Cheers,
Wincent
