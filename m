From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: Support diff.color-words config option
Date: Wed, 21 Jan 2009 02:27:26 -0800
Message-ID: <7v1vuxeyy9.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de>
 <200901192145.21115.bss@iguanasuicide.net>
 <7v1vuympie.fsf@gitster.siamese.dyndns.org>
 <200901201842.24000.markus.heidelberg@web.de>
 <alpine.DEB.1.00.0901202202370.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Teemu Likonen <tlikonen@iki.fi>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 11:29:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPaKV-00017g-FX
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 11:29:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275AbZAUK1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 05:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752931AbZAUK1i
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 05:27:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47784 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768AbZAUK1i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 05:27:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B4C1B923EE;
	Wed, 21 Jan 2009 05:27:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 59FC8923ED; Wed,
 21 Jan 2009 05:27:28 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1FEE4206-E7A6-11DD-A5E9-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106591>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Subject: Rename diff.suppress-blank-empty to diff.suppressBlankEmpty
>
> All the other config variables use CamelCase.  This config variable should
> not be an exception.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Thanks.
