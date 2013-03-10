From: Kirill Smelkov <kirr@navytux.spb.ru>
Subject: Re: [PATCH] format-patch: RFC 2047 says multi-octet character may
 not be split
Date: Sun, 10 Mar 2013 11:05:26 +0400
Organization: NAVYTUX.SPB.RU
Message-ID: <20130310070525.GA4020@vasy.zxlink>
References: <1362568106-30741-1-git-send-email-kirr@mns.spb.ru>
 <7vd2vcqv1y.fsf@alter.siamese.dyndns.org>
 <20130307105430.GA3049@tugrik.mns.mnsspb.ru>
 <7vobevm6fp.fsf@alter.siamese.dyndns.org>
 <20130309152722.GA32248@mini.zxlink>
 <7vzjyce6jc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Komissarov <dak@mnsspb.ru>, git@vger.kernel.org,
	Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <schnhrr@cs.tu-berlin.de>,
	kirr@mns.spb.ru
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 08:02:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEaHI-0002XM-Mx
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 08:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435Ab3CJHCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 03:02:03 -0400
Received: from forward2h.mail.yandex.net ([84.201.187.147]:59472 "EHLO
	forward2h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab3CJHCC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 03:02:02 -0400
Received: from smtp1h.mail.yandex.net (smtp1h.mail.yandex.net [84.201.187.144])
	by forward2h.mail.yandex.net (Yandex) with ESMTP id F212C700E24;
	Sun, 10 Mar 2013 11:01:57 +0400 (MSK)
Received: from smtp1h.mail.yandex.net (localhost [127.0.0.1])
	by smtp1h.mail.yandex.net (Yandex) with ESMTP id 3D09713400E4;
	Sun, 10 Mar 2013 11:01:57 +0400 (MSK)
Received: from unknown (unknown [78.25.121.25])
	by smtp1h.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 1oDWZh9h-1uDKOcf8;
	Sun, 10 Mar 2013 11:01:56 +0400
Received: from kirr by vasy.zxlink with local (Exim 4.80)
	(envelope-from <kirr@vasy.zxlink>)
	id 1UEaJz-00014c-L1; Sun, 10 Mar 2013 11:05:27 +0400
Content-Disposition: inline
In-Reply-To: <7vzjyce6jc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217787>

On Sat, Mar 09, 2013 at 11:07:19AM -0800, Junio C Hamano wrote:
> Kirill Smelkov <kirr@navytux.spb.ru> writes:
> > P.S. sorry for the delay - I harmed my arm yesterday.
> 
> Ouch. Take care and be well soon.

Thanks, and thanks fr accepting the patch.
