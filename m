From: Junio C Hamano <gitster@pobox.com>
Subject: Re: notice: pu broken tonight
Date: Wed, 10 Jun 2009 00:56:07 -0700
Message-ID: <7vzlcgr088.fsf@alter.siamese.dyndns.org>
References: <7vy6s1pzwb.fsf@alter.siamese.dyndns.org>
	<20090610074400.GA26020@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Jun 10 09:56:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEIfT-0004z2-5A
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 09:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932AbZFJH4H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 03:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753736AbZFJH4G
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 03:56:06 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:55376 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469AbZFJH4F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 03:56:05 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090610075606.EVSD17135.fed1rmmtao104.cox.net@fed1rmimpo03.cox.net>;
          Wed, 10 Jun 2009 03:56:06 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 27w71c0024aMwMQ047w7TN; Wed, 10 Jun 2009 03:56:07 -0400
X-VR-Score: -80.00
X-Authority-Analysis: v=1.0 c=1 a=TSbVqHtbAAAA:8 a=HpILnx9KVFunQwdcILcA:9
 a=U4MViNN2Ni0e8jIssE6kiVAVXEMA:4 a=XNN-oNMjSfgA:10
X-CM-Score: 0.00
In-Reply-To: <20090610074400.GA26020@pengutronix.de> ("Uwe =?utf-8?Q?Klein?=
 =?utf-8?Q?e-K=C3=B6nig=22's?= message of "Wed\, 10 Jun 2009 09\:44\:00
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121262>

Uwe Kleine-K=C3=B6nig  <u.kleine-koenig@pengutronix.de> writes:

> Hello Junio,
>
> On Tue, Jun 09, 2009 at 01:36:20AM -0700, Junio C Hamano wrote:
>>                                                         Other than t=
hat I
>> do not think I forgot to queue any patch I saw on the list.
> What about
>
> 	http://news.gmane.org/find-root.php?group=3Dgmane.comp.version-contr=
ol.git&article=3D120990

> ?  I think it's save, but I didn't get any feed-back by you yet.

Nor anybody else for that matter ;-).

A patch that adds a new feature to a low-level building block without a=
ny
in-tree users, especially if there is no test for it, ranks very low in
the priority scale when I am short of time.
