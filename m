From: gruziak89 <pawel.gruza@wp.pl>
Subject: Git -  server mediator
Date: Fri, 30 Dec 2011 04:43:40 -0800 (PST)
Message-ID: <1325249020526-7138036.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 30 13:43:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgboI-0005NO-2e
	for gcvg-git-2@lo.gmane.org; Fri, 30 Dec 2011 13:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323Ab1L3Mnl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Dec 2011 07:43:41 -0500
Received: from sam.nabble.com ([216.139.236.26]:33528 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753292Ab1L3Mnl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Dec 2011 07:43:41 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <pawel.gruza@wp.pl>)
	id 1RgboC-0001qO-Hp
	for git@vger.kernel.org; Fri, 30 Dec 2011 04:43:40 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187802>

Hi,
We have a project on githubie. On our server is the server git (gitosi)=
=2E Our
server needs to mediate in communication. namely:
People from our team clone the repository from our server. And all four
changes are sending him. When done work in the evening every day someon=
e
comes through ssh to a server and sends on github to change once it get=
s (so
someone can modify the contents of githubie). We collect these changes =
on us
from the server.
So the question is how do po=C5=9Bredncz=C4=85ce repository that will w=
ork at all push
/ pull from github and at the same time will be from the local computer=
, it
should work for push / pull.
Thanks for the reply.

--
View this message in context: http://git.661346.n2.nabble.com/Git-serve=
r-mediator-tp7138036p7138036.html
Sent from the git mailing list archive at Nabble.com.
