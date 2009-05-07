From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] Add --reference option to git submodule.
Date: Thu, 07 May 2009 16:55:04 -0700
Message-ID: <7vr5z0cvtz.fsf@alter.siamese.dyndns.org>
References: <20090504193001.GA13719@redhat.com>
	<49FFE771.1030208@drmicha.warpmail.net>
	<20090507141656.GA1770@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Fri May 08 01:55:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2DQw-0004kk-V2
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 01:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbZEGXzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 19:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbZEGXzF
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 19:55:05 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:57277 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbZEGXzE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 19:55:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090507235503.MINI20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 May 2009 19:55:03 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id onv41b00B4aMwMQ03nv4M6; Thu, 07 May 2009 19:55:04 -0400
X-Authority-Analysis: v=1.0 c=1 a=pg9a2Ic4KOAA:10 a=APCfFyvMKA4A:10
 a=20KFwNOVAAAA:8 a=OA35TFMIY6380tIjW8cA:9 a=gTbBsDqa2g3MdSxqAiHLv1W-gFIA:4
 a=jEp0ucaQiEUA:10
X-CM-Score: 0.00
In-Reply-To: <20090507141656.GA1770@redhat.com> (Michael S. Tsirkin's message of "Thu\, 7 May 2009 17\:16\:56 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118542>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Tue, May 05, 2009 at 09:14:57AM +0200, Michael J Gruber wrote:
>> Michael S. Tsirkin venit, vidit, dixit 04.05.2009 21:30:
>> > This adds --reference option to git submodule add and
>> > git submodule update commands, which is passed to git clone.
>> > 
>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> > ---
>> > 
>> > I think it's ready now :) Comments?
>> 
>> Please don't expect Junio to look at this now, shortly before 1.6.3.
>
> Hey Junio, now that 1.6.3 is out, could you please give this patch
> a consideration? Should I repost?

I have Message-ID: <20090504193001.GA13719@redhat.com> in my reviewbox;
unless you have updates, you do not have to.
