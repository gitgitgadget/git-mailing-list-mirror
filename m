From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Merging adjacent deleted lines?
Date: Fri, 23 Jan 2009 11:32:36 +0100
Message-ID: <200901231132.36543.robin.rosenberg.lists@dewire.com>
References: <57518fd10901211120n62f8d0e9ya8595fc9baa6476c@mail.gmail.com> <200901222113.31082.robin.rosenberg.lists@dewire.com> <76718490901222318l7c3559ecje4a627fe2ff2ad12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jonathan del Strother <maillist@steelskies.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 11:34:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQJMU-0008Al-AU
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 11:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717AbZAWKcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 05:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754614AbZAWKcl
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 05:32:41 -0500
Received: from mail.dewire.com ([83.140.172.130]:18709 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753862AbZAWKck (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 05:32:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C82908026CA;
	Fri, 23 Jan 2009 11:32:37 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7I-xHRI4BSke; Fri, 23 Jan 2009 11:32:37 +0100 (CET)
Received: from sleipner.localnet (sleipner.dewire.com [10.1.2.197])
	by dewire.com (Postfix) with ESMTP id 48D6880027F;
	Fri, 23 Jan 2009 11:32:37 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <76718490901222318l7c3559ecje4a627fe2ff2ad12@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106871>

fredag 23 januari 2009 08:18:15 skrev Jay Soffian:
> On Thu, Jan 22, 2009 at 3:13 PM, Robin Rosenberg
> <robin.rosenberg.lists@dewire.com> wrote:
[...]
> > Try a three-way merge tool instead like, e.g. xxdiff.
> 
> opendiff (aka FileMerge) *is* a three-way merge tool. If the
> screenshot above is not clear, I'm not sure what would be. The left
> pane shows your copy of the file with only line1, line3, and line4.
> The right pane shows the other copy, with only line1, line2, and
> line4.

Where's the ancestor? I'm used to having four panes for doing three-way 
merges, but your screenshot showed only three.

> 
> Shrug.

You have the option to ignore me....

-- robin
