From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Who uses Signed-off-by and DCO?
Date: Fri, 12 Jun 2009 17:59:40 -0700
Message-ID: <7vfxe52bk3.fsf@alter.siamese.dyndns.org>
References: <20090612084207.6117@nanako3.lavabit.com>
	<20090612175105.GD6417@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Jun 13 02:59:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFHb4-0006nu-2U
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 02:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbZFMA7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 20:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbZFMA7j
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 20:59:39 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:57676 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbZFMA7j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 20:59:39 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090613005941.XZVN20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Fri, 12 Jun 2009 20:59:41 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 3Czh1c0034aMwMQ04Czhmp; Fri, 12 Jun 2009 20:59:41 -0400
X-VR-Score: -220.00
X-Authority-Analysis: v=1.0 c=1 a=8UCnzis1hPQA:10 a=M92U2GiyUpJ0XrGiLd4A:9
 a=23LciFGfGA2slOshP-BKTaCLe30A:4
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121477>

Theodore Tso <tytso@mit.edu> writes:

> On Fri, Jun 12, 2009 at 08:42:07AM +0900, Nanako Shiraishi wrote:
>> git provides options and configuration variables to easily handle
>> the Signed-off-by tag line. It is used to certify that the sender
>> certifies the patch with the Developer's Certificate of Origin.
>> 
>> I have read SubmittingPatches document and understand this
>> convention is used by the Linux Kernel Project.
>> 
>> I was giving a git introduction to students in my lab, and this
>> question came up from one of them. How widely is this convention
>> used? Are there projects other than the Linux Kernel and git itself?
>
> E2fsprogs uses the DCO convetion as well.

True; I do not know if it counts as "other than the Kernel project"
in the original question, though.
