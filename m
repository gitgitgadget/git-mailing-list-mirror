From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Fix man page breakage with DocBook XSL v1.72
Date: Wed, 14 Nov 2007 01:47:56 -0800
Message-ID: <7v7ikljgz7.fsf@gitster.siamese.dyndns.org>
References: <20071114093846.GA21082@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Nov 14 10:48:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsEr6-00017k-NZ
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 10:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623AbXKNJsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 04:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752810AbXKNJsD
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 04:48:03 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56333 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbXKNJsB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 04:48:01 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 9B5E12F0;
	Wed, 14 Nov 2007 04:48:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 3DD559449E;
	Wed, 14 Nov 2007 04:48:20 -0500 (EST)
In-Reply-To: <20071114093846.GA21082@diku.dk> (Jonas Fonseca's message of
	"Wed, 14 Nov 2007 10:38:46 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64973>

Jonas Fonseca <fonseca@diku.dk> writes:

> The fix adds a DOCBOOK_XSL_172 build variable that will disable the
> hack. To allow this variable to be defined in config.mak it also moves
> build variable handling below the inclusion of config.mak.

Ah, I misread the patch.  Thanks.
