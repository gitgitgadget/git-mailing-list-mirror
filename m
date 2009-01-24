From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: problems with http://git-scm.com/
Date: Sat, 24 Jan 2009 17:37:56 +0000
Message-ID: <20090124173756.GU6683@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 24 19:20:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQn75-0005D6-Gn
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 19:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988AbZAXSSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 13:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753972AbZAXSSj
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 13:18:39 -0500
Received: from mhs.swan.ac.uk ([137.44.1.33]:40088 "EHLO mhs.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224AbZAXSSi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 13:18:38 -0500
X-Greylist: delayed 2441 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Jan 2009 13:18:38 EST
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by mhs.swan.ac.uk with esmtp (Exim 4.69)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1LQmSC-0004Um-05; Sat, 24 Jan 2009 17:37:56 +0000
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id B70E2DB00A;
	Sat, 24 Jan 2009 17:37:55 +0000 (GMT)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id 8460F741E9; Sat, 24 Jan 2009 17:37:56 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106982>

Hi,

since a few docs my (somewhat rusty) Konqueror can't load
http://git-scm.com/
anymore.

Now checking at
http://validator.w3.org/
we get one error:

 Line 174, Column 14: there is no attribute "clear".
    <br clear="all"/>

And that shouldn't be (since http://git-scm.com/ claims to
be strict xhtml).
Don't know whether this is the problem, but that attribute
clearly should be removed anyway.

Oliver
