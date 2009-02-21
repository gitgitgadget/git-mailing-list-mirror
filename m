From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/4] Add more tests of cvsimport
Date: Sat, 21 Feb 2009 14:05:32 +0100
Message-ID: <499FFC1C.5080801@alum.mit.edu>
References: <1235107093-32605-1-git-send-email-mhagger@alum.mit.edu> <56112.77.61.241.211.1235118428.squirrel@hupie.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Sat Feb 21 14:07:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LarZb-0004DE-IY
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 14:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760AbZBUNFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 08:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753537AbZBUNFm
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 08:05:42 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:57486 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298AbZBUNFl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 08:05:41 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.130] (77-21-84-251-dynip.superkabel.de [77.21.84.251])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n1LD5Xse023228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 21 Feb 2009 14:05:33 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20090105 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
In-Reply-To: <56112.77.61.241.211.1235118428.squirrel@hupie.xs4all.nl>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110951>

Ferry Huberts (Pelagic) wrote:
> I'm actually working on coming up with a patch for a bug I hit that
> has to to do with safecrlf=true. Maybe now I should coordinate with you?

I am only adding some tests of "git cvsimport"; I definitely don't plan
to become a "git cvsimport" hacker.  But we can certainly work together
on the test infrastructure if it will help you.

Michael
