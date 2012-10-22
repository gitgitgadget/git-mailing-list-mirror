From: victorcruz <vitycruz@gmail.com>
Subject: Re: Migrating from StarTeam to GIT
Date: Mon, 22 Oct 2012 16:24:54 -0700 (PDT)
Message-ID: <1350948294188-7569734.post@n2.nabble.com>
References: <89b129c60902190919p2cdbe349o4a2a659617dae341@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 01:25:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQRMp-00057z-VT
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 01:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372Ab2JVXYz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Oct 2012 19:24:55 -0400
Received: from 216-139-250-139.aus.us.siteprotect.com ([216.139.250.139]:41353
	"EHLO joe.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab2JVXYy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2012 19:24:54 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by joe.nabble.com with esmtp (Exim 4.72)
	(envelope-from <vitycruz@gmail.com>)
	id 1TQRMc-0003NN-6S
	for git@vger.kernel.org; Mon, 22 Oct 2012 16:24:54 -0700
In-Reply-To: <89b129c60902190919p2cdbe349o4a2a659617dae341@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208208>

victor cruz alonso
vitycruz@gmail.com

The following is a small web application that converts projects of Star=
Team
to GIT repository.

http://dl.dropbox.com/u/101447754/startgit.tar.gz

I developed because in my work decided to migrate and give the possibil=
ity
that any group without previous research work to make such a process.

Now:

StartGIT es una sencilla herramienta para trabajar con Controladores de
Versiones, su fin es poder convertir un repositorio en Starteam a GIT, =
para
ello se hace uso del script "svnimporter-1.2-st" obtenido en
"http://www.polarion.com/user/direct_register.php?dl=3Dsvnimporterst":

Tener instalado:
  - GIT
  - git-svn
  - java
  - apache2

Pasos:
 - Descomprimir "startgit.zip"
 - Colocar la carpeta descomprimida "startgit" en el directorio "/var/w=
ww/"
 - Abrir navegador web y colocar la siguiente direccci=C3=B3n
"http://localhost/startgit"

//-------------------------------------------------------------

StartGIT is a simple tool, its purpose is to convert a Starteam reposit=
ory
to GIT.

This script uses the "svnimporter-1.2-st" obtained "http://www.polarion=
=2Ecom
/ user / direct_register.php? dl =3D svnimporterst "

Have installed:
   - GIT
   - Git-svn
   - java
   - apache2

steps:
  - Unzip "startgit.zip"
  - Place the unzipped folder "startgit" in the "/ var / www /"
  - Open web browser and "http://localhost/startgit"



--
View this message in context: http://git.661346.n2.nabble.com/Migrating=
-from-StarTeam-to-GIT-tp2354198p7569734.html
Sent from the git mailing list archive at Nabble.com.
