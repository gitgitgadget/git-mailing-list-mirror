From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] add throughput to progress display
Date: Tue, 30 Oct 2007 01:29:16 -0700
Message-ID: <7vr6jdm2eb.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.9999.0710291904190.22100@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 09:29:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImmTe-0001Yz-KX
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 09:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbXJ3I3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 04:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbXJ3I3X
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 04:29:23 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:45565 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbXJ3I3W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 04:29:22 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A2C652EF;
	Tue, 30 Oct 2007 04:29:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 444088F39D;
	Tue, 30 Oct 2007 04:29:41 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Very nice.

I however wonder why this breaks t1004 when applied on top of
lt/rename topic.
