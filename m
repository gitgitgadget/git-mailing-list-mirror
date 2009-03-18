From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 00/12] Improve test coverage in revwalk
Date: Wed, 18 Mar 2009 10:21:52 +0100
Message-ID: <200903181021.52693.robin.rosenberg.lists@dewire.com>
References: <1237340451-31562-1-git-send-email-spearce@spearce.org> <200903180734.59435.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 10:23:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljrzs-00026N-NZ
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 10:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230AbZCRJWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 05:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754424AbZCRJWE
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 05:22:04 -0400
Received: from mail.dewire.com ([83.140.172.130]:22741 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752947AbZCRJWC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 05:22:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 6E8201391363;
	Wed, 18 Mar 2009 10:21:58 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N5tlqtKoN5EN; Wed, 18 Mar 2009 10:21:53 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id B0BA71391364;
	Wed, 18 Mar 2009 10:21:53 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <200903180734.59435.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113600>

onsdag 18 mars 2009 07:34:59 skrev Robin Rosenberg <robin.rosenberg.lists@dewire.com>:
> onsdag 18 mars 2009 02:40:39 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > The tests are commented out because JUnit doesn't have a notion of
> > "known broken".  But I did leave in TODO comments.  I'd like to
> > apply the test, and then work later to improve it, but I'm open
> > to suggestions.
> 
> If we'd switch to JUnit4/TestNG we could abuse the expected exception
> annotation.

..or the  @Ignore annotation

-- robin
