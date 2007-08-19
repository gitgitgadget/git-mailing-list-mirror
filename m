From: Adam Roben <aroben@apple.com>
Subject: Re: [RFC] Clean way to disable pager
Date: Sun, 19 Aug 2007 14:59:16 -0700
Message-ID: <325563A3-050A-4830-9ACB-9ED15322F038@apple.com>
References: <vpq1wdz307k.fsf@bauges.imag.fr> <7vodh3bbmx.fsf@gitster.siamese.dyndns.org> <vpq643bz4vx.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v900)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Aug 19 23:59:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMsnq-0005QY-Pg
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 23:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbXHSV7T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 17:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbXHSV7T
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 17:59:19 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:55109 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbXHSV7S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 17:59:18 -0400
Received: from relay11.apple.com (relay11.apple.com [17.128.113.48])
	by mail-out4.apple.com (Postfix) with ESMTP id A1D77F48779;
	Sun, 19 Aug 2007 14:59:17 -0700 (PDT)
Received: from relay11.apple.com (unknown [127.0.0.1])
	by relay11.apple.com (Symantec Mail Security) with ESMTP id 86BA328247;
	Sun, 19 Aug 2007 14:59:17 -0700 (PDT)
X-AuditID: 11807130-a69a0bb000006012-6d-46c8bd353aca
Received: from [17.151.100.102] (unknown [17.151.100.102])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by relay11.apple.com (Symantec Mail Security) with ESMTP id 1298C2822D;
	Sun, 19 Aug 2007 14:59:17 -0700 (PDT)
In-Reply-To: <vpq643bz4vx.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.900)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56155>


On Aug 19, 2007, at 12:44 PM, Matthieu Moy wrote:

> +    [-p|--paginate] [--no-pager]

   I think that [-p|--[no-]paginate] would be more consistent with the  
way negatable options are normally specified.

-Adam
