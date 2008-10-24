From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/4] diff: introduce diff.<driver>.binary
Date: Fri, 24 Oct 2008 09:02:35 +0200
Message-ID: <4901730B.7020906@viscovery.net>
References: <20081005214114.GA21875@coredump.intra.peff.net> <20081005214336.GC21925@coredump.intra.peff.net> <20081024024631.GA20365@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 24 09:03:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtGiE-0005fr-4R
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 09:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbYJXHCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 03:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbYJXHCp
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 03:02:45 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:57833 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbYJXHCo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 03:02:44 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KtIYt-0000uy-53; Fri, 24 Oct 2008 11:02:27 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CC5264FB; Fri, 24 Oct 2008 09:02:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20081024024631.GA20365@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99013>

Thank you for picking up the topic again and continuing on it. Your series
works nicely here, even without setting diff.*.binary.

-- Hannes
