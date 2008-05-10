From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 13/22] Added the class ComplexFilePattern.
Date: Sat, 10 May 2008 22:53:20 +0200
Message-ID: <200805102253.20379.robin.rosenberg.lists@dewire.com>
References: <1210424440-13886-1-git-send-email-florianskarten@web.de> <1210424440-13886-14-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Florian Koeberle <florianskarten@web.de>
X-From: git-owner@vger.kernel.org Sat May 10 22:56:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juw5y-0001Gj-HC
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 22:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373AbYEJUyN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 May 2008 16:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754998AbYEJUyM
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 16:54:12 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12925 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753791AbYEJUyL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 May 2008 16:54:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A61FD1434CC0;
	Sat, 10 May 2008 22:54:10 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yl7aCxXlNKkO; Sat, 10 May 2008 22:54:10 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 5744F1434CBF;
	Sat, 10 May 2008 22:54:10 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1210424440-13886-14-git-send-email-florianskarten@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81700>

l=F6rdagen den 10 maj 2008 15.00.31 skrev Florian Koeberle:
> +class ComplexFilePattern implements FilePattern {
> +	/**
> +	 * Can contain String and
> +	 */

Could you elaborate on this?

-- robin
