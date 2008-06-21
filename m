From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Move deletion of configure generated files to distclean
Date: Sat, 21 Jun 2008 03:35:47 +0200
Message-ID: <20080621013547.GF7369@leksak.fem-net>
References: <D4D1BF84-3D3F-4DEC-87C0-F926228E0BF5@tekrat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: shire <shire@tekrat.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 03:36:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9s2A-0004w9-FG
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 03:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbYFUBf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 21:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbYFUBf6
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 21:35:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:33104 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751004AbYFUBf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 21:35:58 -0400
Received: (qmail invoked by alias); 21 Jun 2008 01:35:56 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp031) with SMTP; 21 Jun 2008 03:35:56 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18twD9fC4wtEEpvsEQ8BlJqwrX4QTyC/s7j8Esg8n
	GgOQQ5iKs8aToR
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K9s15-0001yh-HR; Sat, 21 Jun 2008 03:35:47 +0200
Content-Disposition: inline
In-Reply-To: <D4D1BF84-3D3F-4DEC-87C0-F926228E0BF5@tekrat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85686>

Hi,

whitespace and linebreaks are broken in your patch.
(Just noticed because I needed a quick patch to test something and I
took yours.)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
