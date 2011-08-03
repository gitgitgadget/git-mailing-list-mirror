From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/2] Clarify semantics of git attribute macros
Date: Wed, 3 Aug 2011 22:34:51 +0100
Organization: OPDS
Message-ID: <9F6331D9665D41C4A1B4BF9CAB4F5EF6@PhilipOakley>
References: <1312378890-31703-1-git-send-email-mhagger@alum.mit.edu>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <gitster@pobox.com>, <peff@peff.net>,
	"Michael Haggerty" <mhagger@alum.mit.edu>
To: "Michael Haggerty" <mhagger@alum.mit.edu>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 03 23:35:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qoj5i-00051u-7m
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 23:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815Ab1HCVe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 17:34:57 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:3797 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752077Ab1HCVe4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 17:34:56 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgEFAAu+OU5Z8rvp/2dsb2JhbABCDooGnUx4gTsBBAEBBQgBAS4eAQEhCwIDBQIBAw4HDCUUAQQaBgcXBgEaAgECAwGHVQjBCIVjXwSHK5t9OA
X-IronPort-AV: E=Sophos;i="4.67,312,1309734000"; 
   d="scan'208";a="341687291"
Received: from host-89-242-187-233.as13285.net (HELO PhilipOakley) ([89.242.187.233])
  by out1.ip04ir2.opaltelecom.net with SMTP; 03 Aug 2011 22:34:51 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178622>

From: "Michael Haggerty"
> Make it clearer that attribute macros do not only affect other
> attributes, but are attributes themselves.

I felt that this summary was the better wording. It is simple and direct.
i.e. "Note: Attribute macros not only affect attributes, but are attributes 
themselves."

Philip Oakley
Scotland 
