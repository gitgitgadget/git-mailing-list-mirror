From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 1/1] jgit: create a tag command
Date: Thu, 10 Jul 2008 20:02:10 +0200
Message-ID: <200807102002.11044.robin.rosenberg.lists@dewire.com>
References: <200807070041.35873.robin.rosenberg.lists@dewire.com> <200807070116.39892.robin.rosenberg.lists@dewire.com> <e2b179460807100831g5d62a0a8nc7e7bf2715f0b9f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Marek Zawirski" <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Mike Ralphson" <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 20:12:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH0cc-0003Rb-Tu
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 20:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760589AbYGJSHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 14:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760575AbYGJSHU
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 14:07:20 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12357 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756992AbYGJSHS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 14:07:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1E1AE802846;
	Thu, 10 Jul 2008 20:07:16 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SfAg8IYfZ1FB; Thu, 10 Jul 2008 20:07:15 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 9C1FA8027F7;
	Thu, 10 Jul 2008 20:07:15 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <e2b179460807100831g5d62a0a8nc7e7bf2715f0b9f1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87994>

torsdagen den 10 juli 2008 17.31.06 skrev Mike Ralphson:
> 2008/7/7 Robin Rosenberg <robin.rosenberg.lists@dewire.com>:
> >
> > This command allows us to create simple or annotated tags.
> > PGP signed tags are not yet supported.
> >
> > Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> 
> Apologies this will be whitespace damaged, but it's trivial.
Don't do like that again : Had to use patch -l to apply this.  Why doesn't git am have that?

Anyway thanks for the fix.

-- robin
