From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Automated/Daily build systems supporting git?
Date: Tue, 08 Apr 2008 15:57:52 +0100
Message-ID: <1207666672.5698.4.camel@pitcairn.cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 16:58:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjFHB-00052U-PM
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 16:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757094AbYDHO5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 10:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756675AbYDHO5i
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 10:57:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:2114 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbYDHO5h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 10:57:37 -0400
Received: by ug-out-1314.google.com with SMTP id z38so786595ugc.16
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 07:57:35 -0700 (PDT)
Received: by 10.67.115.17 with SMTP id s17mr3165947ugm.56.1207666655121;
        Tue, 08 Apr 2008 07:57:35 -0700 (PDT)
Received: from ?10.0.0.166? ( [212.44.17.78])
        by mx.google.com with ESMTPS id y7sm10246280ugc.16.2008.04.08.07.57.32
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 08 Apr 2008 07:57:33 -0700 (PDT)
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79000>

Hi,

I'm currently doing some investigation into automated/daily build
systems to track the health of a source tree. There seem to be a number
about but as I'm also looking to move the CVS tree over to git I was
wondering if the denziens of the list knew of any they could recommend?

Ideally it would be an open source system. For bonus points something
that could auto bisect and point at culprit commits would be great :-)

If there are any systems that don't yet support git but people feel are
clean systems capable of having support added I would also be all ears.

-- 
Alex, homepage: http://www.bennee.com/~alex/
They are relatively good but absolutely terrible. -- Alan Kay,
commenting on Apollos
