From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] checkout: respect diff.ignoreSubmodules setting
Date: Wed, 25 Aug 2010 23:57:43 +0200
Message-ID: <4C7591D7.9050508@web.de>
References: <alpine.DEB.1.00.1008251225200.4020@intel-tinevez-2-302> <4C755778.7010306@web.de> <7vlj7uqwr6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 23:57:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoNyg-0002Eq-Pr
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 23:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201Ab0HYV5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 17:57:46 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:51482 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776Ab0HYV5p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 17:57:45 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id E5C7316E9E13D;
	Wed, 25 Aug 2010 23:57:43 +0200 (CEST)
Received: from [93.246.46.43] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OoNyZ-0001nL-00; Wed, 25 Aug 2010 23:57:43 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <7vlj7uqwr6.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+ikID5UkAGJnOYhhRcgA56+mo9E6eiEphJKYjm
	IitjRkqBe1Lm7GNJ40j96n02/4fop66xc7if78Yj5yuQqDLvXQ
	DYRpVpEiqMPFASeaRU0w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154483>

Am 25.08.2010 22:10, schrieb Junio C Hamano:
> Thanks.  Perhaps we would want a new test or two in t2013?

Sure, I will add some as soon as I find some time ...
