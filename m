From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Java Git (aka jgit) library switching license to BSD/EPL
Date: Fri, 9 May 2008 09:20:49 +0200
Message-ID: <200805090920.50718.robin.rosenberg@dewire.com>
References: <20080509021158.GA29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Dave Watson <dwatson@mimvista.com>,
	Philippe Ombredanne <philippe@easyeclipse.org>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 09 09:46:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuNJG-0003Wz-0K
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 09:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbYEIHpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 03:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbYEIHpc
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 03:45:32 -0400
Received: from [83.140.172.130] ([83.140.172.130]:4723 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750873AbYEIHpb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 03:45:31 -0400
X-Greylist: delayed 1440 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 May 2008 03:45:31 EDT
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 65F46147BE78;
	Fri,  9 May 2008 09:21:28 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WPeEr89tXept; Fri,  9 May 2008 09:21:27 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 8F8D08027E1;
	Fri,  9 May 2008 09:21:27 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080509021158.GA29038@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81604>

fredagen den 9 maj 2008 04.11.58 skrev Shawn O. Pearce:
> The Java Git library (also known as "jgit"[*1*]) is a 100% pure Java
> implementation of a data access library for the Git on-disk data
> structures, as well as a re-implementation of some commonly used
> application functions such as history graph traversal/visualization
> and network transport (fetch).
>
> Since its inception on March 6, 2006 jgit has been under the
> GPLv2 license.  To make the library available to a wider audience
> (including but not limited to the Eclipse Git plugin, numerous
> Apache projects such as Ant/Maven, the Netbeans IDE, etc.) we are
> switching to a dual license between a 3-clause BSD (the EDL[*2*])
> and the EPL[*3*].

I confirm this is fine with me.

-- robin
