From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Should "git apply --check" imply verbose?
Date: Tue, 20 Aug 2013 18:37:58 -0400
Message-ID: <20130820183758.436dee18@gandalf.local.home>
References: <5213873A.6010003@windriver.com>
	<xmqqioz06y9m.fsf@gitster.dls.corp.google.com>
	<5213B95D.3040409@windriver.com>
	<xmqqzjsc5ggp.fsf@gitster.dls.corp.google.com>
	<20130820151554.6afbcb7f@gandalf.local.home>
	<7v7gfgkuyo.fsf@alter.siamese.dyndns.org>
	<20130820155433.217abb3e@gandalf.local.home>
	<xmqqtxikujfn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	<git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 00:38:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBuYw-0001GC-Ew
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 00:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419Ab3HTWiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 18:38:01 -0400
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:17557 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab3HTWiB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 18:38:01 -0400
X-Authority-Analysis: v=2.0 cv=aqMw+FlV c=1 sm=0 a=Sro2XwOs0tJUSHxCKfOySw==:17 a=Drc5e87SC40A:10 a=JcweFNKryUAA:10 a=5SG0PmZfjMsA:10 a=kj9zAlcOel0A:10 a=meVymXHHAAAA:8 a=KGjhK52YXX0A:10 a=psXsv1EI8KAA:10 a=ybZZDoGAAAAA:8 a=Qbu8Kep6Mu55Og-sJO0A:9 a=CjuIK1q_8ugA:10 a=qIVjreYYsbEA:10 a=vBZAZqri1RMA:10 a=2LqW3D-HrFsA:10 a=Sro2XwOs0tJUSHxCKfOySw==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 67.255.60.225
Received: from [67.255.60.225] ([67.255.60.225:50410] helo=gandalf.local.home)
	by hrndva-oedge03.mail.rr.com (envelope-from <rostedt@goodmis.org>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id CE/04-25552-7CFE3125; Tue, 20 Aug 2013 22:37:59 +0000
In-Reply-To: <xmqqtxikujfn.fsf@gitster.dls.corp.google.com>
X-Mailer: Claws Mail 3.9.2 (GTK+ 2.24.20; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232657>

On Tue, 20 Aug 2013 14:43:56 -0700
Junio C Hamano <gitster@pobox.com> wrote:

 
> But only folks in the kernel circle will be told by Linus the
> similarity between apply and patch, no?

Well, there was a time when Linus was making his rounds showcasing git
more than Linux, to people that were not kernel developers.

-- Steve
