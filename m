From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 0/8] gitweb: gravatar support
Date: Thu, 25 Jun 2009 11:56:26 -0700
Message-ID: <7veit8b0rp.fsf@alter.siamese.dyndns.org>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
	<200906251455.32953.jnareb@gmail.com>
	<cb7bb73a0906250615i2ed880eci2d3716aa1ca43e4d@mail.gmail.com>
	<7v8wjggs2c.fsf@alter.siamese.dyndns.org>
	<cb7bb73a0906251146s785fac1by6847e1d0350f195b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 20:56:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJu7u-0007Sh-I8
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 20:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647AbZFYS40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 14:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754600AbZFYS4Z
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 14:56:25 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:64104 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475AbZFYS4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 14:56:24 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090625185627.WDFT25927.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 25 Jun 2009 14:56:27 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8JwT1c0074aMwMQ04JwTJS; Thu, 25 Jun 2009 14:56:27 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=hQqndbpKY2IA:10 a=pGLkceISAAAA:8
 a=ybZZDoGAAAAA:8 a=P6H1My3GfQJrqHuCoKAA:9 a=YQZJq7u5JOI3aPJQMdalGTMsEBQA:4
 a=MSl-tDqOz04A:10 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <cb7bb73a0906251146s785fac1by6847e1d0350f195b@mail.gmail.com> (Giuseppe Bilotta's message of "Thu\, 25 Jun 2009 20\:46\:01 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122234>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> On Thu, Jun 25, 2009 at 7:07 PM, Junio C Hamano<gitster@pobox.com> wrote:
>> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>>
>>> I was thinking about some form of fallback like that too, but I
>>> haven't the slightest idea how picons work, so I'm afraid I'll leave
>>> that enhancement to some later time.
>>
>> Yeah, let's not go overboard with the initial series.
>
> Well, I'll confess that I've been on a coding frenzy all day, so
> expect a new release with preliminary picon support as soon as the
> review for the last patchset is done 8-D

Ok, I saved v6 in my to-queue box planning to queue it in 'pu', but I'll
discard them and wait until the dust settles in v$n ($n >= 7).

Thanks.
