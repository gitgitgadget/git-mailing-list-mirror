From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [MinGW port] Unable to repack on Clearcase dynamic views
Date: Thu, 31 May 2007 20:51:43 +0200
Message-ID: <200705312051.46429.robin.rosenberg.lists@dewire.com>
References: <fcaeb9bf0705300742u22b54c78vccbc037fb553141f@mail.gmail.com> <200705302028.15549.robin.rosenberg.lists@dewire.com> <34a7ae040705310246w72c30c19ic063895a46b8f3fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Paolo Teti" <paolo.teti@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 21:23:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtqEp-00065h-6A
	for gcvg-git@gmane.org; Thu, 31 May 2007 21:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757532AbXEaTWf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 15:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757536AbXEaTWf
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 15:22:35 -0400
Received: from [83.140.172.130] ([83.140.172.130]:3998 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757532AbXEaTWe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 15:22:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 52C7C8030AF;
	Thu, 31 May 2007 21:16:07 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04034-03; Thu, 31 May 2007 21:16:07 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 0A736802817;
	Thu, 31 May 2007 21:16:06 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <34a7ae040705310246w72c30c19ic063895a46b8f3fb@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48817>

torsdag 31 maj 2007 skrev Paolo Teti:
> 2007/5/30, Robin Rosenberg <robin.rosenberg.lists@dewire.com>:
> 
> > BTW, Does anyone have something like git-cvsexportcommit for clearcase?
> 
> a stupid workaround is git-cvsexportcommit + clearimport /clearexport_cvs.
> -
That would require a clearcase to cvs converter, wouldn't it, so I'd have something to commit to..
Even more stupid than my attempt at a clearcase to git converter.

-- robin
