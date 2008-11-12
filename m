From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Newbie questions regarding jgit
Date: Wed, 12 Nov 2008 23:37:33 +0100
Message-ID: <200811122337.33816.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Farrukh Najmi" <farrukh@wellfleetsoftware.com>,
	git@vger.kernel.org
To: "Jonas Fonseca" <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 23:39:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0OMg-0007XR-Lk
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 23:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbYKLWho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 17:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752709AbYKLWho
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 17:37:44 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:62183 "EHLO
	pne-smtpout2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752428AbYKLWhn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Nov 2008 17:37:43 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout2-sn2.hy.skanova.net (7.3.129)
        id 4873CA9501F745D8; Wed, 12 Nov 2008 23:37:35 +0100
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100825>

(resend without HTML)
tisdag 11 november 2008 22:37:40 skrev Jonas Fonseca:
> On Tue, Nov 11, 2008 at 21:44, Farrukh Najmi
> <farrukh@wellfleetsoftware.com> wrote:
> > Hi all,
> 
> Hello,
> 
> > I am git newbie and looking to use jgit in a servlet endpoint.
> 
> Sounds interesting. I have been thinking about how hard it would be to
> write a very simpe jgitweb kind of thing and am very interested to
> hear more about your experiences.

Consider this: 
http://www.jgit.org/cgi-bin/gitweb/gitweb.cgi?p=EGIT-jee.git;a=shortlog;h=rr/jeegitweb

It's an toy experiment with taglibs. Unfortunately the JSP doesn't even compile (!) anymore,
maybe someone can spot the error. Something very close to this did work a while ago.

The example jsp is here:
http://www.jgit.org/cgi-bin/gitweb/gitweb.cgi?p=EGIT-jee.git;a=blob;f=org.spearce.jeegit web/WebContent/index.jsp;h=d065d9f5a725a161a640e58e3be4d5b3a0666b5e;hb=fabffb50f0a020ff9b1653c090675bbd56dcc80a

-- robin
