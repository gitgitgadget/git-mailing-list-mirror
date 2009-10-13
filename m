From: m.skoric@web.de
Subject: Bad URL passed to RA lay
Date: Tue, 13 Oct 2009 09:35:08 +0200
Organization: http://freemail.web.de/
Message-ID: <1952825702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 09:38:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxbwB-00016f-TT
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 09:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933720AbZJMHfr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Oct 2009 03:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933718AbZJMHfr
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 03:35:47 -0400
Received: from fmmailgate09.web.de ([217.72.192.184]:49274 "EHLO
	fmmailgate09.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933705AbZJMHfq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2009 03:35:46 -0400
Received: from web.de 
	by fmmailgate09.web.de (Postfix) with SMTP id 1DEC12B33093
	for <git@vger.kernel.org>; Tue, 13 Oct 2009 09:35:09 +0200 (CEST)
Received: from [88.79.247.30] by freemailng2306.web.de with HTTP;
 Tue, 13 Oct 2009 09:35:08 +0200
X-Provags-Id: V01U2FsdGVkX1+uPNcmKaIuFtZBVYQVYU4jOr168SAXnqDrikhK3wFVYJ3pE
 BhGOAnRSRruoWaHepmeJXioudM9N/M8vfGaBT3udMm1OfuESyI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130137>

Hi List,

i have a problem with git-svn clone / fetch. I get following error whil=
e doing one of previous command -> "Bad URL passed to RA lay"
This happens because a branch doesn't exists in svn anymore and git wan=
ts to retrieve data from it. Here is the complete error message

Initializing parent: Abo-Uebernahme (Bug #994)@341
=46ound possible branch point: "quoted"..trunk =3D> "quoted"...Abo-Uebe=
rnahme (Bug #994), 203
=46ound branch parent: (Abo-Uebernahme (Bug #994)@341) bb831869748c98bf=
97d105c5894ae65331c95c08
Bad URL passed to RA layer: Malformed URL for repository at /usr/bin/gi=
t-svn line 4311

git version 1.6.3.3

Aynone else has this Problem?
Can anyone help me?

Thanks in advance

Majk
______________________________________________________
GRATIS f=FCr alle WEB.DE-Nutzer: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://movieflat.web.de
