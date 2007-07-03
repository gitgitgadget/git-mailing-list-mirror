From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: being nice to patch(1)
Date: Tue, 3 Jul 2007 14:35:54 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707031432202.9434@woody.linux-foundation.org>
References: <20070702125450.28228edd.akpm@linux-foundation.org>
	<alpine.LFD.0.98.0707021409510.9434@woody.linux-foundation.org>
	<20070702142557.eba61ccd.akpm@linux-foundation.org>
	<alpine.LFD.0.98.0707021436300.9434@woody.linux-foundation.org>
	<20070702145601.a0dcef0f.akpm@linux-foundation.org>
	<alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org>
	<7vhcomuofl.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0707022114000.9434@woody.linux-foundation.org>
	<Pine.LNX.4.64.0707031303130.4071@racer.site>
	<4d8e3fd30707030521k6cb3129dy9193344e9e1eccf7@mail.gmail.com>
	<20070703183947.GE5322@thunk.org>
	<alpine.LFD.0.98.0707031159580.9434@woody.linux-foundation.org>
	<87zm2dxl5l.fsf@penguin.cs.ucla.edu>
	<alpine.LFD.0.98.0707031422201.9434@woody.linux-foundation.org>
Reply-To: quilt-dev@nongnu.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, quilt-dev@nongnu.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Eggert <eggert@CS.UCLA.EDU>
X-From: quilt-dev-bounces+gcvqd-quilt-dev=m.gmane.org@nongnu.org Tue Jul 03 23:36:46 2007
connect(): Connection refused
Return-path: <quilt-dev-bounces+gcvqd-quilt-dev=m.gmane.org@nongnu.org>
Envelope-to: gcvqd-quilt-dev@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5q3C-0003vF-0Z
	for gcvqd-quilt-dev@m.gmane.org; Tue, 03 Jul 2007 23:36:46 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1I5q3B-0001ph-Eg
	for gcvqd-quilt-dev@m.gmane.org; Tue, 03 Jul 2007 17:36:45 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1I5q34-0001pa-Uw
	for quilt-dev@nongnu.org; Tue, 03 Jul 2007 17:36:38 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1I5q32-0001pN-Lk
	for quilt-dev@nongnu.org; Tue, 03 Jul 2007 17:36:37 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1I5q32-0001pJ-HI
	for quilt-dev@nongnu.org; Tue, 03 Jul 2007 17:36:36 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by monty-python.gnu.org with esmtps
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.60)
	(envelope-from <torvalds@linux-foundation.org>) id 1I5q32-0002k5-20
	for quilt-dev@nongnu.org; Tue, 03 Jul 2007 17:36:36 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org
	[207.189.120.55]) by smtp2.linux-foundation.org
	(8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id
	l63La0PW030006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Jul 2007 14:36:01 -0700
Received: from localhost (localhost [127.0.0.1]) by imap1.linux-foundation.org
	(8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id
	l63LZsZT017170; Tue, 3 Jul 2007 14:35:54 -0700
In-Reply-To: <alpine.LFD.0.98.0707031422201.9434@woody.linux-foundation.org>
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
X-detected-kernel: Linux 2.6, seldom 2.4 (older, 4)
X-BeenThere: quilt-dev@nongnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: quilt-dev.nongnu.org
List-Unsubscribe: <http://lists.nongnu.org/mailman/listinfo/quilt-dev>,
	<mailto:quilt-dev-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/quilt-dev>
List-Post: <mailto:quilt-dev@nongnu.org>
List-Help: <mailto:quilt-dev-request@nongnu.org?subject=help>
List-Subscribe: <http://lists.nongnu.org/mailman/listinfo/quilt-dev>,
	<mailto:quilt-dev-request@nongnu.org?subject=subscribe>
Sender: quilt-dev-bounces+gcvqd-quilt-dev=m.gmane.org@nongnu.org
Errors-To: quilt-dev-bounces+gcvqd-quilt-dev=m.gmane.org@nongnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51536>



On Tue, 3 Jul 2007, Linus Torvalds wrote:
> 
> But maybe you can use this patch as a starting point, at least.

Oh, Paul - I forgot to mention, and since it wasn't necessarily clear from 
the patch..

I used the patch-2.5.9 sources as a base for this. I don't know how 
official that source base is, I picked it up from a Debian package as the 
"original tar-ball": patch_2.5.9.orig.tar.gz

I suspect it applies to just about any version of patch with no 
modifications, but just to clarify what the base was. Judging by the 
ChangeLog, you're the one who has been doing the later 2.5.x releases even 
though the last version on the GNU sites is 2.5.4.

Confusing.

			Linus
