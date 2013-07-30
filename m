From: Gabriel Jover <gjover@cells.es>
Subject: Help using git subtree
Date: Tue, 30 Jul 2013 11:32:22 +0200
Message-ID: <51F78826.1040502@cells.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 30 11:40:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V46Pf-00007H-TO
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 11:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685Ab3G3JkI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jul 2013 05:40:08 -0400
Received: from berlin.cells.es ([84.89.245.3]:47059 "EHLO berlin.cells.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932613Ab3G3JkD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 05:40:03 -0400
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jul 2013 05:40:03 EDT
Received: from post01.cells.es (unknown [84.89.246.164])
	by berlin.cells.es (Postfix) with ESMTP id 199D91020D
	for <git@vger.kernel.org>; Tue, 30 Jul 2013 11:32:24 +0200 (CEST)
Received: from [84.89.248.4] (pc204.cells.es [84.89.248.4])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by post01.cells.es (Postfix) with ESMTPSA id F0BEF260052
	for <git@vger.kernel.org>; Tue, 30 Jul 2013 11:32:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231357>

Dear all,

I am trying to avoid using git submodules and thus I am testing if git=20
subtree fit my needs.
I have a set of sub-projects linked to a main-project.

Git subtree is very convenient to get all the sub-projects into the=20
main-project directory tree
and to send back sub-project commits to the corresponding repository.
But I don't understand the work flow very well.

I can add a subtree with a given prefix and pull/push my commits to the=
=20
repository,
but how do I do to pull/push commits from the main-project to the=20
corresponding repository
avoiding sub-projects to be sent?

An other question I have is when will be subtree included in git packag=
es.
I had to compile git from sources in order to get this feature.

Sincerely,

G. Jover-Manas

--=20
+----------------------------------------------------+
  Gabriel V. Jover Ma=F1as
  Computing Division
  Cells / Alba Synchrotron  [http:/www.cells.es]
  Carretera BP 1413 de Cerdanyola-Sant Cugat, Km. 3.3
  E-08290 Cerdanyola del Valles (Barcelona), Spain
  E-mail: gjover@cells.es
  Phone: +34 93 592 4471
  Office: ALBA P0 Of8/18
+----------------------------------------------------+

Si heu rebut aquest correu per error, us informo que pot contenir infor=
maci=F3 confidencial i privada i que est=E0 prohibit el seu =FAs. Us ag=
rairiem que ho comuniqueu al remitent i l'elimineu. Gr=E0cies.
Si ha recibido este correo por error, le informo de que puede contener =
informaci=F3n confidencial  y privada y que est=E1 prohibido su uso. Le=
 agradecer=E9 que lo comunique a su remitente y lo elimine. Gracias.
If you have received  this e-mail by error, please note that it may con=
tain confidential and private  information, therefore, the use of this =
information is strictly forbidden. Please inform the sender of the erro=
r and delete the information received. Thank you.
