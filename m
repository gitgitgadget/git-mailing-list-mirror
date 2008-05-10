From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 05/22] Added ProjectSeeker class.
Date: Sat, 10 May 2008 22:45:26 +0200
Message-ID: <200805102245.26162.robin.rosenberg.lists@dewire.com>
References: <1210424440-13886-1-git-send-email-florianskarten@web.de> <1210424440-13886-6-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Florian Koeberle <florianskarten@web.de>
X-From: git-owner@vger.kernel.org Sat May 10 22:47:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuvyQ-0006vd-Lw
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 22:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755662AbYEJUqT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 May 2008 16:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755575AbYEJUqT
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 16:46:19 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12878 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753791AbYEJUqS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 May 2008 16:46:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 6FC281434CBC;
	Sat, 10 May 2008 22:46:17 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tRhl3h4h-uZ8; Sat, 10 May 2008 22:46:16 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 1EF901434CBB;
	Sat, 10 May 2008 22:46:16 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1210424440-13886-6-git-send-email-florianskarten@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81696>

> +/**
> + * Use this class to create instances of {@link Project}.
> + *=20
> + * @author Florian K=C3=B6berle
> + *=20
> + */
> +public class ProjectSeeker {

Let Repository do this.

-- robin
