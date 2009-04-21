From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH-maint] test-lib.sh: Help test_create_repo() find the templates
 dir
Date: Tue, 21 Apr 2009 11:29:10 +0200
Message-ID: <49ED91E6.5060303@drmicha.warpmail.net>
References: <7vocuqbmgu.fsf@gitster.siamese.dyndns.org> <1240305543-27163-1-git-send-email-git@drmicha.warpmail.net> <alpine.DEB.1.00.0904211126180.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 21 11:32:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwCJb-0007bq-VL
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 11:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756293AbZDUJ3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 05:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755550AbZDUJ3T
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 05:29:19 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39319 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754852AbZDUJ3S (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2009 05:29:18 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 3BE912F9545;
	Tue, 21 Apr 2009 05:29:18 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 21 Apr 2009 05:29:18 -0400
X-Sasl-enc: Bf8i4Kjy0Doz5YyiHJsLK17n0cZS7fTohl0dr8Ara+9i 1240306157
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4637256344;
	Tue, 21 Apr 2009 05:29:17 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090420 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <alpine.DEB.1.00.0904211126180.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117117>

Johannes Schindelin venit, vidit, dixit 21.04.2009 11:26:
> Hi,
> 
> On Tue, 21 Apr 2009, Michael J Gruber wrote:
> 
>> This is a patch against maint as discussed in 
>> http://article.gmane.org/gmane.comp.version-control.git/11699 although 
>> maint does not (yet) contain a6d63b7 which actually exposes the problem.
> 
> So it is a fix in need of a problem?

Your question is answered by the second paragraph which I wrote and you
cut... I suggested applying to master only. (Admittedly, the word "only"
does not appear there.)

Cheers,
Michael
