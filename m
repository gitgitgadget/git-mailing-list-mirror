From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 04/12] Add getType() method to RevObject hierarchy
Date: Fri, 6 Jun 2008 15:24:09 +0200
Message-ID: <200806061524.09741.robin.rosenberg@dewire.com>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com> <1212441883-12990-4-git-send-email-marek.zawirski@gmail.com> <1212441883-12990-5-git-send-email-marek.zawirski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 15:28:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4bz1-0007qh-Jq
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 15:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756899AbYFFN1F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jun 2008 09:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756884AbYFFN1E
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 09:27:04 -0400
Received: from [83.140.172.130] ([83.140.172.130]:21507 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756239AbYFFN1D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jun 2008 09:27:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CD7CA80287C;
	Fri,  6 Jun 2008 15:27:01 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id caxc4+rLFdYx; Fri,  6 Jun 2008 15:27:01 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 72C4C8026F0;
	Fri,  6 Jun 2008 15:27:01 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1212441883-12990-5-git-send-email-marek.zawirski@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84064>

m=E5ndagen den 2 juni 2008 23.24.35 skrev Marek Zawirski:
> This let us avoid using instanceof.

Obviously. I think I know why you want to do this and I think it's a
good idea. You might want to explaint why *you* think it's good.

-- robin
