From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sun, 22 Jul 2007 10:30:06 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707221029160.3607@woody.linux-foundation.org>
References: <85lkdezi08.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
 <851wf2bcqy.fsf@lola.goethe.zz>  =?ISO-8859-1?Q?=20<alpine.LFD.0.99?= =?ISO-8859-1?Q?9.07072=04?=
	=?ISO-8859-1?Q?02135450.27249@w?= =?ISO-8859-1?Q?oody.linux-found?=
	=?ISO-8859-1?Q?ation.org>?=
 <alpine.LFD.0.999.0707202154220.27249@woody.linux-foundation.org>
 <85odi69vgt.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707210832180.27249@woody.linux-foundation.org>
 <85tzrxslms.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707211650190.3607@woody.linux-foundation.org>
 <85644dqoig.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707211737090.3607@woody.linux-foundation.org>
 <85r6n1p7sb.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707211840000.3607@woody.linux-foundation.org>
 <85fy3hp3f2.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707212040340.3607@woody.linux-foundation.org>
 <85abtpoydg.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707212332530.6350@asgard.lang.hm>
 <851wf0pzyt.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: david@lang.hm, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 19:30:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICfGJ-0001ZH-I4
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 19:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756305AbXGVRa1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 13:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755100AbXGVRa1
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 13:30:27 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37952 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753957AbXGVRa0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 13:30:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6MHUB6e015245
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Jul 2007 10:30:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6MHU6jk015597;
	Sun, 22 Jul 2007 10:30:06 -0700
In-Reply-To: <851wf0pzyt.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-3.216 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53279>



On Sun, 22 Jul 2007, David Kastrup wrote:
>
> Sigh.  No, I don't want to track every directory.  I want to have
> every directory _trackable_.

And they already are. 

Your point is pointless. You don't understand the git data structures, and 
you are trying to do something that makes no sense.

		Linus
