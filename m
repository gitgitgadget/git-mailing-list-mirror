From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] branch: make --set-upstream saner without an explicit
 starting point
Date: Wed, 18 Jul 2012 17:33:42 +0200
Message-ID: <1342625622.3852.5.camel@centaur.cmartin.tk>
References: <1341480589-1890-1-git-send-email-cmn@elego.de>
	 <7vd34arvhu.fsf@alter.siamese.dyndns.org>
	 <7vtxxmqezp.fsf@alter.siamese.dyndns.org>
	 <1341559103.10752.59.camel@flaca.cmartin.tk>
	 <7vpq89ny8q.fsf@alter.siamese.dyndns.org>
	 <1341561809.10752.61.camel@flaca.cmartin.tk>
	 <7vpq7twr13.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 17:33:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrWG7-0004OR-Ep
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 17:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188Ab2GRPdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 11:33:46 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:34937 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751743Ab2GRPdp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 11:33:45 -0400
Received: from [192.168.1.5] (p57A1FFA4.dip.t-dialin.net [87.161.255.164])
	by hessy.dwim.me (Postfix) with ESMTPSA id 2F5DA81612;
	Wed, 18 Jul 2012 17:33:43 +0200 (CEST)
In-Reply-To: <7vpq7twr13.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.4.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201695>

On Tue, 2012-07-17 at 22:56 -0700, Junio C Hamano wrote:
> Ping on a seemingly stalled discussion (no need to rush but just
> checking).

I've implemented the feedback, but been slacking on writing the tests
which is what's stopped me from re-sending the series.


   cmn
