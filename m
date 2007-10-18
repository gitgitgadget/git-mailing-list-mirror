From: Gonzalo Garramuno <gga@filmaura.com>
Subject: Splitting a repository
Date: Thu, 18 Oct 2007 14:35:00 -0300
Message-ID: <47179944.6080608@filmaura.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 19:35:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiZHE-0003LM-Dh
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 19:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758410AbXJRRfJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2007 13:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756893AbXJRRfJ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 13:35:09 -0400
Received: from an.site5.com ([74.53.3.196]:56786 "EHLO an.site5.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758179AbXJRRfH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 13:35:07 -0400
Received: from [201.255.33.200] (helo=[192.168.1.3])
	by an.site5.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <gga@filmaura.com>)
	id 1IiZGp-0005mk-0y
	for git@vger.kernel.org; Thu, 18 Oct 2007 12:34:57 -0500
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - an.site5.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - filmaura.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61549>


I have a project I have been working on for some time and one of its=20
libraries has grown too much.
I'm now wanting to split that library into a separate git repository.
I'm wondering what's the best way to go around this.  Ideally I would=20
like to have:
	* all history on those library files be moved to the new repository.
	* all history on those library files be removed from the original=20
repository.

or:
	* have the original repository library directory be "linked" to the ne=
w=20
repository.


--=20
Gonzalo Garramu=F1o

=46ilm Aura
A New Dawn in Media Companies

gga@filmaura.com
http://www.filmaura.com
