From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 10/17] trailer: if no input file is passed, read
 from stdin
Date: Sun, 09 Feb 2014 14:55:45 +0100 (CET)
Message-ID: <20140209.145545.84719853892885831.chriscool@tuxfamily.org>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
	<20140130064921.7504.57934.chriscool@tuxfamily.org>
	<xmqq4n4byknr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, sunshine@sunshineco.com,
	dan.carpenter@oracle.com, greg@kroah.com, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Feb 09 14:56:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCUrW-0006pV-9D
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 14:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbaBINzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 08:55:48 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:55164 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767AbaBINzr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Feb 2014 08:55:47 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 7F8C847;
	Sun,  9 Feb 2014 14:55:45 +0100 (CET)
In-Reply-To: <xmqq4n4byknr.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241877>

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 10/17] trailer: if no input file is passed, read from stdin
Date: Thu, 06 Feb 2014 13:51:36 -0800

> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> It is simpler and more natural if the "git interpret-trailers"
>> is made a filter as its output already goes to sdtout.
> 
> sdtout???

Sorry, I have a hard time spelling porprelly these days :-)

Thanks,
Christian.
