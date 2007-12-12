From: Mike Hommey <mh@glandium.org>
Subject: git show stash
Date: Wed, 12 Dec 2007 08:28:36 +0100
Organization: glandium.org
Message-ID: <20071212072836.GA10961@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 08:29:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2M2X-0001od-CP
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 08:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbXLLH3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 02:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753798AbXLLH3f
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 02:29:35 -0500
Received: from smtp25.orange.fr ([193.252.22.22]:13704 "EHLO smtp25.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753550AbXLLH3e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 02:29:34 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2522.orange.fr (SMTP Server) with ESMTP id A271C1C000AB
	for <git@vger.kernel.org>; Wed, 12 Dec 2007 08:29:32 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf2522.orange.fr (SMTP Server) with ESMTP id 33A761C00091
	for <git@vger.kernel.org>; Wed, 12 Dec 2007 08:28:37 +0100 (CET)
X-ME-UUID: 20071212072837211.33A761C00091@mwinf2522.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J2M1E-00034d-1h
	for git@vger.kernel.org; Wed, 12 Dec 2007 08:28:36 +0100
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68002>

Hi,

Is there a particular reason why git show stash displays 2 signs at the
beginning of changed lines, contrary to git show anyotherref that shows
only one ? (the diff header is also different)

Mike
