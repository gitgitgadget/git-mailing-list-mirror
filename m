From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 2/5] Don't display passwords on the console in fetch/push output
Date: Fri, 11 Jul 2008 10:30:31 +0200
Message-ID: <200807111030.31983.robin.rosenberg.lists@dewire.com>
References: <1215670403-19191-1-git-send-email-spearce@spearce.org> <200807102217.38459.robin.rosenberg.lists@dewire.com> <20080711032004.GC32319@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 10:36:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHE7M-00086K-Iq
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 10:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513AbYGKIfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 04:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbYGKIfm
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 04:35:42 -0400
Received: from [83.140.172.130] ([83.140.172.130]:14907 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753624AbYGKIfm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 04:35:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E32ED8027F7;
	Fri, 11 Jul 2008 10:35:40 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PaGSRXR+9qxF; Fri, 11 Jul 2008 10:35:40 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 905B3800691;
	Fri, 11 Jul 2008 10:35:40 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080711032004.GC32319@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88097>

fredagen den 11 juli 2008 05.20.04 skrev Shawn O. Pearce:
> +	public String toPrivateString() {
> +		return format(true);
> +	}
etc

Yes, that's much better. 

-- robin
