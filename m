From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Make builtin-rerere use of strbuf nicer and more efficient.
Date: Tue, 25 Sep 2007 17:31:47 -0700
Message-ID: <7v3ax22rnw.fsf@gitster.siamese.dyndns.org>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org>
	<1190625904-22808-2-git-send-email-madcoder@debian.org>
	<1190625904-22808-3-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Sep 26 02:32:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaKop-0002EK-25
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 02:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbXIZAbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 20:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbXIZAbw
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 20:31:52 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49825 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbXIZAbw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 20:31:52 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 58BDB13A53D;
	Tue, 25 Sep 2007 20:32:11 -0400 (EDT)
In-Reply-To: <1190625904-22808-3-git-send-email-madcoder@debian.org> (Pierre
	Habouzit's message of "Mon, 24 Sep 2007 11:25:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Signoffs?
