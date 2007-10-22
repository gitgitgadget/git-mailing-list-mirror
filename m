From: Brian Dessent <brian@dessent.net>
Subject: Re: [PATCH] Be nice with compilers that do not support runtime paths at 
 all.
Date: Sun, 21 Oct 2007 23:52:18 -0700
Organization: My own little world...
Message-ID: <471C48A2.136B9B96@dessent.net>
References: <7vsl4rdgf4.fsf@gitster.siamese.dyndns.org> <1191450052-23619-1-git-send-email-tsuna@lrde.epita.fr> <7vejgbdbyn.fsf@gitster.siamese.dyndns.org> <34DAC3CA-E226-4488-8B03-FC45A6A95F78@lrde.epita.fr> <09169ECD-19E1-44D1-8539-71EBBA3826A8@lrde.epita.fr> <20071022064454.GV14735@spearce.org>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>,
	git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 08:52:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijr9Q-0004ll-4p
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 08:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbXJVGwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 02:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbXJVGwY
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 02:52:24 -0400
Received: from dessent.net ([69.60.119.225]:38392 "EHLO dessent.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbXJVGwY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 02:52:24 -0400
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.50)
	id 1Ijr98-0004YW-RS; Mon, 22 Oct 2007 06:52:19 +0000
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61960>

"Shawn O. Pearce" wrote:

> How old of a GNU make are talking about here?  The above is certainly

According to the NEWS file, $(call) was added to GNU make v3.78,
released 1999-09-22.

Brian
